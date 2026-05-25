# Microsoft Foundry data-plane OpenAPI 3 – `v1`

This folder contains the **generated** OpenAPI 3.0 definition for the GA (`v1`)
version of the Microsoft Foundry data-plane API.

## Contents

- `microsoft-foundry-openapi3.json` – OpenAPI 3.0 specification (JSON).
- `microsoft-foundry-openapi3.yaml` – OpenAPI 3.0 specification (YAML).

Both files describe the same API surface and are produced from the TypeSpec
sources in
[`specification/ai-foundry/data-plane/Foundry`](../../README.md) by the
`@typespec/openapi3` emitter (configured in
[`tspconfig.yaml`](../../tspconfig.yaml)).

The `v1` definition contains the stable GA operations of the Foundry
data-plane API, covering capabilities such as Agents, Connections, Datasets,
Deployments, Evaluation Taxonomies / Rules / Evaluators, Indexes, Insights,
Memory Stores, Conversations, Evals, Fine-Tuning, Responses, Redteams, and
Schedules.

## Do not edit by hand

These files are generated. Make changes in the TypeSpec sources and re-emit
by following the instructions in the parent
[README](../../README.md) (typically `npx tsv .` from the Foundry TypeSpec
project root).
