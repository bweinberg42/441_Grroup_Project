function [r] = Trilateration(rho_obsv,ref,tolerance, r_guess)
% Determines the location of a satellite given reference information 
% Inputs: 
    % rho_obsv: vector containing observed ranges
    % ref: matrix containing all of the [X Y Z] information for the
    % reference locations for the observations
    % r_guess: guess [X Y Z] vector for where the satellite should be located
    
% Outputs:
    % r: [X Y Z] vector containing the iterated solution for where the
    % satellite is

% Author: Blaire Weinberg

r = r_guess; 

rho_pred = sqrt((ref(:, 1)-r(1,1)).^2+(ref(:, 2)-r(2,1)).^2+(ref(:, 3)-r(3,1)).^2);
e = (rho_obsv-rho_pred);
while (norm(e)>tolerance)
    A = [(r(1,1)-ref(1, 1))/rho_pred(1),(r(2,1)-ref(1, 2))/rho_pred(1),(r(3,1)-ref(1, 3))/rho_pred(1);
         (r(1,1)-ref(2, 1))/rho_pred(2),(r(2,1)-ref(2, 2))/rho_pred(2),(r(3,1)-ref(2, 3))/rho_pred(2);
         (r(1,1)-ref(3, 1))/rho_pred(3),(r(2,1)-ref(3, 2))/rho_pred(3),(r(3,1)-ref(3, 3))/rho_pred(3)];
    rho_pred = sqrt((ref(:, 1)-r(1,1)).^2+(ref(:, 2)-r(2,1)).^2+(ref(:, 3)-r(3,1)).^2);
    e = (rho_obsv-rho_pred);
    r = r+(A\e);        
    disp(e);
end