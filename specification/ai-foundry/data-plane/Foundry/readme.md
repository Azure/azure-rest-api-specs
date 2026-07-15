# Foundry Data Plane

> see https://aka.ms/autorest

This folder contains the TypeSpec source and generated OpenAPI artifacts for the Foundry data-plane API.

``` yaml
openapi-type: data-plane
tag: v1
```

# Releases

### v1
``` yaml $(tag) == 'v1'
input-file:
  - openapi3/v1/microsoft-foundry-openapi3.json
```

### virtual-public-preview
``` yaml $(tag) == 'virtual-public-preview'
input-file:
  - openapi3/virtual-public-preview/microsoft-foundry-openapi3.json
```
