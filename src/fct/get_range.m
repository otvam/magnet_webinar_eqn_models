function [fct_range, shp_obj] = get_range(f_vec, B_pkpk_vec, shape_options)
% Extract the range (frequency and loss density) of a loss map.
%
%    An alpha-shape is created with the logarithm of the frequencies and flux densities.
%    The resulting alpha-shape determines the loss map range. 
%
%    This function is using the 'alphaShape' function for handling the unstructured data.
%    For advanced triangulation options, the following library could be used:
%        - MATLAB Code for Interpolating Triangulated Data
%        - https://github.com/otvam/triangulation_interpolation_matlab
%        - T. Guillod / BSD License
%
%    Parameters:
%        f_vec (vector): measured frequencies
%        B_pkpk_vec (vector): measured peak-to-peak flux densities
%        shape_options (struct): options for computing the loss map range
%
%    Returns:
%        fct_range (function): function determining if points are within the loss map range
%        shp_obj (object): shape object representing the loss map range
%
%    Thomas Guillod.
%    2023 - MIT License.


% extract the options for getting the loss map range
alpha = shape_options.alpha;
hole_threshold = shape_options.hole_threshold;
region_threshold = shape_options.region_threshold;

% shape object describing the loss map range
shp_obj = alphaShape(...
    log10(f_vec).', log10(B_pkpk_vec).', alpha, ...
    'HoleThreshold', hole_threshold, ...
    'RegionThreshold', region_threshold...
    );

% function testing if query points are within the loss map range
fct_range = @(f, B_pkpk) shp_obj.inShape(log10(f), log10(B_pkpk));

end
