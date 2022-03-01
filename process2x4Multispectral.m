%%%%%%%%%%%%%%%%%%%%%%%% Configuration Variables %%%%%%%%%%%%%%%%%%%%%%%%%%

baseImg = imread('base2.tif'); % Ensure that this file path matches the file you want to process.
baseName = 'processedImage'; % Name of output images
addDesc = true; % Displays Band # and frequency on each quadrant
descFontSize = 10; % Description font size


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tifExt = '.tif';
options.append = true;

% Insert description text for each quad
if addDesc
    baseImg = insertText(baseImg, [11 11], 'Band 1 @ 720nm', 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [267 11], 'Band 2 @ 760nm', 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [523 11], 'Band 3 @ 795nm', 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [779 11], 'Band 4 @ 830nm', 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [11 267], 'Band 5 @ 870nm', 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [267 267], 'Band 6 @ 905nm', 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [523 267], 'Band 7 @ 940nm', 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [779 267], 'Band 8 @ 980nm', 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
end

n=0; % Counter for numbering processedImage files

% Capture each individual quad using their pixel coordinates
quad1 = baseImg(1:256,1:256);
quad2 = baseImg(1:256,257:512);
quad3 = baseImg(1:256,513:768);
quad4 = baseImg(1:256,769:1024);
quad5 = baseImg(257:512,1:256);
quad6 = baseImg(257:512,257:512);
quad7 = baseImg(257:512,513:768);
quad8 = baseImg(257:512,769:1024);

quadArray = [quad1 quad2 quad3 quad4 quad5 quad6 quad7 quad8];

% Check to see if a file already exists with the default name.
% If so, begin iteratively looking for next possible filename.
% Save decided file name as finalName.
% Finish by appending the .tif file extension to the finalName
while isfile(append(baseName, tifExt))
    baseName = 'processedImage'; 
    n= int2str(n+1);
    baseName = append(baseName, n);
    n = str2double(n);
end
finalName = append(baseName, tifExt);

% Save and append each quadrant to the processedImage.tif file.
% Allows for viewing in sliceViewer()

saveastiff(quad1, finalName, options)
saveastiff(quad2, finalName, options)
saveastiff(quad3, finalName, options)
saveastiff(quad4, finalName, options)
saveastiff(quad5, finalName, options)
saveastiff(quad6, finalName, options)
saveastiff(quad7, finalName, options)
saveastiff(quad8, finalName, options)

% Load in processedImage.tif as result, then load the figure window,
% and subsequently view slices. Finally, apply selected colormap.
result = loadtiff(finalName);
figure('Name',finalName,'NumberTitle','off')
sliceViewer(result);
colormap default % CHANGE COLOR MAP HERE