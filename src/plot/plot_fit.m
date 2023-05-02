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
disp_error_vec('errors', err_fit_vec)
disp_struct_values('parameters', param_fit)

end
