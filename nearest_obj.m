function [index, dist] = nearest_obj(position, objects)%最近目标点
    if isempty(objects)
        index = -1;
        dist =1000;
        return;
    end
    
    index = 1;
    dist = norm(position - objects(1,:));
    for i = 1:size(objects, 1)
        if norm(position - objects(i,:)) < dist
            index = i;
            dist = norm(position - objects(i,:));
        end
    end
    
end