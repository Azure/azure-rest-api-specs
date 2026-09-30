# Foundry Core TypeSpec library

`@azure-tools/typespec-foundry-core` provides shared TypeSpec definitions in the
`Microsoft.Foundry.Core` namespace and an opt-in demo linter. The TypeSpec
definitions currently contain only the namespace; shared models and operations
will be added separately.

## Development

From the repository root:

```bash
pnpm install
pnpm --filter @azure-tools/typespec-foundry-core build
pnpm --filter @azure-tools/typespec-foundry-core test:ci
```

**No build is required to use or edit the library in this repository.** Workspace
JavaScript imports resolve directly to `src/index.ts`; Node 24 executes the
TypeScript through native type stripping. Keep source imports as `.ts` and use
erasable TypeScript syntax. No loader, watch process, or generated JavaScript is
needed during development.

The build type-checks with `tsc --noEmit`, then runs
`tsp compile . --import @typespec/library-linter --warn-as-error`, also without
output. Library linting and warnings-as-errors apply only to the build script,
not to `tspconfig.yaml`. Root `pnpm build`, `pnpm lint`, and `pnpm test:ci` include
this library.

The package tests use native Node subprocesses to check both source loading
through a workspace link with no `dist/` directory and the packed JavaScript
inside a real `node_modules` directory.

Format TypeSpec sources with:

```bash
pnpm exec tsp format "libs/foundry-core/**/*.tsp"
```

## Usage

Once published, install the package alongside a compatible `@typespec/compiler`
and import it:

```typespec
import "@azure-tools/typespec-foundry-core";

using Microsoft.Foundry.Core;
```

Specs in this repository resolve the workspace package through the root
dependency after `pnpm install`.

## Demo linter

The opt-in `use-standard-operations` rule is adapted from the MIT-licensed
[Foundry demo library](https://github.com/timotheeguerin/foundry-demo-lib/blob/main/packages/foundry-core/src/rules/use-standard-operations.ts).
It follows operation ancestry to approved, library-owned
`Microsoft.Foundry.Core.StandardOperations` job templates. Matching a template's
name or namespace alone does not qualify. Generic wrappers are supported, and
inherited-operation diagnostics point at the consuming interface.

**This is an infrastructure demo, not a production ruleset yet.** The approved
job templates have not been added to this package, so enabling the rule currently
warns on every concrete operation in scope. Tests use fixture templates to
exercise approved ancestry. The demo's service models, Azure rulesets, and casing
patch are not included.

To demonstrate a diagnostic, enable the rule in a consumer's `tspconfig.yaml`:

```yaml
linter:
  enable:
    "@azure-tools/typespec-foundry-core/use-standard-operations": true
```

For example, `op custom(): string;` produces a
`@azure-tools/typespec-foundry-core/use-standard-operations` warning. Importing
the library without enabling the rule does not activate this policy.

To restrict the demo to selected interfaces, replace `true` with options:

```yaml
linter:
  enable:
    "@azure-tools/typespec-foundry-core/use-standard-operations":
      includeInterfaces:
        - Demo.Jobs
```

Interface selectors are exact, fully qualified names, not wildcards.

## Publishing

`pnpm pack` runs `prepack` to emit JavaScript and declarations into `dist/`.
TypeScript rewrites relative `.ts` imports to `.js` in the emitted JavaScript.
pnpm's `publishConfig` overrides switch the packed `main` and `exports` to
`dist/index.js`, while the TypeSpec entrypoint remains `lib/main.tsp`.

The archive includes TypeSpec files, JavaScript, declarations, README, and license,
not implementation `.ts` files or tests. This avoids Node's restriction on
executing TypeScript inside installed `node_modules`. Packing does not modify
the workspace manifest or its source exports. Use **pnpm pack**, not npm pack,
so the manifest overrides and catalog versions are applied.

See [Publishing TypeSpec libraries](../../eng/README.md#publishing-typespec-libraries)
for the manual versioning and Azure Pipelines release workflow.
