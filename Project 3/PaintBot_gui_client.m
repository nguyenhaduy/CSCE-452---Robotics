function varargout = PaintBot_gui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PaintBot_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @PaintBot_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT  

% --- Executes just before PaintBot_gui is made visible.
function PaintBot_gui_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    handles.points = [];

% Update handles structure
    guidata(hObject, handles);


    
%axis off;
    global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 points continuousDraw Connection delay IPvalue;
    IPvalue = '127.0.0.1';
    delay = false;
    Connection = false;
    continuousDraw = 0;
    T0_1 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    T1_2 = [1 0 0 0; 0 1 0 150; 0 0 1 0; 0 0 0 1];
    T2_3 = [1 0 0 0; 0 1 0 100; 0 0 1 0; 0 0 0 1];
    T3_4 = [1 0 0 0; 0 1 0 75; 0 0 1 0; 0 0 0 1];
    P0 = [0; 0; 0; 1];
    P1 = [0; 0; 0; 1];
    P2 = [0; 150; 0; 1];
    P3 = [0; 250; 0; 1];
    P4 = [0; 325; 0; 1];
    theta1 = 0;
    theta2 = 0;
    theta3 = 0;
    points = [];
    
    cla;
    xlim([-400 400])
    ylim([-400 400])
    hold on;
    update();
    
    set(gca, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])

% --- Outputs from this function are returned to the command line.
function varargout = PaintBot_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function A = draw_arms(number)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3;

alpha = linspace(0,360,50)';

E1 = T0_1;
E1(:,4) = (P2-P1)/2;
Arm1 = [20*cosd(alpha) 90*sind(alpha)];
Arm1(:,4) = 1;
Arm1 = Arm1';
Arm1 = E1*Arm1;

E2 = T1_2;
E2(:,4) = (P3+P2)/2;
Arm2 = [20*cosd(alpha) 70*sind(alpha)];
Arm2(:,4) = 1;
Arm2 = Arm2';
E1(:,4) = [0; 0; 0; 1];
Arm2 = E2*E1*Arm2;

E3 = T2_3;
E3(:,4) = (P4+P3)/2;
Arm3 = [20*cosd(alpha) 57.5*sind(alpha)];
Arm3(:,4) = 1;
Arm3 = Arm3';
E2(:,4) = [0; 0; 0; 1];
Arm3 = E3*E2*E1*Arm3;      

plot(Arm1(1,:),Arm1(2,:),'r');
plot(Arm2(1,:),Arm2(2,:),'b');
plot(Arm3(1,:),Arm3(2,:),'g');

function T = T_matrix(theta, T)
% Generate Transformation Matrix
R = [cosd(theta),-sind(theta),0;sind(theta),cosd(theta),0;0,0,1];
for i = 1:3
    for j = 1:3
        T(i,j) = R(i,j);
    end
end

function update()
%Update all the points on graph

global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 points continuousDraw;

P1 = T0_1 * P0;
P2 = T0_1 * T1_2 * P0;
P3 = T0_1 * T1_2 * T2_3 * P0;
P4 = T0_1 * T1_2 * T2_3 * T3_4 * P0;

cla;
rectangle('Position',[-15,-15,30,30],'FaceColor', 'y');
draw_arms;
if length(points) ~= 0
    plot(points(1,:), points(2,:), '.','markersize',30,'Color','k');
end
X = [P1(1), P2(1), P3(1), P4(1)];
Y = [P1(2), P2(2), P3(2), P4(2)];
plot(X,Y,'.','markersize',30,'Color','r');
if (continuousDraw == 1)
    points = [points, P4];
end
hold on

% Link angle calculation
function inverseKine(x,y)
% Input is the polar coordinates of end effector's position.
%
% In order to use this function, you'll need to convert the end
% effector's position to spherical coordinates. All you'll need
% is r (distance from origin to point and azimuth (angular direction).
% These can be calculated as such: r = sqrt(x^2+y^2) and azimuth = atan2(y,x).
%
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 points;

l1 = 150;
l2 = 100;
l3 = 75;

if ((x^2 + y^2) < 125^2)&&(y>0)&&(x>0)
    gamma = 0
elseif ((x^2 + y^2) < 125^2)&&(y<0)
    gamma = 180
else
    gamma = atan2d(x,y)
end

x2 = x - l3*sind(gamma);
y2 = y - l3*cosd(gamma);

if ((-50<=x)&&(x<=50)&&(25<=y)&&(y<=125))||((-50<=x)&&(x<=50)&&(-125<=y)&&(y<=-25))
     disp('Out of Range')
     return
end

c_theta_2 = real((x2^2 + y2^2 - l1^2 - l2^2)/(2*l1*l2));
if (x>=0)
    s_theta_2 = real(sqrt(1-c_theta_2^2));
else
    s_theta_2 = real(sqrt(1-c_theta_2^2));
end
s_theta_1 = real((l1 + l2*c_theta_2)*y - l2*s_theta_2*x)/(x^2 + y^2);
c_theta_1 = real(sqrt(1-s_theta_1^2));
k1 = l1 + l2*c_theta_2;
k2 = l2*s_theta_2;
phi = atan2(k2,k1);

temp_theta2 = -atan2d(s_theta_2,c_theta_2);
temp_theta1 = -real(atan2d(x2,y2) - acosd((x2^2 + y2^2 + l1^2 - l2^2)/(2*l1*sqrt(x2^2 + y2^2))));
temp_theta3 = -(gamma - (-temp_theta1 - temp_theta2))
temp_theta1 = mod(temp_theta1,360)
temp_theta2 = mod(temp_theta2,360)
temp_theta3 = mod(temp_theta3,360)

if (temp_theta1 >= 180)
	temp_theta1 = temp_theta1 - 360;
elseif (temp_theta3 <= -180)
	temp_theta1 = temp_theta1 + 360;
end

if (temp_theta2 >= 180)
	temp_theta2 = temp_theta2 - 360;
elseif (temp_theta2 <= -180)
	temp_theta2 = temp_theta2 + 360;
end


if (temp_theta3 >= 180)
	temp_theta3 = temp_theta3 - 360;
elseif (temp_theta3 <= -180)
	temp_theta3 = temp_theta3 + 360;
end

if (abs(theta1 - temp_theta1) > 60)||(abs(theta2 - temp_theta2) > 60)||(abs(theta3 - temp_theta3) > 60)
    speed = 20;
elseif (abs(theta1 - temp_theta1) > 30)||(abs(theta2 - temp_theta2) > 30)||(abs(theta3 - temp_theta3) > 30)
    speed = 10;
else
    speed = 1;
end

step1 = abs(theta1 - temp_theta1)/speed;
step2 = abs(theta2 - temp_theta2)/speed;
step3 = abs(theta3 - temp_theta3)/speed;

theta1 = temp_theta1;
theta2 = temp_theta2;
theta3 = temp_theta3;

T2_3 = T_matrix(theta3, T2_3);
T1_2 = T_matrix(theta2, T1_2);
T0_1 = T_matrix(theta1, T0_1);

update();

function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 Connection points continuousDraw delay IPvalue;
IPvalue = handles.IPtext.String;
Connection = true;
t = tcpip(IPvalue,4013);
fopen(t);
pause(0.2);
handles.status.String = 'Connected';

delay = false;
continuousDraw = 0;
T0_1 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
T1_2 = [1 0 0 0; 0 1 0 150; 0 0 1 0; 0 0 0 1];
T2_3 = [1 0 0 0; 0 1 0 100; 0 0 1 0; 0 0 0 1];
T3_4 = [1 0 0 0; 0 1 0 75; 0 0 1 0; 0 0 0 1];
P0 = [0; 0; 0; 1];
P1 = [0; 0; 0; 1];
P2 = [0; 150; 0; 1];
P3 = [0; 250; 0; 1];
P4 = [0; 325; 0; 1];
theta1 = 0;
theta2 = 0;
theta3 = 0;
points = [];

t.Terminator = ' ';
    
while Connection
    if(delay)
        pause(4)
    end
        DataReceived=fscanf(t,'%c')
        if (strcmpi(DataReceived, 'DOWN '))
            inverseKine(P4(1), P4(2)-5);
            % Call down callback function
            
        elseif (strcmpi(DataReceived, 'UP '))
            inverseKine(P4(1), P4(2)+5);
            % Call up callback function
            
        elseif (strcmpi(DataReceived, 'LEFT '))
            inverseKine(P4(1)-5, P4(2))
            % Call left callback function
        elseif (strcmpi(DataReceived, 'RIGHT '))
            inverseKine(P4(1)+5, P4(2));
            % Call right callback function       
        elseif (strcmpi(DataReceived, 'CLOCK1 '))
            theta1 = theta1 - 2;
            T0_1 = T_matrix(theta1, T0_1);
            update();
        elseif (strcmpi(DataReceived, 'CLOCK2 '))
            theta2 = theta2 - 2;
            T1_2 = T_matrix(theta2, T1_2);
            update();
        elseif (strcmpi(DataReceived, 'CLOCK3 '))
            theta3 = theta3 - 2;
            T2_3 = T_matrix(theta3, T2_3);
            update();
        elseif (strcmpi(DataReceived, 'COUNTER1 '))
            theta1 = theta1 + 2;
            T0_1 = T_matrix(theta1, T0_1);
            update();
        elseif(strcmpi(DataReceived, 'COUNTER2 '))
            theta2 = theta2 + 2;
            T1_2 = T_matrix(theta2, T1_2);
            update();
        elseif(strcmpi(DataReceived, 'COUNTER3 '))
            theta3 = theta3 + 2;
            T2_3 = T_matrix(theta3, T2_3);
            update();
        elseif(strcmpi(DataReceived, 'PAINT '))
            points = [points, P4];
            update();
        elseif(strcmpi(DataReceived, 'CONTINUOUS '))
            continuousDraw = ~continuousDraw;
        elseif (strcmpi(DataReceived, 'DISCONNECT '))
            Connection = false;
            handles.status.String = 'Disconnected';
        elseif (strcmpi(DataReceived, 'DELAY '))
            delay = ~delay;
            if(delay)
                handles.Delay.String = 'On';
            else
                handles.Delay.String = 'Off';
            end
        end
        drawnow;
end