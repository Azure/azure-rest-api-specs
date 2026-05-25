# Microsoft Foundry data-plane OpenAPI 3 – `virtual-public-preview`

This folder contains the **generated** OpenAPI 3.0 definition for the
`virtual-public-preview` version of the Microsoft Foundry data-plane API.

## Contents

- `microsoft-foundry-openapi3.json` – OpenAPI 3.0 specification (JSON).
- `microsoft-foundry-openapi3.yaml` – OpenAPI 3.0 specification (YAML).

Both files describe the same API surface and are produced from the TypeSpec
sources in
[`specification/ai-foundry/data-plane/Foundry`](../../README.md) by the
`@typespec/openapi3` emitter (configured in
[`tspconfig.yaml`](../../tspconfig.yaml)).

The `virtual-public-preview` definition is a superset of the GA `v1`
specification: in addition to all GA operations, it includes preview-only
capabilities (for example, Agent Containers and Agent Invocations) and any
preview routes/models marked with the `@added` decorator in TypeSpec. It is
intended for early-access scenarios and is not considered stable.

## Do not edit by hand

These files are generated. Make changes in the TypeSpec sources and re-emit
by following the instructions in the parent
[README](../../README.md) (typically `npx tsv .` from the Foundry TypeSpec
project root). Preview features must be authored with the appropriate
`@added` / `@removed` decorators so they appear here but not in the GA `v1`
output.
