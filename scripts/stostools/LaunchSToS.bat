@echo OFF

set StartupProj=%1
set PrNumber=%2
set LastGithubCommitId=%3
set GitHubUrl=%4
set TriggerComment=%5
set DebugMode=%6
set LogVerbosity=%7

if "%VSWHERE%"=="" set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"

for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.Component.MSBuild -property installationPath`) do (
  set InstallDir=%%i
)

CALL "%InstallDir%\Common7\Tools\VsDevCmd.bat"

echo StartupProj: %StartupProj%
echo Pr#: %PrNumber%
echo Last Commit Id: %LastGithubCommitId%
echo GitHub Url: %GitHubUrl%
echo Trigger Comment: %TriggerComment%
echo DebugMode: %DebugMode%
echo Log Verbosity: %LogVerbosity%

dotnet msbuild %startupProj% /t:StartNetSdkCodeGeneration /v:%LogVerbosity% /p:githubprnumber=%PrNumber% /p:githubcommitid=%LastGithubCommitId% /p:giturl=%GitHubUrl%  /p:DebugMode=%DebugMode% /p:triggercomment=%TriggerComment%

REM dotnet msbuild stos.proj /t:StartNetSdkCodeGeneration /v:N /p:githubprnumber=63 /p:githubcommitid=b5ee45302838515adc14857ed45c44ed99a1e517 /p:giturl=https://github.com/Azure/AzSwaggerSpecsTestClone  /p:DebugMode=false /p:triggercomment=startbuild
REM LaunchSToS.bat stos.proj 63 b5ee45302838515adc14857ed45c44ed99a1e517 https://github.com/Azure/AzSwaggerSpecsTestClone startbuild false D
REM stostools\LaunchSToS.bat SToS.proj %ghprbPullId% %ghprbActualCommit% %GIT_URL% %ghprbCommentBody% false n
