; This script is best executed by Fire's "Make" utility.

#define MyAppVersion "9.0.1+189"
#define MyAppName "Fire"
#define MyAppExeName "Fire.dws"
#define MyAppPublisher "APL Team Ltd"
#define MyAppURL "https://github.com/aplteam/Fire"
#define MyAppIcoName "Fire.ico"
#define MyBlank " "
#define TargetDir "Dist\"

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
DefaultDirName={userdocs}\\MyUCMDs\\{#MyAppName}
DefaultGroupName={#MyAppPublisher}\{#MyAppName}
AllowNoIcons=yes
OutputDir=C:/Users/kai/AppData/Local/Temp/InnoTempDir
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
Source: "{#TargetDir}\Fire_uc.dyalog"; DestDir: "{app}\..\";
Source: "{#TargetDir}\Fire\FireAndRegularExpressions.html"; DestDir: "{app}";
Source: "{#TargetDir}\Fire\ReleaseNotes.html"; DestDir: "{app}";
Source: "{#TargetDir}\Fire\ReadMe.html"; DestDir: "{app}";
Source: "{#TargetDir}\Fire\UsefulRegExes.html"; DestDir: "{app}";
Source: "{#TargetDir}\Fire\{#MyAppExeName}"; DestDir: "{app}"
Source: "{#TargetDir}packages\*"; DestDir: "{app}"; Flags: recursesubdirs
Source: "LICENSE"; DestDir: "{app}"
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]

[Run]
Filename: "{app}\ReleaseNotes.html"; Description: "View the Release Notes"; Flags: postinstall shellexec skipifsilent

[Tasks]

[Code]
