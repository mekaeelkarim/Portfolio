function [eval] = classEval(labeledFeat, label)

eval.truePos = 0;
eval.falsePos = 0;
eval.trueNeg = 0;
eval.falseNeg = 0;
totPos = 0;
totNeg = 0;
totObs = height(label);

for i = 1:totObs
    trueVal = labeledFeat(i);
    classVal = label(i);
    if trueVal == 0
        totNeg = totNeg + 1;
        if classVal == 0
            eval.trueNeg = eval.trueNeg + 1;
        else
            eval.falsePos = eval.falsePos + 1;
        end
    else
        totPos = totPos + 1;
        if classVal == 1
            eval.truePos = eval.truePos + 1;
        else
            eval.falseNeg = eval.falseNeg + 1; 
        end
    end
end

eval.fPosRate = eval.falsePos / (eval.falsePos + eval.trueNeg);
eval.fNegRate = eval.falseNeg / (eval.falseNeg + eval.truePos);
eval.tPosRate = eval.truePos / (eval.truePos + eval.falseNeg);
eval.tNegRate = eval.trueNeg / (eval.trueNeg + eval.falsePos);
eval.acc = (eval.truePos + eval.trueNeg)/(eval.truePos + eval.trueNeg + eval.falsePos + eval.falseNeg);

end
