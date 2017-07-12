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

## Configuration



### Basic Information 
These are the global settings for the Resource API.

``` yaml
openapi-type: arm
tag: package-2017-05
```

### Tag: package-features-2015-12
These settings apply only when `--tag=package-features-2015-12` is specified on the command line.

``` yaml $(tag) == 'package-features-2015-12'
input-file:
- Microsoft.Features/2015-12-01/features.json
```

### Tag: package-locks-2016-09
These settings apply only when `--tag=package-locks-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-locks-2016-09'
input-file:
- Microsoft.Authorization/2016-09-01/locks.json
```

### Tag: package-policy-2016-12
These settings apply only when `--tag=package-policy-2016-12` is specified on the command line.

``` yaml $(tag) == 'package-policy-2016-12'
input-file:
- Microsoft.Authorization/2016-12-01/policy.json
```

### Tag: package-resources-2017-05
These settings apply only when `--tag=package-resources-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-resources-2017-05'
input-file:
- Microsoft.Resources/2017-05-10/resources.json
```

### Tag: package-subscriptions-2016-06
These settings apply only when `--tag=package-subscriptions-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2016-06'
input-file:
- Microsoft.Resources/2016-06-01/subscriptions.json
```

### Tag: package-2017-05

These settings apply only when `--tag=package-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-2017-05'
title: ResourceClient
description: Resource Client
input-file:
- Microsoft.Authorization/2016-09-01/locks.json
- Microsoft.Authorization/2016-12-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2017-05-10/resources.json
- Microsoft.Resources/2016-06-01/subscriptions.json
- Microsoft.Scheduler/2016-09-01/links.json
- Microsoft.Solutions/2016-09-01-preview/managedapplications.json
```
 
### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
title: ResourceClient
description: Resource Client
input-file:
- Microsoft.Authorization/2016-09-01/locks.json
- Microsoft.Authorization/2016-04-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-09-01/resources.json
- Microsoft.Resources/2016-06-01/subscriptions.json
- Microsoft.Resources/2016-09-01/links.json
```
 
### Tag: package-2016-07

These settings apply only when `--tag=package-2016-07` is specified on the command line.

``` yaml $(tag) == 'package-2016-07'
title: ResourceClient
description: Resource Client
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2016-04-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-07-01/resources.json
- Microsoft.Resources/2016-06-01/subscriptions.json
```
 
### Tag: package-2016-06

These settings apply only when `--tag=package-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-2016-06'
title: ResourceClient
description: Resource Client
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2016-04-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-02-01/resources.json
- Microsoft.Resources/2016-06-01/subscriptions.json
```
 
### Tag: package-2016-04

These settings apply only when `--tag=package-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-2016-04'
title: ResourceClient
description: Resource Client
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2016-04-01/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-02-01/resources.json
- Microsoft.Resources/2015-11-01/subscriptions.json
```
 
### Tag: package-2016-02

These settings apply only when `--tag=package-2016-02` is specified on the command line.

``` yaml $(tag) == 'package-2016-02'
title: ResourceClient
description: Resource Client
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2015-10-01-preview/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2016-02-01/resources.json
- Microsoft.Resources/2015-11-01/subscriptions.json
```
 
### Tag: package-2015-12

These settings apply only when `--tag=package-2015-12` is specified on the command line.

``` yaml $(tag) == 'package-2015-12'
title: ResourceClient
description: Resource Client
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
- Microsoft.Authorization/2015-10-01-preview/policy.json
- Microsoft.Features/2015-12-01/features.json
- Microsoft.Resources/2015-11-01/resources.json
- Microsoft.Resources/2015-11-01/subscriptions.json
```


---
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

