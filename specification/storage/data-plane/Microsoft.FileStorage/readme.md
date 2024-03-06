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
tag: package-2024-05
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2024-05

These settings apply only when `--tag=package-2024-05` is specified on the command line.

``` yaml $(tag) == 'package-2024-05'
input-file:
- stable/2024-05-04/file.json
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