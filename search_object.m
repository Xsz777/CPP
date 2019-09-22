function [has_object, position] = search_object(objects, pose, detect_radius, work_radius)
    has_object = false;
    position = [-1000 -1000 -1000];
    positions = [];
    for i=1:size((objects),1)
        if norm(objects(i,1:2)-pose(1:2)) < detect_radius ...%norm(¾ØÕó)Çó¾àÀë
            && within_boundary() ... %within_boundary is a to-do function. Now we set the return value to be true
            && abs(sin(pose(4))*pose(1) - cos(pose(4))*pose(2) + cos(pose(4))*objects(i,2) - sin(pose(4))*objects(i,1)) <= work_radius
                has_object = true;
                positions = [positions; objects(i,:)];
        end
    end
    
    if has_object
        min_distance = 10000;
        for i = 1:size(positions, 1)
            if norm(positions(i,:)-pose(1:3)) <min_distance
                min_distance = norm(positions(i,:)-pose(1:3));
                position = positions(i,:);
            end
        end
    end
end