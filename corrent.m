function cur_position = corrent(cur_position, optimal_path, max_distance)
    ideal_position = optimal_path(1, :);
    if sqrt(power(cur_position(1,1)-ideal_position(1,1),2)+power(cur_position(1,2)-ideal_position(1,2),2)+power(cur_position(1,3)-ideal_position(1,3),2))>max_distance
        cur_position = 1;
    else
        cur_position = 0;
    end
end