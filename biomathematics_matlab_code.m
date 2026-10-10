clc; clearvars; close all;

data = readtable('P001_data.xlsx'); %loads excel spreadsheats

dr = [1.8, 1.0, 0.4]; %pre-assigned drift rates
diffs = {'Easy', 'Medium', 'Hard'}; 
cols = {'#2ca02c', '#ff7f0e', '#d62728'};

dt = 0.002; %simulated time step
a = 1.2;
max_t = 2.5; %maximum duration of the trial (shortened to get clear graphs)

%generates 4 different figures for the simulated blocks in experiment
for i = 1:4
    figure('Color', 'w', 'Position', ...
        [100 + 50*(i-1), 100 + 50*(i-1), 750, 500]); 
    hold on;
    yline([-a, a], 'k--', 'HandleVisibility', 'off');%upper and lower boundary
    yline(0, 'Color', [.6 .6 .6], 'HandleVisibility', 'off');
    
    for j = 1:3
        x = 0; 
        history = 0; 

        %updates accumulated evidence to when boundary is reached
        while abs(x) < a && length(history)*dt < max_t
            x = x + dr(j)*dt + sqrt(dt)*randn(); 
            history(end+1) = x;
        end
        plot(0:dt:(length(history)-1)*dt, history, ...
            'LineWidth', 2, 'Color', cols{j}, 'DisplayName', diffs{j});
    end
    
    title(sprintf('Block %d (Uniform Scaling)', i), ...
        'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (seconds)'); ylabel('Evidence accumulation');
    xlim([0, max_t]); ylim([-a-0.3, a+0.3]);
    grid on; legend('Location', 'southeast'); hold off;
end
