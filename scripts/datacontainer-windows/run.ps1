
echo "[$timestamp] Adding git to path"
$env:PATH = $env:PATH + ';C:\MinGit\cmd\;C:\MinGit\cmd'
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $env:PATH

$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Copying files to \Users\Administrator\openapispecs"
Copy-Item -Path "C:\Users\Administrator\specrepo\.git" -Destination "C:\Users\Administrator\openapispecs\.git" -Recurse

cd "C:\Users\Administrator\openapispecs\"
$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp]  Running 'git checkout [$specRetrievalGitBranch] -f'"
git checkout $specRetrievalGitBranch -f

$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Deleting directory \Users\Administrator\specrepo"
Remove-Item -Path "C:\Users\Administrator\specrepo" -Recurse

$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Init completed successfully. OpenAPI specs are present in C:\Users\Administrator\openapispecs"
