% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3199.113968612361532 ; 3213.206772769244708 ];

%-- Principal point:
cc = [ 2003.615779968712104 ; 1060.645362102843592 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.076079151889417 ; -0.250639689568067 ; -0.003518988468479 ; -0.009955634746002 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 174.935388422926792 ; 180.074798472590231 ];

%-- Principal point uncertainty:
cc_error = [ 55.648536354980259 ; 45.677711487460719 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.043327871045420 ; 0.143508407150808 ; 0.004028227087517 ; 0.005862947167518 ; 0.000000000000000 ];

%-- Image size:
nx = 4000;
ny = 2250;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 9;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 3.128035e+00 ; -7.295343e-02 ; 3.649626e-02 ];
Tc_1  = [ -1.543122e+02 ; 9.317820e+01 ; 3.755819e+02 ];
omc_error_1 = [ 1.439823e-02 ; 2.640965e-03 ; 2.406629e-02 ];
Tc_error_1  = [ 6.603985e+00 ; 5.441653e+00 ; 2.078792e+01 ];

%-- Image #2:
omc_2 = [ 3.114256e+00 ; -7.818667e-02 ; 7.848632e-02 ];
Tc_2  = [ -1.372434e+02 ; 7.837878e+01 ; 3.877014e+02 ];
omc_error_2 = [ 1.537753e-02 ; 2.633633e-03 ; 2.530060e-02 ];
Tc_error_2  = [ 6.830766e+00 ; 5.606562e+00 ; 2.149424e+01 ];

%-- Image #3:
omc_3 = [ 2.942820e+00 ; -1.084043e-01 ; 9.613666e-02 ];
Tc_3  = [ -1.526941e+02 ; 8.595174e+01 ; 3.520351e+02 ];
omc_error_3 = [ 1.698286e-02 ; 3.111351e-03 ; 2.266860e-02 ];
Tc_error_3  = [ 6.259321e+00 ; 5.155932e+00 ; 1.945296e+01 ];

%-- Image #4:
omc_4 = [ 2.886886e+00 ; -6.631387e-02 ; 1.321086e-01 ];
Tc_4  = [ -1.631208e+02 ; 8.171231e+01 ; 3.462565e+02 ];
omc_error_4 = [ 1.814410e-02 ; 3.546597e-03 ; 2.236645e-02 ];
Tc_error_4  = [ 6.181019e+00 ; 5.075237e+00 ; 1.923272e+01 ];

%-- Image #5:
omc_5 = [ 2.857165e+00 ; -3.781659e-01 ; 2.584317e-01 ];
Tc_5  = [ -1.271204e+02 ; 8.609654e+01 ; 3.592398e+02 ];
omc_error_5 = [ 1.838625e-02 ; 4.207696e-03 ; 2.455967e-02 ];
Tc_error_5  = [ 6.375223e+00 ; 5.199306e+00 ; 2.003985e+01 ];

%-- Image #6:
omc_6 = [ -2.971155e+00 ; -4.983057e-02 ; -1.771258e-01 ];
Tc_6  = [ -1.420430e+02 ; 9.912852e+01 ; 3.862640e+02 ];
omc_error_6 = [ 1.537037e-02 ; 3.736747e-03 ; 2.452860e-02 ];
Tc_error_6  = [ 6.809945e+00 ; 5.466528e+00 ; 2.111110e+01 ];

%-- Image #7:
omc_7 = [ 2.218489e+00 ; 2.191572e+00 ; -8.847895e-02 ];
Tc_7  = [ -1.530434e+02 ; -8.775345e+01 ; 4.907719e+02 ];
omc_error_7 = [ 1.218512e-02 ; 1.423246e-02 ; 2.689774e-02 ];
Tc_error_7  = [ 8.556691e+00 ; 7.004617e+00 ; 2.713158e+01 ];

%-- Image #8:
omc_8 = [ 3.100532e+00 ; 1.324232e-02 ; -1.074994e-02 ];
Tc_8  = [ -1.546280e+02 ; 1.145213e+02 ; 4.812316e+02 ];
omc_error_8 = [ 1.634405e-02 ; 3.994974e-03 ; 3.091873e-02 ];
Tc_error_8  = [ 8.446287e+00 ; 6.938296e+00 ; 2.671783e+01 ];

%-- Image #9:
omc_9 = [ 2.966876e+00 ; -7.844228e-02 ; 1.014661e-01 ];
Tc_9  = [ -1.500047e+02 ; 8.029485e+01 ; 3.528757e+02 ];
omc_error_9 = [ 1.667828e-02 ; 3.051186e-03 ; 2.300583e-02 ];
Tc_error_9  = [ 6.265156e+00 ; 5.162563e+00 ; 1.947118e+01 ];

