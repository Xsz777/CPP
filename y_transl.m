function transl = y_transl(start_position,end_position,Delta_y)
    transl = floor(abs(end_position(2) - start_position(2))/Delta_y);
    if (mod(abs(end_position(2) - start_position(2)),1/2) == 0)
        transl = transl-1;
    end
end