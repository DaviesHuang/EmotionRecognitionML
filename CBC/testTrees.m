function [ predictions ] = testTrees(trees, features)

predictions = zeros(length(features), 1);
depths = zeros(length(features), 1);
depths_0 = zeros(length(features), 2);
count = 0;

for i=1 : length(trees)
    predictionWithDepth = testTree(trees(i),features);
    for j=1 : length(predictionWithDepth)
        if predictionWithDepth(j, 1) == 1 && depths(j) == 0
            predictions(j) = i;
            depths(j) = predictionWithDepth(j, 2);  
        elseif predictionWithDepth(j, 1) == 1 && predictionWithDepth(j, 2) < depths(j)
            %use the class with fewer depth when there are multiple classes
            predictions(j) = i;
            depths(j) = predictionWithDepth(j, 2);
        elseif predictions(j) == 0 && predictionWithDepth(j, 1) == 0 && predictionWithDepth(j, 2) > depths_0(j, 2)
            depths_0(j, 1) = i;
            depths_0(j, 2) = predictionWithDepth(j, 2);
        end
    end  
end 

for i=1 : length(predictions)
    if predictions(i) == 0
        predictions(i) = depths_0(i, 1);
    end
end

end

