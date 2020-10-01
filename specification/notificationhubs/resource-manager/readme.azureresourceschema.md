## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-notificationhubs-2017-04-01
  - tag: schema-notificationhubs-2016-03-01
  - tag: schema-notificationhubs-2014-09-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-notificationhubs-2017-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-notificationhubs-2017-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NotificationHubs/stable/2017-04-01/notificationhubs.json

```

### Tag: schema-notificationhubs-2016-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-notificationhubs-2016-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NotificationHubs/stable/2016-03-01/notificationhubs.json

```

### Tag: schema-notificationhubs-2014-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-notificationhubs-2014-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NotificationHubs/stable/2014-09-01/notificationhubs.json

```
