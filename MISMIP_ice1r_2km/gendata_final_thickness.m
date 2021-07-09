%Make a binary file containing the thickness at the final timestep of MISMIS_Ice1r_2km experiment

julia_fname = "/data/icesheet_output/aleey/wavi/MISMIP_005/run/outfile.nc"; %with partial grounding
h = ncread(julia_fname, 'h');
h = h(:,:, end);
fid=fopen('MISMIP_Ice1r_2km_finalThickness.bin','w','b'); fwrite(fid,h,'real*8'); fclose(fid);
