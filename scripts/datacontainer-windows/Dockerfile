FROM mcr.microsoft.com/windows/servercore:ltsc2022
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]

RUN mkdir Users\\Administrator\\specrepo

COPY .git C:\\Users\\Administrator\\specrepo\\.git

WORKDIR C:\\Users\\Administrator\\scripts
ADD https://github.com/git-for-windows/git/releases/download/v2.12.2.windows.2/MinGit-2.12.2.2-64-bit.zip MinGit.zip
RUN Expand-Archive C:\\Users\\Administrator\\scripts\\MinGit.zip -DestinationPath c:\\MinGit

COPY run.ps1 run.ps1

WORKDIR C:\\Users\\Administrator\\openapispecs
ENTRYPOINT C:\\Users\\Administrator\\scripts\\run.ps1