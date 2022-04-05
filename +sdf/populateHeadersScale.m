function headers = populateHeadersScale(headers, scale)
%POPULATEHEADERSSCALE Summary of this function goes here
%   Detailed explanation goes here

headers.Xscale = sprintf('%s', scale(1));
headers.Yscale = sprintf('%s', scale(2));
headers.Zscale = sprintf('%s', scale(3));
headers.Zresolution = sprintf('%s', scale(4));
end

