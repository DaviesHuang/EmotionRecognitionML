attributes = ones(45, 1);

clean_data = load('cleandata_students.mat');
x = clean_data.x;
y = clean_data.y;
binary_targets = MapLabel(y,1);

tree = DecisionTreeLearning(x,attributes,binary_targets);
%DrawDecisionTree(tree,'decisionTree');

%DrawDecisionTree(tree,'t2');

%noisy data
%noisy_data = load('noisydata_students.mat');
%x = noisy_data.x;
%y = noisy_data.y;

classificationRateSum = 0;

for i=1:10
    [trainingX, validationX, testX, trainingY, validationY, testY] = getCrossValidationData(x,y,i);
    %use validation set as training set
    trainingX = [trainingX; validationX];
    trainingY = [trainingY; validationY];
    tree_f1c1 = DecisionTreeLearning(trainingX,attributes,MapLabel(trainingY,1));
    tree_f1c2 = DecisionTreeLearning(trainingX,attributes,MapLabel(trainingY,2));
    tree_f1c3 = DecisionTreeLearning(trainingX,attributes,MapLabel(trainingY,3));
    tree_f1c4 = DecisionTreeLearning(trainingX,attributes,MapLabel(trainingY,4));
    tree_f1c5 = DecisionTreeLearning(trainingX,attributes,MapLabel(trainingY,5));
    tree_f1c6 = DecisionTreeLearning(trainingX,attributes,MapLabel(trainingY,6));

    predictions = testTrees([tree_f1c1; tree_f1c2; tree_f1c3; tree_f1c4; tree_f1c5; tree_f1c6], testX);
    confusionMatrix = ConfusionMatrix(testY, predictions, 6);
    [recall, precision, f1Measure, classificationRate] = MatrixPerformance(confusionMatrix);
    classificationRateSum = classificationRate + classificationRateSum;
    classificationRate
end

classficationRateAvg = classificationRateSum / 10;


