%Comparison between matlab and julia versions of WAVI for the MISIP_PLUS_ice1r_2km experiment

% flags
save_flag = 0;

%matlab data
matlab_fname = '../WAVI_MATLAB_MISMIP_PLUS/Ice0_CWI_WAVI_L1L2c_Weertman_1km.nc';
%ncdisp(matlab_fname)
t = ncread(matlab_fname, 'time');
xGL = ncread(matlab_fname, 'xGL');
yGL = ncread(matlab_fname, 'yGL');

xGL(xGL > 1e10) = nan;
yGL(yGL > 1e10) = nan;
figure(1); clf; 
ax(1) = subplot(2,2,1); 
hold on; box on; grid on;
A = parula(length(t));
for i = 1:length(t)
plot(xGL(i,:), yGL(i,:), 'color', A(i,:), 'linewidth', 1.5)
end
title('ice0_1km matlab grounding line', 'interpreter', 'none');
xlabel('x');
ylabel('y');
c = colorbar;
c.TickLabels ={'0', '20', '40', '60', '80', '100'};
c.Label.String = 'time (yrs)';

%evolution of the gl at y = 0 (y = 4*1e4 for the matlab half domain)
centreline_pos = zeros(1,length(t));
for i = 1:length(t)
[~,idx] =min(abs(yGL(i,:) - 4*1e4));
centreline_pos(i) = xGL(i,idx);
end
ax(2) = subplot(2,2,2);
hold on; box on; grid on
centreline_var = (centreline_pos - centreline_pos(1))./centreline_pos(1)*100;
plot(t, centreline_var/1e3, 'color', [0, 47, 167]/255, 'linewidth', 2);
xlabel('time (yrs)');
ylabel('centreline variation from t = 0 (%)')
title('ice0_1km matlab centre line position variation', 'interpreter', 'none');


%
%repeat for julia
%
julia_fname = "/data/icesheet_output/aleey/wavi/MISMIP_011/run/outfile.nc"; 

t = ncread(julia_fname, 'TIME');
x = ncread(julia_fname, 'x');
y = ncread(julia_fname, 'y');
grfrac = ncread(julia_fname, 'grfrac');

t = t(end-20:end) - 900; %take the last 100 yrs of the simulation
grfrac = grfrac(:,:,end-20:end);

ax(3) = subplot(2,2,3); 
hold on; box on; grid on;
A = parula(length(t));
tout = t;

centreline_pos_julia = nan(1,length(t));
for i = 1:length(tout)
[C,h] = contour(x,40*1e3 - y,squeeze(grfrac(:,:,i))', [0.5, 0.5], 'color', A(i,:), 'linewidth', 1.5);
xgl = C(1,2:end);
ygl = C(2,2:end); %first entry is the level
[~,idx] = min(abs(ygl-40e3));
centreline_pos_julia(i) = xgl(idx);
end
c = colorbar;
c.TickLabels ={'0', '20', '40', '60', '80', '100'};
c.Label.String = 'time (yrs)';

%centreline_pos_julia = centreline_pos_julia(~isnan(centreline_pos_julia));

%xlim(ax(1).XLim);
%ylim(ax(1).YLim)
title('ice0_1km julia grounding line', 'interpreter', 'none');
xlabel('x');
ylabel('y');
ax(3).XLim = [4*1e5, 5.4e5];
ax(1).XLim = ax(3).XLim;
ax(3).YLim = ax(1).YLim;

ax(4) = subplot(2,2,4);
hold on; box on; grid on
centreline_var = (centreline_pos_julia - centreline_pos_julia(1))./centreline_pos_julia(1)*100;
plot(t, centreline_var/1e3, 'color', [0, 47, 167]/255, 'linewidth', 2);
xlabel('time (yrs)');
ylabel('centreline variation from t = 0 (%)')
%ax(4).YLim = [4.0,4.4]*1e2;
%ax(2).YLim = ax(4).YLim;
title('ice0_1km julia grounding line variation', 'interpreter', 'none');

%
% save flag
% 
if save_flag 
saveas(gcf, 'ice0_1km.epsc', 'espc');
end
