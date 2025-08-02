[Setup]
AppName=Darkan Launcher
AppPublisher=Darkan
UninstallDisplayName=Darkan
AppVersion=${project.version}
AppSupportURL=https://darkan.org
DefaultDirName={localappdata}\Darkan

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\Darkan.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=DarkanSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-x64\Darkan.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\Darkan.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Darkan\Darkan"; Filename: "{app}\Darkan.exe"
Name: "{userprograms}\Darkan\Darkan (configure)"; Filename: "{app}\Darkan.exe"; Parameters: "--configure"
Name: "{userprograms}\Darkan\Darkan (safe mode)"; Filename: "{app}\Darkan.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Darkan"; Filename: "{app}\Darkan.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Darkan.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Darkan.exe"; Description: "&Open Darkan"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Darkan.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.Darkan\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Darkan.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"
