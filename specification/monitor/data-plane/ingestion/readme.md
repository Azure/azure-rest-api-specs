# My API
> see https://aka.ms/autorest

### Basic Information
These are the global settings for the Ingestion API.

``` yaml
openapi-type: data-plane
tag: package-2023-01-01
```

### Tag: package-2023-01-01

These settings apply only when `--tag=package-2023-01-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01-01'
input-file:
- stable/2023-01-01/DataCollectionRules.json
```
