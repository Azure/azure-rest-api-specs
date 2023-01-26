# fusion

> see https://aka.ms/autorest

## Configuration

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: 2022-10-01-preview
```

### Supported API Versions

```yaml $(tag) == '2019-09-01-preview'
input-file: 
  - Wandisco.Fusion/preview/2019-09-01-preview/fusionGroups.json
```

```yaml $(tag) == '2020-12-01-preview'
input-file: 
  - Wandisco.Fusion/preview/2020-12-01-preview/fusionGroups.json
```

```yaml $(tag) == '2021-01-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-01-01-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-01-preview/fusionGroups.json
```

```yaml $(tag) == '2021-05-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-05-01-preview/fusionGroups.json
  - Wandisco.Fusion/preview/2021-05-01-preview/migrators.json
  - Wandisco.Fusion/preview/2021-05-01-preview/operations.json
  - Wandisco.Fusion/preview/2021-05-01-preview/commonTypes.json
```

```yaml $(tag) == '2022-01-01-preview'
input-file:
  - Wandisco.Fusion/preview/2022-01-01-preview/commonTypes.json
  - Wandisco.Fusion/preview/2022-01-01-preview/migrators.json
  - Wandisco.Fusion/preview/2022-01-01-preview/operations.json
```

```yaml $(tag) == '2022-10-01-preview'
input-file:
  - Wandisco.Fusion/preview/2022-10-01-preview/commonTypes.json
  - Wandisco.Fusion/preview/2022-10-01-preview/migrators.json
  - Wandisco.Fusion/preview/2022-10-01-preview/operations.json
```

## Language specific configurations

### python

```yaml $(python)
no-namespace-folders: true
azure-arm: true
clear-output-folder: true
```

### java
```yaml $(java)
azure-arm: true
namespace: com.wandisco.frp.api.client
```
