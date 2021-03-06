clear; clc;
diary(fullfile('.', 'AnalysisResults', 'DoseResponseFit_log.txt')); diary on;
%% load data, averaged acorss trials of the raw data
load(fullfile('.', 'data', 'AveRawDataMatrix.mat'));
[rowTotal, colTotal, ~] = size(dataRawAve);

%% Label the curves
% 1: saturated curves
% 2: highest DF/F value >> 1, and the 2nd highest concentration reach the half maximum
% 3: weak responses, not 1 nor 2, and non-zero.

maskPlot = zeros(rowTotal, colTotal);

maskPlot(1, 1) = 3;     %1-pentanol 33b; 
maskPlot(1, 2) = 3;     %1-pentanol 45a; 
maskPlot(1, 4) = 1;     %1-pentanol 35a; S
maskPlot(1, 10) = 3;    %1-pentanol 67b; 
maskPlot(1, 11) = 3;    %1-pentanol 85c; 
maskPlot(1, 12) = 3;    %1-pentanol 13a; 

maskPlot(2, 1) = 3;     %3-pentanol 33b;
maskPlot(2, 2) = 3;     %3-pentanol 45a;
maskPlot(2, 5) = 2;     %3-pentanol 42a;
maskPlot(2, 6) = 3;     %3-pentanol 59a;
maskPlot(2, 8) = 3;     %3-pentanol 45b;
maskPlot(2, 9) = 3;     %3-pentanol 24a;
maskPlot(2, 10) = 3;    %3-pentanol 67b;
maskPlot(2, 11) = 3;    %3-pentanol 85c;
maskPlot(2, 12) = 3;    %3-pentanol 13a;
maskPlot(2, 15) = 3;    %3-pentanol 22c;
maskPlot(2, 16) = 3;    %3-pentanol 42b;
maskPlot(2, 18) = 3;    %3-pentanol 94a;

maskPlot(3, 2) = 3;     %6-methyl-5-hepten-2-ol 45a;
maskPlot(3, 4) = 3;     %6-methyl-5-hepten-2-ol 35a;
maskPlot(3, 7) = 3;     %6-methyl-5-hepten-2-ol 1a;
maskPlot(3, 11) = 1;    %6-methyl-5-hepten-2-ol 85c; S
maskPlot(3, 12) = 1;    %6-methyl-5-hepten-2-ol 13a; S

maskPlot(4, 1)  = 2;    %3-octanol 33b; 
maskPlot(4, 2)  = 3;    %3-octanol 45a; 
maskPlot(4, 4)  = 3;    %3-octanol 35a; 
maskPlot(4, 7)  = 3;    %3-octanol 1a; 
maskPlot(4, 9)  = 3;    %3-octanol 24a; 
maskPlot(4, 10)  = 3;   %3-octanol 67b; 
maskPlot(4, 11) = 1;    %3-octanol 85c; S
maskPlot(4, 12) = 1;    %3-octanol 13a; S

maskPlot(5, 1) = 3;     %trans-3-hexen-1-ol 33b; 
maskPlot(5, 2) = 3;     %trans-3-hexen-1-ol 45a; 
maskPlot(5, 4) = 1;     %trans-3-hexen-1-ol 35a; S
maskPlot(5, 5) = 3;     %trans-3-hexen-1-ol 42a; 
maskPlot(5, 10) = 3;    %trans-3-hexen-1-ol 67b; 
maskPlot(5, 11) = 3;    %trans-3-hexen-1-ol 85c;  <0.5
maskPlot(5, 12) = 3;    %trans-3-hexen-1-ol 13a;

maskPlot(6, 1) = 3;     %methyl phenyl sulfide 33b;
maskPlot(6, 6) = 3;     %methyl phenyl sulfide 59a;
maskPlot(6, 7) = 3;     %methyl phenyl sulfide 1a;
maskPlot(6, 8) = 1;     %methyl phenyl sulfide 45b; S
maskPlot(6, 9) = 1;     %methyl phenyl sulfide 24a; S
maskPlot(6, 10) = 3;    %methyl phenyl sulfide 67b;
maskPlot(6, 13) = 2;    %methyl phenyl sulfide 30a;
maskPlot(6, 15) = 1;    %methyl phenyl sulfide 22c; S
maskPlot(6, 18) = 3;    %methyl phenyl sulfide 94a; 

maskPlot(7, 1)  = 3;    %anisole 33b; 
maskPlot(7, 2)  = 3;    %anisole 45a; 
maskPlot(7, 4)  = 3;    %anisole 35a; 
maskPlot(7, 6)  = 3;    %anisole 59a; 
maskPlot(7, 7)  = 3;    %anisole 1a; 
maskPlot(7, 8)  = 3;    %anisole 45b; 
maskPlot(7, 9)  = 1;    %anisole 24a; S
maskPlot(7, 10) = 3;    %anisole 67b; 
maskPlot(7, 13) = 2;    %anisole 30a; 
maskPlot(7, 15) = 3;    %anisole 22c; 
maskPlot(7, 18) = 3;    %anisole 94a; 

maskPlot(8, 1) = 3;     %2-acetylpyridine 33b;
maskPlot(8, 4) = 3;     %2-acetylpyridine 35a;
maskPlot(8, 6) = 3;     %2-acetylpyridine 59a;
maskPlot(8, 8) = 3;     %2-acetylpyridine 45b;
maskPlot(8, 9) = 1;     %2-acetylpyridine 24a; S
maskPlot(8, 15) = 3;    %2-acetylpyridine 22c;

maskPlot(9, 1) = 3;     %2,5-dimethylpyrazine 33b;
maskPlot(9, 2) = 3;     %2,5-dimethylpyrazine 45a;
maskPlot(9, 6) = 3;     %2,5-dimethylpyrazine 59a;
maskPlot(9, 8) = 3;     %2,5-dimethylpyrazine 45b;
maskPlot(9, 10)= 3;     %2,5-dimethylpyrazine 67b;
maskPlot(9, 13) = 3;    %2,5-dimethylpyrazine 30a;
maskPlot(9, 15) = 3;    %2,5-dimethylpyrazine 22c;
maskPlot(9, 16) = 3;    %2,5-dimethylpyrazine 42b;
maskPlot(9, 18) = 3;    %2,5-dimethylpyrazine 94a;

maskPlot(10, 1) = 1;    %pentyl acetate 33b; S
maskPlot(10, 2) = 2;    %pentyl acetate 45a; not flat yet
maskPlot(10, 4) = 1;    %pentyl acetate 35a; S
maskPlot(10, 5) = 3;    %pentyl acetate 42a; 
maskPlot(10, 7) = 2;    %pentyl acetate 1a; not flat yet
maskPlot(10, 9) = 3;    %pentyl acetate 24a; 
maskPlot(10, 10) = 2;   %pentyl acetate 67b; not flat yet
maskPlot(10, 11) = 1;   %pentyl acetate 85c; S
maskPlot(10, 12) = 2;   %pentyl acetate 13a;
maskPlot(10, 13) = 3;   %pentyl acetate 30a;
maskPlot(10, 14) = 3;   %pentyl acetate 82a;
maskPlot(10, 15) = 3;   %pentyl acetate 22c;
maskPlot(10, 16) = 3;   %pentyl acetate 42b;

maskPlot(11, 1) = 1;    %geranyl acetate 33b; S
maskPlot(11, 2) = 1;    %geranyl acetate 45a; S
maskPlot(11, 7) = 3;    %geranyl acetate 1a;
maskPlot(11, 9) = 3;    %geranyl acetate 24a;
maskPlot(11, 14) = 1;   %geranyl acetate 82a; S
maskPlot(11, 16) = 3;   %geranyl acetate 42b;

maskPlot(12, 1)  = 3;   %2-methoxyphenyl acetate 33b; 
maskPlot(12, 6)  = 3;   %2-methoxyphenyl acetate 59a; 
maskPlot(12, 8)  = 3;   %2-methoxyphenyl acetate 45b; 
maskPlot(12, 9)  = 3;   %2-methoxyphenyl acetate 24a; 
maskPlot(12, 11) = 3;   %2-methoxyphenyl acetate 85c; 
maskPlot(12, 15) = 3;   %2-methoxyphenyl acetate 22c; 
maskPlot(12, 18) = 2;   %2-methoxyphenyl acetate 94a; 

maskPlot(13, 2) = 2;    %trans,trans-2,4-nonadienal 45a; 
maskPlot(13, 4) = 3;    %trans,trans-2,4-nonadienal 35a; 
maskPlot(13, 11) = 3;   %trans,trans-2,4-nonadienal 85c; <0.5 
maskPlot(13, 12) = 3;   %trans,trans-2,4-nonadienal 13a; 
maskPlot(13, 17) = 1;   %trans,trans-2,4-nonadienal 74a; S

maskPlot(14, 3) = 2;    %4m5v 83a;
maskPlot(14, 6) = 1;    %4m5v 59a; S
maskPlot(14, 8) = 1;    %4m5v 45b; S
maskPlot(14, 9) = 3;    %4m5v 24a;
maskPlot(14, 15) = 3;   %4m5v 22c;
maskPlot(14, 18) = 3;   %4m5v 94a;
maskPlot(14, 13) = 3;   %4m5v 30a;

maskPlot(15, 3) = 3;    %4,5-dimethylthiazole 83a;
maskPlot(15, 6) = 2;    %4,5-dimethylthiazole 59a; not flat
maskPlot(15, 8) = 3;    %4,5-dimethylthiazole 45b;
maskPlot(15, 10) = 3;   %4,5-dimethylthiazole 67b;

maskPlot(16, 1) = 3;    %4-hexen-3-one 33b;
maskPlot(16, 2) = 3;    %4-hexen-3-one 45a;
maskPlot(16, 4) = 3;    %4-hexen-3-one 35a;
maskPlot(16, 5) = 1;    %4-hexen-3-one 42a; S
maskPlot(16, 9) = 3;    %4-hexen-3-one 24a;
maskPlot(16, 11) = 3;   %4-hexen-3-one 85c;
maskPlot(16, 16) = 2;   %4-hexen-3-one 42b;
maskPlot(16, 17) = 3;   %4-hexen-3-one 74a;

maskPlot(17, 1) = 2;    %2-nonanone 33b; 
maskPlot(17, 2) = 3;    %2-nonanone 45a; 
maskPlot(17, 4) = 3;    %2-nonanone 35a; 
maskPlot(17, 8) = 3;    %2-nonanone 45b; 
maskPlot(17, 9) = 2;    %2-nonanone 24a; 
maskPlot(17, 10) = 3;   %2-nonanone 67b; 
maskPlot(17, 11) = 2;   %2-nonanone 85c; 
maskPlot(17, 12) = 2;   %2-nonanone 13a; 
maskPlot(17, 16) = 3;   %2-nonanone 42b; 
maskPlot(17, 17) = 3;   %2-nonanone 74a; 

maskPlot(18, 2) = 3;    %acetal 45a;
maskPlot(18, 16) = 2;   %acetal 42b; not flat
maskPlot(18, 17) = 3;   %acetal 74a;

maskPlot(19, 4) = 3;    %2-phenyl ethanol 35a;
maskPlot(19, 9) = 3;    %2-phenyl ethanol 24a;
maskPlot(19, 10) = 2;   %2-phenyl ethanol 67b;
maskPlot(19, 11) = 3;   %2-phenyl ethanol 85c;

%% count the number of curves for each type
s1 = ['Count of saturated dose-respons curves:', num2str(length(find(maskPlot==1)))];
s2 = ['Count of unsaturated but strongly activated curves:', num2str(length(find(maskPlot==2)))];
s3 = ['Count of weak dose-respons curves:', num2str(length(find(maskPlot==3)))];
st = ['Count of all non-zero dose-response curves:', num2str(length(find(maskPlot~=0)))];

fprintf([s1, '\n', s2, '\n', s3, '\n', st '\n']);
%% define variables to store the fitted parameters
cMatrix = NaN(rowTotal, colTotal);     % the thresholds for each odor_ORN pair, 'c' in the equation
aMatrix = NaN(rowTotal, colTotal);     % the saturated amplitude for each odor-ORN pair
r2Matrix= NaN(rowTotal, colTotal);     % the R-square value of the fitting

%% estimate the EC50 of the saturated curves
[row, col] = find(maskPlot==1); %find the saturated curves.
coeffMatrix = zeros(length(row), 3);    %store the parameters for the simulation.

x = log10(concList); %log10(concentration)

% control if plot each saturated curve
plotCurve = 0;
if plotCurve == 1
    figCurveFitH = figure;	hold on;	title('Fit All Saturated Curves'); 
    pos = get(gcf, 'pos'); set(gcf, 'pos', [pos(1), pos(2), 750, 420]);
end

% print out the fitted parameters
disp('----------FIT SATURATED CURVES----------');
disp('Equation: Y=a/(1+ exp(-b*(X-c)))');
fprintf('%35s\t%-5s\t%-5s\t%-5s\t%-5s\t\n', 'Curve Name', 'a', 'b', 'c', 'R^2 of the fit');

for i = 1:length(row) %go through all the saturated curves
    curveName = [odorList{row(i)} , '->', infoORNList{col(i)}]; %define the curve name
    y = dataRawAve(row(i), col(i), :);  %retrive the y data
    
    if plotCurve == 1
        figure(figCurveFitH); hPoint = plot(x, y(:), 'o'); %plot the data point
        set(get(get(hPoint,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
        figParam.handle = figCurveFitH; %define the setting of plot
        figParam.lineColor = hPoint.Color;
        figParam.lineName = curveName;
        %fit the curve and plot it 
        [coeffs, gof] = Fit_DR(x, y(:), [], plotCurve, figParam);
    else
        [coeffs, gof] = Fit_DR(x, y(:), [], 0, []);
    end
    
    %print out the fitted parameters
    fprintf('%35s\t%.2f\t%.2f\t%.2f\t%.3f\t\n',curveName,coeffs(1),coeffs(2),coeffs(3), gof.rsquare);
    
    %store the fitted parameters
    coeffMatrix(i, :) = coeffs;
end

if plotCurve == 1
    figure(figCurveFitH); xlabel('Log10(c)'); ylabel('\Delta F/F'); hold off;
end

%% estimate the slop after shifiting EC50 and normalizing amplitude
figSlopH = figure; %figure plot shifted curves
title('Normalized Shifted Saturated Curves'); 
pos = get(gcf, 'pos'); set(gcf, 'pos', [pos(1), pos(2), 540, 420]);

xMatrix = zeros(length(row), 5);    %store the shifted X
yMatrix = zeros(length(row), 5);    %store the normalized Y
for i = 1:length(row)
    xMatrix(i, :) = x - coeffMatrix(i, 3); %shift x using the value of EC50
    
    rawY = dataRawAve(row(i), col(i), :);
    rawY = rawY(:);
    normY = rawY./coeffMatrix(i, 1);
    yMatrix(i, :) = normY;              %rescale y using the maximum

    figure(figSlopH);                   %display each dataset
    plot(xMatrix(i, :), normY, 'o:', 'LineWidth', 0.3); hold on;
end

figParam.handle = figSlopH; %define the setting of plot
figParam.lineColor = [0 0 0];
figParam.lineName = 'Slop Fitting';
fitParam = [1, NaN, 0];

[coeffs, gof] = Fit_DR(xMatrix(:), yMatrix(:),fitParam, 1, figParam);
slop = coeffs(2);
figure(figSlopH);
xlabel('Relative Log10(c)'); ylabel('Normalized Activity');
legend('off'); 

disp('---------- FIND THE SLOP ----------');
disp('Normalize the curves using the parameter a.');
disp('Shift the curves using the parameter c.');
disp('Pool the data and fit the parameter of b in equation:');
disp('Y=1/(1+ exp(-b*X))');
fprintf('b = %.2f\n', slop);
fprintf('R^2 of the fit: %.3f\n', gof.rsquare);
disp('NOTE: if the x-axis is ln(c) instead of log10(c), the value of slop will be');
disp('Slop*log10(e), where e is the Euler number or the base of natural log, ');
fprintf('the value of which is %.3f\n', slop*log10(exp(1)));

%% apply the splo onto the saturated curves and fit the EC50 again
% settup the plot 
figCurveFitH1 = figure; hold on; 
title('Fit Saturated Curves Using Fixed Slop'); 
pos = get(gcf, 'pos'); set(gcf, 'pos', [pos(1), pos(2), 750, 420]);

% print out the fitted parameters
disp('----------FIT SATURATED CURVES USING FIXED SLOP----------');
disp(['Equation: Y=a/(1+ exp(-', num2str(slop), '*(X-c)))']);
fprintf('%35s\t%-5s\t%-5s\t%-5s\t\n', 'Curve Name', 'a', 'c', 'R^2 of the fit');

%define the fitting parameter for the fixed slop case.
fitParam_Fixed_b = [NaN, slop, NaN];

for i = 1:length(row) %go through all the saturated curves
    curveName = [odorList{row(i)} , '->', infoORNList{col(i)}]; %define the curve name
    y = dataRawAve(row(i), col(i), :);  %retrive the y data
    
    figure(figCurveFitH1); hPoint = plot(x, y(:), 'o'); %plot the data point
    set(get(get(hPoint,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
    figParam.handle = figCurveFitH1; %define the setting of plot
    figParam.lineColor = hPoint.Color;
    figParam.lineName = curveName;
    %fit the curve and plot it 
    [coeffs, gof] = Fit_DR(x, y(:), fitParam_Fixed_b, 1, figParam);

    %print out the fitted parameters
    fprintf('%35s\t%.2f\t%.2f\t%.3f\t\n',curveName,coeffs(1),coeffs(3), gof.rsquare);
    
    %rewrite the fitted parameters   
    cMatrix(row(i), col(i)) = coeffs(3);
    aMatrix(row(i), col(i)) = coeffs(1);
    r2Matrix(row(i), col(i))= gof.rsquare;
end

figure(figCurveFitH1);  xlabel('Log10(c)'); ylabel('\Delta F/F');   hold off;

% %% Hill plot the type 1 data
% figHillPlot = figure; hold on; 
% title('Hill Plot Saturated Curves'); 
% pos = get(gcf, 'pos'); set(gcf, 'pos', [pos(1), pos(2), 750, 420]);
% 
% for i = 1:length(row)
%     r = dataRawAve(row(i), col(i), :);
%     r = reshape(r, [5, 1]);
%     rmax = aMatrix(row(i), col(i));
%     y = log(r./(rmax-r));
%     
%     ec50 = cMatrix(row(i), col(i));
%     x = log(concList) - log(10^ec50);
%     
%     plot(x, y, 'o'); hold on;
% end
% 
% hold off; xlabel('Log10(c/EC50)'); ylabel('Log(R/Rmax-R)')

%% apply the slop, estimate type 2 (close to but not saturated curves) curves' threshold.
%set up the plot
figCurveFitH2 = figure; hold on; title('Fit Type 2 Curves'); 
pos = get(gcf, 'pos'); set(gcf, 'pos', [pos(1), pos(2), 750, 420]);

% print out the fitted parameters
disp('----------FIT TYPE 2 CURVES USING FIXED SLOP----------');
disp(['Equation: Y=a/(1+ exp(-', num2str(slop), '*(X-c)))']);
fprintf('%35s\t%-5s\t%-5s\t%-5s\t\n', 'Curve Name', 'a', 'c', 'R^2 of the fit');

[row2, col2] = find(maskPlot==2);

for i = 1:length(row2)
    curveName = [odorList{row2(i)} , '->', infoORNList{col2(i)}]; %define the curve name
    y = dataRawAve(row2(i), col2(i), :);  %retrive the y data
    

    figure(figCurveFitH2); hPoint = plot(x, y(:), 'o'); %plot the data point
    set(get(get(hPoint,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
    
    figParam.handle = figCurveFitH2; %define the setting of plot
    figParam.lineColor = hPoint.Color;
    figParam.lineName = curveName;
    %fit the curve and plot it 
    [coeffs, gof] = Fit_DR(x, y(:), fitParam_Fixed_b, 1, figParam);

    %print out the fitted parameters
    fprintf('%35s\t%.2f\t%.2f\t%.3f\t\n',curveName,coeffs(1),coeffs(3),gof.rsquare);
    
    %save the fitted parameters
    cMatrix(row2(i), col2(i)) = coeffs(3);
    aMatrix(row2(i), col2(i)) = coeffs(1);
    r2Matrix(row2(i), col2(i))= gof.rsquare;
end

figure(figCurveFitH2); xlabel('Log10(c)'); ylabel('\Delta F/F'); hold off;

%% Estimate the maximum values for each odor (for fitting the type 3 curves)
maxAofOdor = zeros(length(odorList), 1); % define parameter to store maximum amplitude 
lowerBound = 3; % set a lower bound of the maximum amplitude

disp('----------FIND AMPLITUDE OF EACH ODOR FOR TYPE 3 CURVE FITTING----------');
fprintf('%30s\t%-5s\t\n', 'Odor Name', 'Amplitude');

maxProj = max(dataRawAve, [], 3); %max of the data along the concentration
 
for i = 1:length(odorList)   
    index = ~isnan(aMatrix(i, :)); %find the nun-zero elements of each row (odor), from the saturated dataset
    maxSeqTemp = aMatrix(i, index);
    maxSeq = maxSeqTemp(maxSeqTemp>lowerBound); %select the max values higher than the lower bound
        
    maxEst = mean(maxSeq); % use the mean as the maximum
    if maxEst>lowerBound
        maxAofOdor(i) = maxEst;
    else %if there is no qualified elements, find the maximum in the raw data
        indexBackup = find(maxProj(i, :)>lowerBound);
        seqBackup = maxProj(i, indexBackup);
        maxEstBackup = mean(seqBackup);
        maxAofOdor(i) = maxEstBackup;
    end
    
	fprintf('%30s\t%.2f\t\n', odorList{i}, maxAofOdor(i));
end

%% apply the slop and amplitude to estimate type 3 curves' threshold.
[row3, col3] = find(maskPlot==3);

%set up the plot
figCurveFitH3 = figure; hold on; 
title('Fit Type 3 Curves'); 
set(gcf, 'pos', [600, 60, 750, 900]);

% print out the fitted parameters
disp('----------FIT TYPE 3 CURVES USING FIXED SLOP AND PREPARED AMPLITUDE----------');
disp(['Equation: Y = a0/(1+ exp(-', num2str(slop), '*(X-c))). a0 is a constant for each odor.']);
fprintf('%35s\t%-5s\t%-5s\t\n', 'Curve Name', 'c', 'R^2 of the fit');

for i = 1:length(row3)
    curveName = [odorList{row3(i)} , '->', infoORNList{col3(i)}]; %define the curve name
    y = dataRawAve(row3(i), col3(i), :);  %retrive the y data
    
    figure(figCurveFitH3); hPoint = plot(x, y(:), 'o'); %plot the data point
    set(get(get(hPoint,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
    
    figParam.handle = figCurveFitH3; %define the setting of plot
    figParam.lineColor = hPoint.Color;
    figParam.lineName = curveName;
    
    %adjust the fitting parameter
    if maxAofOdor(row3(i)) > maxProj(row3(i), col3(i))
        % if the max data value smaller than the preestimated, use the preestimated one 
        fitParam_3 = [maxAofOdor(row3(i)), slop, NaN];
    else
        % else, leave the amplitude free to fit
        fitParam_3 = [NaN, slop, NaN];
    end
    
    %fit the curve and plot it 
    [coeffs, gof] = Fit_DR(x, y(:), fitParam_3, 1, figParam);

    %print out the fitted parameters
    fprintf('%35s\t%.2f\t%.3f\t\n',curveName, coeffs(3), gof.rsquare);
    
    %save the fitted parameters   
    cMatrix(row3(i), col3(i)) = coeffs(3);
    aMatrix(row3(i), col3(i)) = coeffs(1);
    r2Matrix(row3(i), col3(i))= gof.rsquare;
end

figure(figCurveFitH3); xlabel('Log10(c)'); ylabel('\Delta F/F'); hold off;

%% List the bad fitted curves
cutOff = 0.5;
[failedRow, failedCol] = find(r2Matrix<cutOff);

disp('----------FAILED FITTINGS ----------');
disp([num2str(length(failedRow)), '(out of ', num2str( sum(~isnan(r2Matrix(:)))), ') fittings have R-Square smaller than ', num2str(cutOff)]);
fprintf('%35s\t%-5s\t%-5s\t%-5s\t%-5s\t\n', 'Curve Name', 'a', 'b', 'c', 'R^2 of the fit');

%set up the plot
figCurveFailed = figure; hold on; title('Failed Fittings'); 
pos = get(gcf, 'pos'); set(gcf, 'pos', [pos(1), pos(2), 750, 420]);

for i = 1:length(failedRow)
    %print out the fitting results
    curveName = [odorList{failedRow(i)} , '->', infoORNList{failedCol(i)}]; %define the curve name
    fprintf('%35s\t%.2f\t%.2f\t%.2f\t%.3f\t\n',curveName, aMatrix(failedRow(i), failedCol(i)), ...
        slop, cMatrix(failedRow(i), failedCol(i)), r2Matrix(failedRow(i), failedCol(i)));
    
    % plot the data points
    y = dataRawAve(failedRow(i), failedCol(i), :);  %retrive the y data
    figure(figCurveFailed); hPoint = plot(x, y(:), 'o'); %plot the data point
    set(get(get(hPoint,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
    
    % calculate and print the fitted curve
    xx = linspace(-8,-4,50);
    aa = aMatrix(failedRow(i), failedCol(i));
    bb = slop;
    cc = cMatrix(failedRow(i), failedCol(i));
    yy = aa./(1+ exp(-bb*(xx-cc)));
    
    hLine = plot(xx, yy);   %plot the fitted curve
    hLine.Color = hPoint.Color;   %set the color
    set(hLine, 'DisplayName',[curveName, ', R2=', num2str(r2Matrix(failedRow(i), failedCol(i)))]);   %set the name of the curve
    legend('off'); legend('show', 'Location', 'northeastoutside'); %control the display of legends
end

figure(figCurveFailed); xlabel('Log10(c)'); ylabel('\Delta F/F'); hold off;

%% Visualize the EC50 Matrix
% remove odor #5 from the data, to be consistant with the paper.
aMatrix18 = aMatrix; aMatrix18(5, :) = [];
cMatrix18 = cMatrix; cMatrix18(5, :) = [];
r2Matrix18 = r2Matrix; r2Matrix18(5, :) = [];
odorList18 = odorList; odorList18(5) = [];

%replace NaN in the EC50 matrix with 0
cMatrix18(isnan(cMatrix18)) = 0;

% apply the sequence of ORN and odor to order elements of the matrix 
odorOrder = [17 12 15 2 10 3 4 16 9 1 18 8 6 5 7 13 14 11]; % the order is consistant to figure 2
ORNOrder = [16 17 5 2 14 12 11 1 4 7 10 13 15 9 18 8 6 3];

[row18, col18] = size(cMatrix18);
newMStep1 = -cMatrix18;
for i = 1:row18
    newMStep1(i,:) = -cMatrix18(odorOrder(i),:);
end
newMStep2 = newMStep1;
for i = 1:col18
    newMStep2(:,i) = newMStep1(:,ORNOrder(i));
end

% draw the heat map of the EC50 matrix
ec50Map = newMStep2;
figure;  pos = get(gcf, 'pos'); set(gcf, 'pos', [pos(1), pos(2), 610, 420]);
imagesc(ec50Map); 
set(gca, 'CLim', [0 max(ec50Map(:))]);
set(gca,'XTick',1:col18);
set(gca,'XTickLabel',infoORNList(ORNOrder));
set(gca,'xaxisLocation','top');
set(gca,'YTick',1:row18);
set(gca,'YTickLabel',odorList18(odorOrder));
set(gca, 'XTickLabelRotation', 45);
colormap(jet); c = colorbar; 
c.TickLabels{1} = 'NaN'; c.Label.String = '-log10(EC50)';
title('EC50'); 

%% Verify the fitting
% Calculate the percentage of variance explained by the fitting
% Using the logistic equation and fitted parameters generate activity value
% and compare with the actual activity level

%claim variable to store the generated data 
yGen = NaN(rowTotal, colTotal, length(x));

%find out all the data elements need to be generated
[rowG, colG] = find(~isnan(cMatrix));

%calculate the 'predicted' activities
for i = 1: length(rowG)
    a = aMatrix(rowG(i), colG(i));
    b = slop;
    c = cMatrix(rowG(i), colG(i));
    yGen(rowG(i), colG(i), :) = a./(1+ exp(-b*(x-c)));
end

% calculate how many variance captured by the fitting
myIndex = find(~isnan(yGen));
residualData = dataRawAve(myIndex)- yGen(myIndex); %calculate the differences between the real and fitted data

varTotal = var(dataRawAve(myIndex));
varResidual = var(residualData(:));

rSquareFit = 1- varResidual/varTotal;

disp('----------GOODNESS OF THE FITTINGS ----------');
disp(['R-square of the fitting of the entire dataset: ', num2str(rSquareFit)]);

% scatter plot calculate-vs-actual data 
actualData = dataRawAve(myIndex);
genData = yGen(myIndex);
figure; plot(actualData, genData, 'ok', 'MarkerSize', 6);
axis([-1 8 -1 8]);
hold on; 
plot(linspace(-1, 8, 100), linspace(-1, 8, 100), '--k', 'LineWidth',1.5)
xlabel('Actual data');
ylabel('Generated data');
set(gcf, 'Position', [600 500 560 420])
title(['R^2 of the fitting: ', num2str(rSquareFit)]);

%% Save analyzed data 
save(fullfile('.', 'AnalysisResults', 'FitDoseResponse.mat'), 'aMatrix', 'cMatrix', 'slop', 'r2Matrix');
diary off;
