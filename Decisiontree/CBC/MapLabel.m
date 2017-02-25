function [labels] = MapLabel(labels,emolab)
for i = 1:size(labels)
    if labels(i) == emolab
        labels(i) = 1;
    else
        labels(i) = 0;
    end
end