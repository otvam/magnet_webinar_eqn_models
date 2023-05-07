function run_igcc()
% Parametrize and evaluate the iGCC loss model.
%
%    Thomas Guillod.
%    2023 - MIT License.

close('all')
addpath(genpath('src'))

% name of the loss model to be used
model = 'igcc';

% options for computing the loss map range
range_options.alpha = 0.2; % alpha radius (see alphaShape, 'Inf' for full triangulation)
range_options.hole_threshold = 0; % maximum interior holes (see alphaShape, '0' for desactivating)
range_options.region_threshold = 0; % maximum regions (see alphaShape, '0' for desactivating)

% initial value of the fitting parameters
fit_init.lambda_vec = [0.0, 0.0, 0.0, 0.0];
fit_init.beta_vec = [0.0, 0.0, 0.0, 0.0];

% options for the least-square fitting algoritm
fit_options = struct('FunctionTolerance', 1e-6, 'Display', 'off');

% parametrize the loss model with the loss map
map_fit = load('data/N87_25C_fit.mat');
fct_model = get_model(model, map_fit, range_options, fit_init, fit_options);

% evaluate a loss model and compare the results with the measurements
map_eval = load('data/N87_25C_eval.mat');
get_eval(map_eval, fct_model);

end