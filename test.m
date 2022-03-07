tifExt = '.tif';
baseImageDirectory = './baseImages/';
mappedImageDirectory = './mappedImages/';
baseImgName = 'face8band';
addDesc = true;
numRows = 2;                   % Number of rows of quads in the base image
numCols = 4;                   % Number of columns of quads in the base image
descX = 11;
descY = 11;
bandCounter = 1;
cMap = parula;
baseImgHeight = 512;           % In pixels, not including blank space
baseImgWidth = 1024;           % In pixels, not including blank space
bands = {'720nm' '760nm' '805nm' '830nm' '870nm' '905nm' '940nm' '980nm'};
descFontSize = 10;             % Description font size
horSliceIncrement = baseImgWidth / numCols;
vertSliceIncrement = baseImgHeight / numRows;
startVert = 1; endVert = vertSliceIncrement; startHor = 1; endHor = horSliceIncrement;

mappedImg = append(mappedImageDirectory, baseImgName, tifExt);
baseImg = imread(append(baseImageDirectory, baseImgName, tifExt));
imwrite(baseImg, cMap, mappedImg);
imshow(mappedImg)

imgToRead = imread(mappedImg)

if addDesc
    for i = 1:numRows
        for j = 1:numCols
            imgToRead = insertText(imgToRead, [descX descY], append('Band ', int2str(bandCounter) ,' @ ', bands(bandCounter)), 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
            descX = descX + horSliceIncrement;
            bandCounter = bandCounter + 1;
        end
        descY = descY + vertSliceIncrement;
        endVert = endVert + vertSliceIncrement;
        descX = 11;
    end
end

