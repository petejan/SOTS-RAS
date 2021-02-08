
file='PLANKTON_SOTS_PHYTOPLANKTON.csv.nc';

% read the data from the netCDF file
time = ncread(file, 'TIME') + datetime(1950,1,1);
count = ncread(file, 'CELL');
bv = ncread(file, 'VOLUME');

spec = ncread(file, 'SPECIES_INDEX');
spec_name = ncread(file, 'SPECIES');

fam = ncread(file, 'FAMILY_INDEX');
fam_name = ncread(file, 'FAMILY');

gen = ncread(file, 'GENUS_INDEX');
gen_name = ncread(file, 'GENUS');

tax_group= ncread(file, 'TAXON_GROUP_INDEX');
tax_group_name = ncread(file, 'TAXON_GROUP');

doy = days(time - datetime(year(time),1,1));


figure(1); clf;
subplot(2,1,1); plt_scatter(time, count, spec, spec_name, 'cell count (/litre)'); title('colour by SPECIES');
subplot(2,1,2); plt_scatter(time, bv, spec, spec_name, 'volume (um^3/litre/litre)');

figure(3); clf;
subplot(2,1,1); plt_scatter(time, count, fam, fam_name, 'cell count (/litre)'); title('colour by FAMILY');
subplot(2,1,2); plt_scatter(time, bv, fam, fam_name, 'volume (um^3/litre/litre)');

figure(5); clf;
subplot(2,1,1); plt_scatter(time, count, gen, gen_name, 'cell count (/litre)'); title('colour by GENUS');
subplot(2,1,2); plt_scatter(time, bv, gen, gen_name, 'volume (um^3/litre/litre)');

figure(7); clf
subplot(2,1,1); plt_scatter(time, count, tax_group, tax_group_name, 'cell count (/litre)'); title('colour by TAXON GROUP');
subplot(2,1,2); plt_scatter(time, bv, tax_group, tax_group_name, 'volume (um^3/litre/litre)');

figure(9); clf;
subplot(2,1,1); plt_scatter(doy, count, tax_group, tax_group_name, 'cell count (/litre)');  title('colour by TAXON GROUP'); xlim([0 366])
subplot(2,1,2); plt_scatter(doy, bv, tax_group, tax_group_name, 'volume (um^3/litre/litre)'); xlim([0 366])

% save the plots
plotfn = 'phyto-plots.ps';
delete(plotfn);

figures = sort( double(findall(0, 'type', 'figure') ) );
for f = 1:size(figures,1)
      fig = handle(figures(f));
      %set(fig,'PaperOrientation','landscape');
      %set(fig,'PaperUnits','normalized');
      %set(fig,'PaperPosition', [0 0 1 1]);
      
      print( fig, '-dpsc', plotfn, '-append', '-fillpage');
end

function plt_scatter(time, val, name_n, name, ylab)
    scatter(time, val, 20, name_n, 'filled');
    set(gca, 'YScale', 'log');

    cb = colorbar('YTicklabel', name');
    cb.Ticks=1:size(name, 2);
    cb.FontSize=6;
    ylabel(ylab)

end

