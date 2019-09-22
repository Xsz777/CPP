function [North,South,Right,Left,autoch] = look(postion_obj,stop_position)
    North = false;
    South = false;
    Right = false;
    Left = false;
    autoch = false;
%     if(postion_obj(1)<stop_position(1))
%         West = true;
%     elseif(postion_obj(1)>stop_position(1))
%         East = true;
    if(postion_obj(2)<stop_position(2))
        South = true;
    elseif(postion_obj(2)>stop_position(2))
        North = true;
    end
    if North
         if(postion_obj(1)<(stop_position(1)-0.15))
             Left = true;  
         elseif(postion_obj(1)>(stop_position(1)+0.15))
             Right = true;
         elseif((stop_position(1)-0.15)<=postion_obj(1)<=(stop_position(1)+0.15))
             autoch = true;
         end
    end
	if South
         if(postion_obj(1)>(stop_position(1)+0.15))
             Left = true;
         elseif(postion_obj(1)<(stop_position(1)-0.15))
             Right = true;
         else
             autoch = true;
         end
    end
%     if West
%         if(position(2)<stop_position)%±±×ß        
%     if(norm(abs(test_x-target_X),abs(test_y-target_Y)) > test_r)        
end

