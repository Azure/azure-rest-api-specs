# TypeSpec linter rulesets

The private workspace package `@azure-tools/specs-typespec-rulesets` centralizes
the linter policy for every TypeSpec project in this repository. Run `pnpm install`
from the repository root to make it available; it is not published to npm.
Each ruleset currently extends the corresponding ruleset from
`@azure-tools/typespec-azure-rulesets` so future rule changes can be adopted
centrally without editing every project again.

TypeSpec projects reference the package's named rulesets from `tspconfig.yaml`:

```yaml
linter:
  extends:
    - "@azure-tools/specs-typespec-rulesets/resource-manager"
    - "@azure-tools/specs-typespec-rulesets/client-sdk"
```

Use `/data-plane` or `/resource-manager` according to the API plane.
Projects configured with client emitters also extend `/client-sdk`.
The canonical examples are the [data-plane Widget template](../../specification/widget/data-plane/WidgetAnalytics/tspconfig.yaml)
and [ARM Widget template](../../specification/widget/resource-manager/Microsoft.Widget/Widget/tspconfig.yaml).

## Enable individual rules

To opt in to a rule disabled by the inherited ruleset, add its fully qualified
rule name under `linter.enable` in the project's `tspconfig.yaml`. For example:

```yaml
linter:
  extends:
    - "@azure-tools/specs-typespec-rulesets/data-plane"
    - "@azure-tools/specs-typespec-rulesets/client-sdk"
  enable:
    "@azure-tools/typespec-azure-core/no-boolean": true
```

Keep the required `extends` entries. The rule name belongs to the library that
defines the rule, not this wrapper package. To enable a rule repository-wide,
add the same `enable` entry to the appropriate ruleset in `index.ts`.
