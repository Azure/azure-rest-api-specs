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



### Basic Information 
These are the global settings for the Automation API.

``` yaml
title: AutomationClient
description: Automation Client
openapi-type: arm
tag: package-2015-10
```


### Tag: package-2015-10

These settings apply only when `--tag=package-2015-10` is specified on the command line.

``` yaml $(tag) == 'package-2015-10'
input-file:
- Microsoft.Automation/2015-10-31/account.json
- Microsoft.Automation/2015-10-31/certificate.json
- Microsoft.Automation/2015-10-31/connection.json
- Microsoft.Automation/2015-10-31/connectionType.json
- Microsoft.Automation/2015-10-31/credential.json
- Microsoft.Automation/2015-10-31/definitions.json
- Microsoft.Automation/2015-10-31/dscCompilationJob.json
- Microsoft.Automation/2015-10-31/dscConfiguration.json
- Microsoft.Automation/2015-10-31/dscNode.json
- Microsoft.Automation/2015-10-31/dscNodeConfiguration.json
- Microsoft.Automation/2015-10-31/hybridRunbookWorkerGroup.json
- Microsoft.Automation/2015-10-31/job.json
- Microsoft.Automation/2015-10-31/jobSchedule.json
- Microsoft.Automation/2015-10-31/module.json
- Microsoft.Automation/2015-10-31/runbook.json
- Microsoft.Automation/2015-10-31/schedule.json
- Microsoft.Automation/2015-10-31/variable.json
- Microsoft.Automation/2015-10-31/webhook.json
```


### Tag: package-2017-05

These settings apply only when `--tag=package-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-2017-05'
input-file:
- Microsoft.Automation/2017-05-15-preview/account.json
- Microsoft.Automation/2017-05-15-preview/certificate.json
- Microsoft.Automation/2017-05-15-preview/connection.json
- Microsoft.Automation/2017-05-15-preview/connectionType.json
- Microsoft.Automation/2017-05-15-preview/credential.json
- Microsoft.Automation/2017-05-15-preview/definitions.json
- Microsoft.Automation/2017-05-15-preview/dscCompilationJob.json
- Microsoft.Automation/2017-05-15-preview/dscConfiguration.json
- Microsoft.Automation/2017-05-15-preview/dscNode.json
- Microsoft.Automation/2017-05-15-preview/dscNodeConfiguration.json
- Microsoft.Automation/2017-05-15-preview/hybridRunbookWorkerGroup.json
- Microsoft.Automation/2017-05-15-preview/job.json
- Microsoft.Automation/2017-05-15-preview/jobSchedule.json
- Microsoft.Automation/2017-05-15-preview/module.json
- Microsoft.Automation/2017-05-15-preview/runbook.json
- Microsoft.Automation/2017-05-15-preview/schedule.json
- Microsoft.Automation/2017-05-15-preview/variable.json
- Microsoft.Automation/2017-05-15-preview/webhook.json
```

---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Automation
  output-folder: $(csharp-sdks-folder)/Automation/Management.Automation/Generated
  clear-output-folder: true
```

