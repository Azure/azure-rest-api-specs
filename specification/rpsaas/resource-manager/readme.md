# Readme

> see https://aka.ms/autorest

```yaml
openapi-type: arm 
openapi-subtype: rpaas
tag: package-2024-06-01-preview
```

```yaml $(tag) == 'package-2024-06-01-preview'
input-file:
  - Microsoft.Contoso/preview/2024-06-01-preview/openapi.json
```

```yaml $(tag) == '2020-01-01-preview'
input-file: 
  - Microsoft.Contoso/preview/2020-01-01-preview/employee.json
  - Microsoft.Contoso/preview/2020-01-01-preview/cluster.json
```

```yaml $(tag) == '2019-01-01'
input-file: 
  - Microsoft.Contoso/stable/2019-01-01/employee.json
```

```yaml $(tag) == '2018-11-01-preview'
input-file: 
  - Microsoft.Contoso/preview/2018-11-01-preview/employee.json
```
