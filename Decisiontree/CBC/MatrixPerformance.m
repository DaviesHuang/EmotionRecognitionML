function [recall, precision, f1Measure, classificationRate] = MatrixPerformance(confusionMatrix)

    dim = size(confusionMatrix, 1);
    recall = zeros(dim, 1);
    precision = zeros(dim, 1);
    f1Measure = zeros(dim, 1);
    diagonalSum = 0;
    totalSum = 0;
    
    for i = 1 : dim
        
        valRecall = 0;
        valPrecision = 0;
        for j = 1 : dim
            valRecall = valRecall + confusionMatrix(i, j);
            valPrecision = valPrecision + confusionMatrix(j, i);
        end
        
        totalSum = totalSum + valRecall;
        diagonalSum = diagonalSum + confusionMatrix(i, i);
        valRecall = confusionMatrix(i, i) / valRecall;
        valPrecision = confusionMatrix(i, i) / valPrecision;
        
        recall(i, 1) = valRecall;
        precision(i, 1) = valPrecision;
        f1Measure(i, 1) = 2 * (valPrecision * valRecall / (valPrecision + valRecall));
        
    end
    
    classificationRate = diagonalSum / totalSum;

end