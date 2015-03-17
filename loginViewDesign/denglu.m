function varargout = denglu(varargin)
% DENGLU M-file for denglu.fig
%      DENGLU, by itself, creates a new DENGLU or raises the existing
%      singleton*.
%
%      H = DENGLU returns the handle to a new DENGLU or the handle to
%      the existing singleton*.
%
%      DENGLU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DENGLU.M with the given input arguments.
%
%      DENGLU('Property','Value',...) creates a new DENGLU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before denglu_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to denglu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help denglu

% Last Modified by GUIDE v2.5 26-Jun-2013 14:02:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @denglu_OpeningFcn, ...
                   'gui_OutputFcn',  @denglu_OutputFcn, ...
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


% --- Executes just before denglu is made visible.
function denglu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to denglu (see VARARGIN)

% Choose default command line output for denglu
handles.output = hObject;

javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('icon.jpg'));
[num txt raw]=xlsread('user_information.xls');
if ~iscellstr(raw)
    for i=1:numel(raw)
        n(i)=isnumeric(raw{i});
    end
    raw{n}=num2str(raw{n});
end
handles.user=raw(2:end,1);
handles.code=raw(2:end,2);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes denglu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = denglu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function login_user_Callback(hObject, eventdata, handles)
% hObject    handle to login_user (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of login_user as text
%        str2double(get(hObject,'String')) returns contents of login_user as a double


% --- Executes during object creation, after setting all properties.
function login_user_CreateFcn(hObject, eventdata, handles)
% hObject    handle to login_user (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function login_code_Callback(hObject, eventdata, handles)
% hObject    handle to login_code (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of login_code as text
%        str2double(get(hObject,'String')) returns contents of login_code as a double


% --- Executes during object creation, after setting all properties.
function login_code_CreateFcn(hObject, eventdata, handles)
% hObject    handle to login_code (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in log.
function log_Callback(hObject, eventdata, handles)
% hObject    handle to log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user=get(handles.login_user,'string');
code=get(gcf,'userdata');
users=handles.user;
codes=handles.code;
n=find(strcmp(users,{user}));
if length(n) && isequal(codes{n},code)
        h=msgbox('log in success!');
        uiwait(h);
        delete(gcf);
        figure(1)
        set(1,'name','System GUI');
else
        errordlg('user or password wrong!','WARNING');
        set(handles.login_code,'string','');
        set(hObject,'userdata','');
end
    
% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c=get(hObject,'Currentcharacter');
if isstrprop(c,'graphic')
    set(hObject,'userdata',[get(hObject,'userdata') c]);
    set(handles.login_code,'string',[get(handles.login_code,'string') '*']);
else
    val=double(c);
    if ~isempty(c)
        switch val
            case 13
                user=get(handles.login_user,'string');
                code=get(hObject,'userdata');
                users=handles.user;
                codes=handles.code;
                n=find(strcmp(users,{user}));
                if length(n) && isequal(codes{n},code)
                    h=msg('login in success!');
                    uiwait(h);
                    delete(gcf);
                    figure(1)
                    set(1,'name','System GUI');
                else
                    errordlg('user or password wrong!','WARNING');
                    set(handles.login_code,'string','');
                    set(hObject,'userdata','');
                end
            case 8
                str=get(hObject,'userdata');
                if ~isempty(str)
                    str(end)=[];
                end
                set(hObject,'userdata',str);
                str2=get(handles.login_code,'string');
                if ~isempty(str2)
                    str2(end)=[];
                end
                set(handles.login_code,'string',str2);
        end
    end
end


% --- Executes on key press over log with no controls selected.
function log_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if double(get(gcf,'Currentcharacter')) ==13
    user=get(handles.login_user,'string');
    code=get(hObject,'userdata');
    users=handles.user;
    codes=handles.code;
    n=find(strcmp(users,{user}));
    if length(n) && isequal(codes{n},code)
        h=msgbox('log in success!');
        uiwait(h);
        delete(gcf);
        figure(1)
        set(1,'name','System GUI');
    else
        errordlg('user or password wrong!','WARNING');
        set(handles.login_code,'string','');
        set(hObject,'userdata','');
    end
end
