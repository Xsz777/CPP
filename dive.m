function position = dive(start_position, end_position, down_transl_spd, an, fps)
    [North,South,Right,Left,autoch] =  look(end_position,start_position);
    Delta_x = abs(start_position(1)-end_position(1));
%     Delta_y = abs(start_position(2)-end_position(3));
%     Delta_z = H;
    if North
        if Left
            position_s = [start_position(1)-Delta_x start_position(2) start_position(3)];
            show(an,start_position,position_s,fps,down_transl_spd);
            plot3(position_s(1),position_s(2),position_s(3),'r.');
            position = position_s;
        elseif Right          
            position_s = [start_position(1)+Delta_x start_position(2) start_position(3)];
            show(an,start_position,position_s,fps,down_transl_spd);
            plot3(position_s(1),position_s(2),position_s(3),'r.');
            position = position_s;
        elseif autoch
            position = start_position;
        end
    end
    if South
        if Left
            position_s = [start_position(1)+Delta_x start_position(2) start_position(3)];
            show(an,start_position,position_s,fps,down_transl_spd);
            plot3(position_s(1),position_s(2),position_s(3),'r.');
            position = position_s;
        elseif Right
            position_s = [start_position(1)-Delta_x start_position(2) start_position(3)];
            show(an,start_position,position_s,fps,down_transl_spd); 
            plot3(position_s(1),position_s(2),position_s(3),'r.');
            position = position_s;
        elseif autoch
            position = start_position;
        end
    end           
end