function [x0, fct_param, fct_eval] = get_igse_fit(fit_data)
% Define the fitting parameters for the iGSE.
%
%    The fitting function consists of standard constant Steinmetz parameters.
%    The iGSE parameters are extracted from 50% triangular data (and not from sinusoidal data).
%    
%    Parameters:
%        fit_data (struct): initial value of the fitting parameters
%
%    Returns:
%        x0 (vector): initial value for the fitted parameters
%        fct_param (function): function transforming the fit vector into a struct
%        fct_eval (function): function evaluating the fit function for given parameters
%
%    Thomas Guillod.
%    2023 - MIT License.

% get the initial value vector
x0 = [fit_data.k, fit_data.alpha, fit_data.beta];

% function transforming the fit vector into a struct
fct_param = @(x) get_fit_from_x(x);

% function evaluating the fit function for given parameters
fct_eval = @(fit, f, B_pkpk) get_fit_eval(fit, f, B_pkpk);

end

function fit = get_fit_from_x(x)
% Function transforming the fit vector into a struct.
%    
%    Parameters:
%        x (vector): values of the fitting parameters (ordered)
%
%    Returns:
%        fit (struct): values and names of the fitting parameters (unordered)

fit.k = x(1);
fit.alpha = x(2);
fit.beta = x(3);

end

function p_fit_vec = get_fit_eval(fit, f_vec, B_pkpk_vec)
% Function evaluating the fit function for given parameters.
%    
%    Parameters:
%        fit (struct): values and names of the fitting parameters
%        f_vec (vector): frequencies of the signals
%        B_pkpk_vec (vector): peak-to-peak flux densities of the signals
%
%    Returns:
%        p_fit_vec (vector): loss values given by the fitting function

% get the Steinmetz parameters
k = fit.k;
alpha = fit.alpha;
beta = fit.beta;

% get the Steinmetz equation
p_fit_vec = k.*(f_vec.^alpha).*(B_pkpk_vec.^beta);

end