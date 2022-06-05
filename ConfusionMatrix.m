% This code is for calculating top1 accuracy, precision/recall and plot confusion matrix of the trained network


networkName = input('Type Network name : ', 's');
net = trainedNetwork_1;

imageFolder = fullfile('/mnt/Chest_Xrays/','dataset');
imds = imageDatastore(imageFolder, 'LabelSource', 'foldernames', 'IncludeSubfolders', true);
imds = shuffle(imds);

imageSize = net.Layers(1).InputSize;
augmentedTestSet = augmentedImageDatastore(imageSize, imds, 'ColorPreprocessing', 'gray2rgb');

featureLayer = 'classoutput';

labels = imds.Labels;
predictedLabels = predict(net, augmentedTestSet)';

[~, pli] = max(predictedLabels);
predictedLabels = predictedLabels';



plc = categorical();
pred_Covid_19 = zeros(2, length(pli))';
pred_No_findings = zeros(2, length(pli))';
pred_Pneumonia = zeros(2, length(pli))';

resp_Covid_19 = zeros(1, length(pli))';
resp_No_findings = zeros(1, length(pli))';
resp_Pneumonia = zeros(1, length(pli))';

for i = 1 : length(pli)
    if pli(i) == 1
        plc(i) = 'Covid-19';
        resp_Covid_19(i, 1) = 1;

    elseif pli(i) == 2
        plc(i)= 'No_findings';
        resp_No_findings(i, 1) = 1;

    elseif pli(i) == 3
        plc(i)= 'Pneumonia';
        resp_Pneumonia(i, 1) = 1;
    
    else
        disp('Error occured during labeling')
    end

    pred_Covid_19(i, 1) = predictedLabels(i, 1);
    pred_Covid_19(i, 2) = sum(predictedLabels(i, 2:3));
    pred_No_findings(i, 1) = predictedLabels(i, 2);
    pred_No_findings(i, 2) = sum([predictedLabels(i, 1), sum(predictedLabels(i, 3))]);
    pred_Pneumonia(i, 1) = predictedLabels(i, 3);
    pred_Pneumonia(i, 2) = sum([sum(predictedLabels(i, 1:2))]);
end

plc = plc';


mdl_Covid_19 = fitglm(pred_Covid_19,resp_Covid_19,'Distribution','binomial','Link','logit');
mdl_No_findings = fitglm(pred_No_findings,resp_No_findings,'Distribution','binomial','Link','logit');
mdl_Pneumonia = fitglm(pred_Pneumonia,resp_Pneumonia,'Distribution','binomial','Link','logit');


scores_Covid_19 = mdl_Covid_19.Fitted.Probability;
scores_No_findings = mdl_No_findings.Fitted.Probability;
scores_Pneumonia = mdl_Pneumonia.Fitted.Probability;


[X_Covid_19, Y_Covid_19, T_Covid_19, AUC_Covid_19] = perfcurve(labels, scores_Covid_19, 'Covid-19');
[X_No_findings, Y_No_findings, T_No_findings, AUC_No_findings] = perfcurve(labels, scores_No_findings, 'No_findings');
[X_Pneumonia, Y_Pneumonia, T_Pneumonia, AUC_Pneumonia] = perfcurve(labels, scores_Pneumonia, 'Pneumonia');








top1Accuracy = mean(plc == labels);
confMat = confusionmat(plc, labels);

tp = 0;
fp = 0;
fn = 0;

parfor i=1 : length(confMat(:, 1))
    for j=1 : length(confMat(1,:))
        if i == j
            tp = tp + confMat(i, j);
        elseif i > j
            fp = fp + confMat(i, j);
        elseif i < j
            fn = fn + confMat(i, j);
        else
            disp('Error occured during calculating precision/recall');
        end
    end
end


precision = tp/(tp + fp);
recall = tp/(tp + fn);

fprintf("Training accuracy : %f\n", mean(trainInfoStruct_1.TrainingAccuracy'));
fprintf("Training loss : %f\n", mean(trainInfoStruct_1.TrainingLoss'));
fprintf("Validation accuracy : %f\n", trainInfoStruct_1.FinalValidationAccuracy);
fprintf("Validation loss : %f\n", trainInfoStruct_1.FinalValidationLoss);
fprintf("Top 1 accuracy : %f\n", top1Accuracy*100);
fprintf('Precision : %f\n', precision);
fprintf('Recall : %f\n', recall);
fprintf('F1 Score : %f\n\n', 2 * (precision * recall)/(precision + recall));



figure(1)
plotconfusion(labels, plc, networkName);
grid

X_AUC1 = [0; 0; 1;];
Y_AUC1 = [0; 1; 1;];

X_AUC_05 = [0; 0.5; 1;];
Y_AUC_05 = [0; 0.5; 1;];

figure(2)
plot(X_AUC1, Y_AUC1, '-.')
hold on
plot(X_Covid_19, Y_Covid_19)
plot(X_No_findings, Y_No_findings)
plot(X_Pneumonia, Y_Pneumonia)
plot(X_AUC_05, Y_AUC_05, ':')


l_Covid_19 = strcat('Covid-19     AUC=', string(AUC_Covid_19));
l_No_findings = strcat('No_findings        AUC=', string(AUC_No_findings));
l_Pneumonia = strcat('Pneumonia      AUC=', string(AUC_Pneumonia));


legend('AUC = 1', l_Covid_19, l_No_findings, l_Pneumonia, 'AUC = 0.5', 'Location', 'Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves')
hold off

grid
% This code is for calculating top1 accuracy, precision/recall and plot confusion matrix of the trained network


networkName = input('Type Network name : ', 's');
net = trainedNetwork_1;

imageFolder = fullfile('/mnt/Chest_Xrays/','dataset');
imds = imageDatastore(imageFolder, 'LabelSource', 'foldernames', 'IncludeSubfolders', true);
imds = shuffle(imds);

imageSize = net.Layers(1).InputSize;
augmentedTestSet = augmentedImageDatastore(imageSize, imds, 'ColorPreprocessing', 'gray2rgb');

featureLayer = 'classoutput';

labels = imds.Labels;
predictedLabels = predict(net, augmentedTestSet)';

[~, pli] = max(predictedLabels);
predictedLabels = predictedLabels';



plc = categorical();
pred_Covid_19 = zeros(2, length(pli))';
pred_No_findings = zeros(2, length(pli))';
pred_Pneumonia = zeros(2, length(pli))';

resp_Covid_19 = zeros(1, length(pli))';
resp_No_findings = zeros(1, length(pli))';
resp_Pneumonia = zeros(1, length(pli))';

for i = 1 : length(pli)
    if pli(i) == 1
        plc(i) = 'Covid-19';
        resp_Covid_19(i, 1) = 1;

    elseif pli(i) == 2
        plc(i)= 'No_findings';
        resp_No_findings(i, 1) = 1;

    elseif pli(i) == 3
        plc(i)= 'Pneumonia';
        resp_Pneumonia(i, 1) = 1;
    
    else
        disp('Error occured during labeling')
    end

    pred_Covid_19(i, 1) = predictedLabels(i, 1);
    pred_Covid_19(i, 2) = sum(predictedLabels(i, 2:3));
    pred_No_findings(i, 1) = predictedLabels(i, 2);
    pred_No_findings(i, 2) = sum([predictedLabels(i, 1), sum(predictedLabels(i, 3))]);
    pred_Pneumonia(i, 1) = predictedLabels(i, 3);
    pred_Pneumonia(i, 2) = sum([sum(predictedLabels(i, 1:2))]);
end

plc = plc';


mdl_Covid_19 = fitglm(pred_Covid_19,resp_Covid_19,'Distribution','binomial','Link','logit');
mdl_No_findings = fitglm(pred_No_findings,resp_No_findings,'Distribution','binomial','Link','logit');
mdl_Pneumonia = fitglm(pred_Pneumonia,resp_Pneumonia,'Distribution','binomial','Link','logit');


scores_Covid_19 = mdl_Covid_19.Fitted.Probability;
scores_No_findings = mdl_No_findings.Fitted.Probability;
scores_Pneumonia = mdl_Pneumonia.Fitted.Probability;


[X_Covid_19, Y_Covid_19, T_Covid_19, AUC_Covid_19] = perfcurve(labels, scores_Covid_19, 'Covid-19');
[X_No_findings, Y_No_findings, T_No_findings, AUC_No_findings] = perfcurve(labels, scores_No_findings, 'No_findings');
[X_Pneumonia, Y_Pneumonia, T_Pneumonia, AUC_Pneumonia] = perfcurve(labels, scores_Pneumonia, 'Pneumonia');








top1Accuracy = mean(plc == labels);
confMat = confusionmat(plc, labels);

tp = 0;
fp = 0;
fn = 0;

parfor i=1 : length(confMat(:, 1))
    for j=1 : length(confMat(1,:))
        if i == j
            tp = tp + confMat(i, j);
        elseif i > j
            fp = fp + confMat(i, j);
        elseif i < j
            fn = fn + confMat(i, j);
        else
            disp('Error occured during calculating precision/recall');
        end
    end
end


precision = tp/(tp + fp);
recall = tp/(tp + fn);

fprintf("Training accuracy : %f\n", mean(trainInfoStruct_1.TrainingAccuracy'));
fprintf("Training loss : %f\n", mean(trainInfoStruct_1.TrainingLoss'));
fprintf("Validation accuracy : %f\n", trainInfoStruct_1.FinalValidationAccuracy);
fprintf("Validation loss : %f\n", trainInfoStruct_1.FinalValidationLoss);
fprintf("Top 1 accuracy : %f\n", top1Accuracy*100);
fprintf('Precision : %f\n', precision);
fprintf('Recall : %f\n', recall);
fprintf('F1 Score : %f\n\n', 2 * (precision * recall)/(precision + recall));



figure(1)
plotconfusion(labels, plc, networkName);
grid

X_AUC1 = [0; 0; 1;];
Y_AUC1 = [0; 1; 1;];

X_AUC_05 = [0; 0.5; 1;];
Y_AUC_05 = [0; 0.5; 1;];

figure(2)
plot(X_AUC1, Y_AUC1, '-.')
hold on
plot(X_Covid_19, Y_Covid_19)
plot(X_No_findings, Y_No_findings)
plot(X_Pneumonia, Y_Pneumonia)
plot(X_AUC_05, Y_AUC_05, ':')


l_Covid_19 = strcat('Covid-19     AUC=', string(AUC_Covid_19));
l_No_findings = strcat('No_findings        AUC=', string(AUC_No_findings));
l_Pneumonia = strcat('Pneumonia      AUC=', string(AUC_Pneumonia));


legend('AUC = 1', l_Covid_19, l_No_findings, l_Pneumonia, 'AUC = 0.5', 'Location', 'Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC Curves')
hold off

grid
