# Subscription
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Subscription.



---
## Getting Started 
To build the SDK for Subscription, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Subscription API.

``` yaml
openapi-type: arm
tag: package-2017-11-preview
```


### Tag: package-2017-11-preview

These settings apply only when `--tag=package-2017-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-11-preview'
input-file:
- Microsoft.Subscription/2017-11-01-preview/subscriptionDefinitions.json
```

---
# Code Generation


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  namespace: Microsoft.Azure.Management.Subscription
  license-header: MICROSOFT_MIT_NO_VERSION
  output-folder: $(csharp-sdks-folder)/Subscription/Management.Subscription/Generated
  clear-output-folder: true
```
