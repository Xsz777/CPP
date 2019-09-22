function position = approach(start_position,end_position,an,down_transl_spd,fps,Delta_y,Delta_z,down_transl)
    [North,South,Right,Left,autoch] =  look(end_position,start_position);

%[up,down,target_image,rand] = target_image_pose();
    [up,down] = target_image_pose(down_transl,start_position,end_position,Delta_y)
    transl = y_transl(start_position,end_position,Delta_y)
    
    if North
        Delta_y = Delta_y;
    elseif South
        Delta_y = -1*Delta_y;
    end
    while  transl > 0%start_position(2)<end_position(2)-work_radius%(start_position(3)-z_submarine>H) %start_position(2)>end_position(2)-work_radius
        if up
            %if (down_transl<transl)
                position_s = [start_position(1) start_position(2)+Delta_y start_position(3)]
                show(an, start_position,position_s, fps,down_transl_spd);
                %rand =rand+1;
                start_position = position_s;
            %end
                up = false;
                down = true;
                transl = transl-1;
                if transl>3
                    up =true;
                    down = false;
                end
        end
        %end
        if down
            %if (down_transl>=transl)
                position_s = [start_position(1) start_position(2) start_position(3)-Delta_z]
%             if (start_position(3)-z_submarine<H)
%                 down = false;
%                 up = true;
%                 break;
%             end  
                show(an, start_position,position_s, fps,down_transl_spd);
                %rand =rand-1;
                start_position = position_s;     
     
                up = true;
                down = false;
                down_transl = down_transl-1;
        end
        
    end
    while down_transl > 0
        position_s = [start_position(1) start_position(2) start_position(3)-Delta_z]
        show(an, start_position,position_s, fps,down_transl_spd);
        start_position = position_s; 
        down_transl = down_transl-1;
    end
    position = start_position;
%     [North,South,Right,Left] =  look(end_position,start_position);
%     [up,down,target_image,rand] = target_image_pose();
%     while(norm(start_position - end_position)==1)
%         while up
%             if North
%                 if(rand>7)
%                     position_s = [start_position(1) start_position(2)+Delta_y start_position(3)];
%                     show(an, start_position,position_s, fps,transl_spd);
%                     start_position = position_s;
%                     rand = rand +1;
%                     if (start_position(2)>end_position(2)-work_radius)
%                         break;
%                     end
%                 end
%             end
%             if South
%                 if(rand>7)
%                     position_s = [start_position(1) start_position(2)-Delta_y start_position(3)];
%                     show(an, start_position,position_s, fps,transl_spd);
%                     start_position = position_s;
%                     rand = rand+1;
%                     if (start_position(2)>end_position+work_radiums)
%                         break;
%                     end
%                 end
%             end
%             up =false;
%             down = true;
%         end
%         while down
%             if(rand<6)
%                 position_s = [start_position(1) start_position(2) start_position(3)-Delta_z]
%                 show(an, start_position,position_s, fps,transl_spd);
%                 start_position = position_s;
%                 rand = rand-1;
%                 if (start_position(3)<z_submarine+H)
%                     break;
%                 end
%             end
%             down = false;
%             up = true;
%         end
%     end
%     position = start_position;
end
