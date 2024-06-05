# FileStorage

> see https://aka.ms/autorest

This is the AutoRest configuration file for FileStorage.


---
## Getting Started
To build the SDK for FileStorage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the FileStorage API.

``` yaml
openapi-type: data-plane
tag: package-2024-11
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
- preview/2020-10-02/file.json
```

### Tag: package-2021-02

These settings apply only when `--tag=package-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-2021-02'
input-file:
- preview/2021-02-12/file.json
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04'
input-file:
- preview/2021-04-10/file.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
- preview/2021-06-08/file.json
```

### Tag: package-2021-12

These settings apply only when `--tag=package-2021-12` is specified on the command line.

``` yaml $(tag) == 'package-2021-12'
input-file:
- preview/2021-12-02/file.json
```

### Tag: package-2022-11

These settings apply only when `--tag=package-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-2022-11'
input-file:
- preview/2022-11-02/file.json
```

### Tag: package-2023-01

These settings apply only when `--tag=package-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01'
input-file:
- preview/2023-01-03/file.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
- preview/2023-08-03/file.json
```

### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

``` yaml $(tag) == 'package-2024-02'
input-file:
- preview/2024-02-04/file.json
```

### Tag: package-2024-05-preview

These settings apply only when `--tag=package-2024-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-05-preview'
input-file:
- preview/2024-05-04/file.json
```

### Tag: package-2024-05

These settings apply only when `--tag=package-2024-05` is specified on the command line.

``` yaml $(tag) == 'package-2024-05'
input-file:
- stable/2024-05-04/file.json
```

### Tag: package-2024-08

These settings apply only when `--tag=package-2024-08` is specified on the command line.

``` yaml $(tag) == 'package-2024-08'
input-file:
- stable/2024-08-04/file.json
```

### Tag: package-2024-11

These settings apply only when `--tag=package-2024-11` is specified on the command line.

``` yaml $(tag) == 'package-2024-11'
input-file:
- stable/2024-11-04/file.json
```

### Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: These parameters are predfined by storage specifications 
  - suppress: XmsPathsMustOverloadPaths
  - suppress: XmsExamplesRequired
  - suppress: LongRunningOperationsWithLongRunningExtension
  - suppress: OAV107
```
---