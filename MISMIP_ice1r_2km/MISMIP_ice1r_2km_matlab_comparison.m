%Comparison between matlab and julia versions of WAVI for the MISIP_PLUS_ice1r_2km experiment

%matlab data
matlab_fname = '../WAVI_MATLAB_MISMIP_PLUS/Ice1r_CWI_WAVI_L1L2c_Weertman_2km.nc';
%ncdisp(matlab_fname)
t = ncread(matlab_fname, 'time');
xGL = ncread(matlab_fname, 'xGL');
yGL = ncread(matlab_fname, 'yGL');

xGL(xGL > 1e10) = nan;
yGL(yGL > 1e10) = nan;
figure(1); clf; 
ax(1) = subplot(2,1,1); 
hold on; box on; grid on;
A = parula(length(t));
for i = 1:length(t)
plot(xGL(i,:), yGL(i,:), 'color', A(i,:), 'linewidth', 1.5)
end
title('MISMIP_ice1r_2km matlab', 'interpreter', 'none');
xlabel('x');
ylabel('y');

%repeat for julia
julia_fname = "/data/icesheet_output/aleey/wavi/MISMIP_005/run/outfile.nc";
t = ncread(julia_fname, 'TIME');
x = ncread(julia_fname, 'x');
y = ncread(julia_fname, 'y');
grfrac = ncread(julia_fname, 'grfrac');

ax(2) = subplot(2,1,2); 
hold on; box on; grid on;
A = parula(length(t));
for i = 1:10:length(t)
contour(x,y,squeeze(grfrac(:,:,i))', [0.5, 0.5], 'color', A(i,:), 'linewidth', 1.5)
end
%xlim(ax(1).XLim);
%ylim(ax(1).YLim);
title('MISMIP_ice1r_2km julia', 'interpreter', 'none');
xlabel('x');
ylabel('y');
