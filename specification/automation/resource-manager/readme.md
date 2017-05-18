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

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Automation API.

``` yaml
# common 
title: Azure Automation
description: Automation Client
api-version: 2015-10-31

```


# API Version: 2015-10-31

These settings apply only when `--api-version=2015-10-31` is specified on the command line.

``` yaml $(api-version) == '2015-10-31'
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


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

