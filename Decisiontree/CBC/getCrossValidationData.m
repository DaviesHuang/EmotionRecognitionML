function [trainingX, validationX, testX, trainingY, validationY, testY ] = getCrossValidationData(x, y, fold)

if fold == 10
    trainingX = x(1:800, :);
    validationX = x(801:900, :);
    testX = x(901:length(x), :);
    
    trainingY = y(1:800, :);
    validationY = y(801:900, :);
    testY = y(901:length(y), :);
    return;
end    

testX = x(1 + (fold - 1) * 100 : fold * 100, :);
trainingX = vertcat(x(1:(fold - 1) * 100, :), x(fold * 100 + 1 : 900, :));
validationX = x(901:length(x), :);

testY = y(1 + (fold - 1) * 100 : fold * 100, :);
trainingY = vertcat(y(1:(fold - 1) * 100, :), y(fold * 100 + 1 : 900, :));
validationY = y(901:length(y), :);

end

