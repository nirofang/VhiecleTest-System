#define MyAppName "CamAligner" 
#define MyAppVersion "1.0" 
#define MyAppPublisher "Publisher" 
#define MyAppExeName "CamAligner.exe" 

[Setup]
AppName=CamAligner
AppVersion=1.1.0.0
AppCopyright=2017
DefaultDirName=C:\CamAligner
DisableDirPage=yes
DisableProgramGroupPage=auto
DefaultGroupName=CamAligner

[Run]
Filename: "{src}\Run-Time Engine\2013 SP1 (32-bit) f6 Patch\Standard\setup.exe"; Parameters: "/qf /AcceptLicenses yes /disableNotificationCheck /r:n"; Flags: waituntilterminated
Filename: "{localappdata}\temp\vc_redist.x86.exe"; Parameters: "/install /passive"; WorkingDir: "{src}\Run-Time Engine\DotNetFrame452"; Flags: waituntilterminated; StatusMsg: "Installing Microsoft Visual C++ Runtime ..."; Check: VCRedistNeedsInstall
Filename: "{src}\Run-Time Engine\DotNetFrame452\NDP452-KB2901907-x86-x64-AllOS-ENU.exe"; Parameters: "/norestart /passive"; WorkingDir: "{src}\Run-Time Engine\DotNetFrame452"; Flags: waituntilterminated; StatusMsg: "Installing Microsoft DotNet Framework 4.5.2 ..."; Check: Framework45IsNotInstalled
Filename: "netsh"; Parameters: "http add urlacl url= http://+:3302/MyWcfService.svc/ user=.\users"; Flags: waituntilterminated
Filename: "{app}\service\AppController.exe"; Parameters: "--install"; WorkingDir: "{app}\service"; Flags: waituntilterminated
Filename: "{app}\service\AppController.exe"; Parameters: "--start"; WorkingDir: "{app}\service"; Flags: waituntilterminated

[UninstallRun]
Filename: "{pf32}\National Instruments\Shared\NIUninstaller\uninst.exe"; Parameters: "/qb /x all"; Flags: waituntilterminated
Filename: "{app}\service\AppController.exe"; Parameters: "--stop"; WorkingDir: "{app}\service"; Flags: waituntilterminated
Filename: "{app}\service\AppController.exe"; Parameters: "--uninstall"; WorkingDir: "{app}\service"; Flags: waituntilterminated

[Registry]
Root: "HKLM32"; Subkey: "SOFTWARE\CamAligner"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"
Root: "HKLM32"; Subkey: "SOFTWARE\CamAligner"; ValueType: string; ValueName: "HostLink"; ValueData: "http://47.95.218.137"
Root: "HKLM32"; Subkey: "SOFTWARE\CamAligner"; ValueType: string; ValueName: "InstallUserPath"; ValueData: "{localappdata}"

[Files]
Source: "Cam_AppFiles\ReportViewerSetup\setup.exe"; DestDir: "{app}\ReportViewerSetup\"; Flags: ignoreversion
Source: "Cam_AppFiles\ReportViewerSetup\SetupReportviewer.msi"; DestDir: "{app}\ReportViewerSetup\"; Flags: ignoreversion
Source: "Cam_AppFiles\ReportViewerSetup\DotNetFX45\dotNetFx45_Full_x86_x64.exe"; DestDir: "{app}\ReportViewerSetup\DotNetFX45\"; Flags: ignoreversion
Source: "Cam_AppFiles\ReportViewerSetup\ReportViewer\ReportViewer.msi"; DestDir: "{app}\ReportViewerSetup\ReportViewer\"; Flags: ignoreversion
Source: "Cam_AppFiles\ReportViewerSetup\SqlClrTypes_x64\SQLSysClrTypes.msi"; DestDir: "{app}\ReportViewerSetup\SqlClrTypes_x64\"; Flags: ignoreversion
Source: "Cam_AppFiles\ReportViewerSetup\SqlClrTypes_x86\SQLSysClrTypes.msi"; DestDir: "{app}\ReportViewerSetup\SqlClrTypes_x86\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\AppController.exe"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\AppController.exe.config"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\AppWcfService.dll"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\AppWcfService.dll.config"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\SKGL.dll"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\SKGL.xml"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\Newtonsoft.Json.dll"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\Newtonsoft.Json.xml"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\System.Data.SQLite.dll"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\System.Data.SQLite.dll.config"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\System.Data.SQLite.xml"; DestDir: "{app}\service\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\x64\SQLite.Interop.dll"; DestDir: "{app}\service\x64\"; Flags: ignoreversion
Source: "Cam_AppFiles\service\x86\SQLite.Interop.dll"; DestDir: "{app}\service\x86\"; Flags: ignoreversion
Source: "Cam_AppFiles\CamAligner.aliases"; DestDir: "{app}"; Flags: ignoreversion
Source: "Cam_AppFiles\CamAligner.chm"; DestDir: "{app}"; Flags: ignoreversion
Source: "Cam_AppFiles\CamAligner.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "Cam_AppFiles\CamAligner.exe.config"; DestDir: "{app}"; Flags: ignoreversion
Source: "Cam_AppFiles\CamAligner.ini"; DestDir: "{localappdata}\CamAligner\"; DestName: "embeded.ini"; Flags: ignoreversion
Source: "Cam_AppFiles\Lib\COLWindowFramework.lvlibp"; DestDir: "{localappdata}\CamAligner\Lib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Lib\Control.lvlibp"; DestDir: "{localappdata}\CamAligner\Lib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Lib\CustomControl.lvlibp"; DestDir: "{localappdata}\CamAligner\Lib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Lib\Error.lvlibp"; DestDir: "{localappdata}\CamAligner\Lib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Lib\WindowFramework.lvlibp"; DestDir: "{localappdata}\CamAligner\Lib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\CamAligner.chm"; DestDir: "{localappdata}\CamAligner\Support\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Camaligner.ico"; DestDir: "{localappdata}\CamAligner\Support\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Josam-logotype-220x56.jpg"; DestDir: "{localappdata}\CamAligner\Support\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\LASER.WAV"; DestDir: "{localappdata}\CamAligner\Support\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Data\empty.txt"; DestDir: "{localappdata}\CamAligner\Support\Data\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\1D Polynomial Evaluation (CDB).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\1D Polynomial Evaluation (DBL).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\2D Polynomial Evaluation (CDB).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\2D Polynomial Evaluation (DBL).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPCallChain.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPClassInfoTypeDef.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPClassStatistics.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPFindClassPath.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPKernelSlave.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPObjectInfoType.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPSetError.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPSharedInfo.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPStates.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\3GOOPVersion.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\8.6CompatibleGlobalVar.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\A x B.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\A x Vector.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Acquire Input Data.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Add Key.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Add Quotes.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Application Directory.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Array To Matrix - CA.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Array To Matrix - CA2.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Array To Matrix - RA.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Array To Matrix - RA2.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Array To Matrix.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\AxInterop.ShockwaveFlashObjects.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\AxleWithToe.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\BuildHelpPath.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\CamAlignerWheelAlignmentReport.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Check if File or Folder Exists.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Check Path.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Check Special Tags.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Clear Errors.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Close Config Data.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Close File+.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Close Input Device.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Close Reference(Impl).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Close Reference(NdList).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Close Reference(NNMap).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Close Reference(Node).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Close Registry Key.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Close.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\closeJoystick.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\closeKeyboard.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\closeMouse.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Color to RGB.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Common Path to Specific Path.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\compatReadText.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Complex A x B.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Complex A x Vector.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Complex Compact Tri-Matrix Linear Eqs.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Complex Conjugate Transpose Matrix.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Complex Dot Product.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Complex Matrix to Compact Array.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Complex SVD Decomposition.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Complex Vector x A.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\ComplexMatrix.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Config Data RefNum.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Config Data.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Config Queue.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Config to String.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Convert property node font to graphics font.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Create Registry Key.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Curve Fitting Criteria.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Details Display Dialog.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\DialogType.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\DialogTypeEnum.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Directory of Top Level VI.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Dot Product.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Draw Arc.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Draw Circle by Radius.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Draw Flattened Pixmap.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Draw Multiple Lines.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Draw Rect.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Draw Text at Point.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Draw Text in Rect.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Empty Picture"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Error Cluster From Error Code.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Error Code Database.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\error code mapping for polynomial.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\ErrorDescriptions.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\errorList.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\ErrWarn.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Escape String.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\eventvkey.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Find First Error.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Find Tag.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\FixBadRect.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\FlashPlayer.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Format Message String.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\FormatTime String.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\ftd2xx.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\FT_FileTypes.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\General Error Handler CORE.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\General Error Handler.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Generate Error Cluster.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Get Exported File List.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Get File Path.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Get File Type.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Get First Matched Node.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Get Key.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Get Section Names.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Get Section.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Get String Text Bounds.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Get Text Rect.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\GetHelpDir.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\GetRTHostConnectedProp.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\imagedata.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Initialize Mouse.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Interop.ShockwaveFlashObjects.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Inverse A x Y using SVD (CDB).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Inverse A x Y using SVD (DBL).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Is File an LLB.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\JOSAM.Math.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\JOSAM.Utilities.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\JOSAM.WPFUtilities.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\joystickAcquire.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\keyboardAcquire.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Linear Fit (Bisquare).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Linear Fit (LAR).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Linear Fit (LS).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Linear Fit Coefficients (Bisquare).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Linear Fit Coefficients (LAR).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Linear Fit Coefficients (LS).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Linear Fit Coefficients.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Linear Fit.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Load XML File.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Load XML String.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Longest Line Length in Pixels.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\lvanlys.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\LVBoundsTypeDef.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\LVDateTimeRec.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\LVFileType.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\lvinput.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\LVPoint32TypeDef.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\LVPositionTypeDef.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\LVRangeTypeDef.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\LVRectTypeDef.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\lvsound.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\lvsqlite.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Matrix To Array - CM.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Matrix To Array - RM.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Matrix To Array.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Matrix Type of Inverse Matrix.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Mean (CDB).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Mean (DBL).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Mean.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Merge Error Code.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Microsoft.ReportViewer.Common.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Microsoft.ReportViewer.WinForms.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\mouseAcquire.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\New Config to Queue.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\New.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\NI_AALBase.lvlib"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\NI_AALPro.lvlib"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\NI_FileType.lvlib"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\NI_LVConfig.lvlib"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\NI_Matrix.lvlib"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\NI_PackedLibraryUtility.lvlib"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\NI_XML.lvlib"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Not Found Dialog.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\OnFlashCall.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Open Config Data (compatibility).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Open File+.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Open Registry Key.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Parse Config to Queue.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Parse Key Value Pair.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\PCT Pad String.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Polynomial Evaluation.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read File+ (string).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read JPEG File.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Key (Boolean).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Key (Double).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Key (I32).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Key (Path).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Key (String).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Key (U32).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Key.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Registry Value DWORD.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Registry Value Simple STR.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Registry Value Simple U32.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Registry Value Simple.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Registry Value STR.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Registry Value.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Read Value Without Comment.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Real A x B.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Real Compact Tri-Matrix Linear Eqs.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Real Dot Product.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Real Matrix to Compact Array.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Real SVD Decomposition.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Real Transpose Matrix.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\RealMatrix.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Registry Handle Master.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Registry refnum.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Registry RtKey.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Registry SAM.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Registry Simplify Data Type.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Registry View.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Registry WinErr-LVErr.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Remove Quotes.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Remove Zero Coefficients (CDB).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Remove Zero Coefficients (DBL).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Remove Zero Coefficients.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Remove Zero Threshold Type.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\RGB to Color.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Save Config File.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Scalar Polynomial Evaluation (CDB).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Scalar Polynomial Evaluation (DBL).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Search and Replace Pattern.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Section.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Set Bold Text.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Set Pen State.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Set String Value.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Simple Error Handler.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Snd Gen Error Call Chain.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Snd Play Wave File.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Snd Read Wave File.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Snd Write Waveform.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\SO Clear.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\SO Config.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\SO Start.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\SO Wait.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\SO Write.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Complex Linear Eqs (Gen, multi right hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Complex Linear Eqs (Gen, single right hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Complex Linear Equations (multiple right hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Complex Linear Equations (single right hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Complex Linear Equations By Cholesky.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve General Complex Linear Equations.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve General Linear Equations with SVD (CDB).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve General Linear Equations with SVD (CDB, multi hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve General Linear Equations with SVD (DBL).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve General Linear Equations with SVD (DBL, multi hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve General Linear Equations.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Linear Eqs (Gen, multi right hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Linear Eqs (Gen, single right hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Linear Eqs (General).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Linear Equations (multiple right hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Linear Equations (single right hand).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Linear Equations By Cholesky.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Solve Linear Equations.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Sound Format.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Space Constant.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Specific Path to Common Path.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\sqlite3.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\stdole.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\String to Config.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\STR_ASCII-Unicode.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\subElapsedTime.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\SVD Decomposition.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\SVD Option.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\TagReturnType.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Three Button Dialog CORE.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Three Button Dialog.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Transpose Matrix.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Trim Whitespace.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Typecast Queue to Refnum.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Typecast Refnum to Queue.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Unconstrained Linear Fit.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Unescape String.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Unit Vector (CDB).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Unit Vector (DBL).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Unit Vector.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Vector Norm Type.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Vector x A.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\VectorAxle.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\VectorAxleList.dll"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\whitespace.ctl"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Key (Boolean).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Key (Double).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Key (I32).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Key (Path).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Key (String).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Key (U32).vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Key.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Registry Value DWORD.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Registry Value Simple STR.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Registry Value Simple U32.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Registry Value Simple.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Registry Value STR.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\Write Registry Value.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\NI_LVConfig\Load.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\NI_LVConfig\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Dll\NI_XML\Load.vi"; DestDir: "{localappdata}\CamAligner\Support\Dll\NI_XML\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CamAligner.mp4"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\camaligner.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TruckCam.mp4"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\truckcam.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Align\adjust_ds_left.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Align\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Align\adjust_ds_right.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Align\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Align\adjust_front.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Align\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Align\adjust_rear.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Align\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Align\align.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Align\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Align\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Align\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ArticulatedVehicle\articulated_vehicle_2.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ArticulatedVehicle\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ArticulatedVehicle\articulated_vehicle_3.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ArticulatedVehicle\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ArticulatedVehicle\articulated_vehicle_4.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ArticulatedVehicle\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ArticulatedVehicle\articulated_vehicle_trailer_2.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ArticulatedVehicle\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ArticulatedVehicle\articulated_vehicle_trailer_3.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ArticulatedVehicle\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ArticulatedVehicle\articulated_vehicle_trailer_4.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ArticulatedVehicle\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ArticulatedVehicle\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ArticulatedVehicle\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CameraCalib\camera_calibration_step_1.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CameraCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CameraCalib\camera_calibration_step_2.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CameraCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CameraCalib\camera_calibration_step_3.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CameraCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CameraCalib\camera_calibration_step_4.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CameraCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CameraCalib\camera_switch_on.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CameraCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CameraCalib\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CameraCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\computer_screen_error.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\floor_marker_left.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\floor_marker_right.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\front_left_far.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\front_left_near.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\front_right_far.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\front_right_near.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\KPI_caster_justering.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\turn_wheels_left_to_right.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\turn_wheels_middle_to_left.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\CastorKPITurn\turn_wheels_right_to_middle.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\CastorKPITurn\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FloorReference\floor_reference.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FloorReference\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FloorReference\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FloorReference\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameGaugeCalib\frame_gauge_calibration_01.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameGaugeCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameGaugeCalib\frame_gauge_calibration_02.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameGaugeCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameGaugeCalib\frame_gauge_calibration_03.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameGaugeCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameGaugeCalib\frame_gauge_calibration_04.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameGaugeCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameGaugeCalib\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameGaugeCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameMeasurement\frame_measure_1.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameMeasurement\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameMeasurement\frame_measure_2.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameMeasurement\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameMeasurement\frame_measure_3.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameMeasurement\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameMeasurement\frame_measure_4.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameMeasurement\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameMeasurement\frame_measure_5.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameMeasurement\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\FrameMeasurement\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\FrameMeasurement\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\InclinometerCalib\inclinometer_calib_step_1.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\InclinometerCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\InclinometerCalib\inclinometer_calib_step_2.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\InclinometerCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\InclinometerCalib\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\InclinometerCalib\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LDW\LDW_01.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LDW\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LDW\LDW_02.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LDW\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LDW\LDW_03.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LDW\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LDW\LDW_04.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LDW\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LDW\LDW_05.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LDW\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LDW\LDW_06.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LDW\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LDW\LDW_07.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LDW\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LDW\LDW_08.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LDW\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LDW\LDW_09.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LDW\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LPOS\LPOS_01.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LPOS\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LPOS\LPOS_02.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LPOS\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LPOS\LPOS_03.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LPOS\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LPOS\LPOS_04.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LPOS\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LPOS\LPOS_05.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LPOS\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LPOS\LPOS_06.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LPOS\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LPOS\LPOS_07.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LPOS\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LPOS\LPOS_Distance.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LPOS\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\LPOS\LPOS_PreMeasurement.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\LPOS\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Pairing\pairing.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Pairing\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Pairing\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Pairing\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarMirror\radar_mirror_01.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarMirror\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarMirror\radar_mirror_02.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarMirror\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarMirror\radar_mirror_03.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarMirror\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarMirror\radar_mirror_04.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarMirror\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarMirror\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarMirror\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarReference\RadarReference_01.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarReference\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarReference\RadarReference_02.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarReference\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarReference\RadarReference_03.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarReference\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarReference\RadarReference_04.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarReference\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarReference\RadarReference_05.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarReference\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RadarReference\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RadarReference\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Runout\runout_step_1.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Runout\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Runout\runout_step_2.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Runout\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Runout\runout_step_3.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Runout\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Runout\runout_step_4.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Runout\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Runout\runout_step_5.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Runout\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Runout\runout_step_6.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Runout\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Runout\runout_step_7.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Runout\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Runout\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Runout\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_1.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_10.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_2.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_3.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_4.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_5.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_6.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_7.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_8.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\RunoutIncl\runout_step_9.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\RunoutIncl\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\computer_screen_error.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\front_left_far.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\front_left_near.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\front_right_far.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\front_right_near.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\front_roll.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\rear_left_far.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\rear_left_near.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\rear_right_far.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\rear_right_near.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\rear_roll.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\steering_gear_no_button.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\ToeCamber\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\ToeCamber\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\textLayout_2.0.0.232.swz"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_01.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_02.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_03.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_04.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_05.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_06.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_07.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_08.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_09.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_10.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_11.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_12.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_13.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_14.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_15.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_16.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\TwinRoll\twinroll_17.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\TwinRoll\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\adjust_Twinsteer_left.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\adjust_Twinsteer_left_3bars.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\adjust_Twinsteer_right.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\adjust_Twinsteer_right_3bars.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\TwinsteerRoll_left.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\TwinsteerRoll_right.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\Twinsteer_01.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\Twinsteer_01_right.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\Twinsteer_02.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\Twinsteer_02_right.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\Twinsteer_03.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\Twinsteer_03_right.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\Twinsteer_04.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Flashmovies\Twinsteer\Twinsteer_04_right.swf"; DestDir: "{localappdata}\CamAligner\Support\Flashmovies\Twinsteer\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\bcbie60.bpl"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\borlndmm.dll"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\cc3260mt.dll"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\col_reg.dll"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\col_reg_lang.txt"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\english_col_reg.txt"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\French_col_reg.txt"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\German_col_reg.txt"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\Italian_col_reg.txt"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\Japanese_col_reg.txt"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\nmfast60.bpl"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\Rtl60.bpl"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\Spanish_col_reg.txt"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\swedish_col_reg.txt"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Registration\vcl60.bpl"; DestDir: "{localappdata}\CamAligner\Support\Registration\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Align.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\AllvaluesAxleList.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\AllvaluesFrame.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\AllvaluesVehicle.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\ArticulatedVehicle.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Calibration.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\CameraCalibration.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\CastorKPITurn.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Chinese_Report.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\ChooseVehicle.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\FloorReference.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\FrameDefinition.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\FrameGaugeCalibration.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\FrameMeasurement.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\French_Report.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\InclinometerCalibration.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Italian_Report.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Japanese_Report.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Japanese_ToeCamberRunOut.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\LPOS.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\ManMFC.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\NewOrder.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\OpenOrder.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Pairing.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\RadarCalibration.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\RadarDefinition.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\RadarMirror.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\RadarReference.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Report.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\RunOut.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\RunOutIncl.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Setup.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\StartWindow.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\ToeCamberMultiRoll.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\ToeCamberRoll.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\ToeCamberRunOut.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Translation.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Twinsteer.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\TwinsteerRoll.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\VehicleDefinition.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\VehicleTolerance.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\VehicleType.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Bulgarian.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Chinese.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Czech.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Dutch.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\English.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\French.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\German.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Hungarian.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Italian.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Japanese.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Korean.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Lithuanian.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Polish.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Portuguese-Brazil.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Romanian.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Russian.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Spanish.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
Source: "Cam_AppFiles\Support\Translation\Language\Swedish.tlf"; DestDir: "{localappdata}\CamAligner\Support\Translation\Language\"; Flags: ignoreversion
; Visual C++ redist
Source: "Runtime\vc_2017_25008\vc_redist.x86.exe"; DestDir: "{localappdata}\temp"; Flags: deleteafterinstall; Check: VCRedistNeedsInstall

[Code]
function VCRedistNeedsInstall: Boolean;
var
  dName: String;
begin
  Result := False;
  if RegQueryStringValue(HKLM, 'SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{44b03b2c-46e6-4c3d-91c3-87175a02e274}', 'DisplayName', dName) = false then begin
    Result := true;
  end;
end;

function Framework45IsNotInstalled(): Boolean;
var
  bSuccess: Boolean;
  regVersion: Cardinal;
begin
  Result := True;

  bSuccess := RegQueryDWordValue(HKLM, 'Software\Microsoft\NET Framework Setup\NDP\v4\Full', 'Release', regVersion);
  if (True = bSuccess) and (regVersion >= 378389) then begin
    Result := False;
  end;
end;

[UninstallDelete]
Type: filesandordirs; Name: "{localappdata}\CamAligner"

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{app}\CamAligner.exe"; IconIndex: 0
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{app}\CamAligner.exe"; IconIndex: 0
