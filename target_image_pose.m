function [up,down] = target_image_pose(down_transl,start_position,end_position,Delta_y)%up ǰ�� down �½�
    transl = y_transl(start_position,end_position,Delta_y);
    up = false;
    down = false;
    if transl<down_transl
        down = true;
    else
        up = true;
    end
end