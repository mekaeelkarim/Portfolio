function [TT, valueMat, atts] = loadIn(EDFfile)
raw = edfread2(EDFfile);
%info = edfinfo(EDFfile);
labels = ["EEGFP1_LE","EEGFP2_LE","EEGF3_LE", "EEGF4_LE", "EEGC3_LE", "EEGC4_LE", "EEGA1_LE", "EEGA2_LE", "EEGP3_LE", "EEGP4_LE", "EEGO1_LE", "EEGO2_LE", "EEGF7_LE", "EEGF8_LE", "EEGT3_LE", "EEGT4_LE", "EEGT5_LE", "EEGT6_LE", "EEGFZ_LE", "EEGCZ_LE", "EEGPZ_LE", "EEGOZ_LE"];
atts.fs = height(raw.EEGFP1_LE{1,1}); 

raw = raw(:,labels);



lentt = height(raw);
t = (0 + (1/250):1/atts.fs:lentt)';
s = seconds(t);

%vars = [28 29 30];
%rawR = removevars(raw,vars);

rawCellArray = table2array(raw);

valueMat = zeros(atts.fs*lentt,width(rawCellArray));
lenra = height(valueMat);
count = 1;

while count <= width(valueMat)
        temp = vertcat(rawCellArray{1:lentt,count});
        valueMat(1:lenra,count) = temp;
        count = count + 1;
end

valueMat = TCPMont(valueMat);
montLabel = ["FP1-F7", "F7-T3", "T3-T5", "T5-O1", "FP2-F8", "F8-T4", "T4-T6", "T6-O2", "A1-T3", "T3-C3", "C3-CZ", "CZ-C4", "C4-T4", "T4-A2", "FP1-F3", "F3-C3", "C3-P3", "P3-O1", "FP2-F4", "F4-C4", "C4-P4", "P4-O2"];

TT = array2timetable(valueMat, 'RowTimes', s, 'VariableNames', montLabel);

%TT = TT(:,["EEG FP1-LE","EEG FP2-LE","EEG F3-LE", "EEG F4-LE", "EEG C3-LE", "EEG C4-LE", "EEG P3-LE", "EEG P4-LE", "EEG O1-LE", "EEG O2-LE", "EEG F7-LE", "EEG F8-LE", "EEG T3-LE", "EEG T4-LE", "EEG T5-LE", "EEG T6-LE", "EEG FZ-LE", "EEG CZ-LE", "EEG PZ-LE", "EEG OZ-LE"]);


end




