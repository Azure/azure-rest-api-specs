# StorageDataLake

> see https://aka.ms/autorest

This is the AutoRest configuration file for StorageDataLake.


---
## Getting Started
To build the SDK for StorageDataLake, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the StorageDataLake API.

``` yaml
openapi-type: data-plane
tag: package-2023-05
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
- stable/2023-05-03/DataLakeStorage.json
```

### Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: These parameters are predfined by storage specifications 
  - suppress: XmsPathsMustOverloadPaths
  - suppress: XmsExamplesRequired
  - suppress: OperationIdNounConflictingModelNames
    reason: This is only a warning. Changing these definitions would be a massive breaking change to our clients
  - suppress: LongRunningOperationsWithLongRunningExtension
  - suppress: OAV107
```
---