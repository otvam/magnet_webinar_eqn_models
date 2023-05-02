function plot_fit(f_vec, B_pkpk_vec, p_meas_vec, param_fit, fct_fit)
% Plot the deviation between fitted function and a loss map.
%
%    Parameters:
%        f_vec (vector): measured frequencies
%        B_pkpk_vec (vector): measured peak-to-peak flux densities
%        p_meas_vec (vector): measured core loss densities
%        param_fit (struct): optimal parameters of the fitted function
%        fct_fit (function): function returning the optimal fit
%
%    Thomas Guillod.
%    2023 - MIT License.

% evaluate the fit
p_fit_vec = fct_fit(f_vec, B_pkpk_vec);

% compute the relative error between the fitted values and the measurements
err_fit_vec = (p_fit_vec-p_meas_vec)./p_meas_vec;

% plot the relative error
figure('name', 'Fitting Error')
ax = axes();
scatter(f_vec, B_pkpk_vec, 50, 100.*err_fit_vec, 'filled')
cbar = colorbar();
ax.XScale = 'log';
ax.YScale = 'log';
ax.XLabel.String = 'f (Hz)';
ax.YLabel.String = 'B_{pkpk} (T)';
cbar.Label.String = 'Error (%)';
title('Fitting Error')

% display the fit error and parameters
fprintf('fit\n')
get_disp_error(err_fit_vec);
get_disp_param(param_fit)

end

function get_disp_error(err_fit_vec)
% Display the metrics of the relative error.
%
%    Parameters:
%        err_fit_vec (vector): relative error between the model and measurements

% get the absolute relative error
err_abs_vec = abs(err_fit_vec);

% display the metrics of the relative error
fprintf('    errors\n')
fprintf('        n_points = %d\n', length(err_abs_vec))
fprintf('        err_mean = %.3f %%\n', 1e2.*mean(err_abs_vec))
fprintf('        err_rms = %.3f %%\n', 1e2.*rms(err_abs_vec))
fprintf('        err_95th = %.3f %%\n', 1e2.*quantile(err_abs_vec, 0.95))
fprintf('        err_max = %.3f %%\n', 1e2.*max(err_abs_vec))

end

function get_disp_param(param_fit)
% Display the parameter names and values.
%
%    Parameters:
%        param_fit (struct): optimal parameters of the fitted function

% get the paramter names
field = fieldnames(param_fit);

% display the parameter names and values
fprintf('    parameters\n')
for i=1:length(field)
    var = field{i};
    value = param_fit.(field{i});
    if isscalar(value)
        fprintf('        %s = %.3e\n', var, value)
    else
        for j=1:length(value)
            fprintf('        %s / %d = %.3e\n', var, j, value(j))
        end
    end
end

end