# Local Agentic RAG

> see https://aka.ms/autorest

This is the AutoRest configuration file for Local Agentic RAG.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Local Agentic RAG API.

```yaml
openapi-type: data-plane
tag: package-2024-10-01-preview
```

### Tag: package-2024-10-01-preview

These settings apply only when `--tag=package-2024-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01-preview'
input-file:
  - preview/2024-10-01-preview/agents-runtime.json
  - preview/2024-10-01-preview/collections.json
  - preview/2024-10-01-preview/inference.json
  - preview/2024-10-01-preview/ingestion.json
  - preview/2024-10-01-preview/knowledge-base-manager.json
  - preview/2024-10-01-preview/knowledge-sources.json
  - preview/2024-10-01-preview/mcp-server.json
```
