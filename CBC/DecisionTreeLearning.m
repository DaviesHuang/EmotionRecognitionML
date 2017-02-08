function [tree] = DecisionTreeLearning(examples, attributes, binary_targets)

%if all(binary_targets == binary_targets(1))
if range(binary_targets) == 0
    %return leaf node with this value
    tree.op = [];
    tree.kids = [];
    tree.class = binary_targets(1);
    return;
elseif ~any(attributes)    %all elements are 0
    %return leaf node with value = MAJORITY-VALUE(binary_targets)
    tree.op = [];
    tree.kids = [];
    tree.class = mode(binary_targets);
    return;
else 
    best_attribute = ChooseBestDecisionAttribute(examples,attributes, binary_targets); 
    tree.op = best_attribute;
    tree.kids = cell(1, 2);
    tree.class = [];
    
    for i = 0:1
        %add a branch to tree corresponding to best_attibute = υi
        examples_new = examples(examples(:, best_attribute) == i, :);
        binary_targets_new = binary_targets(examples(:, best_attribute) == i);
        if isempty(examples_new)
            %return a leaf node with value = MAJORITY-VALUE(binary_targets)
            tree.op = [];
            tree.kids = [];
            tree.class = mode(binary_targets);
            return;
        else
            attributes_new = attributes;
            attributes_new(best_attribute) = 0;
            tree.kids{i + 1} = DecisionTreeLearning(examples_new, attributes_new, binary_targets_new);
        end
    end
              
                  
end

