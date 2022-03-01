function theta = smart_atan(theta)
%SMART_ATAN smart angle calculation using arctan for two input vectors
%   calculate arctan for two vectors and return the corresponding angle. We
%   will aim to return the correct value based on the sign fo the vectors
%   y, x

for indx = 1:length(theta)
    
    while theta(indx) < 0
        theta(indx) = theta(indx) + 2*pi;
    end

    while theta(indx) > 2*pi
        theta(indx) = theta(indx) - 2*pi;
    end
end

