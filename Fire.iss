; This script is best executed by Fire's "Make" utility.

#define MyAppVersion "7.2.2.111"
#define MyAppName "Fire"
#define MyAppExeName "Fire.dws"
#define MyAppPublisher "APL Team Ltd"
#define MyAppURL "https://github.com/aplteam/Fire"
#define MyAppIcoName "Fire.ico"
#define MyBlank " "
#define TargetDir "Dist\"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
AppId={{F16BFC1D-1862-4F50-91F2-2D64B0789875}

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
OutputDir={#TargetDir}
OutputBaseFilename="SetUp_{#MyAppName}_{#MyAppVersion}"
Compression=lzma
SolidCompression=yes
SetupIconFile={#MyAppIcoName}
PrivilegesRequired=Lowest

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

; The .NET file are needed for the "Check for updates" menu command
Source: "bridge170_unicode.dll"; DestDir: "{app}";
Source: "dyalognet.dll"; DestDir: "{app}"     

; The Conga DLLs are needed for "Check for updates"
;Source: "conga31ssl64.dll"; DestDir: "{app}";
;Source: "conga31_64.dll"; DestDir: "{app}";
;Source: "conga31ssl32.dll"; DestDir: "{app}";
;Source: "conga31_32.dll"; DestDir: "{app}";

Source: "{#TargetDir}\Fire\{#MyAppExeName}"; DestDir: "{app}"
Source: "LICENSE"; DestDir: "{app}"
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]

[Run]
Filename: "{app}\ReleaseNotes.html"; Description: "View the Release Notes"; Flags: postinstall shellexec skipifsilent

[Tasks]

[Code]