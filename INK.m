function varargout = INK(varargin)
% INK MATLAB code for INK.fig
%      INK, by itself, creates a new INK or raises the existing
%      singleton*.
%
%      H = INK returns the handle to a new INK or the handle to
%      the existing singleton*.
%
%      INK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INK.M with the given input arguments.
%
%      INK('Property','Value',...) creates a new INK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before INK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to INK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help INK

% Last Modified by GUIDE v2.5 21-Mar-2016 23:46:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @INK_OpeningFcn, ...
                   'gui_OutputFcn',  @INK_OutputFcn, ...
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


% --- Executes just before INK is made visible.
function INK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to INK (see VARARGIN)

% Choose default command line output for INK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes INK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


global drawing;
drawing =0;
set(gcf,'WindowButtonDownFcn',@mouseDown)
set(gcf,'WindowButtonMotionFcn',@mouseMove)
set(gcf,'WindowButtonUpFcn',@mouseUp)

global pnt
global Npnt
pnt = zeros(1000,3);
Npnt = 0;
tic

% --- Outputs from this function are returned to the command line.
function varargout = INK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ClearButton.
function ClearButton_Callback(hObject, eventdata, handles)
% hObject    handle to ClearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla
global pnt
global Npnt
pnt = zeros(1000,3);
Npnt = 0;


function mouseDown(hObject, eventdata, handles) 
global drawing
% global Spnt
% Spnt=1;
drawing = 1;


function mouseUp(hObject, eventdata, handles) 
global drawing
% global Spnt
drawing = 0;
% Spnt=Spnt+1;


function mouseMove(hObject, eventdata, handles) 
global drawing
global Npnt
global pnt
if drawing
    C = get(gca,'CurrentPoint');
    if C(1,1)<1 && C(1,1)>0 && C(1,2)<1 && C(1,2)>0
        Npnt = Npnt+1;
        pnt(Npnt,1) = C(1,1);
        pnt(Npnt,2) = C(1,2);
        pnt(Npnt,3) = toc;
        plot(C(1,1),C(1,2),'k','marker','o','MarkerFaceColor','r');
        hold on
        xlim([0 1]); ylim([0 1]);
        set(gca,'XTick',[],'YTick',[])
        box on
    end


end



function Score_Callback(hObject, eventdata, handles)
% hObject    handle to Score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Score as text
%        str2double(get(hObject,'String')) returns contents of Score as a double


% --- Executes during object creation, after setting all properties.
function Score_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end


% --- Executes on button press in Recognize.
function Recognize_Callback(hObject, eventdata, handles)
% hObject    handle to Recognize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pnt
global Npnt
if Npnt<1000 
pnt(Npnt+1:end,:) =[];
end
dlmwrite('InkData',pnt)

load temp
load Inkdata
Inkdata(:,3)=[];
global NumPoints SquareSize AngleRange AnglePrecision Phi NumTemplates
NumTemplates=10;
NumPoints=64;
SquareSize=0.5;
AngleRange=pi/4;
AnglePrecision=pi/90;
Phi=0.5*(-1+sqrt(5)); % golden ratio
[length] =path_length(Inkdata);
[data] = resample(Inkdata,length);
[data2] = rotatepoints(data);
[data3] = scaling(data2);
[name,score] = recognize(data3,temp);
score=round(score*100);
set(handles. Score,'String',score);
set(handles. Gesture,'String',name);



function Gesture_Callback(hObject, eventdata, handles)
% hObject    handle to Gesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gesture as text
%        str2double(get(hObject,'String')) returns contents of Gesture as a double


% --- Executes during object creation, after setting all properties.
function Gesture_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
