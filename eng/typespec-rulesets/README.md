# TypeSpec linter rulesets

The private workspace package `@azure-tools/typespec-azure-rulesets` centralizes
the linter policy for every TypeSpec project in this repository. Run `pnpm install`
from the repository root to make it available; it is not published to npm.
It uses the upstream package's name so existing `tspconfig.yaml` references,
templates, and validation remain unchanged.

The upstream npm package is installed with the alias
`@azure-tools/typespec-azure-rulesets-original`. Each repository-owned ruleset
extends the corresponding upstream ruleset through that alias, preserving the
enabled rules until overrides are added here. Keep the alias in both the root
and this package's dependencies: TypeSpec resolves inherited rulesets from the
specification project, not from the package defining the ruleset.

TypeSpec projects continue to reference the named rulesets from `tspconfig.yaml`:

```yaml
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/resource-manager"
    - "@azure-tools/typespec-azure-rulesets/client-sdk"
```

Use `/data-plane` or `/resource-manager` according to the API plane.
Projects configured with client emitters also extend `/client-sdk`.
The canonical examples are the [data-plane Widget template](../../specification/widget/data-plane/WidgetAnalytics/tspconfig.yaml)
and [ARM Widget template](../../specification/widget/resource-manager/Microsoft.Widget/Widget/tspconfig.yaml).

## Enable a rule repository-wide

Update the appropriate entry in `$linter.ruleSets` in `index.ts`: `data-plane`
for data-plane API rules, `resource-manager` for ARM API rules, or `client-sdk`
for SDK rules. Add the rule's fully qualified name to that entry's `enable`
map, keeping its upstream `extends` entry and any existing overrides.

For example, to enable `no-boolean` for every data-plane project:

```ts
"data-plane": {
  extends: ["@azure-tools/typespec-azure-rulesets-original/data-plane"],
  enable: {
    "@azure-tools/typespec-azure-core/no-boolean": true,
  },
},
```

The rule name belongs to the library that defines the rule, not this wrapper
package. No changes to individual `tspconfig.yaml` files are needed. Keep rule
policy centralized here rather than asking services to opt in individually.

Before submitting a ruleset change, run `pnpm --filter @azure-tools/typespec-azure-rulesets build`
and `pnpm --filter @azure-tools/typespec-validation check`, then validate affected
projects with TypeSpec Validation to assess the new diagnostics.
