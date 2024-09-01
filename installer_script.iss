#define MyAppName "Code Merger"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "NersNote"
#define MyAppExeName "code_merger_desktop.exe"

[Setup]
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=installer
OutputBaseFilename=code_merger_setup
Compression=lzma
SolidCompression=yes

[Files]
Source: "C:\Ngoding\code_merger_desktop\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Ngoding\code_merger_desktop\build\windows\x64\runner\Release\code_merger_desktop.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"