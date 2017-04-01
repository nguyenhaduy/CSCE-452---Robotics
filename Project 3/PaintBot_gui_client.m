function varargout = PaintBot_gui(varargin)
% PaintBot_gui MATLAB code for PaintBot_gui.fig
%      PaintBot_gui, by itself, creates a new PaintBot_gui or raises the existing
%      singleton*.
%
%      H = PaintBot_gui returns the handle to a new PaintBot_gui or the handle to
%      the existing singleton*.
%
%      PaintBot_gui('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PaintBot_gui.M with the given input arguments.
%
%      PaintBot_gui('Property','Value',...) creates a new PaintBot_gui or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PaintBot_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PaintBot_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PaintBot_gui

% Last Modified by GUIDE v2.5 01-Apr-2017 16:14:26

% Begin initialization code - DO NOT EDIT
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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PaintBot_gui (see VARARGIN)

% Choose default command line output for PaintBot_gui
    handles.output = hObject;
    handles.points = [];

% Update handles structure
    guidata(hObject, handles);

    
%axis off;
    global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 points continuousDraw t Connection;
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
    
    Connection = false;
        
    set(gca, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
    
    
% axis([-400 400 0 400])

% UIWAIT makes PaintBot_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PaintBot_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Counter1.
function Counter1_Callback(hObject, eventdata, handles) %Counter-Clockwise Joint 1
% hObject    handle to Counter1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P1 P2 P3 P4 theta1 theta2 theta3;
theta1 = theta1 + 2
T0_1 = T_matrix(theta1, T0_1);
update();

% --- Executes on button press in Clock1.
function Clock1_Callback(hObject, eventdata, handles) %Clockwise Joint 1
% hObject    handle to Clock1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3;
theta1 = theta1 - 2
T0_1 = T_matrix(theta1, T0_1);
update();



% --- Executes on button press in Counter2.
function Counter2_Callback(hObject, eventdata, handles) %Counter-Clockwise Joint 2
% hObject    handle to Counter2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3;
theta2 = theta2 + 2;
T1_2 = T_matrix(theta2, T1_2);
update();


% --- Executes on button press in Clock2.
function Clock2_Callback(hObject, eventdata, handles) %Counter-Clockwise Joint 2
% hObject    handle to Clock2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3;
theta2 = theta2 - 2;
T1_2 = T_matrix(theta2, T1_2);
update();

% --- Executes on button press in Counter3.
function Counter3_Callback(hObject, eventdata, handles)
% hObject    handle to Counter3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3;
theta3 = theta3 + 2;
T2_3 = T_matrix(theta3, T2_3);
update();


% --- Executes on button press in Clock3.
function Clock3_Callback(hObject, eventdata, handles)
% hObject    handle to Clock3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3;
theta3 = theta3 - 2;
T2_3 = T_matrix(theta3, T2_3);
update();

% --- Executes on button press in Paint.
function Paint_Callback(hObject, eventdata, handles) %Paint
% hObject    handle to Paint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global P4 points
points = [points, P4];
update();
    

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


% --- Executes on button press in UpButton.
function UpButton_Callback(hObject, eventdata, handles)
% hObject    handle to UpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 points;
disp('Up')
inverseKine(P4(1), P4(2)+5);


% --- Executes on button press in RightButton.
function RightButton_Callback(hObject, eventdata, handles)
% hObject    handle to RightButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 points;
disp('Right')
inverseKine(P4(1)+5, P4(2));

% --- Executes on button press in LeftButton.
function LeftButton_Callback(hObject, eventdata, handles)
% hObject    handle to LeftButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 points;
disp('Left')
inverseKine(P4(1)-5, P4(2));


% --- Executes on button press in DownButton.
function DownButton_Callback(hObject, eventdata, handles)
% hObject    handle to DownButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 points;
disp('Down')
inverseKine(P4(1), P4(2)-5);

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

function ContinuousPaint_Callback(hObject, eventdata, handles)
% hObject    handle to ContinuousPaint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T0_1 T1_2 T2_3 T3_4 P0 P1 P2 P3 P4 theta1 theta2 theta3 points continuousDraw;
continuousDraw = ~continuousDraw;

function message = client(host, port, number_of_retries)

    import java.net.Socket
    import java.io.*

    if (nargin < 3)
        number_of_retries = 20; % set to -1 for infinite
    end
    
    retry        = 0;
    input_socket = [];
    message      = [];

    while true

        retry = retry + 1;
        if ((number_of_retries > 0) && (retry > number_of_retries))
            fprintf(1, 'Too many retries\n');
            break;
        end
        
        try
            fprintf(1, 'Retry %d connecting to %s:%d\n', ...
                    retry, host, port);

            % throws if unable to connect
            input_socket = Socket(host, port);

            % get a buffered data input stream from the socket
            input_stream   = input_socket.getInputStream;
            d_input_stream = DataInputStream(input_stream);

            fprintf(1, 'Connected to server\n');

            % read data from the socket - wait a short time first
            pause(0.5);
            bytes_available = input_stream.available;
            fprintf(1, 'Reading %d bytes\n', bytes_available);
            
            message = zeros(1, bytes_available, 'uint8');
            for i = 1:bytes_available
                message(i) = d_input_stream.readByte;
            end
            
            message = char(message);
            
            % cleanup
            input_socket.close;
            break;
            
        catch
            if ~isempty(input_socket)
                input_socket.close;
            end

            % pause before retrying
            pause(1);
        end
    end

function serverName_Callback(hObject, eventdata, handles) %insert server name
% hObject    handle to serverName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of serverName as text
%        str2double(get(hObject,'String')) returns contents of serverName as a double


% --- Executes during object creation, after setting all properties.
function serverName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to serverName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in connect. 
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Connection
Connection = true;
t = tcpip('127.0.0.1',4013);
fopen(t);
pause(0.2);

t.Terminator = ' ';
    
while Connection
        DataReceived=fscanf(t,'%c')
end


% --- Executes on button press in disconnect. 
function disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Connection
Connection = false;
fclose(t);
delete(t);
