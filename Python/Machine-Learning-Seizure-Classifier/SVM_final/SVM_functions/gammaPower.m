function [gammaFeat] = gammaPower(sig, atts, gammaFeat, featVals)


for ii = 1:width(sig)
    for jj = 0:featVals
        if jj == 0
            gammaFeat(1,ii) = jfeeg('bpg',sig(1:(jj+1)*atts.interv,ii),atts);
        elseif jj == featVals
            gammaFeat(featVals, ii) = jfeeg('bpg',sig((jj-1)*atts.interv:(jj)*atts.interv,ii),atts);
        else
            gammaFeat(jj,ii) = jfeeg('bpg',sig(jj*atts.interv:(jj+1)*atts.interv,ii),atts);
        end
    end
end

end