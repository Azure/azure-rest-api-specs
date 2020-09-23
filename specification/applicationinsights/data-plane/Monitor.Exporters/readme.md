# Exporter for Azure Monitor
> see https://aka.ms/autorest

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

## Configuration

The following are the settings for this using this API with AutoRest.

``` yaml
# specify the version of Autorest to use
version: 1.0.1-20170402

# (more settings here...)
```

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

