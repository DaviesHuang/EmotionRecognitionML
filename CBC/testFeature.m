function [ prediction ] = testFeature(tree, feature)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
prediction = 0;
depth = 0;

while isempty(tree.class)
    depth = depth + 1;
    tree = tree.kids{feature(tree.op) + 1};
end
prediction = tree.class;
end

