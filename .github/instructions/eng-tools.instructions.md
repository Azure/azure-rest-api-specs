---
applyTo:
  - "eng/tools/**"
---

# GitHub Copilot Instructions for eng/tools Code

This file provides instructions for GitHub Copilot when working with the engineering tools in the `eng/tools` directory of this repository. These tools are completely separate from the TypeSpec and OpenAPI specification work that makes up the majority of this repository.

Read the affected tool and a sibling tool before editing. Follow the shared conventions below and the affected package's scripts, keeping changes surgical and focused.

## Overview

The `eng/tools` directory contains a collection of standalone Node.js packages used by CI and by spec authors. Each subdirectory is its own npm package (`@azure-tools/<name>`) with its own `package.json`, tests, and CLI entry point(s). Examples include:

- `lint-diff`
- `oav-runner`
- `openapi-diff-runner`
- `sdk-suppressions`
- `spec-gen-sdk-runner`
- `summarize-impact`
- `suppressions`
- `tsp-client-tests`
- `typespec-migration-validation`
- `typespec-requirement`
- `typespec-validation`

The top-level `eng/tools` directory holds shared configuration that the individual packages extend:

- `package.json` — aggregates every tool as a `workspace:*` devDependency and provides a root `build` script
- `tsconfig.json` — base TypeScript config plus the `include` list of every tool's `src`/`test` files
- Lint configuration is shared by all packages in the repository-root `.oxlintrc.json`
- `vitest.base.config.ts` — base Vitest config that each tool extends
- Root `.oxfmtrc.json` — shared Oxfmt configuration and subtree-scoped ignore patterns

## Technology Stack

- **Language**: TypeScript (`.ts` files, executed directly by Node via type stripping — there is no separate compile/emit step)
- **Runtime**: Node.js >=24.14.1; CI uses Node 24 on Ubuntu and Windows
- **Type Checking**: `tsc --noEmit` (the `build` script only type-checks; it does not emit JavaScript)
- **Testing**: Vitest for unit and integration tests
- **Linting**: oxlint with type-aware rules from `oxlint-tsgolint`
- **Formatting**: Oxfmt using the root `.oxfmtrc.json`; import organization and package.json sorting are disabled
- **Package Manager**: pnpm workspaces (`pnpm ci` for clean installs)

## Project Structure

```
eng/tools/
├── package.json               # Aggregates all tools as workspace:* devDependencies; root "build"
├── tsconfig.json              # Base TS config + include list for all tools
├── vitest.base.config.ts      # Base Vitest config (extended per tool)
└── <tool>/                    # One directory per tool package
    ├── package.json           # @azure-tools/<tool>; scripts, deps, bin entry
    ├── tsconfig.json          # Extends ../tsconfig.json; include src/test
    ├── vitest.config.ts       # Extends ../vitest.base.config.ts
    ├── README.md              # Optional, recommended for user-facing tools
    ├── cmd/                   # Thin CLI wrappers (*.js) declared under package.json "bin"
    ├── src/                   # TypeScript source
    └── test/                  # Vitest test files (and fixtures)
```

## Coding Standards

### TypeScript Style

- **File extension**: Source is `.ts`. CLI wrappers in `cmd/` are `.js` (thin launchers, see below).
- **Module system**: ES modules (`import`/`export`), `"type": "module"` in every `package.json`.
- **Erasable syntax only**: Source is run directly by Node's type stripping, so the base `tsconfig.json` sets `erasableSyntaxOnly` and `verbatimModuleSyntax`. Do **not** use TypeScript features that require runtime transformation — no `enum`, no parameter properties (`constructor(private x)`), no namespaces with runtime members, and no non-`import type` type-only imports that would emit. Use `import type { ... }` for type-only imports.
- **Import extensions**: Import local modules using their real `.ts` extension (e.g. `import { main } from "../src/index.ts"`); `allowImportingTsExtensions` is enabled.
- **Indentation**: 2 spaces (enforced by Oxfmt).
- **Quote style**: Double quotes for strings (enforced by Oxfmt).
- **Line length**: Max 100 characters (`printWidth: 100`, enforced by Oxfmt).
- **Naming conventions**:
  - Functions and variables: `camelCase`
  - Types, interfaces, and classes: `PascalCase`
  - Files: `kebab-case.ts` or `camelCase.ts`
- **Exports**: Prefer named exports over default exports.

### Shared Utilities

- Reuse `@azure-tools/specs-shared` (referenced as `workspace:*`) instead of duplicating helpers such as logging, git, or changed-file utilities.

## Per-Tool Configuration

Every tool package is a thin extension of the shared `eng/tools` configuration. When creating a new tool, mirror an existing one (for example `typespec-validation` or `suppressions`):

### `package.json`

```jsonc
{
  "name": "@azure-tools/<tool>",
  "private": true,
  "type": "module",
  "main": "src/index.ts",
  "bin": {
    "<command>": "cmd/<command>.js"
  },
  "scripts": {
    "build": "tsc --noEmit",
    "check": "pnpm run build && pnpm run lint && pnpm run format:check && pnpm run test:ci",
    "format": "oxfmt . --write",
    "format:check": "oxfmt . --check",
    "lint": "oxlint .",
    "test": "vitest",
    "test:ci": "vitest run --coverage --reporter=verbose"
  },
  "engines": {
    "node": ">=24.14.1"
  }
}
```

- Reference external dependency versions with `catalog:`. Define their versions in the default `catalog` in the root `pnpm-workspace.yaml`, including dependencies used by only one tool.
- Keep internal package references as `workspace:*`; do not put workspace links in the catalog.

### `tsconfig.json`

```jsonc
{
  "extends": "../tsconfig.json",
  "include": ["src/**/*.ts", "test/**/*.ts"]
}
```

### Lint configuration

Use the repository-root `.oxlintrc.json`; do not add per-tool lint configurations or
dependencies. The root package provides `oxlint` and `oxlint-tsgolint`. A local
`"lint": "oxlint ."` script can lint one tool during development; `pnpm lint` from
the repository root lints the enabled packages in one invocation.

See [the engineering guide](../../eng/README.md#linting-and-formatting) for the
packages not yet linted. Enable linting for those packages in a separate change
rather than adding blanket suppressions.

### Vitest config

Use `vitest.config.ts` and re-export the shared base:

```typescript
export { baseConfig as default } from "../vitest.base.config.ts";
```

For tool-specific options such as `testTimeout` or coverage exclusions, use Vitest's `mergeConfig` to extend the base. Tests must live under `./test`. Keep explicit per-tool configs: Vitest 5 does not search ancestor directories for a config.

### CLI wrappers (`cmd/`)

CLI entry points are thin `.js` launchers that import the TypeScript source and invoke `main()`:

```javascript
#!/usr/bin/env node

import { main } from "../src/index.ts";

await main();
```

Declare each wrapper under the package's `bin` field. In CI, tools are invoked via `node eng/tools/<tool>/cmd/<command>.js ...`.

## Build, Test, and Validation

### Available pnpm Scripts

Run these from within an individual tool directory (`eng/tools/<tool>`):

```bash
pnpm run build           # Type-check with tsc --noEmit (no JS emitted)
pnpm run check           # build + lint + format:check + test:ci
pnpm run lint            # Run oxlint for this package
pnpm run format          # Format code with Oxfmt
pnpm run format:check    # Check formatting without modifying files
pnpm run test            # Run tests (watch by default; some tools use --run)
pnpm run test:ci         # Run tests once with coverage report
```

From the `eng/tools` directory, `pnpm run build` type-checks all tools at once.

Use `pnpm run format` rather than adjusting formatting manually.

### Before Committing

Run `pnpm run check` from each affected tool directory. All applicable type, lint, formatting, and test checks must pass before committing. If the tool has no `check` script, run its `build`, `format:check`, and `test:ci` scripts, plus `lint` if defined. Keep the existing central lint coverage and exclusions.

### Testing Conventions

Cover new or changed behavior and bug regressions with focused tests of repository-owned behavior and integration contracts. Reuse adequate existing coverage for mechanical refactors and dependency/API substitutions; add tests for uncovered repository behavior or compatibility risks, not to reproduce upstream test matrices. Preserve configured coverage requirements and justify removing existing tests.

- **Framework**: Vitest
- **Test files**: `*.test.ts` files under each tool's `test/` directory
- **Fixtures**: Place test fixtures under `test/` (the root `.oxfmtrc.json` excludes `fixtures` and `specification` directories under tooling)
- **Assertions**: Use `expect()` from Vitest
- **Coverage**: Generated by `pnpm run test:ci`; exclude `cmd/**` and entry files (e.g. `src/index.ts`) from coverage where appropriate
- **Test structure**: Use `describe()` and `it()` blocks

### CI Integration

Each tool is tested by a dedicated workflow (`.github/workflows/<tool>-test.yaml`) that calls the shared reusable workflow `.github/workflows/_reusable-eng-tools-test.yaml`. The reusable workflow runs `pnpm run build` and `pnpm run test:ci` against the tool's `working-directory`, on a matrix of Ubuntu (Node 24) and Windows (Node 24).

`.github/workflows/format.yaml` runs `pnpm format:check` once from the repository root for `.github` and `eng/tools`. Do not add formatting steps to package/OS test matrices. Package-local formatting commands remain available and use the same root configuration.

Code linting runs once for all packages in `.github/workflows/lint.yaml`, which automatically includes new tools. Do not add lint steps or a lint input to the per-package reusable workflow.

## Common Tasks

### Adding a New Tool

1. Create `eng/tools/<tool>/` with `src/`, `test/`, and `cmd/` directories.
2. Add `package.json` (name `@azure-tools/<tool>`, `"type": "module"`, scripts and `engines` matching the template above).
3. Add `tsconfig.json` extending `../tsconfig.json`.
4. Use the repository-root `.oxlintrc.json` without adding a per-tool lint config.
5. Add `vitest.config.ts` extending `../vitest.base.config.ts`.
6. Add CLI wrapper(s) under `cmd/` and declare them in the `bin` field.
7. Register the package in `eng/tools/package.json` (`workspace:*` devDependency) and `eng/tools/tsconfig.json` (`include` globs).
8. Add a `.github/workflows/<tool>-test.yaml` workflow calling `_reusable-eng-tools-test.yaml` with `package: <tool>`. Include relevant `paths` filters, at minimum `eng/tools/package.json`, `eng/tools/tsconfig.json`, and `eng/tools/<tool>/**`.
9. Run the [required checks](#before-committing) in the new tool directory.

### Updating Dependencies

1. Update the dependency's version in the root `pnpm-workspace.yaml` catalog, leaving the tool's `package.json` reference as `catalog:`. Preserve exact pins where used.
2. For a new dependency, add a catalog entry and reference it with `catalog:` in the appropriate dependency section. Reuse an existing entry rather than adding a second version.
3. Run `pnpm install` from the repository root and include the generated `pnpm-lock.yaml` with the catalog change; do not edit the lockfile manually. Preserve overrides, release-age settings, and build allowlists.
4. Run the [required checks](#before-committing) for affected tools, including consumers of shared dependencies.
5. Separate mechanical catalog changes from version upgrades that require source changes or alter output. Review resolved and transitive lockfile changes, not just manifest ranges.

Only use catalog references in projects included in `pnpm-workspace.yaml`.

## Related Files

- Main Copilot instructions: [`.github/copilot-instructions.md`](../copilot-instructions.md)
- GitHub Actions instructions: [`github-actions.instructions.md`](./github-actions.instructions.md)
- Other instruction files: [`.github/instructions/`](.)
- Reusable test workflow: [`.github/workflows/_reusable-eng-tools-test.yaml`](../workflows/_reusable-eng-tools-test.yaml)
- Vitest docs: https://vitest.dev/
- oxlint docs: https://oxc.rs/docs/guide/usage/linter
