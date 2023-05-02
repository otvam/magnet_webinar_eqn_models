function [param_fit, fct_fit] = get_fit(f_vec, B_pkpk_vec, p_meas_vec, x0, fct_param, fct_eval, fit_options)
% Extraction of a least-square fit of a function with respect to a loss map.
%
%    A parametrized function and a loss dataset are provided.
%    The relative error between the predicted losses and the measurement is considered.
%    The optimal parameters, where the error is minimal, are found with a least-square algoritm. 
%
%    This function is using the 'lsqnonlin' function for the fitting process.
%    For advanced fitting algoritms, the following library could be used:
%        - MATLAB Toolbox for Global Fitting/Optimization
%        - https://github.com/otvam/global_optim_fitting_matlab
%        - T. Guillod / BSD License
%
%    Parameters:
%        f_vec (vector): measured frequencies
%        B_pkpk_vec (vector): measured peak-to-peak flux densities
%        p_meas_vec (vector): measured core loss densities
%        x0 (vector): initial value for the fitted parameters
%        fct_param (function): function transforming the fit vector into a struct
%        fct_eval (function): function evaluating the fit function for given parameters
%        fit_options (struct): options for the least-square fitting algoritm
%
%    Returns:
%        param_fit (struct): optimal parameters of the fitted function
%        fct_fit (function): function returning the optimal fit
%
%    Thomas Guillod.
%    2023 - MIT License.

% function describing the fitting results for the given points
fct_fit = @(fit) fct_eval(fit, f_vec, B_pkpk_vec);

% function describing the relative error between the fits and the measurements
fct_err = @(fit) (fct_fit(fit)-p_meas_vec)./p_meas_vec;

% function to be minimized by the solver
fct_fun = @(x) fct_err(fct_param(x));

% solve the fitting problem with a least-square fitting algoritm
x = lsqnonlin(fct_fun, x0, [], [], fit_options);

% extract the fitted parameters
param_fit = fct_param(x);

% function with the optimal fit
fct_fit = @(f, B_pkpk) fct_eval(param_fit, f, B_pkpk);

end
