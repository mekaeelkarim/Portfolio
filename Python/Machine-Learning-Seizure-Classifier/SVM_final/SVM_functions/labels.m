function [labeledArray] = labels(fileName)
classed = readcell(fileName,'FileType','text');

s1 = 'bckg';
s2 = 'seiz';

if width(classed) == 1
    testr = classed(2:height(classed),1:width(classed));
    testr = split(testr)';

    labs = zeros(height(testr),1);

    for ii = 1:height(testr)
        temp = testr(ii,3);
        id = strcmp(s1,temp);
        if id == 1
            labs(ii,1) = 0;
        else
            labs(ii,1) = 1;
        end
    end
    nolabsarr = str2double(testr);
    nolabsarr = nolabsarr(:,1:2);
    labeledArray = [nolabsarr,labs];
      
else
    testr = classed(2:height(classed),1:width(classed)-1);

    labs = zeros(height(testr),1);

    for ii = 1:height(testr)
        temp = testr(ii,3);
        id = strcmp(s1,temp);
        if id == 1
            labs(ii,1) = 0;
        else
            labs(ii,1) = 1;
        end
    end
    nolabsCell = testr(:,1:2);
    nolabsarr = cell2mat(nolabsCell);
    labeledArray = [nolabsarr,labs];
end

