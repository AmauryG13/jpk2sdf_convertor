%% 
clear all; close all;

%%
basedir = pwd;
datadir = fullfile(basedir, 'data');

[filenames, filepath] = uigetfile( ...
    {
        '*.jpk', 'JPK files';
    }, ...
    'Select files to convert', ... 
    datadir, ...
    'MultiSelect', 'on' ...
);

if ~iscell(filenames)
    filenames = {filenames};
end

sdfFilenames = cellfun(@(x) strrep(x, '.jpk', '.sdf'), filenames, 'UniformOutput', false);

for f = 1:length(filenames)
    filename = fullfile(filepath, filenames{f});

    [image, details] = jpk.open_image(filename);

    sdfData.image = image.AFM_image;
    
    headers = sdf.createHeadersStruct;
    headers = sdf.popluateHeadersDefault(headers);
    headers = sdf.populateHeadersScale(headers, ...
    [ ...
        details.x_scan_length / details.x_scan_pixels , ... X scale
        details.y_scan_length / details.y_scan_pixels, ... Y scale
        image.Scale_factor, ... Z scale
        -1e+6 ... Z resolution
    ]);
    

    sdfData.headers = headers;
    
    sdfFilename = fullfile(filepath, sdfFilenames{f});
    sdf.write_image(sdfFilename, sdfData);
end
