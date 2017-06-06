# Network
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Network.



---
## Getting Started 
To build the SDK for Network, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Network API.

``` yaml
# common 
title: Network
description: Network Client
api-version: 2017-03-01

```


# API Version: 2017-03-01

These settings apply only when `--api-version=2017-03-01` is specified on the command line.

``` yaml $(api-version) == '2017-03-01'
input-file:
- microsoft.Compute/2017-03-01/vmssNetworkInterface.json
- Microsoft.Network/2017-03-01/applicationGateway.json
- Microsoft.Network/2017-03-01/checkDnsAvailability.json
- Microsoft.Network/2017-03-01/expressRouteCircuit.json
- Microsoft.Network/2017-03-01/loadBalancer.json
- Microsoft.Network/2017-03-01/network.json
- Microsoft.Network/2017-03-01/networkInterface.json
- Microsoft.Network/2017-03-01/networkSecurityGroup.json
- Microsoft.Network/2017-03-01/networkWatcher.json
- Microsoft.Network/2017-03-01/publicIpAddress.json
- Microsoft.Network/2017-03-01/routeFilter.json
- Microsoft.Network/2017-03-01/routeTable.json
- Microsoft.Network/2017-03-01/serviceCommunity.json
- Microsoft.Network/2017-03-01/usage.json
- Microsoft.Network/2017-03-01/virtualNetwork.json
- Microsoft.Network/2017-03-01/virtualNetworkGateway.json

```
 
# API Version: 2016-12-01

These settings apply only when `--api-version=2016-12-01` is specified on the command line.

``` yaml $(api-version) == '2016-12-01'
input-file:
- microsoft.Compute/2016-12-01/vmssNetworkInterface.json
- Microsoft.Network/2016-12-01/applicationGateway.json
- Microsoft.Network/2016-12-01/checkDnsAvailability.json
- Microsoft.Network/2016-12-01/expressRouteCircuit.json
- Microsoft.Network/2016-12-01/loadBalancer.json
- Microsoft.Network/2016-12-01/network.json
- Microsoft.Network/2016-12-01/networkInterface.json
- Microsoft.Network/2016-12-01/networkSecurityGroup.json
- Microsoft.Network/2016-12-01/networkWatcher.json
- Microsoft.Network/2016-12-01/publicIpAddress.json
- Microsoft.Network/2016-12-01/routeFilter.json
- Microsoft.Network/2016-12-01/routeTable.json
- Microsoft.Network/2016-12-01/serviceCommunity.json
- Microsoft.Network/2016-12-01/usage.json
- Microsoft.Network/2016-12-01/virtualNetwork.json
- Microsoft.Network/2016-12-01/virtualNetworkGateway.json

```
 
# API Version: 2016-09-01

These settings apply only when `--api-version=2016-09-01` is specified on the command line.

``` yaml $(api-version) == '2016-09-01'
input-file:
- microsoft.Compute/2016-09-01/vmssNetworkInterface.json
- Microsoft.Network/2016-09-01/applicationGateway.json
- Microsoft.Network/2016-09-01/checkDnsAvailability.json
- Microsoft.Network/2016-09-01/expressRouteCircuit.json
- Microsoft.Network/2016-09-01/loadBalancer.json
- Microsoft.Network/2016-09-01/network.json
- Microsoft.Network/2016-09-01/networkInterface.json
- Microsoft.Network/2016-09-01/networkSecurityGroup.json
- Microsoft.Network/2016-09-01/networkWatcher.json
- Microsoft.Network/2016-09-01/publicIpAddress.json
- Microsoft.Network/2016-09-01/routeTable.json
- Microsoft.Network/2016-09-01/usage.json
- Microsoft.Network/2016-09-01/virtualNetwork.json
- Microsoft.Network/2016-09-01/virtualNetworkGateway.json

```
 
# API Version: 2016-06-01

These settings apply only when `--api-version=2016-06-01` is specified on the command line.

``` yaml $(api-version) == '2016-06-01'
input-file:
- Microsoft.Network/2016-06-01/network.json


```
 
# API Version: 2016-03-30

These settings apply only when `--api-version=2016-03-30` is specified on the command line.

``` yaml $(api-version) == '2016-03-30'
input-file:
- Microsoft.Network/2016-03-30/network.json

```
 
# API Version: 2015-06-15split

These settings apply only when `--api-version=2015-06-15split` is specified on the command line.

``` yaml $(api-version) == '2015-06-15split'
input-file:
- Microsoft.Network/2015-06-15/applicationGateway.json
- Microsoft.Network/2015-06-15/checkDnsAvailability.json
- Microsoft.Network/2015-06-15/expressRouteCircuit.json
- Microsoft.Network/2015-06-15/loadBalancer.json
- Microsoft.Network/2015-06-15/networkInterface.json
- Microsoft.Network/2015-06-15/networkSecurityGroup.json
- Microsoft.Network/2015-06-15/publicIpAddress.json
- Microsoft.Network/2015-06-15/routeTable.json
- Microsoft.Network/2015-06-15/usage.json
- Microsoft.Network/2015-06-15/virtualNetwork.json
- Microsoft.Network/2015-06-15/virtualNetworkGateway.json
- microsoft.Compute/2015-06-15/vmssNetworkInterface.json
```
 
# API Version: 2015-06-15

These settings apply only when `--api-version=2015-06-15` is specified on the command line.

``` yaml $(api-version) == '2015-06-15'
input-file:
- Microsoft.Network/2015-06-15/network.json
```
 
# API Version: 2015-05-01-preview

These settings apply only when `--api-version=2015-05-01-preview` is specified on the command line.

``` yaml $(api-version) == '2015-05-01-preview'
input-file:
- Microsoft.Network/2015-05-01-preview/network.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

