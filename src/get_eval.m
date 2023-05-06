function map_eval = get_eval(map_eval, fct_model)
% Evaluate a loss model and compare the results with the measurements.
%
%    Parameters:
%        map_eval (struct): loss map containing the waveforms and the measured losses
%        fct_model (function): function describing the fitted loss model
%
%    Returns:
%        map_eval (struct): loss map containing the waveforms, the measured losses, and the predicted losses
%
%    Thomas Guillod.
%    2023 - MIT License.

% extract the values from the loss map
f_vec = map_eval.f_vec;
d_mat = map_eval.d_mat;
B_mat = map_eval.B_mat;
p_meas_vec = map_eval.p_meas_vec;

% evaluate the loss model
[valid_vec, p_model_vec] = fct_model(f_vec, d_mat, B_mat);

% compute the relative error between the loss model and the measurements
err_model_vec = (p_model_vec-p_meas_vec)./p_meas_vec;

% plot the deviation between the loss model and the measurements
plot_eval(valid_vec, err_model_vec)

% add the predicted losses to the loss map
map_eval.valid_vec = valid_vec;
map_eval.p_model_vec = p_model_vec;
map_eval.err_model_vec = err_model_vec;

end