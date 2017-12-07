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

### Tag: package-all-subscription

These settings apply only when `--tag=package-all-subscription` is specified on the command line.

``` yaml $(tag) == 'package-all-subscription'
input-file:
- Microsoft.Subscription/2017-11-01-preview/subscriptionDefinitions.json
- ../../resources/resource-manager/Microsoft.Resources/2016-06-01/subscriptions.json
title: SubscriptionClient
description: The subscription client
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

## Python

These settings apply only when `--python --tag=package-all-subscription` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && $(tag) == 'package-all-subscription'
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.subscription
  package-name: azure-mgmt-subscription
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update' && $(tag) == 'package-all-subscription'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-subscription/azure/mgmt/subscription
```
``` yaml $(python) && $(python-mode) == 'create' && $(tag) == 'package-all-subscription'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-subscription
```
