# DataLakeAnalytics
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for DataLakeAnalytics.



---
## Getting Started 
To build the SDK for DataLakeAnalytics, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the DataLakeAnalytics API.

``` yaml
openapi-type: arm
tag: package-2016-11
```


### Tag:
# DataLakeAnalytics
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for DataLakeAnalytics.



---
## Getting Started 
To build the SDK for DataLakeAnalytics, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the DataLakeAnalytics API.

``` yaml
openapi-type: arm
tag: package-2016-11
```


### Tag: package-2016-11

These settings apply only when `--tag=package-2016-11` is specified on the command line.

``` yaml $(tag) == 'package-2016-11'
input-file:
- Microsoft.DataLakeAnalytics/2016-11-01/account.json
```
 
### Tag: package-2015-10-preview

These settings apply only when `--tag=package-2015-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-10-preview'
input-file:
- Microsoft.DataLakeAnalytics/2015-10-01-preview/account.json
```


---
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

 package-2016-11

These settings apply only when `--tag=package-2016-11` is specified on the command line.

``` yaml $(tag) == 'package-2016-11'
input-file:
- Microsoft.DataLakeAnalytics/2016-11-01/account.json
```
 
### Tag: package-2015-10-preview

These settings apply only when `--tag=package-2015-10-preview` is specified on the command line.

<<<<<<< HEAD
``` yaml $(tag) == 'package-2016-03-preview'
title: DataLakeAnalyticsAccountManagementClient
description: DataLake Analytics Client
input-file:
- Microsoft.DataLakeAnalytics/2015-10-01-preview/account.json
- Microsoft.DataLakeAnalytics/2015-10-01-preview/catalog.json
- Microsoft.DataLakeAnalytics/2016-03-20-preview/job.json
```
 
### Tag: package-2015-11-preview

These settings apply only when `--tag=package-2015-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-11-preview'
title: DataLakeAnalyticsAccountManagementClient
description: DataLake Analytics Client
input-file:
- Microsoft.DataLakeAnalytics/2015-10-01-preview/account.json
- Microsoft.DataLakeAnalytics/2015-10-01-preview/catalog.json
- Microsoft.DataLakeAnalytics/2015-11-01-preview/job.json
=======
``` yaml $(tag) == 'package-2015-10-preview'
input-file:
- Microsoft.DataLakeAnalytics/2015-10-01-preview/account.json
>>>>>>> current
```


---
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

