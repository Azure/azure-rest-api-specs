@echo off
echo Running AutoRest with NET _generated output directory...
cd /d "%~dp0"

REM Ensure the target output directory exists
if not exist "..\..\..\DevTestLabs\NET\_generated" mkdir "..\..\..\DevTestLabs\NET\_generated" 2>nul

REM Run AutoRest with the NET _generated output directory
echo Using AutoRest with DevTestLabs NET _generated output folder...
call autorest --input-file=./DTL.json --csharp --output-folder="..\..\DevTestLabs\NET\_generated" --namespace=Microsoft.Azure.Management.DevTestLabs --sample-generation=false --modelerfour.lenient-model-deduplication=true

if %ERRORLEVEL% EQU 0 (
    echo AutoRest execution completed successfully.
    echo Generated files can be found in ..\DevTestLabs\NET\_generated
) else (
    echo AutoRest execution failed with error code %ERRORLEVEL%.
)

pause

if %ERRORLEVEL% EQU 0 (
    echo AutoRest execution completed successfully.
) else (
    echo AutoRest execution failed with error code %ERRORLEVEL%.
)

pause
