% Knee joint = motor_data.motor_pos(:,1)
% Hip joint = motor_data.motor_pos(:,2)

load("mane_pd_v0_ws.mat")

figure()
hold on
plot(motor_data.time, motor_data.motor_pos(:,1), '-r');
title("Knee Motor Encoder"); xlabel("Time (s)"); ylabel("Position (rev)")
grid on; xlim([0 0.5]);

figure()
hold on
plot(motor_data.time, motor_data.motor_trq(:,1), '-r');
plot(motor_data.time, motor_data.motor_trq_cmd(:,1), '--k');
title("Knee Motor Torque"); xlabel("Time (s)"); ylabel("Torque (N*m)")
legend(["Measured","Commanded"])
grid on; xlim([0 0.5]);

% figure()
% hold on
% plot(motor_data.time, motor_data.motor_pos(:,2), '-r');
% title("Motor 2 Encoder"); xlabel("Time (s)"); ylabel("Position (rev)")
% grid on
% 
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