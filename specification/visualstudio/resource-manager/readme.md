# VisualStudio
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for VisualStudio.


The App service RP comprises of services where each service has its own tag.
Hence, each sub-service has its own swagger spec. 

All of them are tied together using this configuration and are packaged together into one compute client library.
This makes it easier for customers to download one (nuget/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.


---
## Getting Started 
To build the SDK for VisualStudio, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the VisualStudio API.

``` yaml
openapi-type: arm
tag: package-2014-04-preview
```


### Tag: package-2014-04-preview

These settings apply only when `--tag=package-2014-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2014-04-preview'
input-file:
- Microsoft.VisualStudio/2014-04-01-preview/Csm.json
```


---
## Code Generation


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: visualstudio
  clear-output-folder: true
```

### Tag: package-2014-04-preview and go

These settings apply only when `--tag=package-2014-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2014-04-preview' && $(go)
output-folder: $(go-sdk-folder)/services/visualstudio/mgmt/2014-04-01-preview/visualstudio
```
