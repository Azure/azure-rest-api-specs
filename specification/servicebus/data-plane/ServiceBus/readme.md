# ServiceBus

> see https://aka.ms/autorest

This is the AutoRest configuration file for ServiceBus.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the [ServiceBus].

```yaml
openapi-type: data-plane
tag: package-2021-05
```

### Tag: package-2021-05

These settings apply only when `--tag=package-2021-05` is specified on the command line.

```yaml $(tag) == 'package-2021-05'
input-file:
  - Microsoft.ServiceBus/stable/2021-05/servicebus.json
```

### Suppression

``` yaml
directive:
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: servicebus.json
    reason: Response body is XML, not JSON, so cannot validate.
```
