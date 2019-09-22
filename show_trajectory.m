function show_trajectory(al, traj, fps)
    i = 1;
    a = tic;
    while i <= size(traj, 1)
        b = toc(a);
        if b > 1/fps
            addpoints(al, traj(i,1), traj(i, 2), traj(i, 3));
            drawnow
            i = i+1;
            a = tic;
        end
    end
end