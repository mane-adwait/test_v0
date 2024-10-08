% 2024 October 08. Adwait Mane.
% PD position controller to stabilize a single motor.
% ODrive functions (e.g. boom.Motors.goToPosition) are defined in
% the ODriveController class (matlab/share/ODriveController.m).

close all
clear boom
addpath('share');

% Set run parameters
% stride_frequency = 0.5; % Hz
% num_strides = 5;
% duration = num_strides/stride_frequency; % Seconds.
duration = 4; % Seconds.

boom = BoomController(); % Connect to the boom ROS network.
% boom.Legs.setKinematicsType(1,  rr-2d?); % Not required for a single
% motor.
boom.ready(); % Put the motors in control mode.

% boom.Motors.setPGains() % Scalar input sets all motor gains. Vector input
% sets each motor separately.

% Initialize the motors at (0,0) rad angular position.
boom.Motors.goToPosition([0 0]); 
pause(1)

boom.Motors.setControlModes(1); % Torque mode.

boom.startRecording(floor(duration * 50)); % To preallocate.

torque1 = 0.1; torque2 = 0; % N*m. Peak torque = 1.7 N*m.
boom.Motors.setTorques([torque1 torque2]);

pauseSafe(boom, duration + 1.0); % Pressing Ctrl+C switches to idle mode. Otherwise same as pause. 

% Replace the above with a PD control loop here.

boom.stopRecording();

% Reset the motors to (0,0) rad angular position.
boom.Motors.setControlModes(3); % Position mode.
boom.Motors.goToPosition([0 0]);
pause(1)

boom.idle();

motor_data = parseMotorData(boom.MotorData);
boom_data = parseBoomData(boom.BoomData);
leg_data = parseLegData(boom.LegData);

% Encoder values: motor_data.motor_pos(:,motor_num);

figure()
hold on
plot(motor_data.time, motor_data.motor_pos(:,1), '-r');
title("Motor 1 Encoder"); xlabel("Time (s)"); ylabel("Position (rev)")
grid on

% figure()
% hold on
% plot(motor_data.time, motor_data.motor_pos_cmd(:,1), '--k');
% plot(motor_data.time, motor_data.motor_pos(:,1), '-r');
% title("Motor 1 Encoder")
% xlabel("Time (s)")
% ylabel("Position (rev)")
% legend(["Commanded", "Encoder Estimate"])
% 
% figure()
% hold on
% plot(motor_data.time, motor_data.motor_pos_cmd(:,2), '--k');
% plot(motor_data.time, motor_data.motor_pos(:,2), '-r');
% title("Motor 2 Encoder")
% xlabel("Time (s)")
% ylabel("Position (rev)")
% legend(["Commanded", "Encoder Estimate"])