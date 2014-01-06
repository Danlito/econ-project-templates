% Add path to Matlab's project_paths function
addpath ../../bld/src/library/

load(project_paths('OUT_ANALYSIS', 'schelling_baseline.mat'));

n_cycles = size(locations_by_round, 3);
n_rows = ceil(n_cycles / 2);
n_types = 2;
colors = ['g', 'b'];

f = figure('visible', 'off');
% Adjust figure size
set(f, 'Units', 'normalized');
pos = get(f, 'Position');
set(f, 'Position', [pos(1) pos(2) pos(3) n_rows*0.2])

% Create new subplot and plot agents' locations for each cycle
for i = 1 : n_cycles;
    this_round = locations_by_round( :, :, i);
    h = subplot(n_rows, 2, i);
    title(['Cycle ', int2str(i)]);
    % Allow for multiple types
    hold on
    for t = 1 : n_types;
        this_type = this_round( :, 3) == t;
        plot( ... 
            this_round(this_type, 1), this_round(this_type, 2), ... 
            'o', 'MarkerEdgeColor', colors(t) , 'MarkerSize', 4 ...
        );
    end
    hold off
    % Adjust subplot nicely
    pos = get(h,'Position');
    set(h,'Position',[pos(1) pos(2) 0.9*pos(3) pos(4)]);
    set(gca,'XTick', [0, 1]);
    set(gca,'XTickLabel', {'0', '1'});
    set(gca,'YTick', [0, 1]);
    set(gca,'YTickLabel', {'', '1'});
end

set(f,'PaperPositionMode','auto');
saveas(f, project_paths('OUT_FIGURES','schelling_baseline_fig.png'));