$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Copying files to /user/data/openapispecs"
Copy-Item -Path "/usr/data/specrepo/" -Destination "/usr/data/openapispecs/.git/" -Recurse

$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Running 'git checkout [$specRetrievalGitBranch] -f'"
git checkout $specRetrievalGitBranch -f

$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Deleting directory /usr/data/specrepo/"
Remove-Item -Path /usr/data/specrepo/ -Recurse

$timestamp= Get-Date -UFormat "%A %m/%d/%Y %R %Z"
echo "[$timestamp] Init completed successfully. OpenAPI specs are present in C:\RPSaaS\onebox\specifications."
