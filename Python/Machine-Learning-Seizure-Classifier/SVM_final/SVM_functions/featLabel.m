function [labeledFeat] = featLabel(labeledArray,feat)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
featLabels = zeros(height(feat),1);
for i = 1:height(labeledArray)
    if i == 1
        ind1 = 1;
    else
        ind1 = round(labeledArray(i,1));
    end
    ind2 = round(labeledArray(i,2));
    featLabels(ind1:1:ind2) = labeledArray(i,3);  
end 
labeledFeat = featLabels;
end

