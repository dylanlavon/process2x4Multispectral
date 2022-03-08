% Variables %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numRows = 2;
numCols = 4;
numBands = numRows * numCols;

baseImgHeight = 512;           % In pixels, not including blank space
baseImgWidth = 1024;           % In pixels, not including blank space

horSliceIncrement = baseImgWidth / numCols;
vertSliceIncrement = baseImgHeight / numRows;
quadCellArray = {};
startVert = 1; endVert = vertSliceIncrement; startHor = 1; endHor = horSliceIncrement;
options.append = true;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Take base b&w image and apply colormapping
% Save colormapped image as jpg in mapped image directory

baseImg = imread('./baseImages/face8band.tif');
imwrite(baseImg,parula,'./mappedImages/mappedImage.jpg');
mappedImg = imread('./mappedImages/mappedImage.jpg');



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

% Save the image as a multilayer .tif image
for i = 1:numBands    
    imwrite(cell2mat(quadCellArray(i)),parula,'finalImage.tif','WriteMode','append')
end

result = loadtiff('finalImage.tif')

sliceViewer(result,"Colormap",parula)
