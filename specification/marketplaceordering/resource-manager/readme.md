# Marketplace Agreements API

> see https://aka.ms/autorest

The underlying APIs are available to users who would like to write their own REST calls. These APIs would allow the user to accept the terms at a subscription, offer and SKU level. These apis are invoked in the context of azure subscription.

----
***GetAzureRmMarketplaceTerms***

**Request**

This api returns the latest terms for a given Subscription, Publisher, Product and Name. 
      
**Reply**

200 OK. Agreement Terms in response body.

***SaveAzureRmMarketplaceTerms***

**Request**

This api sends the license information retrieved by the first API along with Accepted flag which confirms that the terms are accepted(true) or not accepted(false). 

**Reply**

1. 200 OK. The request was successfully processed and the terms were accepted or acceptance revoked as per the request body. 
2. 400 Bad/Malformed request. E.g. Signature doesn’t match, please retrieve terms again and request acceptance.
3. 403 Forbidden. E.g. The caller does not have permission to accept terms for given subscription. (only a reader).
4. 404 E.g. The Publisher/Offer/Plan tuple is not a valid virtual machine.

---
## Getting Started 
To build the SDK for Marketplace Agreements, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Marketplace Agreements API.

``` yaml
openapi-type: arm
tag: package-2015-06-01
```


### Tag: package-2015-06-01

These settings apply only when `--tag=package-2015-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-01'
input-file:
- Microsoft.MarketplaceOrdering/2015-06-01/Agreements.json
```


---
# Code Generation


---
## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.MarketplaceOrdering
  output-folder: $(csharp-sdks-folder)/Management.MarketplaceOrdering/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: marketplaceordering
  clear-output-folder: true
```

### Tag: package-2015-06-01 and go

These settings apply only when `--tag=package-2015-06-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-06-01' && $(go)
output-folder: $(go-sdk-folder)/services/marketplaceordering/mgmt/2015-06-01/marketplaceordering
```
