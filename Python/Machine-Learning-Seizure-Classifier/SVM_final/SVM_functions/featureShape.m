function [featShape,featVals, atts] = featureShape(raws,atts)

totVals = height(raws);
atts.interv = 1*atts.fs;

featVals = floor(totVals/atts.interv);

featShape = zeros(featVals,width(raws));

end

