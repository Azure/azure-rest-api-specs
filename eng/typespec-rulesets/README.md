# TypeSpec linter rulesets

These repository-owned rulesets centralize the linter policy for every TypeSpec
project in this repository. Each ruleset currently extends the corresponding
ruleset from `@azure-tools/typespec-azure-rulesets` so future rule changes can be
adopted centrally without editing every project again.

TypeSpec projects reference these files from `tspconfig.yaml` using a `file:`
URL with a path relative to the project directory. For example:

```yaml
linter:
  extends:
    - "file:../../../../../eng/typespec-rulesets/resource-manager.yaml"
    - "file:../../../../../eng/typespec-rulesets/client-sdk.yaml"
```

Use `data-plane.yaml` or `resource-manager.yaml` according to the API plane.
Projects configured with client emitters also extend `client-sdk.yaml`.
