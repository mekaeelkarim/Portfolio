function [hjorthFeatA] = hjorthA(sig, atts, hjorthFeatA, featVals)

for ii = 1:width(sig)
    for jj = 0:featVals
        if jj == 0
            hjorthFeatA(1,ii) = jfeeg('ha',sig(1:(jj+1)*atts.interv,ii),atts);
        elseif jj == featVals
            hjorthFeatA(featVals, ii) = jfeeg('ha',sig((jj-1)*atts.interv:(jj)*atts.interv,ii),atts);
        else
            hjorthFeatA(jj,ii) = jfeeg('ha',sig(jj*atts.interv:(jj+1)*atts.interv,ii),atts);
        end
    end
end

end