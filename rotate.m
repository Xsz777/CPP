%this is a to-do function. TO-DO list: figure out physical theory so that
%we can figure out which parameters to return to help control the engine
function orientation = rotate(start_orient, end_orient, rot_spd)
    orientation = end_orient;
%     if start_orient <= end_orient
%         angle1 = end_orient - start_orient;
%         angle2 = start_orient + 2 * pi - end_orient;
%     else 
%         angle1 = start_orient -end_orient;
%         angle2 = end_orient + 2 * pi - start_orient;
%     end
%     if angle1 < angle      
%      if end_orient > start_orient
     sum = abs(start_orient-end_orient);
     if sum>pi
         sum =-(2*pi-sum);
     end
%     fprintf('\n rotating %f \n', min(abs(start_orient-end_orient),abs(2 * pi + start_orient - end_orient)));
     fprintf('\n rotating %f \n',sum)
     pause(abs(start_orient-end_orient)/rot_spd);%pasue(a)‘›∂®a√Î
     end
