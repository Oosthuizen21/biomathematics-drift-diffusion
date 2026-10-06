clc, clearvars, close all

data = readtable('P001_data.xlsx');

real_rts = data.RT_seconds;
accuracy = data.Accuracy;
difficulty = data.Difficulty;

%Parameters
a = 1.2;
b = -a;
dt = 0.002;
max_time = max(real_rts);

drift_rates = [1.8, 1.0, 0.4];
diff_labels = {'Easy', 'Medium', 'Hard'};
path_colors = {'#2ca02c', '#ff7f0e', '#d62728'};

figure('Color', 'w'); hold on;

yline(a, 'b--');
yline(b, 'b--');
yline(0, 'b', 'Starting Point', 'Color', [0.5 0.5 0.5]);

for idx = 1:3
    v = drift_rates(idx);

    x = 0;
    t_idx = 1;
    path_history = [x];

    while abs(x) < a && (t_idx * dt) < max_time

        x = x + v * dt + 1.0 * sqrt(dt) * randn();
        path_history = [path_history, x];
        t_idx = t_idx + 1; % Increment time index
    end

    trail_timeline = 0:dt:(length(path_history) - 1)*dt;
    plot(trail_timeline, path_history, 'LineWidth', 2, 'Color', ...
        path_colors{idx}, 'DisplayName', ...
        [diff_labels{idx} ' Simulated Trial'])
end

title("Speed test distribution vs Condition-based results");
xlabel("Time in seconds");
ylabel("Evidence accumulation");
xlim([0 max_time]);
ylim([b - 0.3, a + 0.3]);

hold off;
