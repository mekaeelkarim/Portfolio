cd train
edfFilesTr = dir("*.edf")';
tseFilesTr = dir("*.tse_bi")';

[finTrainFeat, finTrainLabel] = trainPrep(edfFilesTr, tseFilesTr);

SVMModel = fitcsvm(finTrainFeat, finTrainLabel);

cd ../test
edfFilesTe = dir("*.edf")';
tseFilesTe = dir("*.tse_bi")';

[finTestFeat, finTestLabel] = testPrep(edfFilesTe, tseFilesTe);

prediction = predict(SVMModel, finTestFeat);

eval = classEval(prediction, finTestLabel);

