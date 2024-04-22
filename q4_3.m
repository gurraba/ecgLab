filename = 'ARMSWING.tmp.xlsx';

% Read the table with the specified options
dataTable = readtable(filename);
%disp(dataTable)

ArmswingTimeData = dataTable{2:end, 1};  % Accesses all rows of the first column
ArmswingTimeData = linspace(0, ArmswingTimeData(end) - ArmswingTimeData(1), size(ArmswingTimeData,1));
%disp(ArmswingTimeData)

ArmswingData = dataTable{2:end, 2};  % Accesses all rows of the first column
%disp(ArmswingData)

% ---------

[ imf , residual ] = emd ( ArmswingData ); % EMD
disp(imf)
[imfRows, imfCols] = size(imf);  % numRows will contain the number of rows
disp(imfRows)
disp(imfCols)

x = [];
for n = 1:length(ArmswingData)
    c_n = 0;
    r_n = residual(n);
    for k = 1:imfCols
        c_kn = imf(n, k);
        %disp(c_kn)
        c_n = c_n + c_kn;
       %disp(ArmswingData(n))
       %disp(imf)
    end
    x_n = c_n + r_n;
    x = [x, x_n];
end

figure(1)
plot(ArmswingTimeData, ArmswingData);  % Plot as points connected by lines
hold on;
plot(ArmswingTimeData, x, '--', 'LineWidth', 1);  % Plot as points connected by dashed lines
hold off;
legend('Raw', 'EMD');
xlabel('Time');  % Label x-axis
ylabel('x');  % Label y-axis
title('Armswing ECG');  % Add title to the plot

% Plot late columns
figure(2)
plot(ArmswingTimeData, x);%, 'LineWidth', 2);  % Plot as points connected by dashed lines
hold on;
for i = 3:imfCols
    x_i = [];
    for n = 1:length(ArmswingData)
        c_n = 0;
        r_n = residual(n);
        for k = i:imfCols
            c_kn = imf(n, k);
            c_n = c_n + c_kn;
        end
        x_i_n = c_n + r_n;
        x_i = [x_i, x_i_n];
    end
    plot(ArmswingTimeData, x_i);  % Plot as points connected by lines
    hold on;
end

hold off;
legend('EMD all col', 'EMD last 4 col', 'EMD last 3 col', 'EMD last 2 col', 'EMD last col');
xlabel('Time');  % Label x-axis
ylabel('x');  % Label y-axis
title('EMD late columns');  % Add title to the plot

% Plot early columns
figure(3)
plot(ArmswingTimeData, x, 'LineWidth', 2);  % Plot as points connected by dashed lines
hold on;
for i = 3:imfCols
    x_i = [];
    for n = 1:length(ArmswingData)
        c_n = 0;
        r_n = residual(n);
        for k = 1:imfCols-i
            c_kn = imf(n, k);
            c_n = c_n + c_kn;
        end
        x_i_n = c_n + r_n;
        x_i = [x_i, x_i_n];
    end
    plot(ArmswingTimeData, x_i);  % Plot as points connected by lines
    hold on;
end

hold off;
legend('EMD all col', 'EMD first 3 col', 'EMD first 2 col', 'EMD first col');
xlabel('Time');  % Label x-axis
ylabel('x');  % Label y-axis
title('EMD early columns');  % Add title to the plot


% Find ECG in EMD
figure(4)
plot(ArmswingTimeData, ArmswingData);  % Plot as points connected by dashed lines
hold on;
x_find = [];
start_col = 2;
end_col = 3;
for n = 1:length(ArmswingData)
    c_n = 0;
    r_n = residual(n);
    for k = start_col:end_col
        c_kn = imf(n, k);
        c_n = c_n + c_kn;
    end
    x_find_n = c_n + r_n;
    x_find = [x_find, x_find_n];
end

plot(ArmswingTimeData, x_find);  % Plot as points connected by lines
hold off;
legend('EMD all col', ['EMD col [', num2str(start_col), ':', num2str(end_col), ']']);
xlabel('Time');  % Label x-axis
ylabel('x');  % Label y-axis
title('EMD early columns');  % Add title to the plot