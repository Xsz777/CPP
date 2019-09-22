function show(an, start_position,end_position, fps,down_transl_spd)
    %traj = mtraj(@lspb, start_position,end_position, round(norm(start_position-end_position))/down_transl_spd);
    %optimal_path = [start_position;end_position];
    %optimal_path_new = traj_new(optimal_path(1:2,:), down_transl_spd, 100, 100, 100, 3, 2, 2, 1.5, 1, 1);
    traj = traj_new([start_position;end_position], down_transl_spd, 100, 100, 100, 3, 2, 2, 1.5, 1, 1);
    i = 1; 
    a = tic;
    while i <= size(traj, 1)
        b = toc(a);
        if b > 1/fps
            addpoints(an, traj(i,1), traj(i, 2), traj(i, 3));
            drawnow
            i = i+1;
            a = tic;
        end
    end
end
