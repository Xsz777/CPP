function position = dive_back(start_position, end_position, down_transl_spd, an, fps)
    traj = mtraj(@lspb, start_position, end_position, round(norm(end_position - start_position)/down_transl_spd));
    %traj = traj_new([start_position;end_position], down_transl_spd, 100, 100, 100, 3, 2, 2, 1.5, 1, 1);

    show_trajectory(an,traj,fps); 
    position = end_position;
end