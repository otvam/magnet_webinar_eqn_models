function [valid_vec, p_model_vec] = get_igse_model(f_vec, d_mat, B_mat, fct_range, param_fit)
% Definition of the iGSE model.
%
%    The iGSE has been introduced in:
%        - Venkatachalam, K. and Sullivan, C. R. and Abdallah, T. and Tacca, H.
%        - Accurate Prediction of Ferrite Core Loss with Nonsinusoidal Waveforms using only Steinmetz Parameters
%        - IEEE Workshop on Computers in Power Electronics, 2002
%
%    The iGSE parameters are extracted from 50% triangular data (and not from sinusoidal data).
%
%    The iGSE does not include relaxation and DC bias effects.
%    This implementation of the iGSE does not include minor loop splitting.
%    
%    Parameters:
%        f_vec (vector): frequencies of the piecewise linear waveforms
%        d_mat (matrix): duty cycles defining the piecewise linear waveforms
%        B_mat (matrix): flux densities defining the piecewise linear waveforms
%        fct_range (function): function determining if points are within the loss map range
%        param_fit (struct): optimal parameters of the fitted function
%
%    Returns:
%        valid_vec (vector): indicate invalid/inaccurate points for the model 
%        p_model_vec (vector): loss values given by the loss model
%
%    Thomas Guillod.
%    2023 - MIT License.

% get the Steinmetz parameters
k = param_fit.k;
alpha = param_fit.alpha;
beta = param_fit.beta;

% get the duration and slope of the piecewise linear segments
[dd_mat, dB_dt_mat, B_pkpk_vec] = get_gradient(f_vec, d_mat, B_mat);

% check which points are within the fitting range
valid_vec = fct_range(f_vec, B_pkpk_vec);

% compute the iGSE integral (for piecewise linear waveforms)
w_mat = (k./(2.^alpha)).*(B_pkpk_vec.^(beta-alpha)).*(abs(dB_dt_mat).^alpha);
p_mat = dd_mat.*w_mat;
p_model_vec = sum(p_mat, 1);

end