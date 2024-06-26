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

### Suppression

``` yaml
directive:
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: assistants_generated.json
    reason: No existing examples.
```
