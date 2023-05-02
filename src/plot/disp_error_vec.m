function disp_error_vec(name, err_vec)
% Display the metrics of the relative error for a given vector.
%
%    Parameters:
%        name (string): description of the relative error vector 
%        err_vec (vector): relative error between the model and measurements

% get the absolute relative error
err_abs_vec = abs(err_vec);

% display the metrics of the relative error
fprintf('    %s\n', name)
fprintf('        n_points = %d\n', length(err_abs_vec))
fprintf('        err_mean = %.3f %%\n', 1e2.*mean(err_abs_vec))
fprintf('        err_rms = %.3f %%\n', 1e2.*rms(err_abs_vec))
fprintf('        err_95th = %.3f %%\n', 1e2.*quantile(err_abs_vec, 0.95))
fprintf('        err_max = %.3f %%\n', 1e2.*max(err_abs_vec))

end