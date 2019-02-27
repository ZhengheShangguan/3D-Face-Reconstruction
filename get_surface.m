function  height_map = get_surface(surface_normals, image_size, method)
% surface_normals: 3 x num_pixels array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object

    
%% <<< fill in your code below >>>
    h = image_size(1);
    w = image_size(2);
    normals_2d = surface_normals(:,:,1:2)./surface_normals(:,:,3);
    switch method
        case 'column'
            row_sum = cumsum(normals_2d(1,:,1),2);
            height_map = repmat(row_sum,h,1) + cumsum(normals_2d(:,:,2));
        case 'row'
            col_sum = cumsum(normals_2d(:,1,2));
            height_map = repmat(col_sum,1,w) + cumsum(normals_2d(:,:,1),2);            
            % col_sum_lefthalf = cumsum(normals_2d(:,1,2));
            % col_sum_righthalf = cumsum(normals_2d(:,image_size(2),2));            
            % height_map(:,1:0.5*image_size(2)) = repmat(col_sum_lefthalf,1,0.5*image_size(2)) + cumsum(normals_2d(:,1:0.5*image_size(2),1),2);
            % height_map(:,(0.5*image_size(2)+1):image_size(2)) = repmat(col_sum_righthalf,1,0.5*image_size(2)) + cumsum(normals_2d(:,(0.5*image_size(2)+1):image_size(2),1),2,'reverse');            
        case 'average'
            row_sum = cumsum(normals_2d(1,:,1),2);
            col_sum = cumsum(normals_2d(:,1,2));
            height_map = 0.5*(repmat(row_sum,h,1) + cumsum(normals_2d(:,:,2)) + repmat(col_sum,1,w) + cumsum(normals_2d(:,:,1),2));
        case 'random'
            for i = 1:1:h
                for j = 1:1:w
                    % Integrate 10 different paths then give the average
                    for time = 1:1:10
                        height_pixel_tmp(time) = rdmpath(normals_2d, i, j);
                    end
                    height_map(i,j) = mean(height_pixel_tmp);
                end
            end
end
