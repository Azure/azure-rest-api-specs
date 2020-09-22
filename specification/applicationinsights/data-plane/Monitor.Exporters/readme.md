# Exporter for Azure Monitor
This is the AutoRest configuration file for Monitor Exporter.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

## Configuration

### Basic Information

These are the global settings for the schemaregistry.

```yaml
openapi-type: data-plane
tag: 2020-09-15-preview
```

### Tag: 2020-09-15-preview

These settings apply only when `--tag=2020-09-15-preview` is specified on the command line.

```yaml $(tag) == '2020-09-15-preview'
input-file:
  - preview/2020-09-15_Preview/swagger.json
```

