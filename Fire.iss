; This script is best executed by Fire's "Make" utility.

#define MyAppVersion "9.4.1+238"
#define MyAppName "Fire"
#define MyAppExeName "Fire.dws"
#define MyAppPublisher "Kai Jaeger"
#define MyAppURL "https://github.com/aplteam/Fire"
#define MyAppIcoName "Fire.ico"
#define MyBlank " "
#define TargetDir "<<TARGETDIR>>"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
AppId={{45ab0fb3-f47a-1048-97ab-a7fe5a4bd1d3}

AppName="{#MyAppName}"
AppVersion={#MyAppVersion}
AppVerName={#MyAppName}{#MyBlank}{#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={userdocs}//MyUCMDs//{#MyAppName}
DefaultGroupName={#MyAppPublisher}/{#MyAppName}
AllowNoIcons=yes
OutputDir={#TargetDir}
OutputBaseFilename="SetUp_{#MyAppName}_{#MyAppVersion}"
Compression=lzma
SolidCompression=yes
SetupIconFile={#MyAppIcoName}
PrivilegesRequired=Lowest
AlwaysShowDirOnReadyPage=yes
DisableWelcomePage=no
DisableDirPage=no
CreateUninstallRegKey=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"; LicenseFile: "License";

[Registry]

[Dirs]

[Files]
Source: "{#TargetDir}Fire_uc.dyalog"; DestDir: "{app}";
Source: "{#TargetDir}Fire_uc.dyalog"; DestDir: "{app}/test/";
Source: "{#TargetDir}html/FireAndRegularExpressions.html"; DestDir: "{app}";
Source: "{#TargetDir}html/ReleaseNotes.html"; DestDir: "{app}";
Source: "{#TargetDir}html/UsefulRegExes.html"; DestDir: "{app}";
Source: "{#TargetDir}{#MyAppExeName}"; DestDir: "{app}"
Source: "{#TargetDir}packages/*"; DestDir: "{app}/packages/"; Flags: recursesubdirs
;Source: "{#TargetDir}LICENSE"; DestDir: "{app}"
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]


[Run]
; Because with 9.1.0 the user command script was moved into Fire/, so we delete leftovers:
Filename: "{app}/ReleaseNotes.html"; Description: "View the Release Notes"; Flags: postinstall shellexec skipifsilent

[Tasks]

[InstallDelete]

[Code]
// Delete potential left-over from 9.1.0 (and earlier) installations
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then begin
    DeleteFile(ExpandConstant('{app}\..\Fire_uc.dyalog')); 
  end;
end;