# Table Dataplane

> see https://aka.ms/autorest

This is the AutoRest configuration file for Tables.



---
## Getting Started
To build the SDK for Tables, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Tables API.

``` yaml
azure-validator: true
openapi-type: data-plane
tag: package-2019-02
```

### Tag: package-2019-02

These settings apply only when `--tag=package-2019-02` is specified on the command line.

``` yaml $(tag) == 'package-2019-02'
input-file:
- preview/2019-02-02/table.json
```

### Suppression


```yaml
directive:
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: table.json
    reason: Service uses XML, not JSON, so cannot validate.
  - suppress: XmsPathsMustOverloadPaths
    from: table.json
    reason: Service has paths made up only of endpoint + parameters.
  - suppress: HostParametersValidation
    from: table.json
    reason: Existing API contract using "url" instead of "endpoint".
```

