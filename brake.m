%this function can only handle scene like that: the trajectory plane is
%parallel to xOy plane.
function end_position = brake(start_pose, start_v, max_deceleration, al, fps)
    %al = animatedline('Color',[1 .7 .7],'Marker','.');
    v_scalar = norm(start_v);
    delta_s = v_scalar*v_scalar / (2*max_deceleration);
    end_position = start_pose(1:3);
    end_position(1:2) = start_pose(1:2) + [delta_s*cos(start_pose(4)) delta_s*sin(start_pose(4))];
    traj = jtraj(start_pose(1:3), end_position, round(abs(start_v)/max_deceleration), start_v, [0 0 0]);
    show_trajectory(al, start_pose, fps);
    show_trajectory(al, traj, fps);
end