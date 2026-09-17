---
applyTo:
  - "eng/tools/**"
---

# GitHub Copilot Instructions for eng/tools Code

This file provides instructions for GitHub Copilot when working with the engineering tools in the `eng/tools` directory of this repository. These tools are completely separate from the TypeSpec and OpenAPI specification work that makes up the majority of this repository.

All tools under `eng/tools` follow the same patterns for development and testing. When adding a new tool or modifying an existing one, match the conventions described here.

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

- `package.json` — aggregates every tool as a `file:` devDependency and provides a root `build` script
- `tsconfig.json` — base TypeScript config plus the `include` list of every tool's `src`/`test` files
- Lint configuration is shared by all packages in the repository-root `.oxlintrc.json`
- `vitest.base.config.js` — base Vitest config that each tool extends
- Root `.oxfmtrc.json` — shared Oxfmt configuration and subtree-scoped ignore patterns

## Technology Stack

- **Language**: TypeScript (`.ts` files, executed directly by Node via type stripping — there is no separate compile/emit step)
- **Runtime**: Node.js >= 22.18.0 (CI runs on Node 22 for ubuntu and Node 24 for windows)
- **Type Checking**: `tsc --noEmit` (the `build` script only type-checks; it does not emit JavaScript)
- **Testing**: Vitest for unit and integration tests
- **Linting**: oxlint with type-aware rules from `oxlint-tsgolint`
- **Formatting**: Oxfmt using the root `.oxfmtrc.json`; import organization and package.json sorting are disabled
- **Package Manager**: pnpm workspaces (`pnpm ci` for clean installs)

## Project Structure

```
eng/tools/
├── package.json               # Aggregates all tools as file: devDependencies; root "build"
├── tsconfig.json              # Base TS config + include list for all tools
├── vitest.base.config.js      # Base Vitest config (extended per tool)
└── <tool>/                    # One directory per tool package
    ├── package.json           # @azure-tools/<tool>; scripts, deps, bin entry
    ├── tsconfig.json          # Extends ../tsconfig.json; include src/test
    ├── vitest.config.js       # Extends ../vitest.base.config.js (or vitest.config.ts / vite.config.ts)
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

- Reuse `@azure-tools/specs-shared` (referenced as `file:../../../.github/shared`) instead of duplicating helpers such as logging, git, or changed-file utilities.
- Tools may depend on each other via `file:` references (for example `typespec-validation` depends on `suppressions`).

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
    "node": ">=22.18.0"
  }
}
```

- Reference external dependency versions with `catalog:`. Define their versions in the default `catalog` in the root `pnpm-workspace.yaml`, including dependencies used by only one tool.
- Keep internal package references as `workspace:*`; do not put workspace links in the catalog.
- Add the new package to the root `eng/tools/package.json` `devDependencies` as a `file:<tool>` entry.

### `tsconfig.json`

```jsonc
{
  "extends": "../tsconfig.json",
  "include": ["src/**/*.ts", "test/**/*.ts"]
}
```

- Also add the new package's `src` and `test` globs to the `include` list in `eng/tools/tsconfig.json`.

### Lint configuration

Use the repository-root `.oxlintrc.json`; do not add per-tool lint configurations or
dependencies. The root package provides `oxlint` and `oxlint-tsgolint`. A local
`"lint": "oxlint ."` script can lint one tool during development; `pnpm lint` from
the repository root lints the previously linted packages in one invocation.

See [the engineering guide](../../eng/README.md#linting-and-formatting) for the
packages excluded to preserve the previous ESLint coverage. Enable linting for
those packages in a separate change rather than adding migration-only suppressions.

### Vitest config

Extend the shared base (`vitest.config.js`) or define a tool-specific config (`vitest.config.ts` / `vite.config.ts`) when you need extra options such as `testTimeout` or custom coverage excludes. Tests must live under `./test`.

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
pnpm run check           # build + lint + format:check + test:ci (run this before committing)
pnpm run lint            # Run oxlint for this package
pnpm run format          # Format code with Oxfmt
pnpm run format:check    # Check formatting without modifying files
pnpm run test            # Run tests (watch by default; some tools use --run)
pnpm run test:ci         # Run tests once with coverage report
```

From the `eng/tools` directory, `pnpm run build` type-checks all tools at once.

### Before Committing

From the directory of each tool you changed, run:

```bash
pnpm run check
```

This runs the type-check, lint, format check, and tests. All must pass before committing. If a tool does not yet define a `check` script, run `build`, `lint`, `format:check`, and `test:ci` individually.

### Testing Conventions

- **Framework**: Vitest
- **Test files**: `*.test.ts` files under each tool's `test/` directory
- **Fixtures**: Place test fixtures under `test/` (the root `.oxfmtrc.json` excludes `fixtures` and `specification` directories under tooling)
- **Assertions**: Use `expect()` from Vitest
- **Coverage**: Generated by `pnpm run test:ci`; exclude `cmd/**` and entry files (e.g. `src/index.ts`) from coverage where appropriate
- **Test structure**: Use `describe()` and `it()` blocks

Example test structure:

```typescript
import { describe, expect, it } from "vitest";
import { myFunction } from "../src/my-module.ts";

describe("myFunction", () => {
  it("should do something", async () => {
    const result = await myFunction({ option: "value" });
    expect(result).toEqual(expectedValue);
  });
});
```

### CI Integration

Each tool is tested by a dedicated workflow (`.github/workflows/<tool>-test.yaml`) that calls the shared reusable workflow `.github/workflows/_reusable-eng-tools-test.yaml`. The reusable workflow runs `pnpm run build` and `pnpm run test:ci` against the tool's `working-directory`, on a matrix of Ubuntu (Node 24) and Windows (Node 24).

`.github/workflows/format.yaml` runs `pnpm format:check` once from the repository root for `.github` and `eng/tools`. Do not add formatting steps to package/OS test matrices. Package-local formatting commands remain available and use the same root configuration.

Code linting runs once for all packages in `.github/workflows/lint.yaml`. Do not add
lint steps or a lint input to the per-package reusable workflow.

When adding a new tool:

1. Add a `<tool>-test.yaml` workflow that calls `_reusable-eng-tools-test.yaml` with `package: <tool>`. The central lint workflow automatically includes new tools.
2. List the relevant `paths` filters (at minimum `eng/tools/package.json`, `eng/tools/tsconfig.json`, and `eng/tools/<tool>/**`) so the workflow runs when the tool changes.

## Common Tasks

### Adding a New Tool

1. Create `eng/tools/<tool>/` with `src/`, `test/`, and `cmd/` directories.
2. Add `package.json` (name `@azure-tools/<tool>`, `"type": "module"`, scripts and `engines` matching the template above).
3. Add `tsconfig.json` extending `../tsconfig.json`.
4. Use the repository-root `.oxlintrc.json` without adding a per-tool lint config.
5. Add a Vitest config (extend `../vitest.base.config.js` or provide a tool-specific config).
6. Add CLI wrapper(s) under `cmd/` and declare them in the `bin` field.
7. Register the package in `eng/tools/package.json` (`workspace:*` devDependency) and `eng/tools/tsconfig.json` (`include` globs).
8. Add a `.github/workflows/<tool>-test.yaml` workflow calling `_reusable-eng-tools-test.yaml`.
9. Run `pnpm run check` in the new tool directory.

### Updating Dependencies

1. Update the dependency's version in the root `pnpm-workspace.yaml` catalog, leaving the tool's `package.json` reference as `catalog:`. Preserve exact pins where used.
2. For a new dependency, add a catalog entry and reference it with `catalog:` in the appropriate dependency section. Reuse an existing entry rather than adding a second version.
3. Run `pnpm install` from the repository root and include the generated `pnpm-lock.yaml` with the catalog change. Preserve overrides, release-age settings, and build allowlists.
4. Run the affected tools' checks, including consumers of shared dependencies. Tools without a `check` script need their available build, lint, formatting, and test commands run explicitly.
5. Separate mechanical catalog changes from version upgrades that require source changes or alter output. Review resolved and transitive lockfile changes, not just manifest ranges.

Only use catalog references in projects included in `pnpm-workspace.yaml`.

## For AI Agents

When modifying `eng/tools` code:

1. **Read existing code first**: Match the conventions of a sibling tool before changing anything.
2. **Run checks locally**: Always run `pnpm run check` in the affected tool directory before committing.
3. **Update tests**: Add or modify tests when changing functionality.
4. **Preserve typing**: Keep code fully typed and free of `tsc --noEmit` errors.
5. **Follow conventions**: Match the existing structure, scripts, and config layout.
6. **Minimize changes**: Make surgical, focused changes.
7. **Keep config in sync**: When adding a tool, update both `eng/tools/package.json` and `eng/tools/tsconfig.json`.

### Critical Don'ts

- ❌ Don't use non-erasable TypeScript syntax (`enum`, parameter properties, runtime namespaces) — Node runs the `.ts` directly via type stripping.
- ❌ Don't emit JavaScript from `tsc`; `build` is `tsc --noEmit` (type-check only).
- ❌ Don't commit without running `pnpm run check`.
- ❌ Don't edit `pnpm-lock.yaml` manually (use `pnpm install`).
- ❌ Don't change formatting manually (use `pnpm run format`).
- ❌ Don't forget to register a new tool in `eng/tools/package.json` and `eng/tools/tsconfig.json`.

### Critical Do's

- ✅ Do extend the shared base configs (`tsconfig`, `vitest.base.config.js`) and use the root oxlint and Oxfmt configs.
- ✅ Do write Vitest tests for new functionality under `test/`.
- ✅ Do use `import type` for type-only imports.
- ✅ Do reuse `@azure-tools/specs-shared` utilities instead of duplicating them.
- ✅ Do add a `<tool>-test.yaml` workflow for any new tool.
- ✅ Do run `pnpm run check` before committing.

## Related Files

- Main Copilot instructions: [`.github/copilot-instructions.md`](../copilot-instructions.md)
- GitHub Actions instructions: [`github-actions.instructions.md`](./github-actions.instructions.md)
- Other instruction files: [`.github/instructions/`](.)
- Reusable test workflow: [`.github/workflows/_reusable-eng-tools-test.yaml`](../workflows/_reusable-eng-tools-test.yaml)
- Vitest docs: https://vitest.dev/
- oxlint docs: https://oxc.rs/docs/guide/usage/linter
