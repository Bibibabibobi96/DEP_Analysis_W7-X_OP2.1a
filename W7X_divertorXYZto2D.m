function [length,theta,diff_rho,diff_z] = W7X_divertorXYZto2D(x,y,z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[~,rho0,z0] = cart2pol(4, 3.1, -0.1);
[theta,rho,z] = cart2pol(x,y,z);
% length = sqrt( (rho-rho0).^2 + (z-z0).^2 );
length = sqrt(  (x+4).^2 + (y-3).^2 +(z+0.5).^2);% 
diff_rho = rho-rho0;
% diff_z = z-z0;
diff_z = sqrt( (rho-rho0).^2 + (z-z0).^2 )+8.9;
end