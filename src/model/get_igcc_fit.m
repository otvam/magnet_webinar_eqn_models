function [x0, fct_param, fct_eval] = get_igcc_fit(fit_init)
% Define the fitting parameters for the iGCC.
%
%    The fitted function consists of frequency dependent Steinmetz parameters.
%    The iGCC parameters are extracted from 50% triangular data (and not from sinusoidal data).
%    
%    Parameters:
%        fit_init (struct): initial value of the fitting parameters
%
%    Returns:
%        x0 (vector): initial value for the fitted parameters
%        fct_param (function): function transforming the fit vector into a struct
%        fct_eval (function): function evaluating the fit function for given parameters
%
%    Thomas Guillod.
%    2023 - MIT License.

% get the initial value vector
x0 = [fit_init.lambda_vec, fit_init.beta_vec];

% function transforming the fit vector into a struct
fct_param = @(x) get_fit_from_x(x);

% function evaluating the fit function for given parameters
fct_eval = @(fit, f_vec, B_pkpk_vec) get_fit_eval(fit, f_vec, B_pkpk_vec);

end

function fit = get_fit_from_x(x)
% Function transforming the fit vector into a struct.
%    
%    Parameters:
%        x (vector): values of the fitting parameters (ordered)
%
%    Returns:
%        fit (struct): values and names of the fitting parameters (unordered)

fit.lambda_vec = x(1:4);
fit.beta_vec = x(5:8);

end

function p_fit = get_fit_eval(fit, f_vec, B_pkpk_vec)
% Function evaluating the fit function for given parameters.
%    
%    Parameters:
%        fit (struct): values and names of the fitting parameters
%        f_vec (vector): frequencies of the signals
%        B_pkpk_vec (vector): peak-to-peak flux densities of the signals
%
%    Returns:
%        p_fit_vec (vector): loss values given by the fitting function

% get the fitted parameters
lambda_vec = fit.lambda_vec;
beta_vec = fit.beta_vec;

% compute the frequency dependent Steinmetz parameters
lambda = 10.^polyval(lambda_vec, log10(f_vec));
beta = polyval(beta_vec, log10(f_vec));

% get the Steinmetz equation
p_fit = lambda.*(B_pkpk_vec.^beta);

end
