# Foundry data-plane common TypeSpec

> see https://aka.ms/autorest

Shared TypeSpec building blocks reused by every Foundry data-plane feature area:

- `service.tsp` — service declaration, endpoint, authentication, and API version enum.
- `models.tsp` — cross-cutting shared models (errors, timestamps, etc.).
- `custom-types.tsp` — repository-defined scalar and template types.
- `servicepatterns.tsp` — Foundry operation templates (`FoundryDataPlaneOperation`, `FoundryDataPlaneRequiredPreviewOperation`, …), preview-feature opt-in keys, pagination helpers, and the long-running job framework.
- `openai-templates.tsp` — OpenAI-compatible operation templates shared by the `openai/*` sub-services.
- `error.range.tsp` — Azure Core error response wiring.

Feature-area folders import from this folder via `../common/*.tsp`. The AutoRest configuration for SDK generation is in [`../../readme.md`](../../readme.md).

``` yaml
openapi-type: data-plane
```
