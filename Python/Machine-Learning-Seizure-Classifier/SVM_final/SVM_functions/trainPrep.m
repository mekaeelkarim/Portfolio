function [finTrainFeat,finTrainLabel] = trainPrep(edfFiles,tseFiles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
tot = width(edfFiles);

finTrainFeat = [];
finTrainLabel = [];
for x = 1:tot
    edfFile = edfFiles(x);
    tseFile = tseFiles(x);
    [TT, valueMat, atts] = loadIn(edfFile.name);
    [featShape,featVals, atts] = featureShape(valueMat, atts);
    labeledArray = labels(tseFile.name);
    betaFeat = betaPower(valueMat, atts,featShape, featVals);
    %hjorthFeat = hjorthA(valueMat, atts, featShape, featVals);
    %gammaFeat = gammaPower(valueMat, atts, featShape, featVals);
    %newFeat = [betaFeat, gammaFeat];
    %newFeat = [betaFeat, hjorthFeat];
    labeledFeat = featLabel(labeledArray, featShape);
    [finTrainFeat, finTrainLabel] = overallFeat(finTrainFeat, betaFeat, finTrainLabel, labeledFeat);
end
end