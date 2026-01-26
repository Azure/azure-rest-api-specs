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
suppressions:
  - code: AvoidAnonymousTypes
    reason: LRO status response uses inline OperationStatus model from Azure.Core templates
    from: discovery-workspace.json
    where:
      - $.paths["/projects/{projectName}/investigations/{investigationName}"].delete.responses["202"].schema
      - $.paths["/projects/{projectName}/investigations/{investigationName}/operations/{operationId}"].get.responses["200"].schema
      - $.paths["/tools/projects/{projectName}:run"].post.responses["202"].schema
      - $.paths["/tools/projects/{projectName}/operations/{operationId}"].get.responses["200"].schema
  - code: LroExtension
    reason: cancelRun Does not expose polling semantics.
    from: discovery-workspace.json
    where:
      - $.paths["/tools/projects/{projectName}/operations/{operationId}:cancel"].post
```
