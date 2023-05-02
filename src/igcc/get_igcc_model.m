function [valid_vec, p_model_vec] = get_igcc_model(f_vec, d_mat, B_mat, fct_range, fct_fit)
% Definition of the iGCC model.
%
%    The iGCC has been introduced in:
%        - Guillod, T. and Lee, J. S. and Li, H. and Wang, S. and Chen, M. and and Sullivan, C. R.
%        - Calculation of Ferrite Core Losses with Arbitrary Waveforms using the Composite Waveform Hypothesis
%        - IEEE Applied Power Electronics Conference, 2023
%
%    The iGCC parameters are extracted from 50% triangular data (and not from sinusoidal data).
%
%    The iGCC does not include relaxation and DC bias effects.
%    This implementation of the iGCC does not include minor loop splitting.
%    
%    Parameters:
%        f_vec (vector): frequencies of the piecewise linear waveforms
%        d_mat (matrix): duty cycles defining the piecewise linear waveforms
%        B_mat (matrix): flux densities defining the piecewise linear waveforms
%        fct_range (function): function determining if points are within the loss map range
%        fct_fit (function): function returning the optimal fit
%
%    Returns:
%        valid_vec (vector): indicate invalid/inaccurate points for the model 
%        p_model_vec (vector): loss values given by the loss model
%
%    Thomas Guillod.
%    2023 - MIT License.

% get the duration and slope of the piecewise linear segments
[dd_mat, dB_dt_mat, B_pkpk_vec] = get_gradient(f_vec, d_mat, B_mat);

% iGCC equivalent frequency
t_eq_mat = abs(B_pkpk_vec./dB_dt_mat);
f_eq_mat = 1./(2.*t_eq_mat);

% fix signal with quasi-zero frequency
f_eq_mat(f_eq_mat<eps) = eps;

% evaluate the iGCC for the different segments
for i=1:size(f_eq_mat, 1)
    is_valid_mat(i,:) = fct_range(f_eq_mat(i,:), B_pkpk_vec);
    p_split_mat(i,:) = fct_fit(f_eq_mat(i,:), B_pkpk_vec);
end

% check that all the segments are within the fitting range
valid_vec = all(is_valid_mat, 1);

% compute the iGCC integral (for piecewise linear waveforms)
p_model_vec = sum(dd_mat.*p_split_mat, 1);

end
