# ServiceBus

> see https://aka.ms/autorest

This is the AutoRest configuration file for ServiceBus.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

## General OpenAPI tooling

The definition is Swagger 2.0. Before importing it into tools such as Swagger UI, set the standard `host` field in a local copy to your namespace's fully qualified domain name, such as `your-namespace.servicebus.windows.net`. Supply only the hostname, without a scheme or path. The checked-in `example-namespace.servicebus.windows.net` is a placeholder, not your namespace. Requests use HTTPS.

AutoRest consumers continue to supply the existing `endpoint` parameter through `x-ms-parameterized-host`. Keep that extension and its parameter unchanged when configuring `host` for general OpenAPI tooling. Swagger 2.0 does not support variables in its standard `host` field.

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
  - ./stable/2021-05/servicebus.json
```

### Suppression

```yaml
directive:
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: servicebus.json
    reason: Response body is XML, not JSON, so cannot validate.
```
