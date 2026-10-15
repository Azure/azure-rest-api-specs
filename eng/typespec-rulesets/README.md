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

## SDK generation compatibility

The private workspace package is not available when SDK automation copies a
TypeSpec project into an SDK repository. Projects that are actively validated
by that automation may temporarily extend the equivalent published
`@azure-tools/typespec-azure-rulesets` rulesets instead. The repository-owned
rulesets currently extend those published rulesets without overrides, and
TypeSpec Validation accepts either form.

## Enable a rule repository-wide

Update the appropriate entry in `$linter.ruleSets` in `index.ts`: `data-plane`
for data-plane API rules, `resource-manager` for ARM API rules, or `client-sdk`
for SDK rules. Add the rule's fully qualified name to that entry's `enable`
map, keeping its upstream `extends` entry and any existing overrides.

For example, to enable `no-boolean` for every data-plane project:

```ts
export const $linter = defineLinter({
  rules: [],
  ruleSets: {
    "data-plane": {
      extends: ["@azure-tools/typespec-azure-rulesets/data-plane"],
      enable: {
        "@azure-tools/typespec-azure-core/no-boolean": true,
      },
    },
    "resource-manager": {
      extends: ["@azure-tools/typespec-azure-rulesets/resource-manager"],
    },
    "client-sdk": {
      extends: ["@azure-tools/typespec-azure-rulesets/client-sdk"],
    },
  },
});
```

The rule name belongs to the library that defines the rule, not this wrapper
package. Projects already extend the repository-owned rulesets, so no changes to
individual `tspconfig.yaml` files are needed. Keep rule policy centralized here
rather than asking services to opt in individually.

Before submitting a ruleset change, run `pnpm --filter @azure-tools/specs-typespec-rulesets build`
and `pnpm --filter @azure-tools/typespec-validation check`, then validate affected
projects with TypeSpec Validation to assess the new diagnostics.
