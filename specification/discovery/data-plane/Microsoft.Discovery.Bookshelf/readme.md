# Microsoft.Discovery.Bookshelf

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.Discovery.Bookshelf data-plane.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

## Configuration

### Basic Information

These are the global settings for the Microsoft.Discovery.Bookshelf API.

```yaml
openapi-type: data-plane
tag: package-2026-02-01-preview
```

### Tag: package-2026-02-01-preview

These settings apply only when `--tag=package-2026-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-02-01-preview'
input-file:
  - preview/2026-02-01-preview/discovery-bookshelf.json
suppressions:
  - code: AvoidAnonymousTypes
    reason: LRO status response uses inline OperationStatus model from Azure.Core templates
    from: discovery-bookshelf.json
    where:
      - $.paths["/knowledgeBases/{knowledgeBaseName}"].delete.responses["202"].schema
      - $.paths["/knowledgeBases/{knowledgeBaseName}/versions/{versionName}"].delete.responses["202"].schema
      - $.paths["/knowledgeBases/{knowledgeBaseName}/versions/{versionName}:startIndexing"].post.responses["202"].schema
      - $.paths["/knowledgeBases/{knowledgeBaseName}/versions/{versionName}:cancelIndexing"].post.responses["202"].schema
```
