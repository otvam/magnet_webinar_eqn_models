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
get_disp_sub('all points', err_model_vec)
get_disp_sub('valid points', err_valid_vec)
get_disp_sub('invalid points', err_invalid_vec)

end

function get_disp_sub(name, err_model_vec)
% Display the metrics of the relative error for a given vector.
%
%    Parameters:
%        name (string): description of the relative error vector 
%        err_model_vec (vector): relative error between the model and measurements

% get the absolute relative error
err_abs_vec = abs(err_model_vec);

% display the metrics of the relative error
fprintf('    %s\n', name)
fprintf('        n_points = %d\n', length(err_abs_vec))
fprintf('        err_mean = %.3f %%\n', 1e2.*mean(err_abs_vec))
fprintf('        err_rms = %.3f %%\n', 1e2.*rms(err_abs_vec))
fprintf('        err_95th = %.3f %%\n', 1e2.*quantile(err_abs_vec, 0.95))
fprintf('        err_max = %.3f %%\n', 1e2.*max(err_abs_vec))

end