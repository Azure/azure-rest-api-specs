## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-scheduler-2016-03-01
  - tag: schema-scheduler-2016-01-01
  - tag: schema-scheduler-2014-08-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-scheduler-2016-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-scheduler-2016-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scheduler/stable/2016-03-01/scheduler.json

```

### Tag: schema-scheduler-2016-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-scheduler-2016-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scheduler/stable/2016-01-01/scheduler.json

```

### Tag: schema-scheduler-2014-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-scheduler-2014-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scheduler/preview/2014-08-01-preview/scheduler.json

```
