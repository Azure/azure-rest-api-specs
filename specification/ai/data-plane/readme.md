# OpenAI

> see https://aka.ms/autorest

This is the AutoRest configuration file for OpenAI.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the [OpenAI].

```yaml
openapi-type: data-plane
tag: package-2024-05-01-preview
```

### Tag: package-2024-05-01-preview

These settings apply only when `--tag=package-2024-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-05'
input-file:
  - OpenAI.Assistants/OpenApiV3/2024-05-01-preview/assistants_generated.yaml
```

### Suppression

``` yaml
directive:
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: assistants_generated.json
    reason: No existing examples.
```
