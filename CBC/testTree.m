function [ predictions ] = testTree(tree, features)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

predictions = zeros(length(features), 1);

for i=1:length(features)
    predictions(i) = testFeature(tree, features(i, :));
end

end

