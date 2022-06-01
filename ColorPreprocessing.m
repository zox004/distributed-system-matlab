imageFolder = fullfile('/mnt/Chest_Xrays/','dataset');
imds = imageDatastore(imageFolder, 'LabelSource', 'foldernames', 'IncludeSubfolders', true);


auimds = augmentedImageDatastore([256, 256, 3],imds,'ColorPreprocessing','gray2rgb');


Train_Data = partitionByIndex(auimds,[1:900]);
Test_Data = partitionByIndex(auimds,[901:1125]);
