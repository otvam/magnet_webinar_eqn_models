function [dd_mat, dB_dt_mat, B_pkpk_vec] = get_gradient(f_vec, d_mat, B_mat)
% Compute parameters of several piecewise linear waveforms.
%
%    Parameters:
%        f_vec (vector): frequencies of the piecewise linear waveforms
%        d_mat (matrix): duty cycles defining the piecewise linear waveforms
%        B_mat (matrix): flux densities defining the piecewise linear waveforms
%
%    Returns:
%        dd_mat (matrix): relative durations of the different segments
%        dB_dt_mat (matrix): flux density gradients of the different segments
%        B_pkpk_vec (vector): peak-to-peak flux densities of the waveforms
%
%    Thomas Guillod.
%    2023 - MIT License.

% compute the duration and gradient of the segments
dd_mat = diff(d_mat, 1, 1);
dB_mat = diff(B_mat, 1, 1);
dB_dt_mat = f_vec.*(dB_mat./dd_mat);

% check for invalid signal
assert(all(dd_mat>eps, 'all'), 'invalid signal')

% extract the peak-to-peak flux densities
B_pkpk_vec = max(B_mat, [], 1)-min(B_mat, [], 1);

end
