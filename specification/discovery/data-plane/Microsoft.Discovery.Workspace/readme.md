# Microsoft.Discovery.Workspace

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.Discovery.Workspace data-plane.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

## Configuration

### Basic Information

These are the global settings for the Microsoft.Discovery.Workspace API.

```yaml
openapi-type: data-plane
tag: package-2026-02-01-preview
```

### Tag: package-2026-02-01-preview

These settings apply only when `--tag=package-2026-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-02-01-preview'
input-file:
  - preview/2026-02-01-preview/discovery-workspace.json
```
