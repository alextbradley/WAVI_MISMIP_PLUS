%Create an initial condition for MISMIP_ice0_1km by interpolating the final state from MISMIP_ice0_2km
fname = 'MISMIP_ice0_2km_SteadyThickness.bin';
fid = fopen(fname); h2km = fread(fid, 'real*8', 'b'); h2km = reshape(h2km, [320, 40]);

%2km grid details
x0 = 0;
y0 = -40000;
nx = 320;
ny = 40; 
dx = 2000;
dy = 2000;
x = 0:dx:(nx-1)*dx;
y = (y0 + dy/2):dy: -(y0 + dy/2);
[X,Y] = meshgrid(x,y);
X = X';
Y = Y';

%let matlab do the interpolation
F = scatteredInterpolant(X(:),Y(:),h2km(:));

%1km grid details
Nx = 640;
Ny = 80;
Dx = 1000;
Dy = 1000;
xx = 0:Dx:(Nx-1)*Dx;
yy = (y0 + Dy/2):Dy: -(y0 + Dy/2);
[XX,YY] = meshgrid(xx,yy);
XX = XX';
YY = YY';

%evaluate on new grid
h1km = F(XX(:),YY(:));
h1km = reshape(h1km, [Nx,Ny]);

%compare these two
figure(1); clf;
subplot(1,2,1); box on
contourf(x,y,h2km', 20, 'linestyle', 'none'); 
colorbar;
title('Original 2km steady state');

subplot(1,2,2); box on
contourf(xx,yy,h1km', 20, 'linestyle', 'none'); 
colorbar;
title('Interpolated 1km');

%output the file
fid = fopen('MISMIP_ice0_2km_to_1km_interpolated.bin', 'w', 'b'); fwrite(fid, h1km, 'real*8'); fclose(fid);
