function height_pixel = rdmpath(normals_2d, i, j)
% this function is for getting the single pixel's height by using random
% path integration method.
% the random path only allows going right side or downward side, for which 
% I treat 0 as going right side, 1 as going downward side.

    % generate a LONG ENOUGH flipping coin random sequence with probablity
    % (i-1)/(i+j-2) to go downward, because for reaching (i,j) from (1,1), 
    % we need i-1 downward steps and j-1 rightward steps.
    y = zeros(1,3*(i+j));
    x = rand(1,3*(i+j));
    y(x<(i-1)/(i+j-2)) = 1;
    
    % initial height value at the start point (1,1)
    right_step = 0;
    down_step = 0;
    height_pixel = normals_2d(1,1,1) + normals_2d(1,1,2);
    
    % for-loop to integrate the height along the random path
    for k = 1:1:3*(i+j)
        if down_step < i-1 && right_step < j-1
            if y(k) == 1
                height_pixel = height_pixel + normals_2d(down_step+2, right_step+1, 2);
                down_step = down_step + 1;
            else
                height_pixel = height_pixel + normals_2d(down_step+1, right_step+2, 1);
                right_step = right_step + 1;
            end
        elseif down_step == i-1
            while right_step < j-1
                height_pixel = height_pixel + normals_2d(down_step+1, right_step+2, 1);
                right_step = right_step + 1;
            end
            break
        elseif right_step == j-1
            while down_step < i-1
                height_pixel = height_pixel + normals_2d(down_step+2, right_step+1, 2);
                down_step = down_step + 1;
            end
            break
        end
    end
end
            