function [confusionMatrix] = ConfusionMatrix(actual, predicted, n)

    confusionMatrix = zeros(n);
    num = size(actual, 1);
    
    for i = 1 : num
        row = actual(i, 1);
        col = predicted(i, 1);
        confusionMatrix(row, col) = confusionMatrix(row, col) + 1; 
    end

end