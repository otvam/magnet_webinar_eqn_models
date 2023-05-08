function plot_range(shp_obj)
% Plot the range (frequency and flux density) of a loss map.
%
%    Parameters:
%        shp_obj (object): shape object representing the loss map range
%
%    Thomas Guillod.
%    2023 - MIT License.

% extract the frequencies and flux densities
f = 10.^shp_obj.Points(:, 1);
B = 10.^shp_obj.Points(:, 2);
tri = shp_obj.alphaTriangulation;

% plot the shape representing the range and the data points
figure('name', 'Fitting Range')
ax = axes();
triplot(tri, f, B, 'k');
hold('on')
patch('Faces',tri,'Vertices', [f, B],'FaceColor','g', 'FaceAlpha', 0.2)
plot(f, B, 'or')
ax.XScale = 'log';
ax.YScale = 'log';
ax.XLabel.String = 'f (Hz)';
ax.YLabel.String = 'B_{pkpk} (T)';
title('Fitting Range')

end
