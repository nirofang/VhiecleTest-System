echo %~dp0
robocopy %~dp0 %~dp0..\ClientSide\SetupFiles\ *.iss

pause