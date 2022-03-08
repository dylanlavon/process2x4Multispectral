clc;clear;

%%%%%%%%%%%%%%%%%%%%%%%% Configuration Variables %%%%%%%%%%%%%%%%%%%%%%%%%%

baseImageDirectory = './baseImages/';
processedImageDirectory = './processedImages/';

% Ensure that this file path matches the file you want to process.
% Do not add the file extension.
baseImgName = '01_03_22_Multispectral_face_8Band'; 
baseImgHeight = 512;           % In pixels, not including blank space
baseImgWidth = 1024;           % In pixels, not including blank space
numRows = 2;                   % Number of rows of quads in the base image
numCols = 4;                   % Number of columns of quads in the base image
addDesc = false;                % Displays Band # and frequency on each quadrant
descFontSize = 10;             % Description font size
cMap = parula;            % Define which colormap to use

% Band Frequencies, ignore if you aren't using the Description Text on
% line 7.
bands = {'720nm' '760nm' '805nm' '830nm' '870nm' '905nm' '940nm' '980nm'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tifExt = '.tif';

numBands = numCols .* numRows;
options.append = true;
n=0; % Counter for numbering processedImage files
horSliceIncrement = baseImgWidth / numCols;
vertSliceIncrement = baseImgHeight / numRows;
quadCellArray = {};
startVert = 1; endVert = vertSliceIncrement; startHor = 1; endHor = horSliceIncrement;

baseImg = imread(append(baseImageDirectory, baseImgName, tifExt));

descX = 11;
descY = 11;
bandCounter = 1;
originalBaseName = baseImgName;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Insert description text for each quad
if addDesc
    for i = 1:numRows
        for j = 1:numCols
            baseImg = insertText(baseImg, [descX descY], append('Band ', int2str(bandCounter) ,' @ ', bands(bandCounter)), 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
            descX = descX + horSliceIncrement;
            bandCounter = bandCounter + 1;
        end
        descY = descY + vertSliceIncrement;
        endVert = endVert + vertSliceIncrement;
        descX = 11;
    end
end

% Reset values to prepare for next loop.
startVert = 1; endVert = vertSliceIncrement; startHor = 1; endHor = horSliceIncrement; 


% Capture each individual quad using their pixel coordinates, then add each
% quad to the quadCellArray.

for i = 1:numRows
    for j = 1:numCols
        quad = baseImg(startVert:endVert,startHor:endHor);
        quadCellArray{end + 1} = quad;
        startHor = startHor + horSliceIncrement;
        endHor = endHor + horSliceIncrement;
    end
    startVert = startVert + vertSliceIncrement;
    endVert = endVert + vertSliceIncrement;
    startHor = 1;
    endHor = horSliceIncrement;
end


% Check to see if a file already exists with the default name.
% If so, begin iteratively looking for next possible filename.
% Save decided file name as finalName.
% Finish by appending the .tif file extension to the finalName

while isfile(append(processedImageDirectory, baseImgName, tifExt))
    baseImgName = originalBaseName;
    n= int2str(n+1);
    baseImgName = append(baseImgName, n);
    n = str2double(n);
end
finalName = append(processedImageDirectory, baseImgName, tifExt);

% Save and append each quadrant to the processedImage.tif file.
% Allows for viewing in sliceViewer()

for i = 1:numBands
    imwrite(cell2mat(quadCellArray(i)),cMap, finalName, 'WriteMode','append');
end


% Load in processedImage.tif as result, then load the figure window,
% and subsequently view slices. Finally, apply selected colormap.

result = loadtiff(finalName);
figure('Name',append('processed.',baseImgName, tifExt),'NumberTitle','off')
sliceViewer(result, "Colormap",cMap);
