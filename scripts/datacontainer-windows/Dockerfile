FROM mcr.microsoft.com/windows/server:ltsc2022

RUN mkdir usr\\data\\specrepo

COPY .git \\usr\\data\\specrepo\\.git

WORKDIR C:\\usr\\data\\scripts
ADD https://github.com/git-for-windows/git/releases/download/v2.12.2.windows.2/MinGit-2.12.2.2-64-bit.zip MinGit.zip

COPY run.ps1 run.ps1
RUN  powershell .\run.ps1

WORKDIR C:\\usr\\data\\openapispecs
CMD ["C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "-File", "C:\\run.ps1"]