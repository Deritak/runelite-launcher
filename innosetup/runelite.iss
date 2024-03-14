[Setup]
AppName=Zenyte Launcher
AppPublisher=Zenyte
UninstallDisplayName=Zenyte
AppVersion=${project.version}
AppSupportURL=https://zenyte.com
DefaultDirName={localappdata}\Zenyte

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/innosetup/runelite_small.bmp
SetupIconFile=${basedir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\Zenyte.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=ZenyteSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-x64\Zenyte.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x64\Zenyte.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Zenyte\Zenyte"; Filename: "{app}\Zenyte.exe"
Name: "{userprograms}\Zenyte\Zenyte (configure)"; Filename: "{app}\Zenyte.exe"; Parameters: "--configure"
Name: "{userprograms}\Zenyte\Zenyte (safe mode)"; Filename: "{app}\Zenyte.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Zenyte"; Filename: "{app}\Zenyte.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Zenyte.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Zenyte.exe"; Description: "&Open Zenyte"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Zenyte.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.zenyte\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"