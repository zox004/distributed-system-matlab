str = input('Type input size : ', 's');

inputSize = [];
inputSize = sscanf(str,'%f',[1,Inf]);


imageFolder = fullfile('/mnt/Chest_Xrays/','dataset');
imds = imageDatastore(imageFolder, 'LabelSource', 'foldernames', 'IncludeSubfolders', true);


auimds = augmentedImageDatastore(inputSize,imds,'ColorPreprocessing','gray2rgb');


Training_Data = partitionByIndex(auimds,[1:900]);
Validation_Data = partitionByIndex(auimds,[901:1125]);
