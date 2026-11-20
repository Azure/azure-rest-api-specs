# Contoso

> see https://aka.ms/autorest

```yaml
title: Contoso
openapi-type: data-plane
tag: stable
```

### Tag: stable

```yaml $(tag) == 'stable'
input-file:
  - stable/one.json
  - stable/two.json
```

### Tag: preview

```yaml $(tag) == 'preview'
input-file:
  - preview/three.json
```

### Tag: mixed

```yaml $(tag) == 'mixed'
input-file:
  - stable/one.json
  - other/four.json
```
