attributes = ones(45, 1);

clean_data = load('cleandata_students.mat');
x = clean_data.x;
y = clean_data.y;
y = MapLabel(y,1);

tree = DecisionTreeLearning(x,attributes,y);
DrawDecisionTree(tree,'decisionTree');
result = testTree(tree, x);

%correct = sum((result == y) == 0);

correct = result == y;


