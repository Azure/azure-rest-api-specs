$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Installing MinGit"
Expand-Archive MinGit.zip -DestinationPath c:\MinGit
$env:PATH = $env:PATH + ';C:\MinGit\cmd\;C:\MinGit\cmd'
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $env:PATH

$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Copying files to /user/data/openapispecs"
Copy-Item -Path "C:\\usr\\data\\specrepo\\.git" -Destination "C:\\usr\\data\\openapispecs\\.git" -Recurse

cd "C:\\usr\\data\\openapispecs\\"
$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp]  Running 'git checkout [$specRetrievalGitBranch] -f'"
git checkout master -f

$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Deleting directory /usr/data/specrepo/"
Remove-Item -Path C:\\usr\\data\\specrepo -Recurse

$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Init completed successfully. OpenAPI specs are present in C:\usr\data\openapispecs "
