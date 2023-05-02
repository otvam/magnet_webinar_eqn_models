function disp_struct_values(name, data)
% Display the parameter names and values of a struct.
%
%    Parameters:
%        name (string): description of the struct 
%        data (struct): struct containing the data

% get the paramter names
field = fieldnames(data);

% display the parameter names and values
fprintf('    %s\n', name)
for i=1:length(field)
    var = field{i};
    value = data.(field{i});
    if isscalar(value)
        fprintf('        %s = %.3e\n', var, value)
    else
        for j=1:length(value)
            fprintf('        %s / %d = %.3e\n', var, j, value(j))
        end
    end
end

end