function [best_attribute] = ChooseBestDecisionAttribute(examples, attributes, binary_targets)

    best_ig = -1;
    best_attribute = 0;
    
    [targets_num, n] = size(binary_targets);
    p = sum(binary_targets);
    n = targets_num - p;
    overall_entropy = ENTROPY(p, n);

    [num, temp] = size(attributes);
    for i = 1 : num
        if (attributes(i) == 1)
            attr = examples(:,i);
            ig = INFORMATION_GAIN(attr, binary_targets, overall_entropy, targets_num);
            if (ig > best_ig)
                best_ig = ig;
                best_attribute = i;
            end
        end
    end

end

function [ig] = INFORMATION_GAIN(attr, binary_targets, overall_entropy, targets_num)

    p0 = 0;
    n0 = 0;
    p1 = 0;
    n1 = 0;

    for i = 1 : targets_num
       if (attr(i) == 0)
           
           if (binary_targets(i) == 1)
               p0 = p0 + 1;
           elseif (binary_targets(i) == 0)
               n0 = n0 + 1;
           end
           
       elseif (attr(i) == 1)
           
           if (binary_targets(i) == 1)
               p1 = p1 + 1;
           elseif (binary_targets(i) == 0)
               n1 = n1 + 1;
           end
           
       end
    end

    remainder = ((p0 + n0) / targets_num) * ENTROPY(p0, n0) + ((p1 + n1)/ targets_num) * ENTROPY(p1, n1);
    
    ig = overall_entropy - remainder;

end

function [entropy] = ENTROPY(p, n)

    p_proportion = p / (p + n);
    n_proportion = n / (p + n);
    p_term = -(p_proportion) * log2(p_proportion);
    n_term = -(n_proportion) * log2(n_proportion);
    
    if (p_proportion <= 0)
        p_term = 0;
    end
    
    if (n_proportion <= 0)
        n_term = 0;
    end
    
    entropy = p_term + n_term;
    
    if ((p + n) <= 0)
        entropy = 0;
    end
end