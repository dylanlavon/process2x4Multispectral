%%%%%%%%%%%%%%%%%%%%%%%% Configuration Variables %%%%%%%%%%%%%%%%%%%%%%%%%%

processedImageDirectory = './processedImages/';
cMap = summer;            % Define which colormap to use

%%%%%%%%%%%%%%%%%%%%%%%% CONSTNATS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numOfBands = {'1' '2' '4' '6' '8'}';
oneBand = {};
twoBand = {};
fourBand = {};
sixBand = {};
eightBand = {};
namesOfBands = {oneBand twoBand fourBand sixBand eightBand};
tifExt = '.tif';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% BEGIN GETTING ALL IMAGE PATHS PLACED INTO ARRAYS

for bandFolder = 1:length(numOfBands)
    currentBandFolder = char(numOfBands(bandFolder));
    imagePath = append('./baseImages/', currentBandFolder, '/');
    size = dir([imagePath '/*.tif']);
    num = numel(size);

    if currentBandFolder == '1' && num >= 1
        for x = 3:numel(dir(imagePath))
            folder = dir(imagePath);
            stripped = folder(x).name;
            stripped = stripped(1:end-4);
            oneBand = [oneBand, stripped];
        end
    end
    if currentBandFolder == '2' && num >= 1
        for x = 3:numel(dir(imagePath))
            folder = dir(imagePath);
            stripped = folder(x).name;
            stripped = stripped(1:end-4);
            twoBand = [twoBand, stripped];
        end
    end
    if currentBandFolder == '4' && num >= 1
        for x = 3:numel(dir(imagePath))
            folder = dir(imagePath);
            stripped = folder(x).name;
            stripped = stripped(1:end-4);
            fourBand = [fourBand, stripped];
        end
    end
    if currentBandFolder == '6' && num >= 1
        for x = 3:numel(dir(imagePath))
            folder = dir(imagePath);
            stripped = folder(x).name;
            stripped = stripped(1:end-4);
            sixBand = [sixBand, stripped];
        end
    end
    if currentBandFolder == '8' && num >= 1
        for x = 1:numel(dir(imagePath)) - 2
            folder = dir(imagePath);
            stripped = folder(x).name;
            stripped = stripped(1:end-4);
            eightBand = [eightBand, stripped];
        end
    end
end
%% 

allImagePaths = {};

% Loop through each item of each folder
for folderIndex = 1:length(numOfBands)
    for imageIndex = 1:numel(dir(string(append('./baseImages/', numOfBands(folderIndex), '/')))) - 2 % account for . and .. 
        slicePath = string(append('./baseImages/', numOfBands(folderIndex), '/'));
        sliceDir = dir(slicePath);
        sliceDir(1:2) = [];
        name = sliceDir(imageIndex).name;
        basePath = append('./baseImages/', numOfBands(folderIndex));
        numBands = numOfBands(folderIndex);

        % Capture each individual quad using their pixel coordinates, then add each
        % quad to the quadCellArray.

        
        baseImg = imread(string(append(basePath, '/', name)));
        originalBaseName = name(1:end-4);
        quadCellArray = {};
        n=0; % Counter for numbering processedImage files
        
    
        % Set up numRows and numCols for each amount of bands
        if cell2mat(numOfBands(folderIndex)) == '1'
            numRows = 1;
            numCols = 1;
        end
        if cell2mat(numOfBands(folderIndex)) == '2'
            numRows = 1;
            numCols = 2;
        end
        if cell2mat(numOfBands(folderIndex)) == '4'
            numRows = 1;
            numCols = 4;
        end
        if cell2mat(numOfBands(folderIndex)) == '6'
            numRows = 2;
            numCols = 4;
        end
        if cell2mat(numOfBands(folderIndex)) == '8'
            numRows = 2;
            numCols = 4;
        end

        % Calculate additional variables to aid in slicing into quads
        baseImgHeight = numRows * 256;
        baseImgWidth = numCols * 256;
        horSliceIncrement = baseImgWidth / numCols;
        vertSliceIncrement = baseImgHeight / numRows;
        startVert = 1; endVert = vertSliceIncrement; startHor = 1; endHor = horSliceIncrement;

        % Slice each image into quads.
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

        strippedName = name(1:end-4);
        originalStrippedName = strippedName;
        
        while isfile(append(processedImageDirectory, strippedName, tifExt))
            strippedName = originalStrippedName;
            n= int2str(n+1);
            strippedName = append(strippedName, n);
            n = str2double(n);
        end
        finalName = append(processedImageDirectory, strippedName, tifExt);
        
        % Save and append each quadrant to the processedImages folder.      
        for i = 1:str2num(cell2mat(numBands))
            imwrite(cell2mat(quadCellArray(i)),cMap, finalName, 'WriteMode','append');
        end
    end
end

  