# MachineLearning
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for MachineLearning.



---
## Getting Started 
To build the SDK for MachineLearning, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the MachineLearning API.

``` yaml
openapi-type: arm
tag: package-webservices-2017-01 # TODO: make validation pick up multiple tags
```


### Tag: package-webservices-2017-01

These settings apply only when `--tag=package-webservices-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-webservices-2017-01'
input-file:
- Microsoft.MachineLearning/2017-01-01/webservices.json
```
 
### Tag: package-commitmentPlans-2016-05-preview

These settings apply only when `--tag=package-commitmentPlans-2016-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-commitmentPlans-2016-05-preview'
input-file:
- Microsoft.MachineLearning/2016-05-01-preview/commitmentPlans.json
```
 
### Tag: package-webservices-2016-05-preview

These settings apply only when `--tag=package-webservices-2016-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-webservices-2016-05-preview'
input-file:
- Microsoft.MachineLearning/2016-05-01-preview/webservices.json
```


---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  payload-flattening-threshold: 1
  license-header: MICROSOFT_MIT
```

```yaml $(csharp) && $(package-commitmentPlans)
csharp:
  namespace: Microsoft.Azure.Management.MachineLearning.CommitmentPlans
  output-folder: $(csharp-sdks-folder)/MachineLearning/Management.MachineLearning/Generated/CommitmentPlans
```

```yaml $(csharp) && $(package-webservices)
csharp:
  namespace: Microsoft.Azure.Management.MachineLearning.WebServices
  output-folder: $(csharp-sdks-folder)/MachineLearning/Management.MachineLearning/Generated/WebServices
```