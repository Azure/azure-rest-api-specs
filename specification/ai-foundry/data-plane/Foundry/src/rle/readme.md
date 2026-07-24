# Reinforcement Learning Environments (RLE)

> see https://aka.ms/autorest

TypeSpec sources for the Foundry Reinforcement Learning Environments feature.

- `models.tsp` — RL environment, sandbox, and runtime data contracts.
- `routes.tsp` — `RLEnvironments`, `RLESandboxes`, and `RLEnvironmentRuntime` operations.

This feature is exposed as a **beta preview** and requires the `Foundry-Features: ReinforcementLearning=V1Preview` request header. Client-side relocation into the beta sub-namespace is configured in [`../../relocate-beta-operations.tsp`](../../relocate-beta-operations.tsp).

The AutoRest configuration for SDK generation lives in [`../../readme.md`](../../readme.md). This file exists only to satisfy folder-level readme requirements.

``` yaml
openapi-type: data-plane
```
