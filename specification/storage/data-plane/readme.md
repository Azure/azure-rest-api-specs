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

### Tag: blob-package-2021-02

These settings apply only when `--tag=blob-package-2021-02` is specified on the command line.

``` yaml $(tag) == 'blob-package-2021-02'
input-file:
- Microsoft.BlobStorage/preview/2021-02-12/blob.json
```

### Tag: datalake-package-2020-06

These settings apply only when `--tag=datalake-package-2020-06` is specified on the command line.

``` yaml $(tag) == 'datalake-package-2020-06'
input-file:
- Microsoft.StorageDataLake/stable/2020-06-12/DataLakeStorage.json
```

### Tag: file-package-2021-02

These settings apply only when `--tag=file-package-2021-02` is specified on the command line.

``` yaml $(tag) == 'file-package-2021-02'
input-file:
- Microsoft.FileStorage/preview/2021-02-12/file.json
```

### Tag: queue-package-2018-03

These settings apply only when `--tag=queue-package-2018-03` is specified on the command line.

``` yaml $(tag) == 'queue-package-2018-03'
input-file:
- Microsoft.QueueStorage/preview/2018-03-28/queue.json
```

### Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: These parameters are predfined by storage specifications 
  - suppress: XmsPathsMustOverloadPaths
  - suppress: XmsExamplesRequired
```
---