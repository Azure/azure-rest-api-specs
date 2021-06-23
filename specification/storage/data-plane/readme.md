# Storage

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Storage.


---
## Getting Started
To build the SDK for Storage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Storage APIs.

``` yaml
title: StorageClient
description: Storage Client
openapi-type: data-plane
tag: package-2020-03
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2018-03

These settings apply only when `--tag=package-2018-03` is specified on the command line.

``` yaml $(tag) == 'package-2018-03'
input-file:
- preview/2018-03-28/queue.json
```

### Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: preview/2018-03-28/queue.json
    reason: These parameters are predfined by storage specifications 
```

``` yaml
directive:
  - suppress: XmsPathsMustOverloadPaths
    from: preview/2018-03-28/queue.json
```

``` yaml
directive:
  - suppress: XmsExamplesRequired
    from: preview/2018-03-28/queue.json
```
---
