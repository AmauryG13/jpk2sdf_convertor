function write_image(filename, data)

image = data.image;
headers = data.headers;

fid = fopen(filename, 'w+');

fprintf(fid, 'aBCR-1.0\n');

headers.NumPoints = int2str(size(image, 1));
headers.NumProfiles = int2str(size(image, 2));

append_headers(fid, headers);
append_data(fid, image, headers);
append_footer(fid, headers);

fclose(fid);

end

%%
function append_headers(fid, headers)
    hFormat = '%s\t= %s\n';
    fields = fieldnames(headers);
    
    for h = 1:length(fields)
        if ~isempty(headers.(fields{h}))
            fprintf(fid, hFormat, fields{h}, headers.(fields{h}));
        end
    end
    
    fprintf(fid, '*\n\n');
end

function append_data(fid, image, headers)
    nbProfiles = str2double(headers.NumProfiles);
    
    for profile = 1:nbProfiles
        line = image(profile,:);
        
        fprintf(fid, '%.4f ', line);
        fprintf(fid, '\n');
    end
    
    fprintf(fid, '\n');
end

function append_footer(fid, data)
    fprintf(fid, '*\n\n*\n');
end
