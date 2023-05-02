function plot_eval(valid_vec, err_model_vec)
% Plot the deviation between the loss model and a measured loss dataset.
%
%    Parameters:
%        valid_vec (vector): indicate invalid/inaccurate points for the model 
%        err_model_vec (vector): relative error between the model and measurements
%
%    Thomas Guillod.
%    2023 - MIT License.

% extract the error for the valid and invalid points
err_valid_vec = err_model_vec(valid_vec==true);
err_invalid_vec = err_model_vec(valid_vec==false);

% plot the histogram of the relative error (all points)
figure('name', 'Model Error')
histogram(100.*err_model_vec, 'Normalization', 'probability')
xlabel('Error (%)');
ylabel('Density (p.u.)');
title('Model Error')

% display the relative error for the different point categories
fprintf('eval\n')
disp_error_vec('all points', err_model_vec)
disp_error_vec('valid points', err_valid_vec)
disp_error_vec('invalid points', err_invalid_vec)

end

