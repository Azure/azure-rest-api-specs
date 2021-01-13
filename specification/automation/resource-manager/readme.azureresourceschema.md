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
  - Microsoft.Automation/preview/2020-01-13-preview/python2package.json
  - Microsoft.Automation/preview/2020-01-13-preview/dscNode.json
  - Microsoft.Automation/preview/2020-01-13-preview/dscCompilationJob.json
  - Microsoft.Automation/preview/2020-01-13-preview/dscNodeCounts.json
  - Microsoft.Automation/preview/2020-01-13-preview/sourceControl.json
  - Microsoft.Automation/preview/2020-01-13-preview/sourceControlSyncJob.json
  - Microsoft.Automation/preview/2020-01-13-preview/sourceControlSyncJobStreams.json
  - Microsoft.Automation/preview/2020-01-13-preview/account.json
  - Microsoft.Automation/preview/2020-01-13-preview/certificate.json
  - Microsoft.Automation/preview/2020-01-13-preview/connection.json
  - Microsoft.Automation/preview/2020-01-13-preview/connectionType.json
  - Microsoft.Automation/preview/2020-01-13-preview/credential.json
  - Microsoft.Automation/preview/2020-01-13-preview/hybridRunbookWorkerGroup.json
  - Microsoft.Automation/preview/2020-01-13-preview/jobSchedule.json
  - Microsoft.Automation/preview/2020-01-13-preview/linkedWorkspace.json
  - Microsoft.Automation/preview/2020-01-13-preview/module.json
  - Microsoft.Automation/preview/2020-01-13-preview/schedule.json
  - Microsoft.Automation/preview/2020-01-13-preview/variable.json
  - Microsoft.Automation/preview/2020-01-13-preview/watcher.json
  - Microsoft.Automation/stable/2018-06-30/dscNodeConfiguration.json
  - Microsoft.Automation/stable/2018-06-30/job.json
  - Microsoft.Automation/stable/2018-06-30/operations.json
  - Microsoft.Automation/stable/2018-06-30/runbook.json
  - Microsoft.Automation/stable/2018-06-30/softwareUpdateConfiguration.json
  - Microsoft.Automation/stable/2018-06-30/softwareUpdateConfigurationRun.json
  - Microsoft.Automation/stable/2018-06-30/softwareUpdateConfigurationMachineRun.json
  - Microsoft.Automation/stable/2018-06-30/webhook.json
```

### Tag: schema-automation-2018-06-30 and azureresourceschema

``` yaml $(tag) == 'schema-automation-2018-06-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Automation/stable/2018-06-30/runbook.json
  - Microsoft.Automation/stable/2018-06-30/python2package.json
  - Microsoft.Automation/stable/2018-06-30/dscNode.json
  - Microsoft.Automation/stable/2018-06-30/dscCompilationJob.json
  - Microsoft.Automation/stable/2018-06-30/dscNodeConfiguration.json
  - Microsoft.Automation/stable/2018-06-30/dscNodeCounts.json
  - Microsoft.Automation/stable/2018-06-30/softwareUpdateConfigurationRun.json
  - Microsoft.Automation/stable/2018-06-30/softwareUpdateConfigurationMachineRun.json
  - Microsoft.Automation/stable/2018-06-30/sourceControl.json
  - Microsoft.Automation/stable/2018-06-30/sourceControlSyncJob.json
  - Microsoft.Automation/stable/2018-06-30/sourceControlSyncJobStreams.json
  - Microsoft.Automation/stable/2018-06-30/job.json
  - Microsoft.Automation/stable/2018-06-30/account.json
  - Microsoft.Automation/stable/2018-06-30/certificate.json
  - Microsoft.Automation/stable/2018-06-30/connection.json
  - Microsoft.Automation/stable/2018-06-30/connectionType.json
  - Microsoft.Automation/stable/2018-06-30/credential.json
  - Microsoft.Automation/stable/2018-06-30/dscConfiguration.json
  - Microsoft.Automation/stable/2018-06-30/softwareUpdateConfiguration.json
  - Microsoft.Automation/stable/2018-06-30/hybridRunbookWorkerGroup.json
  - Microsoft.Automation/stable/2018-06-30/jobSchedule.json
  - Microsoft.Automation/stable/2018-06-30/linkedWorkspace.json
  - Microsoft.Automation/stable/2018-06-30/module.json
  - Microsoft.Automation/stable/2018-06-30/schedule.json
  - Microsoft.Automation/stable/2018-06-30/variable.json
  - Microsoft.Automation/stable/2018-06-30/webhook.json
  - Microsoft.Automation/stable/2018-06-30/watcher.json
  - Microsoft.Automation/stable/2018-06-30/operations.json
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
  - Microsoft.Automation/stable/2018-01-15/softwareUpdateConfigurationRun.json
  - Microsoft.Automation/stable/2018-01-15/softwareUpdateConfigurationMachineRun.json
  - Microsoft.Automation/stable/2018-01-15/sourceControl.json
  - Microsoft.Automation/stable/2018-01-15/sourceControlSyncJob.json
  - Microsoft.Automation/stable/2018-01-15/sourceControlSyncJobStreams.json
  - Microsoft.Automation/stable/2018-01-15/job.json
  - Microsoft.Automation/stable/2018-01-15/account.json
  - Microsoft.Automation/stable/2018-01-15/certificate.json
  - Microsoft.Automation/stable/2018-01-15/connection.json
  - Microsoft.Automation/stable/2018-01-15/connectionType.json
  - Microsoft.Automation/stable/2018-01-15/credential.json
  - Microsoft.Automation/stable/2018-01-15/dscConfiguration.json
  - Microsoft.Automation/stable/2018-01-15/softwareUpdateConfiguration.json
  - Microsoft.Automation/stable/2018-01-15/hybridRunbookWorkerGroup.json
  - Microsoft.Automation/stable/2018-01-15/jobSchedule.json
  - Microsoft.Automation/stable/2018-01-15/linkedWorkspace.json
  - Microsoft.Automation/stable/2018-01-15/module.json
  - Microsoft.Automation/stable/2018-01-15/runbook.json
  - Microsoft.Automation/stable/2018-01-15/schedule.json
  - Microsoft.Automation/stable/2018-01-15/variable.json
  - Microsoft.Automation/stable/2018-01-15/webhook.json
  - Microsoft.Automation/stable/2018-01-15/watcher.json
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
  - Microsoft.Automation/preview/2017-05-15-preview/account.json
  - Microsoft.Automation/preview/2017-05-15-preview/certificate.json
  - Microsoft.Automation/preview/2017-05-15-preview/connection.json
  - Microsoft.Automation/preview/2017-05-15-preview/connectionType.json
  - Microsoft.Automation/preview/2017-05-15-preview/credential.json
  - Microsoft.Automation/preview/2017-05-15-preview/dscCompilationJob.json
  - Microsoft.Automation/preview/2017-05-15-preview/dscConfiguration.json
  - Microsoft.Automation/preview/2017-05-15-preview/dscNode.json
  - Microsoft.Automation/preview/2017-05-15-preview/dscNodeConfiguration.json
  - Microsoft.Automation/preview/2017-05-15-preview/hybridRunbookWorkerGroup.json
  - Microsoft.Automation/preview/2017-05-15-preview/jobSchedule.json
  - Microsoft.Automation/preview/2017-05-15-preview/linkedWorkspace.json
  - Microsoft.Automation/preview/2017-05-15-preview/module.json
  - Microsoft.Automation/preview/2017-05-15-preview/runbook.json
  - Microsoft.Automation/preview/2017-05-15-preview/schedule.json
  - Microsoft.Automation/preview/2017-05-15-preview/variable.json
  - Microsoft.Automation/preview/2017-05-15-preview/webhook.json
  - Microsoft.Automation/preview/2017-05-15-preview/watcher.json

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
