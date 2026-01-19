# Azure Monitor AppliationInsights LiveMetrics
> see https://aka.ms/autorest

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

## Configuration

### Basic Information

THe current release is `2024-04-01-preview`

```yaml
openapi-type: data-plane
tag: 2024-04-01-preview
```

### Tag: 2024-04-01-preview

These settings apply only when `--tag=2024-04-01-preview` is specified on the command line.

```yaml $(tag) == '2024-04-01-preview'
input-file:
  - preview/2024-04-01-preview/livemetrics.json
```