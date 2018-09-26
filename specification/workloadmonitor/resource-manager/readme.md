# Microsoft.WorkloadMonitor 
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.WorkloadMonitor.

---
## Getting Started 
To build the SDK for Microsoft.WorkloadMonitor, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the API.

``` yaml
openapi-type: arm
tag: package-2018-08-preview
```


### Tag: package-2018-08-preview

These settings apply only when `--tag=package-2018-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-08-preview'
input-file:
- microsoft.workloadmonitor/preview/2018-08-31-preview/Microsoft.WorkloadMonitor.json
```

``` yaml
directive:
- suppress:
    - R3026 # Create/Update/Delete operations are not exposed.
```
