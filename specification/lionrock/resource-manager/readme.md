# Microsoft.Lionrock

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.Lionrock resource provider.

## Configuration

### Basic Information

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: 2025-10-01
```


### Tag: 2025-10-01

These settings apply only when `--tag=2025-10-01` is specified on the command line.

```yaml $(tag) == '2025-10-01'
input-file:
  - Microsoft.Lionrock/stable/2025-10-01/lionrock.json
```


### Tag: 2025-12-04-preview

These settings apply only when `--tag=2025-12-04-preview` is specified on the command line.

```yaml $(tag) == '2025-12-04-preview'
input-file:
  - Microsoft.Lionrock/preview/2025-12-04-preview/lionrock.json
```
