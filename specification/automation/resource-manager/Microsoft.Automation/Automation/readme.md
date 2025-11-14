# Automation

> see https://aka.ms/autorest

This is the AutoRest configuration file for Automation.

---
## Getting Started 
To build the SDK for Automation, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

=======
### Basic Information
These are the global settings for the Automation API.

``` yaml
title: AutomationClient
description: Automation Client
openapi-type: arm
tag: package-2024-10-23
```

### Tag: package-2015-10

These settings apply only when `--tag=package-2015-10` is specified on the command line.

``` yaml $(tag) == 'package-2015-10'
input-file:
- stable/2015-10-31/account.json
- stable/2015-10-31/certificate.json
- stable/2015-10-31/connection.json
- stable/2015-10-31/connectionType.json
- stable/2015-10-31/credential.json
- stable/2015-10-31/dscCompilationJob.json
- stable/2015-10-31/dscConfiguration.json
- stable/2015-10-31/dscNode.json
- stable/2015-10-31/dscNodeConfiguration.json
- stable/2015-10-31/hybridRunbookWorkerGroup.json
- stable/2015-10-31/job.json
- stable/2015-10-31/jobSchedule.json
- stable/2015-10-31/linkedWorkspace.json
- stable/2015-10-31/module.json
- stable/2015-10-31/runbook.json
- stable/2015-10-31/schedule.json
- stable/2015-10-31/variable.json
- stable/2015-10-31/watcher.json
- stable/2015-10-31/webhook.json
```


### Tag: package-2017-05-preview

These settings apply only when `--tag=package-2017-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-05-preview'
input-file:
- stable/2015-10-31/account.json
- stable/2015-10-31/certificate.json
- stable/2015-10-31/connection.json
- stable/2015-10-31/connectionType.json
- stable/2015-10-31/credential.json
- stable/2015-10-31/dscCompilationJob.json
- stable/2015-10-31/dscConfiguration.json
- stable/2015-10-31/dscNode.json
- stable/2015-10-31/dscNodeConfiguration.json
- stable/2015-10-31/hybridRunbookWorkerGroup.json
- stable/2015-10-31/jobSchedule.json
- stable/2015-10-31/linkedWorkspace.json
- stable/2015-10-31/module.json
- stable/2015-10-31/runbook.json
- stable/2015-10-31/schedule.json
- stable/2015-10-31/variable.json
- stable/2015-10-31/watcher.json
- stable/2015-10-31/webhook.json
- preview/2017-05-15-preview/softwareUpdateConfiguration.json
- preview/2017-05-15-preview/softwareUpdateConfigurationRun.json
- preview/2017-05-15-preview/softwareUpdateConfigurationMachineRun.json
- preview/2017-05-15-preview/sourceControl.json
- preview/2017-05-15-preview/sourceControlSyncJob.json
- preview/2017-05-15-preview/sourceControlSyncJobStreams.json
- preview/2017-05-15-preview/job.json
```

### Tag: package-2018-01-preview

These settings apply only when `--tag=package-2018-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-preview'
input-file:
- stable/2015-10-31/account.json
- stable/2015-10-31/certificate.json
- stable/2015-10-31/connection.json
- stable/2015-10-31/connectionType.json
- stable/2015-10-31/credential.json
- stable/2015-10-31/dscConfiguration.json
- stable/2015-10-31/hybridRunbookWorkerGroup.json
- stable/2015-10-31/jobSchedule.json
- stable/2015-10-31/linkedWorkspace.json
- stable/2015-10-31/module.json
- stable/2015-10-31/runbook.json
- stable/2015-10-31/schedule.json
- stable/2015-10-31/variable.json
- stable/2015-10-31/webhook.json
- stable/2015-10-31/watcher.json
- preview/2017-05-15-preview/softwareUpdateConfiguration.json
- preview/2017-05-15-preview/softwareUpdateConfigurationRun.json
- preview/2017-05-15-preview/softwareUpdateConfigurationMachineRun.json
- preview/2017-05-15-preview/sourceControl.json
- preview/2017-05-15-preview/sourceControlSyncJob.json
- preview/2017-05-15-preview/sourceControlSyncJobStreams.json
- preview/2017-05-15-preview/job.json
- stable/2018-01-15/dscNode.json
- stable/2018-01-15/dscCompilationJob.json
- stable/2018-01-15/dscNodeConfiguration.json
- stable/2018-01-15/dscNodeCounts.json
```

### Tag: package-2018-06-preview

These settings apply only when `--tag=package-2018-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-preview'
input-file:
- stable/2015-10-31/account.json
- stable/2015-10-31/certificate.json
- stable/2015-10-31/connection.json
- stable/2015-10-31/connectionType.json
- stable/2015-10-31/credential.json
- stable/2015-10-31/dscConfiguration.json
- stable/2015-10-31/hybridRunbookWorkerGroup.json
- stable/2015-10-31/jobSchedule.json
- stable/2015-10-31/linkedWorkspace.json
- stable/2015-10-31/module.json
- stable/2015-10-31/schedule.json
- stable/2015-10-31/variable.json
- stable/2015-10-31/webhook.json
- stable/2015-10-31/watcher.json
- preview/2017-05-15-preview/softwareUpdateConfiguration.json
- preview/2017-05-15-preview/softwareUpdateConfigurationRun.json
- preview/2017-05-15-preview/softwareUpdateConfigurationMachineRun.json
- preview/2017-05-15-preview/sourceControl.json
- preview/2017-05-15-preview/sourceControlSyncJob.json
- preview/2017-05-15-preview/sourceControlSyncJobStreams.json
- preview/2017-05-15-preview/job.json
- stable/2018-01-15/dscNode.json
- stable/2018-01-15/dscCompilationJob.json
- stable/2018-01-15/dscNodeConfiguration.json
- stable/2018-01-15/dscNodeCounts.json
- stable/2018-06-30/runbook.json
- stable/2018-06-30/python2package.json
```

### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-2019-06'
input-file:
- stable/2019-06-01/runbook.json
- stable/2019-06-01/python2package.json
- stable/2019-06-01/dscNode.json
- stable/2019-06-01/dscCompilationJob.json
- stable/2019-06-01/dscNodeConfiguration.json
- stable/2019-06-01/dscNodeCounts.json
- stable/2019-06-01/softwareUpdateConfigurationRun.json
- stable/2019-06-01/softwareUpdateConfigurationMachineRun.json
- stable/2019-06-01/sourceControl.json
- stable/2019-06-01/sourceControlSyncJob.json
- stable/2019-06-01/sourceControlSyncJobStreams.json
- stable/2019-06-01/job.json
- stable/2019-06-01/account.json
- stable/2019-06-01/certificate.json
- stable/2019-06-01/connection.json
- stable/2019-06-01/connectionType.json
- stable/2019-06-01/credential.json
- stable/2019-06-01/dscConfiguration.json
- stable/2019-06-01/softwareUpdateConfiguration.json
- stable/2019-06-01/hybridRunbookWorkerGroup.json
- stable/2019-06-01/jobSchedule.json
- stable/2019-06-01/linkedWorkspace.json
- stable/2019-06-01/module.json
- stable/2019-06-01/operations.json
- stable/2019-06-01/schedule.json
- stable/2019-06-01/variable.json
- stable/2019-06-01/watcher.json
- stable/2015-10-31/webhook.json
```

### Tag: package-2020-01-13-preview

These settings apply only when `--tag=package-2020-01-13-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-13-preview'
input-file:
- preview/2020-01-13-preview/privateEndpointConnection.json
- preview/2020-01-13-preview/privateLinkResources.json
- preview/2020-01-13-preview/python2package.json
- preview/2020-01-13-preview/dscNode.json
- preview/2020-01-13-preview/dscNodeConfiguration.json
- preview/2020-01-13-preview/dscCompilationJob.json
- preview/2020-01-13-preview/dscNodeCounts.json
- preview/2020-01-13-preview/sourceControl.json
- preview/2020-01-13-preview/sourceControlSyncJob.json
- preview/2020-01-13-preview/sourceControlSyncJobStreams.json
- preview/2020-01-13-preview/account.json
- preview/2020-01-13-preview/certificate.json
- preview/2020-01-13-preview/connection.json
- preview/2020-01-13-preview/connectionType.json
- preview/2020-01-13-preview/credential.json
- preview/2020-01-13-preview/hybridRunbookWorkerGroup.json
- preview/2020-01-13-preview/jobSchedule.json
- preview/2020-01-13-preview/linkedWorkspace.json
- preview/2020-01-13-preview/module.json
- preview/2020-01-13-preview/schedule.json
- preview/2020-01-13-preview/variable.json
- preview/2020-01-13-preview/watcher.json
- stable/2019-06-01/dscConfiguration.json
- stable/2019-06-01/job.json
- stable/2019-06-01/operations.json
- stable/2019-06-01/softwareUpdateConfiguration.json
- stable/2019-06-01/softwareUpdateConfigurationRun.json
- stable/2019-06-01/softwareUpdateConfigurationMachineRun.json
- stable/2018-06-30/runbook.json
- stable/2015-10-31/webhook.json
```

### Tag: package-2021-06-22

These settings apply only when `--tag=package-2021-06-22` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-22'
input-file:
- preview/2020-01-13-preview/privateEndpointConnection.json
- preview/2020-01-13-preview/privateLinkResources.json
- preview/2020-01-13-preview/python2package.json
- preview/2020-01-13-preview/dscNode.json
- preview/2020-01-13-preview/dscNodeConfiguration.json
- preview/2020-01-13-preview/dscCompilationJob.json
- preview/2020-01-13-preview/dscNodeCounts.json
- preview/2020-01-13-preview/sourceControl.json
- preview/2020-01-13-preview/sourceControlSyncJob.json
- preview/2020-01-13-preview/sourceControlSyncJobStreams.json
- stable/2021-06-22/account.json
- preview/2020-01-13-preview/certificate.json
- preview/2020-01-13-preview/connection.json
- preview/2020-01-13-preview/connectionType.json
- preview/2020-01-13-preview/credential.json
- stable/2021-06-22/hybridRunbookWorkerGroup.json
- preview/2020-01-13-preview/jobSchedule.json
- preview/2020-01-13-preview/linkedWorkspace.json
- preview/2020-01-13-preview/module.json
- preview/2020-01-13-preview/schedule.json
- preview/2020-01-13-preview/variable.json
- preview/2020-01-13-preview/watcher.json
- stable/2019-06-01/dscConfiguration.json
- stable/2019-06-01/job.json
- stable/2021-06-22/operations.json
- stable/2019-06-01/softwareUpdateConfiguration.json
- stable/2019-06-01/softwareUpdateConfigurationRun.json
- stable/2019-06-01/softwareUpdateConfigurationMachineRun.json
- stable/2018-06-30/runbook.json
- stable/2015-10-31/webhook.json
- stable/2021-06-22/hybridRunbookWorker.json
```

### Tag: package-2022-01-31

These settings apply only when `--tag=package-2022-01-31` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-31'
input-file:
- preview/2020-01-13-preview/privateEndpointConnection.json
- preview/2020-01-13-preview/privateLinkResources.json
- preview/2020-01-13-preview/python2package.json
- preview/2020-01-13-preview/dscNode.json
- preview/2020-01-13-preview/dscNodeConfiguration.json
- preview/2020-01-13-preview/dscCompilationJob.json
- preview/2020-01-13-preview/dscNodeCounts.json
- preview/2020-01-13-preview/sourceControl.json
- preview/2020-01-13-preview/sourceControlSyncJob.json
- preview/2020-01-13-preview/sourceControlSyncJobStreams.json
- stable/2021-06-22/account.json
- preview/2020-01-13-preview/certificate.json
- preview/2020-01-13-preview/connection.json
- preview/2020-01-13-preview/connectionType.json
- preview/2020-01-13-preview/credential.json
- stable/2021-06-22/hybridRunbookWorkerGroup.json
- preview/2020-01-13-preview/jobSchedule.json
- preview/2020-01-13-preview/linkedWorkspace.json
- preview/2020-01-13-preview/module.json
- preview/2020-01-13-preview/schedule.json
- preview/2020-01-13-preview/variable.json
- preview/2020-01-13-preview/watcher.json
- stable/2019-06-01/dscConfiguration.json
- stable/2019-06-01/job.json
- stable/2021-06-22/operations.json
- stable/2019-06-01/softwareUpdateConfiguration.json
- stable/2019-06-01/softwareUpdateConfigurationRun.json
- stable/2019-06-01/softwareUpdateConfigurationMachineRun.json
- stable/2018-06-30/runbook.json
- stable/2015-10-31/webhook.json
- stable/2021-06-22/hybridRunbookWorker.json
- stable/2022-01-31/deletedAutomationAccount.json
```

### Tag: package-2022-02-22

These settings apply only when `--tag=package-2022-02-22` is specified on the command line.

``` yaml $(tag) == 'package-2022-02-22'
input-file:
- preview/2020-01-13-preview/privateEndpointConnection.json
- preview/2020-01-13-preview/privateLinkResources.json
- preview/2020-01-13-preview/python2package.json
- preview/2020-01-13-preview/dscNode.json
- preview/2020-01-13-preview/dscNodeConfiguration.json
- preview/2020-01-13-preview/dscCompilationJob.json
- preview/2020-01-13-preview/dscNodeCounts.json
- preview/2020-01-13-preview/sourceControl.json
- preview/2020-01-13-preview/sourceControlSyncJob.json
- preview/2020-01-13-preview/sourceControlSyncJobStreams.json
- stable/2021-06-22/account.json
- preview/2020-01-13-preview/certificate.json
- preview/2020-01-13-preview/connection.json
- preview/2020-01-13-preview/connectionType.json
- preview/2020-01-13-preview/credential.json
- preview/2020-01-13-preview/jobSchedule.json
- preview/2020-01-13-preview/linkedWorkspace.json
- preview/2020-01-13-preview/module.json
- preview/2020-01-13-preview/schedule.json
- preview/2020-01-13-preview/variable.json
- preview/2020-01-13-preview/watcher.json
- stable/2019-06-01/dscConfiguration.json
- stable/2019-06-01/job.json
- stable/2021-06-22/operations.json
- stable/2019-06-01/softwareUpdateConfiguration.json
- stable/2019-06-01/softwareUpdateConfigurationRun.json
- stable/2019-06-01/softwareUpdateConfigurationMachineRun.json
- stable/2018-06-30/runbook.json
- stable/2015-10-31/webhook.json
- stable/2021-06-22/hybridRunbookWorker.json
- stable/2022-01-31/deletedAutomationAccount.json
- stable/2022-02-22/hybridRunbookWorkerGroup.json
```

### Tag: package-2022-08-08

These settings apply only when `--tag=package-2022-08-08` is specified on the command line.

``` yaml $(tag) == 'package-2022-08-08'
input-file:
- preview/2020-01-13-preview/privateEndpointConnection.json
- preview/2020-01-13-preview/privateLinkResources.json
- preview/2020-01-13-preview/dscNode.json
- preview/2020-01-13-preview/dscCompilationJob.json
- preview/2020-01-13-preview/dscNodeCounts.json
- preview/2020-01-13-preview/watcher.json
- stable/2019-06-01/softwareUpdateConfiguration.json
- stable/2015-10-31/webhook.json
- stable/2022-01-31/deletedAutomationAccount.json
- stable/2022-08-08/account.json
- stable/2022-08-08/certificate.json
- stable/2022-08-08/connection.json
- stable/2022-08-08/connectionType.json
- stable/2022-08-08/credential.json
- stable/2022-08-08/dscConfiguration.json
- stable/2022-08-08/dscNodeConfiguration.json
- stable/2022-08-08/hybridRunbookWorker.json
- stable/2022-08-08/hybridRunbookWorkerGroup.json
- stable/2022-08-08/job.json
- stable/2022-08-08/jobSchedule.json
- stable/2022-08-08/linkedWorkspace.json
- stable/2022-08-08/module.json
- stable/2022-08-08/operations.json
- stable/2022-08-08/python2package.json
- stable/2022-08-08/python3package.json
- stable/2022-08-08/runbook.json
- stable/2022-08-08/schedule.json
- stable/2022-08-08/softwareUpdateConfigurationMachineRun.json
- stable/2022-08-08/softwareUpdateConfigurationRun.json
- stable/2022-08-08/sourceControl.json
- stable/2022-08-08/sourceControlSyncJob.json
- stable/2022-08-08/sourceControlSyncJobStreams.json
- stable/2022-08-08/variable.json
```

### Tag: package-2023-05-15-preview

These settings apply only when `--tag=package-2023-05-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-05-15-preview'
input-file:
- preview/2023-05-15-preview/dscNodeCounts.json
- preview/2023-05-15-preview/softwareUpdateConfiguration.json
- preview/2023-05-15-preview/deletedAutomationAccount.json
- preview/2023-05-15-preview/privateLinkResources.json
- preview/2023-05-15-preview/dscNode.json
- preview/2023-05-15-preview/account.json
- preview/2023-05-15-preview/certificate.json
- preview/2023-05-15-preview/connection.json
- preview/2023-05-15-preview/connectionType.json
- preview/2023-05-15-preview/credential.json
- preview/2023-05-15-preview/dscCompilationJob.json
- preview/2023-05-15-preview/dscConfiguration.json
- preview/2023-05-15-preview/dscNodeConfiguration.json
- preview/2023-05-15-preview/hybridRunbookWorker.json
- preview/2023-05-15-preview/hybridRunbookWorkerGroup.json
- preview/2023-05-15-preview/job.json
- preview/2023-05-15-preview/jobSchedule.json
- preview/2023-05-15-preview/linkedWorkspace.json
- preview/2023-05-15-preview/module.json
- preview/2023-05-15-preview/operations.json
- preview/2023-05-15-preview/package.json
- preview/2023-05-15-preview/privateEndpointConnection.json
- preview/2023-05-15-preview/python2package.json
- preview/2023-05-15-preview/python3package.json
- preview/2023-05-15-preview/runbook.json
- preview/2023-05-15-preview/runtimeEnvironment.json
- preview/2023-05-15-preview/schedule.json
- preview/2023-05-15-preview/softwareUpdateConfigurationMachineRun.json
- preview/2023-05-15-preview/softwareUpdateConfigurationRun.json
- preview/2023-05-15-preview/sourceControl.json
- preview/2023-05-15-preview/sourceControlSyncJob.json
- preview/2023-05-15-preview/sourceControlSyncJobStreams.json
- preview/2023-05-15-preview/variable.json
- preview/2023-05-15-preview/watcher.json
- preview/2023-05-15-preview/webhook.json
```

### Tag: package-2023-11-01

These settings apply only when `--tag=package-2023-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-11-01'
input-file:
- preview/2020-01-13-preview/privateEndpointConnection.json
- preview/2020-01-13-preview/privateLinkResources.json
- preview/2020-01-13-preview/dscNode.json
- preview/2020-01-13-preview/dscCompilationJob.json
- preview/2020-01-13-preview/dscNodeCounts.json
- preview/2020-01-13-preview/watcher.json
- stable/2019-06-01/softwareUpdateConfiguration.json
- stable/2015-10-31/webhook.json
- stable/2022-01-31/deletedAutomationAccount.json
- stable/2023-11-01/account.json
- stable/2023-11-01/certificate.json
- stable/2023-11-01/connection.json
- stable/2023-11-01/connectionType.json
- stable/2023-11-01/credential.json
- stable/2023-11-01/dscConfiguration.json
- stable/2023-11-01/dscNodeConfiguration.json
- stable/2023-11-01/hybridRunbookWorker.json
- stable/2023-11-01/hybridRunbookWorkerGroup.json
- stable/2023-11-01/job.json
- stable/2023-11-01/jobSchedule.json
- stable/2023-11-01/linkedWorkspace.json
- stable/2023-11-01/module.json
- stable/2023-11-01/powershell72Module.json
- stable/2023-11-01/operations.json
- stable/2023-11-01/python2package.json
- stable/2023-11-01/python3package.json
- stable/2023-11-01/runbook.json
- stable/2023-11-01/schedule.json
- stable/2023-11-01/softwareUpdateConfigurationMachineRun.json
- stable/2023-11-01/softwareUpdateConfigurationRun.json
- stable/2023-11-01/sourceControl.json
- stable/2023-11-01/sourceControlSyncJob.json
- stable/2023-11-01/sourceControlSyncJobStreams.json
- stable/2023-11-01/variable.json
```

### Tag: package-2024-10-23

These settings apply only when `--tag=package-2024-10-23` is specified on the command line.

``` yaml $(tag) == 'package-2024-10-23'
input-file:
- stable/2024-10-23/dscNodeCounts.json
- stable/2024-10-23/softwareUpdateConfiguration.json
- stable/2024-10-23/deletedAutomationAccount.json
- stable/2024-10-23/privateLinkResources.json
- stable/2024-10-23/dscNode.json
- stable/2024-10-23/account.json
- stable/2024-10-23/certificate.json
- stable/2024-10-23/connection.json
- stable/2024-10-23/connectionType.json
- stable/2024-10-23/credential.json
- stable/2024-10-23/dscConfiguration.json
- stable/2024-10-23/dscNodeConfiguration.json
- stable/2024-10-23/hybridRunbookWorker.json
- stable/2024-10-23/hybridRunbookWorkerGroup.json
- stable/2024-10-23/job.json
- stable/2024-10-23/jobSchedule.json
- stable/2024-10-23/linkedWorkspace.json
- stable/2024-10-23/module.json
- stable/2024-10-23/operations.json
- stable/2024-10-23/package.json
- stable/2024-10-23/privateEndpointConnection.json
- stable/2024-10-23/python2package.json
- stable/2024-10-23/python3package.json
- stable/2024-10-23/runbook.json
- stable/2024-10-23/runtimeEnvironment.json
- stable/2024-10-23/schedule.json
- stable/2024-10-23/softwareUpdateConfigurationMachineRun.json
- stable/2024-10-23/softwareUpdateConfigurationRun.json
- stable/2024-10-23/sourceControl.json
- stable/2024-10-23/sourceControlSyncJob.json
- stable/2024-10-23/sourceControlSyncJobStreams.json
- stable/2024-10-23/variable.json
- stable/2024-10-23/watcher.json
- stable/2024-10-23/webhook.json
```


---
## Suppression
``` yaml
directive:
  - suppress: RequiredPropertiesMissingInResourceModel
    from: runbook.json
    where: $.definitions.TestJob
  - suppress: BodyTopLevelProperties
    from: runbook.json
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: account.json
    where: $.definitions.Key.properties.KeyName
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: account.json
    where: $.definitions.Key.properties.Permissions
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: account.json
    where: $.definitions.Key.properties.Value
  - suppress: LongRunningResponseStatusCode
    from: runbook.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/publish"].post["x-ms-long-running-operation"]
  - suppress: LongRunningResponseStatusCode
    from: runbook.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/publish"].post["x-ms-long-running-operation"]
  - suppress: DefaultErrorResponseSchema
    from: hybridRunbookWorkerGroup.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DefaultErrorResponseSchema
    from: hybridRunbookWorker.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DefaultErrorResponseSchema
    from: operations.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: BodyTopLevelProperties
    from: hybridRunbookWorkerGroup.json
    reason: This body format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: RequiredPropertiesMissingInResourceModel
    from: hybridRunbookWorkerGroup.json
    reason: This body format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DefaultErrorResponseSchema
    from: deletedAutomationAccount.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DefaultErrorResponseSchema
    from: python3package.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DefaultErrorResponseSchema
    from: account.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.  
  - suppress: DefaultErrorResponseSchema
    from: certificate.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DefaultErrorResponseSchema
    from: connection.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DefaultErrorResponseSchema
    from: connectionType.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.  
  - suppress: DefaultErrorResponseSchema
    from: credential.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.    
  - suppress: DefaultErrorResponseSchema
    from: dscConfiguration.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: dscNodeConfiguration.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: job.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: jobSchedule.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: linkedWorkspace.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: module.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: python2package.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: runbook.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: schedule.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: softwareUpdateConfigurationMachineRun.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: softwareUpdateConfigurationRun.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: sourceControl.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: sourceControlSyncJob.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: sourceControlSyncJobStreams.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: variable.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DefaultErrorResponseSchema
    from: runbook.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DefaultErrorResponseSchema
    from: runtimeEnvironment.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: ResourceNameRestriction
    from: runtimeEnvironment.json
    reason: This Automation account name is part of the previous api, cannot change it as it will result in breaking change.     
  - suppress: DeleteOperationResponses
    from: credential.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DeleteOperationResponses
    from: certificate.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DeleteOperationResponses
    from: dscNodeConfiguration.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DeleteOperationResponses
    from: hybridRunbookWorkerGroup.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DeleteOperationResponses
    from: module.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change. 
  - suppress: DeleteOperationResponses
    from: python2package.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: DeleteOperationResponses
    from: schedule.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.  
  - suppress: DeleteOperationResponses
    from: sourceControl.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.  
  - suppress: DeleteOperationResponses
    from: variable.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.  
  - suppress: DeleteOperationResponses
    from: python2package.json
    reason: This error format is already part of the previous api, cannot change it as it will result in breaking change.
  - suppress: PutRequestResponseSchemeArm
    from: powershell72Module.json
  - suppress: AvoidAdditionalProperties
    from: runtimeEnvironment.json
    where: $.definitions.DefaultPackages
    reason: Already used in previous api version, fixing it will cause breaking change        


```

---
# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_automation']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```


## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.automation
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-automation
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2015-10
```

### Tag: package-2015-10 and java

These settings apply only when `--tag=package-2015-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.automation.v2015_10_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/automation/mgmt-v2015_10_31
regenerate-manager: true
generate-interface: true
```






