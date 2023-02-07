FROM mcr.microsoft.com/windows/server:ltsc2022

RUN mkdir usr\data\specrepo

RUN xcopy \.git \usr\data\specrepo\.git /s

WORKDIR C:\usr\data\scripts
COPY api-specs azure-rest-api-specs

COPY ..\datacontainer\run.ps1 run.ps1
RUN  powershell .\run.ps1

WORKDIR C:/usr/data/openapispecs
CMD ["C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "-File", "C:\\run.ps1"]