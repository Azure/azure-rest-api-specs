# Resource
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Resource.



---
## Getting Started 
To build the SDK for Resource, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Resource API.

``` yaml
# common 
title: Resource
description: Resource Client
openapi-type: arm
tag: 2017-05-10

```


# Tag: 2017-05-10

These settings apply only when `--tag=2017-05-10` is specified on the command line.

``` yaml $(tag) == '2017-05-10'
input-file:
- Microsoft.Authorization/2016-09-01/locks.json
- Microsoft.Authorization/2016-12-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2017-05-10/resources.json
- Microsoft.Resources/2016-06-01/subscriptions.json
- Microsoft.Scheduler/2016-09-01/links.json
- Microsoft.Solutions/2016-09-01-preview/managedapplications.json

```
 
# Tag: 2016-09-01

These settings apply only when `--tag=2016-09-01` is specified on the command line.

``` yaml $(tag) == '2016-09-01'
input-file:
- Microsoft.Authorization/2016-09-01/locks.json
- Microsoft.Authorization/2016-04-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-09-01/resources.json
- Microsoft.Resources/2016-06-01/subscriptions.json
- Microsoft.Resources/2016-09-01/links.json

```
 
# Tag: 2016-07-01

These settings apply only when `--tag=2016-07-01` is specified on the command line.

``` yaml $(tag) == '2016-07-01'
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2016-04-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-07-01/resources.json
- Microsoft.Resources/2016-06-01/subscriptions.json

```
 
# Tag: 2016-06-01

These settings apply only when `--tag=2016-06-01` is specified on the command line.

``` yaml $(tag) == '2016-06-01'
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2016-04-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-02-01/resources.json
- Microsoft.Resources/2016-06-01/subscriptions.json

```
 
# Tag: 2016-04-01

These settings apply only when `--tag=2016-04-01` is specified on the command line.

``` yaml $(tag) == '2016-04-01'
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2016-04-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-02-01/resources.json
- Microsoft.Resources/2015-11-01/subscriptions.json

```
 
# Tag: 2016-02-01

These settings apply only when `--tag=2016-02-01` is specified on the command line.

``` yaml $(tag) == '2016-02-01'
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2015-10-01-preview/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-02-01/resources.json
- Microsoft.Resources/2015-11-01/subscriptions.json

```
 
# Tag: 2015-12-01

These settings apply only when `--tag=2015-12-01` is specified on the command line.

``` yaml $(tag) == '2015-12-01'
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2015-10-01-preview/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2015-11-01/resources.json
- Microsoft.Resources/2015-11-01/subscriptions.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

