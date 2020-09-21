# fusion

> see https://aka.ms/autorest

```yaml
tag: 2019-09-01-preview
openapi-subtype: rpaas
```

```yaml $(tag) == '2019-09-01-preview'
input-file: 
  - Wandisco.Fusion/preview/2019-09-01-preview/fusionGroups.json
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
