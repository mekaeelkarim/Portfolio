function [betaFeat] = betaPower(sig, atts, betaFeat, featVals)

for ii = 1:width(sig)
    for jj = 0:featVals
        if jj == 0
            betaFeat(1,ii) = jfeeg('bpb',sig(1:(jj+1)*atts.interv,ii),atts);
        elseif jj == featVals
            betaFeat(featVals, ii) = jfeeg('bpb',sig((jj-1)*atts.interv:(jj)*atts.interv,ii),atts);
        else
            betaFeat(jj,ii) = jfeeg('bpb',sig(jj*atts.interv:(jj+1)*atts.interv,ii),atts);
        end
    end
end

end