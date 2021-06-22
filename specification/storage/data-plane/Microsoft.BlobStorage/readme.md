# DataLakeStorage

> see https://aka.ms/autorest

This is the AutoRest configuration file for DataLakeStorage.



---
## Getting Started
To build the SDK for BlobStorage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the BlobStorage API.

``` yaml
openapi-type: data-plane
tag: package-2020-10
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
- preview/2020-10-02/blob.json
```

### Tag: package-2020-08

These settings apply only when `--tag=package-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-2020-08'
input-file:
- preview/2020-08-04/blob.json
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06'
input-file:
- preview/2020-06-12/blob.json
```

### Tag: package-2020-04

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04'
input-file:
- preview/2020-04-08/blob.json
```

### Tag: package-2020-02

These settings apply only when `--tag=package-2020-02` is specified on the command line.

``` yaml $(tag) == 'package-2020-02'
input-file:
- preview/2020-02-10/blob.json
```

### Tag: package-2019-12

These settings apply only when `--tag=package-2019-12` is specified on the command line.

``` yaml $(tag) == 'package-2019-12'
input-file:
- preview/2019-12-12/blob.json
```

### Tag: package-2019-07

These settings apply only when `--tag=package-2019-07` is specified on the command line.

``` yaml $(tag) == 'package-2019-07'
input-file:
- preview/2019-07-07/blob.json
```

### Tag: package-2019-02

These settings apply only when `--tag=package-2019-02` is specified on the command line.

``` yaml $(tag) == 'package-2019-02'
input-file:
- preview/2019-02-02/blob.json
```

### Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: preview/2020-10-02/blob.json
    reason: These parameters are predfined by storage specifications 
```

``` yaml
directive:
  - suppress: XmsPathsMustOverloadPaths
    from: preview/2020-10-02/blob.json
```

``` yaml
directive:
  - suppress: XmsExamplesRequired
    from: preview/2020-10-02/blob.json
```
---
