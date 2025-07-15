# [[ServiceName]]

---

## Configuration

### Basic Information

These are the global settings for the [[ServiceName]].

```yaml
openapi-type: [[OpenApiType]]
tag: package-[[Version]]
```

### Tag: package-[[Version]]

These settings apply only when `--tag=package-[[Version]]` is specified on the command line.

```yaml $(tag) == 'package-[[Version]]'
input-file:
  - [[ResourceProviderName]]/[[ReleaseState]]/[[Version]]/[[ServiceName]].json
```
