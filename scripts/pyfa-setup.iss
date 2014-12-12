; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

; Versioning
; we do some #ifdef conditionals because automated compilation passes these as arguments

#ifndef MyAppVersion
    #define MyAppVersion "1.3.0"
#endif
#ifndef MyAppExpansion
    #define MyAppExpansion "Crius 1.0"
#endif

; Other config

#define MyAppName "pyfa"
#define MyAppPublisher "pyfa"
#define MyAppURL "https://forums.eveonline.com/default.aspx?g=posts&t=247609&p=1"
#define MyAppExeName "pyfa.exe"

#ifndef MyOutputFile
    #define MyOutputFile LowerCase(StringChange(MyAppName+'-'+MyAppVersion+'-'+MyAppExpansion+'-win', " ", "-"))
#endif
#ifndef MyAppDir
    #define MyAppDir "pyfa"
#endif
#ifndef MyOutputDir
    #define MyOutputDir "dist"
#endif

[Setup]

; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{3DA39096-C08D-49CD-90E0-1D177F32C8AA}
AppName={#MyAppName}
AppVersion={#MyAppVersion} ({#MyAppExpansion})
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile={#MyAppDir}\gpl.txt
OutputDir={#MyOutputDir}
OutputBaseFilename={#MyOutputFile}
SetupIconFile={#MyAppDir}\pyfa.ico
Compression=lzma
SolidCompression=yes
CloseApplications=yes
AppReadmeFile=https://github.com/DarkFenX/Pyfa/blob/v{#MyAppVersion}/readme.txt

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "{#MyAppDir}\pyfa.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]

function IsAppRunning(const FileName : string): Boolean;
var
    FSWbemLocator: Variant;
    FWMIService   : Variant;
    FWbemObjectSet: Variant;
begin
    Result := false;
    FSWbemLocator := CreateOleObject('WBEMScripting.SWBEMLocator');
    FWMIService := FSWbemLocator.ConnectServer('', 'root\CIMV2', '', '');
    FWbemObjectSet := FWMIService.ExecQuery(Format('SELECT Name FROM Win32_Process Where Name="%s"',[FileName]));
    Result := (FWbemObjectSet.Count > 0);
    FWbemObjectSet := Unassigned;
    FWMIService := Unassigned;
    FSWbemLocator := Unassigned;
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  if(IsAppRunning( 'pyfa.exe' )) then
    begin
      Result := 'Please close pyfa before continuing. When closed, please go back to the previous step and continue.';
    end
  else
    begin
      Result := '';
    end
end;