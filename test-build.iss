[Setup]
AppName=SvelteKitApp
AppVersion=1.0
DefaultDirName={pf}\SvelteKitApp
DefaultGroupName=SvelteKitApp
OutputBaseFilename=SvelteKitAppInstaller
Compression=lzma
SolidCompression=yes

[Files]
; Copy the SvelteKit build files from your app
Source: "path\to\your\app\build\*"; DestDir: "{app}\build"; Flags: recursesubdirs createallsubdirs
; Copy server.js
Source: "path\to\your\app\server.js"; DestDir: "{app}"; Flags: ignoreversion
; Copy package.json and package-lock.json (if available) to install dependencies
Source: "path\to\your\app\package.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "path\to\your\app\package-lock.json"; DestDir: "{app}"; Flags: ignoreversion
; Copy Node.js installer
Source: "\path\to\node-v20.17.0-x64.msi"; DestDir: "{tmp}"; Flags: ignoreversion

[Icons]
; Create a shortcut to the batch file to start the server
Name: "{group}\Start SvelteKitApp"; Filename: "{app}\start-server.bat"
Name: "{group}\Uninstall SvelteKitApp"; Filename: "{uninstallexe}"

[Run]
; Install Node.js into "C:\Program Files\nodejs"
Filename: "{tmp}\node-v20.17.0-x64.msi"; Parameters: "/quiet INSTALLDIR=""C:\Program Files\nodejs"""; StatusMsg: "Installing Node.js..."; Flags: shellexec waituntilterminated

; Run npm install to install dependencies after the app is installed
Filename: "C:\Program Files\nodejs\npm.cmd"; Parameters: "install"; WorkingDir: "{app}"; StatusMsg: "Installing app dependencies..."; Flags: waituntilterminated

; Optionally run the app after installation
Filename: "{app}\start-server.bat"; Description: "Run SvelteKitApp"; Flags: nowait postinstall skipifsilent

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  AppDir, BatchFile: string;
begin
  if CurStep = ssPostInstall then
  begin
    AppDir := ExpandConstant('{app}');
    BatchFile := AppDir + '\start-server.bat';

    // Create the batch file that starts the SvelteKit app using Node.js
    SaveStringToFile(BatchFile,
    '@echo off' + #13#10 +
    'cd /d "' + AppDir + '"' + #13#10 +
    '"C:\Program Files\nodejs\node.exe" server.js' + #13#10 +
    'pause', False);
  end;
end;
