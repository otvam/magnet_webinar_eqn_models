function fct_model = get_model(model, map_fit, range_options, fit_init, fit_options)
% Parametrize a loss model (iGSE or iGCC) with a measured loss map.
%
%    The model parameters are extracted from 50% triangular data (and not from sinusoidal data).
%    The model is parametrized in several steps:
%        - the range (frequency and loss density) of the provided data is extracted
%        - the parametrized fitting function is constructed for the selected model
%        - the parametrized fitting function is fitted with the provided data
%        - the loss model is constructed from the obtained fitted function
%
%    The returned loss model is a function handle with the following parameters:
%        - input
%            - f_vec (vector): frequencies of the piecewise linear waveforms
%            - d_mat (matrix): duty cycles defining the piecewise linear waveforms
%            - B_mat (matrix): flux densities defining the piecewise linear waveforms
%        - output
%            - valid_vec (vector): indicate invalid/inaccurate points for the model 
%            - p_model_vec (vector): loss values given by the loss model
%    
%    Parameters:
%        model (string): name of the loss model to be used
%        map_fit (struct): loss map containing the measurements used for fitting the model
%        range_options (struct): options for computing the loss map range
%        fit_init (struct): initial value of the fitting parameters
%        fit_options (struct): options for the least-square fitting algoritm
%
%    Returns:
%        fct_model (function): function describing the fitted loss model
%
%    Thomas Guillod.
%    2023 - MIT License.

% extract the values from the loss map
f_vec = map_fit.f_vec;
B_pkpk_vec = map_fit.B_pkpk_vec;
p_meas_vec = map_fit.p_meas_vec;

% extract the range (frequency and loss density) of the loss map
[fct_range, shp_obj] = get_range(f_vec, B_pkpk_vec, range_options);

% plot the range (frequency and loss density) of the loss map
plot_range(shp_obj)

% get the parametrized fitting function
switch model
    case 'igse'
        [x0, fct_param, fct_eval] = get_igse_fit(fit_init);
    case 'igcc'
        [x0, fct_param, fct_eval] = get_igcc_fit(fit_init);
    otherwise
        error('invalid model')
end

% fit the parametrized fitting function with the provided data
[param_fit, fct_fit] = get_fit(f_vec, B_pkpk_vec, p_meas_vec, x0, fct_param, fct_eval, fit_options);

% plot the deviation between fitted function and the loss map
plot_fit(f_vec, B_pkpk_vec, p_meas_vec, param_fit, fct_fit)

% get a function handle describing the fitted loss model
switch model
    case 'igse'
        fct_model = @(f_vec, d_mat, B_mat) get_igse_model(f_vec, d_mat, B_mat, fct_range, param_fit);
    case 'igcc'
        fct_model = @(f_vec, d_mat, B_mat) get_igcc_model(f_vec, d_mat, B_mat, fct_range, fct_fit);
    otherwise
        error('invalid model')
end

end