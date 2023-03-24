@set @dummy=0/*
@echo off
NET FILE 1>NUL 2>NUL
if "%ERRORLEVEL%" neq "0" (
  cscript //nologo //E:JScript "%~f0" %*
  exit /b %ERRORLEVEL%
)

@echo on
@set /P VMName="VMName: "
powershell -Command "Add-VMGpuPartitionAdapter -VMName %VMName%"
powershell -Command "Set-VMGpuPartitionAdapter -VMName %VMName% -Passthru"
powershell -Command "Set-VM -GuestControlledCacheTypes $true -VMName %VMName%"
powershell -Command "Set-VM -LowMemoryMappedIoSpace 1GB -VMName %VMName%"
powershell -Command "Set-VM -HighMemoryMappedIoSpace 32GB -VMName %VMName%"
@pause

@echo off
goto :EOF
*/
var cmd = '"/c ""' + WScript.ScriptFullName + '" ';
for (var i = 0; i < WScript.Arguments.Length; i++) cmd += '"' + WScript.Arguments(i) + '" ';
(new ActiveXObject('Shell.Application')).ShellExecute('cmd.exe', cmd + ' "', '', 'runas', 1);