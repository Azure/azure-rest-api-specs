# Widget

> see https://aka.ms/autorest
> This is the AutoRest configuration file for Widget.

## Configuration

Required if any services under this folder are RPaaS.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: unused
```

### Tag: unused

Required to make LintDiff pass

```yaml $(tag) == 'unused'
input-file:
  - Microsoft.Widget/Widget/stable/2021-11-01/widget.json
```
