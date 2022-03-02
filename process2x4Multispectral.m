%%%%%%%%%%%%%%%%%%%%%%%% Configuration Variables %%%%%%%%%%%%%%%%%%%%%%%%%%

baseImg = imread('base2.tif'); % Ensure that this file path matches the file you want to process.
numRows = 2;                   % Number of rows of quads in the base image
numCols = 4;                   % Number of columns of quads in the base image
baseName = 'processedImage';   % Name of output images
addDesc = true;                % Displays Band # and frequency on each quadrant
descFontSize = 10;             % Description font size
cMap = 'parula(5)';            % Define which colormap to use

% Band Frequencies, ignore if you aren't using the Description Text on
% line 7.
band1 = '720nm';
band2 = '760nm';
band3 = '705nm';
band4 = '830nm';
band5 = '870nm';
band6 = '905nm';
band7 = '940nm';
band8 = '980nm';
[baseImgHeight, baseImgWidth] = size(baseImg);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tifExt = '.tif';
options.append = true;
n=0; % Counter for numbering processedImage files

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Insert description text for each quad
if addDesc
    baseImg = insertText(baseImg, [11 11], append('Band 1 @ ', band1), 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [267 11], append('Band 2 @ ', band2), 'FontSize',descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [523 11], append('Band 3 @ ', band3), 'FontSize',descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [779 11], append('Band 4 @ ', band4), 'FontSize',descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [11 267], append('Band 5 @ ', band5), 'FontSize',descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [267 267], append('Band 6 @ ', band6), 'FontSize',descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [523 267], append('Band 7 @ ', band7), 'FontSize',descFontSize, BoxOpacity=0, TextColor='white');
    baseImg = insertText(baseImg, [779 267], append('Band 8 @ ', band8), 'FontSize',descFontSize, BoxOpacity=0, TextColor='white');
end


% Capture each individual quad using their pixel coordinates
quad1 = baseImg(1:256,1:256);
quad2 = baseImg(1:256,257:512);
quad3 = baseImg(1:256,513:768);
quad4 = baseImg(1:256,769:1024);
quad5 = baseImg(257:512,1:256);
quad6 = baseImg(257:512,257:512);
quad7 = baseImg(257:512,513:768);
quad8 = baseImg(257:512,769:1024);
quadCellArray = {quad1, quad2, quad3, quad4, quad5, quad6, quad7, quad8};

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

for i = 1:8
    saveastiff(cell2mat(quadCellArray(i)), finalName, options)
end


% Load in processedImage.tif as result, then load the figure window,
% and subsequently view slices. Finally, apply selected colormap.

result = loadtiff(finalName);
figure('Name',finalName,'NumberTitle','off')
sliceViewer(result);
colormap(cMap)
