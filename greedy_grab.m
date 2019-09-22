function [position, orientation, objects] = greedy_grab(pose_start, objects, work_radius, search_radius, transl_spd, rot_spd, al, fps)
    position_s = pose_start(1:3);%x,y,z´ú±íposition
    orientation_s = pose_start(4);%
    position = position_s;
    [index, dist] = nearest_obj(position, objects);
    [position, orientation, objects] = grab(position, orientation_s, objects,index);
    [index, dist] = nearest_obj(position, objects);
    while dist < search_radius
        if dist < work_radius
            [position, orientation, objects] = grab(position, orientation_s, objects,index);
            [index, dist] = nearest_obj(position, objects);
            continue;
        else
             orientation = rotate(orientation, objects(index,1:2)-position(1:2), rot_spd);
             traj = mtraj(@lspb, position, objects(index, :), round(norm(position-objects(index, :))/0.5));
             show_trajectory(al, traj, fps);
             position = [objects(index,1:2) position(3)];
             [position, orientation, objects] = grab(position, orientation, objects,index);
             [index, dist] = nearest_obj(position, objects);
        end
    end
end
