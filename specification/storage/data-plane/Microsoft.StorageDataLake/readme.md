# DataLakeStorage

> see https://aka.ms/autorest

This is the AutoRest configuration file for DataLakeStorage.


---
## Getting Started
To build the SDK for DataLakeStorage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the DataLakeStorage API.

``` yaml
openapi-type: data-plane
tag: package-2020-06
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06'
input-file:
- stable/2020-06-12/DataLakeStorage.json
```

### Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: stable/2020-06-12/DataLakeStorage.json
    reason: These parameters are predfined by storage specifications 
```

``` yaml
directive:
  - suppress: XmsPathsMustOverloadPaths
    from: stable/2020-06-12/DataLakeStorage.json
```

``` yaml
directive:
  - suppress: XmsExamplesRequired
    from: stable/2020-06-12/DataLakeStorage.json
```

``` yaml
directive:
  - suppress: OperationIdNounConflictingModelNames
    from: stable/2020-06-12/DataLakeStorage.json
    reason: This is only a warning. Changing these definitions would be a massive breaking change to our clients
```
---
