str = input('Type input size : ', 's');

inputSize = [];
inputSize = sscanf(str,'%f',[1,Inf]);


imageFolder = fullfile('/mnt/Chest_Xrays/','dataset');
imds = imageDatastore(imageFolder, 'LabelSource', 'foldernames', 'IncludeSubfolders', true);
imds = shuffle(imds);


[imds_T, imds_V] = splitEachLabel(imds,0.8);

Training_Data = augmentedImageDatastore(inputSize,imds_T,'ColorPreprocessing','gray2rgb');
Validation_Data = augmentedImageDatastore(inputSize,imds_V,'ColorPreprocessing','gray2rgb');
