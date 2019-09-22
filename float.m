function position = float(start_position, end_position, transl_spd, an, fps,down_transl_spd,z_cruising)%,rot_spd)
    up_position = [start_position(1) start_position(2) z_cruising];
    show(an, start_position,up_position, fps,down_transl_spd);
    show(an,up_position,end_position, fps,down_transl_spd);
    position = end_position;
    %position_s = dive_back(start_position,up_position, transl_spd, an, fps);
%     orientation_s = 0;
%     orientation_s = rotate(orientation_s, calc_orientation(position_s(1:2), end_position(1:2)), rot_spd);
    %position = dive_back(up_position, end_position, transl_spd, an, fps);
end