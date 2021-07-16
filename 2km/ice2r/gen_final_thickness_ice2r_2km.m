%Output a binary file with the thickness at the end of the ice2r_2km simulation (initial condition for ice2ra and ice2rr)

fname = "/data/icesheet_output/aleey/wavi/MISMIP_019/run/outfile.nc";
h = ncread(fname, 'h');
h = h(:,:,end);
fid=fopen('ice2r_2km_finalThickness.bin','w','b'); fwrite(fid,h,'real*8'); fclose(fid);

