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

---

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
