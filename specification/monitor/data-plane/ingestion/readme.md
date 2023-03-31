# My API

> see https://aka.ms/autorest

### Basic Information

These are the global settings for the Ingestion API.

``` yaml
openapi-type: data-plane
tag: package-preview-2023-04
```


### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-04'
input-file:
  - preview/2023-04-01-preview/DataCollectionRules.json
```
### Tag: package-2023-01-01

These settings apply only when `--tag=package-2023-01-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01-01'
input-file:
- stable/2023-01-01/DataCollectionRules.json
```

### Tag: package-2021-11-preview

These settings apply only when `--tag=package-2021-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-11-preview'
input-file:
- preview/2021-11-01-preview/DataCollectionRules.json
```
