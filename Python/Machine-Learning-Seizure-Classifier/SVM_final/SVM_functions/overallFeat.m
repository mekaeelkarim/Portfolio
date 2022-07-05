function [overallFeat,overallLabel] = overallFeat(oldFeat,newFeat, oldLabel, newLabel)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
overallFeat = [oldFeat;newFeat];
overallLabel = [oldLabel;newLabel]; 
end