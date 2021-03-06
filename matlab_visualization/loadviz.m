%% Load the visualization MAT file
% Load visualization files.
load OMAVModel.mat
OMAV = h; clear h;
%takes show_omegas from workspce
OMAV.load(0.2, 16, [0.0;0.0;0],show_omegas);

%% Configure the visualization

% Set lighting.
lightangle(-120,  30);
lightangle( 120, -30);
lightangle(-120, -30);
lightangle( 120,  30);
lightangle(-120,  30);
lightangle( 120, -30);
lightangle(-120, -30);
lightangle( 120,  30);

% Set view angle.
view(24,33);
% set(gca,'CameraPosition',  1e-3*[2679.17 -4731.06 3838.21], ...
%         'CameraTarget',    1e-3*[381.33   429.964 169.419], ...
%         'CameraViewAngle', 11.3725);

%%
% EOF
