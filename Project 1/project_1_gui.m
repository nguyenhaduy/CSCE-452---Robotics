function varargout = project_1_gui(varargin)
% PROJECT_1_GUI MATLAB code for project_1_gui.fig
%      PROJECT_1_GUI, by itself, creates a new PROJECT_1_GUI or raises the existing
%      singleton*.
%
%      H = PROJECT_1_GUI returns the handle to a new PROJECT_1_GUI or the handle to
%      the existing singleton*.
%
%      PROJECT_1_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT_1_GUI.M with the given input arguments.
%
%      PROJECT_1_GUI('Property','Value',...) creates a new PROJECT_1_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before project_1_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to project_1_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help project_1_gui

% Last Modified by GUIDE v2.5 28-Feb-2017 13:46:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @project_1_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @project_1_gui_OutputFcn, ...
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



% --- Executes just before project_1_gui is made visible.
function project_1_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to project_1_gui (see VARARGIN)

% Choose default command line output for project_1_gui
handles.output = hObject;

% Update handles structure
    guidata(hObject, handles);

%axis off;
    global T0_1 T1_2 T2_3 T3_4 R1 R2 R3 P0 P1 P2 P3 P4 theta1 theta2 theta3;
    T0_1 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    T1_2 = [1 0 0 0; 0 1 0 150; 0 0 1 0; 0 0 0 1];

    R1 = [1 0 0; 0 1 0; 0 0 1];
    T2_3 = [1 0 0 0; 0 1 0 100; 0 0 1 0; 0 0 0 1];
    R2 = [1 0 0; 0 1 0; 0 0 1];
    T3_4 = [1 0 0 0; 0 1 0 75; 0 0 1 0; 0 0 0 1];
    R3 = [1 0 0; 0 1 0; 0 0 1];
    P0 = [0; 0; 0; 1];
    P1 = [0; 0; 0; 1];
    P2 = [0; 150; 0; 1];
    P3 = [0; 250; 0; 1];
    P4 = [0; 325; 0; 1];
    theta1 = 0;
    theta2 = 0;
    theta3 = 0;

    cla;
    xx = [P1(1), P2(1), P3(1), P4(1)];
    yy = [P1(2), P2(2), P3(2), P4(2)];
    zz = [0, 0, 0, 0];
    plot(xx,yy,'.','markersize',30,'Color','r');
    hold on

    xlim([-400 400])
    ylim([0 400])
% axis([-400 400 0 400])

% UIWAIT makes project_1_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = project_1_gui_OutputFcn(hObject, eventdata, handles) 
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
    global T0_1 T1_2 T2_3 T3_4 R1 R2 R3 P0 P1 P2 P3 P4 theta1 theta2 theta3;
    theta1 = theta1 + 1;
    R1 = [cosd(theta1),-sind(theta1),0;sind(theta1),cosd(theta1),0;0,0,1]
    % P2(1:3) = R1 * P2(1:3)
    for i = 1:3
        for j = 1:4
            if (j<4)&&(i<4)
                T0_1(i,j) = R1(i,j);
    %         else 
    %             T1(i,j) = P1(i);
            end
        end
    end
    T0_1

    P1 = T0_1 * P0
    P2 = T0_1 * T1_2 * P0
    P3 = T0_1 * T1_2 * T2_3 * P0
    P4 = T0_1 * T1_2 * T2_3 * T3_4 * P0

    cla;

    xx = [P1(1), P2(1), P3(1), P4(1)];
    yy = [P1(2), P2(2), P3(2), P4(2)];
    zz = [0, 0, 0, 0];
    plot(xx,yy,'.','markersize',30,'Color','r');
    hold on


% temp = [T2(1,4), T2(2,4), T2(3,4), 1]
% temp  = temp * P1
% for i = 1:3
%     T2(i,4) = temp(1,i)
% end


% --- Executes on button press in Clock1.
function Clock1_Callback(hObject, eventdata, handles) %Clockwise Joint 1
% hObject    handle to Clock1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global T0_1 T1_2 T2_3 T3_4 R1 R2 R3 P0 P1 P2 P3 P4 theta1 theta2 theta3;
    theta1 = theta1 - 1;
    R1 = [cosd(theta1),-sind(theta1),0;sind(theta1),cosd(theta1),0;0,0,1]
    for i = 1:3
        for j = 1:4
            if (j<4)&&(i<4)
                T0_1(i,j) = R1(i,j);
    %         else 
    %             T1(i,j) = P1(i);
            end
        end
    end
    T0_1

    P1 = T0_1 * P0
    P2 = T0_1 * T1_2 * P0
    P3 = T0_1 * T1_2 * T2_3 * P0
    P4 = T0_1 * T1_2 * T2_3 * T3_4 * P0

    cla;

    xx = [P1(1), P2(1), P3(1), P4(1)];
    yy = [P1(2), P2(2), P3(2), P4(2)];
    zz = [0, 0, 0, 0];
    plot(xx,yy,'.','markersize',30,'Color','r');
    hold on



% --- Executes on button press in Counter2.
function Counter2_Callback(hObject, eventdata, handles) %Counter-Clockwise Joint 2
% hObject    handle to Counter2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global T0_1 T1_2 T2_3 T3_4 R1 R2 R3 P0 P1 P2 P3 P4 theta1 theta2 theta3;
    theta2 = theta2 + 1;
    R2 = [cosd(theta2),-sind(theta2),0;sind(theta2),cosd(theta2),0;0,0,1]
    for i = 1:3
        for j = 1:4
            if (j<4)&&(i<4)
                T1_2(i,j) = R2(i,j);
    %         else 
    %             T1(i,j) = P1(i);
            end
        end
    end
    T0_1

    P1 = T0_1 * P0
    P2 = T0_1 * T1_2 * P0
    P3 = T0_1 * T1_2 * T2_3 * P0
    P4 = T0_1 * T1_2 * T2_3 * T3_4 * P0

    cla;

    xx = [P1(1), P2(1), P3(1), P4(1)];
    yy = [P1(2), P2(2), P3(2), P4(2)];
    zz = [0, 0, 0, 0];
    plot(xx,yy,'.','markersize',30,'Color','r');
    hold on


% --- Executes on button press in Clock2.
function Clock2_Callback(hObject, eventdata, handles) %Counter-Clockwise Joint 2
% hObject    handle to Clock2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global T0_1 T1_2 T2_3 T3_4 R1 R2 R3 P0 P1 P2 P3 P4 theta1 theta2 theta3;
    theta2 = theta2 - 1;
    R2 = [cosd(theta2),-sind(theta2),0;sind(theta2),cosd(theta2),0;0,0,1]
    for i = 1:3
        for j = 1:4
            if (j<4)&&(i<4)
                T1_2(i,j) = R2(i,j);
    %         else 
    %             T1(i,j) = P1(i);
            end
        end
    end
    T0_1

    P1 = T0_1 * P0
    P2 = T0_1 * T1_2 * P0
    P3 = T0_1 * T1_2 * T2_3 * P0
    P4 = T0_1 * T1_2 * T2_3 * T3_4 * P0
    
    cla;

    xx = [P1(1), P2(1), P3(1), P4(1)];
    yy = [P1(2), P2(2), P3(2), P4(2)];
    zz = [0, 0, 0, 0];
    plot(xx,yy,'.','markersize',30,'Color','r');
    hold on

% --- Executes on button press in Counter3.
function Counter3_Callback(hObject, eventdata, handles)
% hObject    handle to Counter3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global T0_1 T1_2 T2_3 T3_4 R1 R2 R3 P0 P1 P2 P3 P4 theta1 theta2 theta3;
    theta3 = theta3 + 1;
    R3 = [cosd(theta3),-sind(theta3),0;sind(theta3),cosd(theta3),0;0,0,1]
    for i = 1:3
        for j = 1:4
            if (j<4)&&(i<4)
                T2_3(i,j) = R3(i,j);
    %         else 
    %             T1(i,j) = P1(i);
            end
        end
    end
    T0_1

    P1 = T0_1 * P0
    P2 = T0_1 * T1_2 * P0
    P3 = T0_1 * T1_2 * T2_3 * P0
    P4 = T0_1 * T1_2 * T2_3 * T3_4 * P0
    
    cla;

    xx = [P1(1), P2(1), P3(1), P4(1)];
    yy = [P1(2), P2(2), P3(2), P4(2)];
    zz = [0, 0, 0, 0];
    plot(xx,yy,'.','markersize',30,'Color','r');
    hold on


% --- Executes on button press in Clock3.
function Clock3_Callback(hObject, eventdata, handles)
% hObject    handle to Clock3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global T0_1 T1_2 T2_3 T3_4 R1 R2 R3 P0 P1 P2 P3 P4 theta1 theta2 theta3;
    theta3 = theta3 + 1;
    R3 = [cosd(theta3),-sind(theta3),0;sind(theta3),cosd(theta3),0;0,0,1]
    for i = 1:3
        for j = 1:4
            if (j<4)&&(i<4)
                T2_3(i,j) = R3(i,j);
    %         else 
    %             T1(i,j) = P1(i);
            end
        end
    end
    T0_1

    P1 = T0_1 * P0
    P2 = T0_1 * T1_2 * P0
    P3 = T0_1 * T1_2 * T2_3 * P0
    P4 = T0_1 * T1_2 * T2_3 * T3_4 * P0

% --- Executes on button press in Paint.
function Paint_Callback(hObject, eventdata, handles) %Paint
% hObject    handle to Paint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function h = generate_Arm(a,b,c)
%a = horizontal radius
%b = vertical radius
%c = color
beta = 0 * (pi/180);
sinbeta = sin(beta);
cosbeta = cos(beta);
alpha = linspace(0,360,50)' .* (pi/180); %linspace 3rd arg = #steps = smoothness
sinalpha = sin(alpha);
cosalpha = cos(alpha);
X = (a*cosalpha*cosbeta-b*sinalpha*sinbeta);
Y = (a*cosalpha*sinbeta+b*sinalpha*cosbeta);
h = fill(X,Y,c);
set(h,'FaceAlpha',0.75')

function h = generate_Circle(x,y,r,c)
%x = x loc
%y = y loc
%r = radius
%c = color
angle = 0:0.01:2*pi;
xp = r * cos(angle);
yp = r * sin(angle);
h = fill(x + xp, y + yp, c);
