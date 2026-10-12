# Foundry Core TypeSpec library

`@azure-tools/typespec-foundry-core` provides shared TypeSpec definitions in the
`Microsoft.Foundry.Core` namespace. The library currently includes a narrow set
of generic, reusable building blocks ported from the Azure AI Foundry data-plane
spec:

- **Scalars** (`lib/scalars.tsp`) — `FoundryTimestamp`, `FoundryDurationSeconds`,
  `FoundryDurationMilliseconds`
- **Pagination** (`lib/pagination.tsp`) — `AgentsPagedResult`,
  `PagedResultWithNextLink`, `CommonPageQueryParameters`, and the individual
  page query parameter aliases
- **Errors** (`lib/errors.tsp`) — `AzureRangeErrorResponse`
- **Foundations** (`lib/foundations.tsp`) — `FoundryDataPlaneApiVersionParameter`,
  the preview header aliases, and the low-level `Foundations.Operation` /
  `Foundations.PreviewOperation` signatures
- **Jobs** (`lib/jobs.tsp`) — `JobStatus`, `JobLike`, job response envelopes, and
  the `StandardOperations` job lifecycle templates (`PostJob`, `QueryJobStatus`,
  `ListJobs`, `CancelJob`, `DeleteJob`, and their `*Preview` variants)

OpenAI/agent-specific patterns, feature opt-in unions, job source models, and
other service-specific types remain in the spec for now and are candidates for
a later migration pass. The library also still includes an empty linter; lint
rules, and their tests can be added without further engineering setup.

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

New `test/**/*.test.ts` files are automatically included in the package tests,
root test workspace, and publishing pipeline.

Format TypeSpec sources with:

```bash
pnpm exec tsp format "libs/foundry-core/**/*.tsp"
```

## Samples

`samples/*.tsp` are small, standalone TypeSpec files that each import the
library (via a relative `../lib/main.tsp` import) and exercise one area —
pagination, error handling, and the job lifecycle templates. They are not
service specs; they exist to demonstrate usage and to catch regressions.
`test/samples.test.ts` compiles every file under `samples/` with
`@typespec/compiler`'s `compile()` and `NodeHost`, and asserts there are no
error diagnostics. Add a new `samples/*.tsp` file whenever a new area of the
library needs a worked example — it's picked up automatically.

## Usage

Once published, install the package alongside a compatible `@typespec/compiler`
and import it:

```typespec
import "@azure-tools/typespec-foundry-core";

using Microsoft.Foundry.Core;
```

Specs in this repository resolve the workspace package through the root
dependency after `pnpm install`.

## Adding a lint rule

1. Define the rule with `createRule` from `@typespec/compiler` in
   `src/rules/<rule-name>.ts`, using `.ts` imports for local modules.
2. Import and register it in the `rules` array in `src/linter.ts`.
3. Add its tests under `test/` and run the build and test commands above.

Consumers opt into rules through `linter.enable` in their `tspconfig.yaml`.
The skeleton does not register any rules or change existing service behavior.

For a worked example, including native source-loading and packed-package tests,
see the [Foundry Core POC](https://github.com/Azure/azure-rest-api-specs/pull/46849).
Its demo rule and tests are intentionally deferred from this skeleton.

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
for automatic development releases on `latest` and the manual Azure Pipelines
release workflow.
