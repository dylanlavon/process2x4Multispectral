numOfBands = {'1' '2' '4' '6' '8'}'
oneBand = {};
twoBand = {};
fourBand = {};
sixBand = {};
eightBand = {};


for bandFolder = 1:length(numOfBands)
    currentBandFolder = char(numOfBands(bandFolder));
    imagePath = append('./baseImages/', currentBandFolder, '/');
    size = dir([imagePath '/*.tif']);
    num = numel(size);

    if currentBandFolder == '1' && num >= 1
        for x = 3:numel(dir(imagePath))
            folder = dir(imagePath);
            oneBand = [oneBand, append(folder(x).folder, '\', folder(x).name)]
        end
    end
    if currentBandFolder == '2' && num >= 1
        for x = 3:numel(dir(imagePath))
            folder = dir(imagePath);
            twoBand = [twoBand, append(folder(x).folder, '\', folder(x).name)]
        end
    end
    if currentBandFolder == '4' && num >= 1
        for x = 3:numel(dir(imagePath))
            folder = dir(imagePath);
            fourBand = [fourBand, append(folder(x).folder, '\', folder(x).name)]
        end
    end
    if currentBandFolder == '6' && num >= 1
        for x = 3:numel(dir(imagePath))
            folder = dir(imagePath);
            sixBand = [sixBand, append(folder(x).folder, '\', folder(x).name)]
        end
    end
    if currentBandFolder == '8' && num >= 1
        for x = 3:numel(dir(imagePath))
            folder = dir(imagePath);
            eightBand = [eightBand, append(folder(x).folder, '\', folder(x).name)]
        end
    end
end

testImg = imread(char(eightBand(1)))
