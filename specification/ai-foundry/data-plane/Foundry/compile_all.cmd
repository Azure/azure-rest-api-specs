:: Script to compile main.tsp at the project root and all client.tsp files in the \src\sdk-* folders
@echo off
setlocal

set "ROOT_DIR=%~dp0"
cd /d "%ROOT_DIR%" || exit /b 1

echo Compiling all sdk-* client TypeSpec files...
for /d %%D in ("src\sdk-*") do (
    if exist "%%~fD\client.tsp" (
        echo.
        echo [%%~fD] npx tsp compile client.tsp
        pushd "%%~fD" || exit /b 1
        call npx tsp compile client.tsp
        @echo off
        if errorlevel 1 (
            popd
            echo.
            echo Compile failed in %%~fD
            exit /b 1
        )
        popd
    )
)

echo.
echo [ROOT] npx tsp compile .
call npx tsp compile .
@echo off
if errorlevel 1 exit /b 1

echo.
echo All compilations completed successfully.
exit /b 0
