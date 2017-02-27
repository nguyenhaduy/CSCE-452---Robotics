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

% Last Modified by GUIDE v2.5 26-Feb-2017 17:09:55

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
rectangle('Position',[-12,0,24,150],'FaceColor','r')
rectangle('Position',[-12,150,24,100],'FaceColor','b')
rectangle('Position',[-12,250,24,75],'FaceColor','g')
rectangle('Position',[-4,0,10,10],'FaceColor', 'w','Curvature',[1 1])
rectangle('Position',[-15,0,30,10],'FaceColor', 'y')
rectangle('Position',[-5,320,10,10],'FaceColor','k' ,'Curvature',[1 1])
rectangle('Position',[-5,145,10,10],'FaceColor','k' ,'Curvature',[1 1])
rectangle('Position',[-5,245,10,10],'FaceColor','k' ,'Curvature',[1 1])
%axis off;
global T0 T1 R1 T2 R2 T3 R3 P0 P1 P2 P3;
T0 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
T1 = [1 0 0 0; 0 1 0 150; 0 0 1 0; 0 0 0 1];

R1 = [1 0 0; 0 1 0; 0 0 1];
T2 = [1 0 0 0; 0 1 0 250; 0 0 1 0; 0 0 0 1];
R2 = [1 0 0; 0 1 0; 0 0 1];
T3 = [1 0 0 0; 0 1 0 325; 0 0 1 0; 0 0 0 1];
R3 = [1 0 0; 0 1 0; 0 0 1];
P0 = [0; 0; 0; 1];
P1 = [0; 150; 0; 1];
P2 = [0; 250; 0; 1];
P3 = [0; 325; 0; 1];

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
global R1 T1 P1 P2 P3 T2 T3
R1 = [cosd(30),-sind(30),0;sind(30),cosd(30),0;0,0,1]
P1(1:3) = R1 * P1(1:3) %ask about rotation of T1, from P1/R1
for i = 1:3
    for j = 1:4
        if (j<4)&&(i<4)
            T1(i,j) = R1(i,j);
        else 
            T1(i,j) = P1(i);
        end
    end
end
P1 = T1 * P1
temp = [T2(1,4), T2(2,4), T2(3,4), 1]
temp  = temp * P1
for i = 1:3
    T2(i,4) = temp(1,i)
end
T1


% --- Executes on button press in Clock1.
function Clock1_Callback(hObject, eventdata, handles) %Clockwise Joint 1
% hObject    handle to Clock1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in Counter2.
function Counter2_Callback(hObject, eventdata, handles) %Counter-Clockwise Joint 2
% hObject    handle to Counter2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Clock2.
function Clock2_Callback(hObject, eventdata, handles) %Counter-Clockwise Joint 2
% hObject    handle to Clock2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Paint.
function Paint_Callback(hObject, eventdata, handles) %Paint
% hObject    handle to Paint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
