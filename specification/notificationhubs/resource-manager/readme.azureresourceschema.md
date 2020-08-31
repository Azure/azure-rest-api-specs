## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.NotificationHubs/stable/2017-04-01/notificationhubs.json
  - Microsoft.NotificationHubs/stable/2016-03-01/notificationhubs.json
  - Microsoft.NotificationHubs/stable/2014-09-01/notificationhubs.json

```