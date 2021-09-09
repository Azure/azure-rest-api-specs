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
tag: package-2021-06-22
```

### Tag: package-2015-10

These settings apply only when `--tag=package-2015-10` is specified on the command line.

``` yaml $(tag) == 'package-2015-10'
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
- Microsoft.Automation/stable/2015-10-31/watcher.json
- Microsoft.Automation/stable/2015-10-31/webhook.json
```


### Tag: package-2017-05-preview

These settings apply only when `--tag=package-2017-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-05-preview'
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
- Microsoft.Automation/stable/2015-10-31/jobSchedule.json
- Microsoft.Automation/stable/2015-10-31/linkedWorkspace.json
- Microsoft.Automation/stable/2015-10-31/module.json
- Microsoft.Automation/stable/2015-10-31/runbook.json
- Microsoft.Automation/stable/2015-10-31/schedule.json
- Microsoft.Automation/stable/2015-10-31/variable.json
- Microsoft.Automation/stable/2015-10-31/watcher.json
- Microsoft.Automation/stable/2015-10-31/webhook.json
- Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfiguration.json
- Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationRun.json
- Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationMachineRun.json
- Microsoft.Automation/preview/2017-05-15-preview/sourceControl.json
- Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJob.json
- Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJobStreams.json
- Microsoft.Automation/preview/2017-05-15-preview/job.json
```

### Tag: package-2018-01-preview

These settings apply only when `--tag=package-2018-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-preview'
input-file:
- Microsoft.Automation/stable/2015-10-31/account.json
- Microsoft.Automation/stable/2015-10-31/certificate.json
- Microsoft.Automation/stable/2015-10-31/connection.json
- Microsoft.Automation/stable/2015-10-31/connectionType.json
- Microsoft.Automation/stable/2015-10-31/credential.json
- Microsoft.Automation/stable/2015-10-31/dscConfiguration.json
- Microsoft.Automation/stable/2015-10-31/hybridRunbookWorkerGroup.json
- Microsoft.Automation/stable/2015-10-31/jobSchedule.json
- Microsoft.Automation/stable/2015-10-31/linkedWorkspace.json
- Microsoft.Automation/stable/2015-10-31/module.json
- Microsoft.Automation/stable/2015-10-31/runbook.json
- Microsoft.Automation/stable/2015-10-31/schedule.json
- Microsoft.Automation/stable/2015-10-31/variable.json
- Microsoft.Automation/stable/2015-10-31/webhook.json
- Microsoft.Automation/stable/2015-10-31/watcher.json
- Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfiguration.json
- Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationRun.json
- Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationMachineRun.json
- Microsoft.Automation/preview/2017-05-15-preview/sourceControl.json
- Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJob.json
- Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJobStreams.json
- Microsoft.Automation/preview/2017-05-15-preview/job.json
- Microsoft.Automation/stable/2018-01-15/dscNode.json
- Microsoft.Automation/stable/2018-01-15/dscCompilationJob.json
- Microsoft.Automation/stable/2018-01-15/dscNodeConfiguration.json
- Microsoft.Automation/stable/2018-01-15/dscNodeCounts.json
```

### Tag: package-2018-06-preview

These settings apply only when `--tag=package-2018-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-preview'
input-file:
- Microsoft.Automation/stable/2015-10-31/account.json
- Microsoft.Automation/stable/2015-10-31/certificate.json
- Microsoft.Automation/stable/2015-10-31/connection.json
- Microsoft.Automation/stable/2015-10-31/connectionType.json
- Microsoft.Automation/stable/2015-10-31/credential.json
- Microsoft.Automation/stable/2015-10-31/dscConfiguration.json
- Microsoft.Automation/stable/2015-10-31/hybridRunbookWorkerGroup.json
- Microsoft.Automation/stable/2015-10-31/jobSchedule.json
- Microsoft.Automation/stable/2015-10-31/linkedWorkspace.json
- Microsoft.Automation/stable/2015-10-31/module.json
- Microsoft.Automation/stable/2015-10-31/schedule.json
- Microsoft.Automation/stable/2015-10-31/variable.json
- Microsoft.Automation/stable/2015-10-31/webhook.json
- Microsoft.Automation/stable/2015-10-31/watcher.json
- Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfiguration.json
- Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationRun.json
- Microsoft.Automation/preview/2017-05-15-preview/softwareUpdateConfigurationMachineRun.json
- Microsoft.Automation/preview/2017-05-15-preview/sourceControl.json
- Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJob.json
- Microsoft.Automation/preview/2017-05-15-preview/sourceControlSyncJobStreams.json
- Microsoft.Automation/preview/2017-05-15-preview/job.json
- Microsoft.Automation/stable/2018-01-15/dscNode.json
- Microsoft.Automation/stable/2018-01-15/dscCompilationJob.json
- Microsoft.Automation/stable/2018-01-15/dscNodeConfiguration.json
- Microsoft.Automation/stable/2018-01-15/dscNodeCounts.json
- Microsoft.Automation/stable/2018-06-30/runbook.json
- Microsoft.Automation/stable/2018-06-30/python2package.json
```

### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-2019-06'
input-file:
- Microsoft.Automation/stable/2019-06-01/runbook.json
- Microsoft.Automation/stable/2019-06-01/python2package.json
- Microsoft.Automation/stable/2019-06-01/dscNode.json
- Microsoft.Automation/stable/2019-06-01/dscCompilationJob.json
- Microsoft.Automation/stable/2019-06-01/dscNodeConfiguration.json
- Microsoft.Automation/stable/2019-06-01/dscNodeCounts.json
- Microsoft.Automation/stable/2019-06-01/softwareUpdateConfigurationRun.json
- Microsoft.Automation/stable/2019-06-01/softwareUpdateConfigurationMachineRun.json
- Microsoft.Automation/stable/2019-06-01/sourceControl.json
- Microsoft.Automation/stable/2019-06-01/sourceControlSyncJob.json
- Microsoft.Automation/stable/2019-06-01/sourceControlSyncJobStreams.json
- Microsoft.Automation/stable/2019-06-01/job.json
- Microsoft.Automation/stable/2019-06-01/account.json
- Microsoft.Automation/stable/2019-06-01/certificate.json
- Microsoft.Automation/stable/2019-06-01/connection.json
- Microsoft.Automation/stable/2019-06-01/connectionType.json
- Microsoft.Automation/stable/2019-06-01/credential.json
- Microsoft.Automation/stable/2019-06-01/dscConfiguration.json
- Microsoft.Automation/stable/2019-06-01/softwareUpdateConfiguration.json
- Microsoft.Automation/stable/2019-06-01/hybridRunbookWorkerGroup.json
- Microsoft.Automation/stable/2019-06-01/jobSchedule.json
- Microsoft.Automation/stable/2019-06-01/linkedWorkspace.json
- Microsoft.Automation/stable/2019-06-01/module.json
- Microsoft.Automation/stable/2019-06-01/operations.json
- Microsoft.Automation/stable/2019-06-01/schedule.json
- Microsoft.Automation/stable/2019-06-01/variable.json
- Microsoft.Automation/stable/2019-06-01/watcher.json
- Microsoft.Automation/stable/2015-10-31/webhook.json
```

### Tag: package-2020-01-13-preview

These settings apply only when `--tag=package-2020-01-13-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-13-preview'
input-file:
- Microsoft.Automation/preview/2020-01-13-preview/privateEndpointConnection.json
- Microsoft.Automation/preview/2020-01-13-preview/privateLinkResources.json
- Microsoft.Automation/preview/2020-01-13-preview/python2package.json
- Microsoft.Automation/preview/2020-01-13-preview/dscNode.json
- Microsoft.Automation/preview/2020-01-13-preview/dscNodeConfiguration.json
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
- Microsoft.Automation/stable/2019-06-01/dscConfiguration.json
- Microsoft.Automation/stable/2019-06-01/job.json
- Microsoft.Automation/stable/2019-06-01/operations.json
- Microsoft.Automation/stable/2019-06-01/softwareUpdateConfiguration.json
- Microsoft.Automation/stable/2019-06-01/softwareUpdateConfigurationRun.json
- Microsoft.Automation/stable/2019-06-01/softwareUpdateConfigurationMachineRun.json
- Microsoft.Automation/stable/2018-06-30/runbook.json
- Microsoft.Automation/stable/2015-10-31/webhook.json
```

### Tag: package-2021-06-22

These settings apply only when `--tag=package-2021-06-22` is specified on the command line.

``` yaml $(tag) == 'package-2021-06-22'
input-file:
- Microsoft.Automation/preview/2020-01-13-preview/privateEndpointConnection.json
- Microsoft.Automation/preview/2020-01-13-preview/privateLinkResources.json
- Microsoft.Automation/preview/2020-01-13-preview/python2package.json
- Microsoft.Automation/preview/2020-01-13-preview/dscNode.json
- Microsoft.Automation/preview/2020-01-13-preview/dscNodeConfiguration.json
- Microsoft.Automation/preview/2020-01-13-preview/dscCompilationJob.json
- Microsoft.Automation/preview/2020-01-13-preview/dscNodeCounts.json
- Microsoft.Automation/preview/2020-01-13-preview/sourceControl.json
- Microsoft.Automation/preview/2020-01-13-preview/sourceControlSyncJob.json
- Microsoft.Automation/preview/2020-01-13-preview/sourceControlSyncJobStreams.json
- Microsoft.Automation/stable/2021-06-22/account.json
- Microsoft.Automation/preview/2020-01-13-preview/certificate.json
- Microsoft.Automation/preview/2020-01-13-preview/connection.json
- Microsoft.Automation/preview/2020-01-13-preview/connectionType.json
- Microsoft.Automation/preview/2020-01-13-preview/credential.json
- Microsoft.Automation/stable/2021-06-22/hybridRunbookWorkerGroup.json
- Microsoft.Automation/preview/2020-01-13-preview/jobSchedule.json
- Microsoft.Automation/preview/2020-01-13-preview/linkedWorkspace.json
- Microsoft.Automation/preview/2020-01-13-preview/module.json
- Microsoft.Automation/preview/2020-01-13-preview/schedule.json
- Microsoft.Automation/preview/2020-01-13-preview/variable.json
- Microsoft.Automation/preview/2020-01-13-preview/watcher.json
- Microsoft.Automation/stable/2019-06-01/dscConfiguration.json
- Microsoft.Automation/stable/2019-06-01/job.json
- Microsoft.Automation/stable/2021-06-22/operations.json
- Microsoft.Automation/stable/2019-06-01/softwareUpdateConfiguration.json
- Microsoft.Automation/stable/2019-06-01/softwareUpdateConfigurationRun.json
- Microsoft.Automation/stable/2019-06-01/softwareUpdateConfigurationMachineRun.json
- Microsoft.Automation/stable/2018-06-30/runbook.json
- Microsoft.Automation/stable/2015-10-31/webhook.json
- Microsoft.Automation/stable/2021-06-22/hybridRunbookWorker.json
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
    where: $.definitions.TestJob.properties
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
```

---
# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_automation']
  - repo: azure-resource-manager-schemas
```


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Automation
  output-folder: $(csharp-sdks-folder)/automation/Microsoft.Azure.Management.Automation/src/Generated
  clear-output-folder: true
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





