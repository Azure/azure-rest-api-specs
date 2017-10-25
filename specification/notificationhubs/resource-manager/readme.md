# NotificationHubs
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for NotificationHubs.



---
## Getting Started 
To build the SDK for NotificationHubs, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the NotificationHubs API.

``` yaml
openapi-type: arm
tag: package-2017-04
```


### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- Microsoft.NotificationHubs/2017-04-01/notificationhubs.json
```
 
### Tag: package-2016-03

These settings apply only when `--tag=package-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-2016-03'
input-file:
- Microsoft.NotificationHubs/2016-03-01/notificationhubs.json
```
 
### Tag: package-2014-09

These settings apply only when `--tag=package-2014-09` is specified on the command line.

``` yaml $(tag) == 'package-2014-09'
input-file:
- Microsoft.NotificationHubs/2014-09-01/notificationhubs.json
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
  namespace: Microsoft.Azure.Management.NotificationHubs
  output-folder: $(csharp-sdks-folder)/NotificationHubs/Management.NotificationHubs/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: notificationhubs
  clear-output-folder: true
```

### Tag: package-2017-04 and go

These settings apply only when `--tag=package-2017-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-04' && $(go)
output-folder: $(go-sdk-folder)/services/notificationhubs/mgmt/2017-04-01/notificationhubs
```

### Tag: package-2016-03 and go

These settings apply only when `--tag=package-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-03' && $(go)
output-folder: $(go-sdk-folder)/services/notificationhubs/mgmt/2016-03-01/notificationhubs
```

### Tag: package-2014-09 and go

These settings apply only when `--tag=package-2014-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2014-09' && $(go)
output-folder: $(go-sdk-folder)/services/notificationhubs/mgmt/2014-09-01/notificationhubs
```
