function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs)
% imarray: h x w x Nimages array of Nimages no. of images
% light_dirs: Nimages x 3 array of light source directions
% albedo_image: h x w image
% surface_normals: h x w x 3 array of unit surface normals


%% <<< fill in your code below >>>
% Pre-reshape the data
[h,w,l] = size(imarray);
imarray_stack = reshape(imarray, h*w, l)'; % need a Transpose for the following "\"

% Get all the solutions with only one back slash
g_stack = light_dirs \ imarray_stack;

% Calculate N(x,y) and rho(x,y)
rho_stack = sqrt(sum(g_stack.^2));
N_stack = g_stack ./ rho_stack;

% Post-reshape the data
albedo_image = reshape(rho_stack,h,w);
surface_normals = reshape(N_stack', [h,w,3]);

end