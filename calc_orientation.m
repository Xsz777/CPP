function orientation = calc_orientation(start_position, end_position)
    direction = end_position(1:2) - start_position(1:2);
    orientation = acos(dot(direction, [1 0 ]) / (norm(direction) * 1));%两向量夹角的弧度
    if direction(2) < 0
        orientation = 2 * pi - orientation;
    end
end