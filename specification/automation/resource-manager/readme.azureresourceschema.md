## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-automation-2020-01-13-preview
  - tag: schema-automation-2018-06-30
  - tag: schema-automation-2018-01-15
  - tag: schema-automation-2017-05-15-preview
  - tag: schema-automation-2015-10-31

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-automation-2020-01-13-preview and azureresourceschema

``` yaml $(tag) == 'schema-automation-2020-01-13-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Automation/preview/2020-01-13-preview/privateEndpointConnection.json
  - Microsoft.Automation/preview/2020-01-13-preview/privateLinkResources.json

```

### Tag: schema-automation-2018-06-30 and azureresourceschema

``` yaml $(tag) == 'schema-automation-2018-06-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Automation/stable/2018-06-30/runbook.json
  - Microsoft.Automation/stable/2018-06-30/python2package.json

```

### Tag: schema-automation-2018-01-15 and azureresourceschema

``` yaml $(tag) == 'schema-automation-2018-01-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Automation/stable/2018-01-15/dscNode.json
  - Microsoft.Automation/stable/2018-01-15/dscCompilationJob.json
  - Microsoft.Automation/stable/2018-01-15/dscNodeConfiguration.json
  - Microsoft.Automation/stable/2018-01-15/dscNodeCounts.json

```

### Tag: schema-automation-2017-05-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-automation-2017-05-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfiguration.json
  - Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationRun.json
  - Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationMachineRun.json
  - Microsoft.Automation/preview/2017-05-15-preview/sourceControl.json
  - Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJob.json
  - Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJobStreams.json
  - Microsoft.Automation/preview/2017-05-15-preview/job.json

```

### Tag: schema-automation-2015-10-31 and azureresourceschema

``` yaml $(tag) == 'schema-automation-2015-10-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Automation/stable/2015-10-31/account.json
  - Microsoft.Automation/stable/2015-10-31/certificate.json
  - Microsoft.Automation/stable/2015-10-31/connection.json
  - Microsoft.Automation/stable/2015-10-31/connectionType.json
  - Microsoft.Automation/stable/2015-10-31/credential.json
  - Microsoft.Automation/stable/2015-10-31/dscCompilationJob.json
  - Microsoft.Automation/stable/2015-10-31/dscConfiguration.json
  - Microsoft.Automation/stable/2015-10-31/dscNode.json
  - Microsoft.Automation/stable/2015-10-31/dscNodeConfiguration.json
  - Microsoft.Automation/stable/2015-10-31/hybridRunbookWorkerGroup.json
  - Microsoft.Automation/stable/2015-10-31/job.json
  - Microsoft.Automation/stable/2015-10-31/jobSchedule.json
  - Microsoft.Automation/stable/2015-10-31/linkedWorkspace.json
  - Microsoft.Automation/stable/2015-10-31/module.json
  - Microsoft.Automation/stable/2015-10-31/runbook.json
  - Microsoft.Automation/stable/2015-10-31/schedule.json
  - Microsoft.Automation/stable/2015-10-31/variable.json
  - Microsoft.Automation/stable/2015-10-31/webhook.json
  - Microsoft.Automation/stable/2015-10-31/watcher.json

```
