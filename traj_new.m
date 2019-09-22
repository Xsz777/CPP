function [optimal_path_new, vels, deceleration_x, deceleration_y, deceleration_z, max_vels_x, max_vels_y, max_vels_z, t_x, t_y, t_z,v_] = traj_new(optimal_path, transl_spd, approximate_max_vels_x, approximate_max_vels_y, approximate_max_vels_z, acceleration_x, acceleration_y, acceleration_z, approximate_deceleration_x, approximate_deceleration_y, approximate_deceleration_z)
    j = 1;
    v = 0;
    m_x = 0;
    t_x = 0;
    k = round(sqrt(abs(power(optimal_path(2,1)-optimal_path(1,1),2)+power(optimal_path(2,2)-optimal_path(1,2),2)+power(optimal_path(2,3)-optimal_path(1,3),2)))/transl_spd);
    while j < k
        n_x = k-j;
        if approximate_max_vels_x > j*acceleration_x
            if n_x*approximate_deceleration_x < j*acceleration_x %应分为加速匀速减速三段而不是两段
                deceleration_x = j*acceleration_x/n_x;
                v = 0;
                m_x = n_x;
                t_x = sqrt(2*abs(optimal_path(2,1)-optimal_path(1,1))/(acceleration_x*j*(k)));
                break;
            end
        else
            if n_x*approximate_deceleration_x <  approximate_max_vels_x%应分为加速匀速减速三段而不是两段
                m_x = round(j*acceleration_x/approximate_deceleration_x);
                if m_x > n_x
                    m_x = n_x;
                    deceleration_x = j*acceleration_x/m_x;
                    v = 0;
                    t_x = sqrt(2*abs(optimal_path(2,1)-optimal_path(1,1))/(acceleration_x*j*(k)));
                    break;
                end
                deceleration_x = j*acceleration_x/m_x;
                v = n_x-m_x;
                t_x = (sqrt(power(j*v, 2)-2*acceleration_x*j*(k-v)*abs(optimal_path(2,1)-optimal_path(1,1)))-j)/(acceleration_x*j*(k-v));
                break;
            end
        end
        j = j+1;
    end
    v_a_x = j;
    v_x = v;
    v_d_x = m_x;
    
    j = 1;
    v = 0;
    m_y = 0;
    t_y = 0;
    while j < k
        n_y = k-j;
        if approximate_max_vels_y > j*acceleration_y
            if n_y*approximate_deceleration_y < j*acceleration_y
                deceleration_y = j*acceleration_y/n_y;
                v = 0;
                m_y = n_y;
                t_y = sqrt(2*abs(optimal_path(2,2)-optimal_path(1,2))/(acceleration_y*j*(k)));
                break;
            end
        else
            if n_y*approximate_deceleration_y <  approximate_max_vels_y%应分为加速匀速减速三段而不是两段
                m_y = round(j*acceleration_y/approximate_deceleration_y);
                if m_y > n_y
                    m_y = n_y;
                    deceleration_y = j*acceleration_y/m_y;
                    v = n_y-m_y;
                    t_y = sqrt(2*abs(optimal_path(2,2)-optimal_path(1,2))/(acceleration_y*j*(k)));
                    break;
                end
                deceleration_y = j*acceleration_y/m_y;
                v = n_y-m_y;
                t_y = (sqrt(power(j*v, 2)-2*acceleration_y*j*(k-v)*abs(optimal_path(2,2)-optimal_path(1,2)))-j)/(acceleration_y*j*(k-v));
                break;
            end
        end
        j = j+1;
    end
    v_a_y = j;
    v_y = v;
    v_d_y = m_y;
    
    j = 1;
    v = 0;
    m_z = 0;
    t_z = 0;
    while j < k
        n_z = k-j;
        if approximate_max_vels_z > j*acceleration_z
            if n_z*approximate_deceleration_z < j*acceleration_z
                deceleration_z = j*acceleration_z/n_z;
                v = 0;
                m_z = n_z;
                t_z = sqrt(2*abs(optimal_path(2,3)-optimal_path(1,3))/(acceleration_z*j*(k)));
                break;
            end
        else
            if n_z*approximate_deceleration_z <  approximate_max_vels_z%应分为加速匀速减速三段而不是两段
                m_z = round(j*acceleration_z/approximate_deceleration_z);
                if m_z > n_z
                    m_z = n_z;
                    deceleration_z = j*acceleration_z/m_z;
                    v = n_z-m_z;
                    t_z = sqrt(2*abs(optimal_path(2,3)-optimal_path(1,3))/(acceleration_z*j*(k)));
                    break;
                end
                deceleration_z = j*acceleration_z/m_z;
                v = n_z-m_z;
                t_z = (sqrt(power(j*v, 2)-2*acceleration_z*j*(k-v)*abs(optimal_path(2,3)-optimal_path(1,3)))-j)/(acceleration_z*j*(k-v));
                break;
            end
        end
        j = j+1;
    end
    v_a_z = j;
    v_z = v;
    v_d_z = m_z;
    
    optimal_path_new = optimal_path;
    vels = zeros(size(optimal_path));
    abs_x = abs(optimal_path(2,1)-optimal_path(1,1))/(optimal_path(2,1)-optimal_path(1,1));
    abs_y = abs(optimal_path(2,2)-optimal_path(1,2))/(optimal_path(2,2)-optimal_path(1,2));
    abs_z = abs(optimal_path(2,3)-optimal_path(1,3))/(optimal_path(2,3)-optimal_path(1,3));
    vels(1,1) = 0;
    vels(1,2) = 0;
    vels(1,3) = 0;
    max_vels_x = abs_x*acceleration_x*v_a_x*t_x;
    max_vels_y = abs_y*acceleration_y*v_a_y*t_y;
    max_vels_z = abs_z*acceleration_z*v_a_z*t_z;
    i = 1;
%     m_x = 0;
%     m_y = 0;
    while i < k
        
        if i <= v_a_x
            Vx = abs_x*acceleration_x*i*t_x;
            Sx = optimal_path(1,1)+abs_x*acceleration_x*power(i*t_x,2)/2;
        elseif i <= v_a_x+v_x
            Vx = max_vels_x;
            Sx = optimal_path(1,1)+abs_x*acceleration_x*power(v_a_x*t_x,2)/2+Vx*(i-v_a_x)*t_x;
        else
            Vx = max_vels_x-abs_x*deceleration_x*(i-v_a_x-v_x)*t_x;
            Sx = optimal_path(1,1)+abs_x*acceleration_x*power(v_a_x*t_x,2)/2+Vx*v_x*t_x+abs_x*(power(max_vels_x,2)-power(Vx,2))/(2*deceleration_x);
        end
        
        if i <= v_a_y
            Vy = abs_y*acceleration_y*i*t_y;
            Sy = optimal_path(1,2)+abs_y*acceleration_y*power(i*t_y,2)/2;
        elseif i <= v_a_y+v_y
            Vy = max_vels_y;
            Sy = optimal_path(1,2)+abs_y*acceleration_y*power(v_a_y*t_y,2)/2+Vy*(i-v_a_y)*t_y;
        else
            Vy = max_vels_y-abs_y*deceleration_y*(i-v_a_y-v_y)*t_y;
            Sy = optimal_path(1,2)+abs_y*acceleration_y*power(v_a_y*t_y,2)/2+Vy*v_y*t_y+abs_y*(power(max_vels_y,2)-power(Vy,2))/(2*deceleration_y);
        end
        
        if i <= v_a_z
            Vz = abs_z*acceleration_z*i*t_z;
            Sz = optimal_path(1,3)+abs_z*acceleration_z*power(i*t_z,2)/2;
        elseif i <= v_a_z+v_z
            Vz = max_vels_z;
            Sz = optimal_path(1,3)+abs_z*acceleration_z*power(v_a_z*t_z,2)/2+Vz*(i-v_a_z)*t_z;
        else
            Vz = max_vels_z-abs_z*deceleration_z*(i-v_a_z-v_z)*t_z;
            Sz = optimal_path(1,3)+abs_z*acceleration_z*power(v_a_z*t_z,2)/2+Vz*v_z*t_z+abs_z*(power(max_vels_z,2)-power(Vz,2))/(2*deceleration_z);
        end
        
        if optimal_path(2,1)-optimal_path(1,1) == 0
            Vx = 0;
            Sx = optimal_path(2,1);
        end
        
        if optimal_path(2,2)-optimal_path(1,2) == 0
            Vy = 0;
            Sy = optimal_path(2,2);
        end
        
        if optimal_path(2,3)-optimal_path(1,3) == 0
            Vz = 0;
            Sz = optimal_path(2,3);
        end
        
        vels = [vels(1:i,:); [Vx Vy Vz]; vels(end,:)];
        optimal_path_new = [optimal_path_new(1:i,:); [Sx Sy Sz];optimal_path_new(end,:)];
        i = i+1; 
    end
    v_ = [v_a_x v_x v_d_x v_a_y v_y v_d_y v_a_z v_z v_d_z k];
%     while i < k
%         n_x = k-i;
%         if n_x*deceleration_x > i*acceleration_x
%             if acceleration_x*i < approximate_max_vels_x
%                 Vx = acceleration_x*i*t_x*abs_x;
%                 Sx = optimal_path(1,1)+abs_x*power(acceleration_x*i*t_x,2)/2;
%             else
%                 if m_x == 0
%                     max_vels_x = acceleration_x*i*t_x*abs_x;
%                     Sx = optimal_path(1,1)+abs_x*power(acceleration_x*i*t_x,2)/2;
%                 else
%                     Sx = optimal_path_new(i,1)+vels(i,1)*t_x;
%                 end
%                 Vx = max_vels_x;
%                 m_x = m_x+1;
%             end
%         else
%             l = vels(i,1);
%             if abs_x*(l-abs_x*deceleration_x*t_x) < 0
%                 Vx = 0;
%             else
%                 Vx = l-abs_x*deceleration_x*t_x;
%             end
%             Sx = optimal_path_new(i,1)+vels(i,1)*t_x-abs_x*power(deceleration_x*t_x,2)/2;
%         end
%         
%         n_y = k-i;
%         if n_y*deceleration_y > i*acceleration_y
%             if acceleration_y*i < approximate_max_vels_y
%                 Vy = acceleration_y*i*t_y*abs_y;
%                 Sy = optimal_path(1,2)+abs_y*power(acceleration_y*i*t_y,2)/2;
%             else
%                 if m_y == 0
%                     max_vels_y = acceleration_y*i*t_y*abs_y;
%                     Sy = optimal_path(1,2)+abs_y*power(acceleration_y*i*t_y,2)/2;
%                 else
%                     Sy = optimal_path_new(i,2)+vels(i,2)*t_y;
%                 end
%                 Vy = max_vels_y;
%                 m_y = m_y+1;
%             end
%         else
%             l = vels(i,2);
%             if abs_y*(l-abs_y*deceleration_y*t_y) < 0
%                 Vy = 0;
%             else
%                 Vy = l-abs_y*deceleration_y*t_y;
%             end
%             Sy = optimal_path_new(i,2)+vels(i,2)*t_y-abs_y*power(deceleration_y*t_y,2)/2;
%         end
%         
%         vels = [vels(1:i,:); [Vx Vy 0]; vels(end,:)];
%         optimal_path_new = [optimal_path_new(1:i,:); [Sx Sy 100];optimal_path_new(end,:)];
%         i = i+1; 
%     end

end