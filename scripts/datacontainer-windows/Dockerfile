FROM BaseImage
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]

RUN mkdir usr\\data\\specrepo

COPY .git \\usr\\data\\specrepo\\.git

WORKDIR C:\\usr\\data\\scripts
ADD https://github.com/git-for-windows/git/releases/download/v2.12.2.windows.2/MinGit-2.12.2.2-64-bit.zip MinGit.zip
RUN Expand-Archive C:\usr\data\scripts\MinGit.zip -DestinationPath c:\MinGit

COPY run.ps1 run.ps1

WORKDIR C:\\usr\\data\\openapispecs
ENTRYPOINT C:\\usr\\data\scripts\run.ps1