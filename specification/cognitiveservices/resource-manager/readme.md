# CognitiveServices
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for CognitiveServices.

# Notice
Microsoft will use data you send to the Cognitive Services to improve Microsoft products and services. Where you send personal data to the Cognitive Services, you are responsible for obtaining sufficient consent from the data subjects. The General Privacy and Security Terms in the Online Services Terms do not apply to the Cognitive Services. Please refer to the Microsoft Cognitive Services section in the [Online Services Terms](https://www.microsoft.com/en-us/Licensing/product-licensing/products.aspx) for details. Microsoft offers policy controls that may be used to [disable new Cognitive Services deployments](https://docs.microsoft.com/en-us/azure/cognitive-services/cognitive-services-apis-create-account).

---
## Getting Started 
To build the SDK for CognitiveServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the CognitiveServices API.

``` yaml
openapi-type: arm
tag: package-2017-04
```


### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- Microsoft.CognitiveServices/2017-04-18/cognitiveservices.json
```
 
### Tag: package-2016-02-preview

These settings apply only when `--tag=package-2016-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-02-preview'
input-file:
- Microsoft.CognitiveServices/2016-02-01-preview/cognitiveservices.json
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
  namespace: Microsoft.Azure.Management.CognitiveServices
  output-folder: $(csharp-sdks-folder)/CognitiveServices/management/Management.CognitiveServices/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: cognitiveservices
  clear-output-folder: true
```

### Tag: package-2017-04 and go

These settings apply only when `--tag=package-2017-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-04' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/mgmt/2017-04-18/cognitiveservices
```

### Tag: package-2016-02-preview and go

These settings apply only when `--tag=package-2016-02-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-02-preview' && $(go)
output-folder: $(go-sdk-folder)/services/cognitiveservices/mgmt/2016-02-01-preview/cognitiveservices
```
