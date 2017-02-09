function [ predictions ] = testTree(tree, features)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

predictions = zeros(length(features), 2);

for i=1:length(features)
    [prediction, depth] = testFeature(tree, features(i, :));
    predictions(i, 1) = prediction;
    predictions(i, 2) = depth;
end

end

