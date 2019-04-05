# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Backup.Admin/preview/2018-09-01/Backup.json
  - $(this-folder)/Microsoft.Backup.Admin/preview/2018-09-01/BackupLocations.json
  - $(this-folder)/Microsoft.Backup.Admin/preview/2018-09-01/Backups.json
  - $(this-folder)/Microsoft.Backup.Admin/stable/2016-05-01/Backup.json
  - $(this-folder)/Microsoft.Backup.Admin/stable/2016-05-01/BackupLocations.json
  - $(this-folder)/Microsoft.Backup.Admin/stable/2016-05-01/Backups.json
require: $(this-folder)/../../../../../profiles/readme.md
```
