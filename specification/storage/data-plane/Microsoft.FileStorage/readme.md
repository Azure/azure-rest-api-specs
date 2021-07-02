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
tag: package-2020-10
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
- preview/2020-10-02/file.json
```

### Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: preview/2020-10-02/file.json
    reason: These parameters are predfined by storage specifications 
  - suppress: XmsPathsMustOverloadPaths
    from: preview/2020-10-02/file.json
  - suppress: XmsExamplesRequired
    from: preview/2020-10-02/file.json
```
---