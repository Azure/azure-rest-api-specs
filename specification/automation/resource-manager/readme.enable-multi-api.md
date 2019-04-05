# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/account.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/certificate.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/connection.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/connectionType.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/credential.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/dscCompilationJob.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/dscConfiguration.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/dscNode.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/dscNodeConfiguration.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/hybridRunbookWorkerGroup.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/job.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/jobSchedule.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/linkedWorkspace.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/module.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/runbook.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/schedule.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/variable.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/webhook.json
  - $(this-folder)/Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfiguration.json
  - $(this-folder)/Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationRun.json
  - $(this-folder)/Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationMachineRun.json
  - $(this-folder)/Microsoft.Automation/preview/2017-05-15-preview/sourceControl.json
  - $(this-folder)/Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJob.json
  - $(this-folder)/Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJobStreams.json
  - $(this-folder)/Microsoft.Automation/preview/2017-05-15-preview/job.json
  - $(this-folder)/Microsoft.Automation/stable/2015-10-31/watcher.json
  - $(this-folder)/Microsoft.Automation/stable/2018-01-15/dscNode.json
  - $(this-folder)/Microsoft.Automation/stable/2018-01-15/dscCompilationJob.json
  - $(this-folder)/Microsoft.Automation/stable/2018-01-15/dscNodeConfiguration.json
  - $(this-folder)/Microsoft.Automation/stable/2018-01-15/dscNodeCounts.json
  - $(this-folder)/Microsoft.Automation/stable/2018-06-30/runbook.json
  - $(this-folder)/Microsoft.Automation/stable/2018-06-30/python2package.json
require: $(this-folder)/../../../../profiles/readme.md
```
