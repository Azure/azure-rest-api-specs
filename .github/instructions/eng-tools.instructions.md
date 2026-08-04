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
- `eslint.base.config.js` — base ESLint config that each tool extends
- `vitest.base.config.js` — base Vitest config that each tool extends
- `.prettierrc.yaml` / `.prettierignore` — shared Prettier configuration

## Technology Stack

- **Language**: TypeScript (`.ts` files, executed directly by Node via type stripping — there is no separate compile/emit step)
- **Runtime**: Node.js >= 22.18.0 (CI runs on Node 22 for ubuntu and Node 24 for windows)
- **Type Checking**: `tsc --noEmit` (the `build` script only type-checks; it does not emit JavaScript)
- **Testing**: Vitest for unit and integration tests
- **Linting**: ESLint (flat config) with TypeScript-aware rules
- **Formatting**: Prettier with the organize-imports plugin (shared config)
- **Package Manager**: npm (`npm ci` for clean installs)

## Project Structure

```
eng/tools/
├── package.json               # Aggregates all tools as file: devDependencies; root "build"
├── tsconfig.json              # Base TS config + include list for all tools
├── eslint.base.config.js      # Base ESLint config (extended per tool)
├── vitest.base.config.js      # Base Vitest config (extended per tool)
├── .prettierrc.yaml           # Shared Prettier config (keep in sync with .github)
├── .prettierignore            # Shared Prettier ignore list
└── <tool>/                    # One directory per tool package
    ├── package.json           # @azure-tools/<tool>; scripts, deps, bin entry
    ├── tsconfig.json          # Extends ../tsconfig.json; include src/test
    ├── eslint.config.js       # Extends ../eslint.base.config.js
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
- **Indentation**: 2 spaces (enforced by Prettier).
- **Quote style**: Double quotes for strings (enforced by Prettier).
- **Line length**: Max 100 characters (`printWidth: 100`, enforced by Prettier).
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
    "check": "npm run build && npm run lint && npm run format:check && npm run test:ci",
    "format": "prettier . --ignore-path ../.prettierignore --write",
    "format:check": "prettier . --ignore-path ../.prettierignore --check",
    "format:check:ci": "prettier . --ignore-path ../.prettierignore --check --log-level debug",
    "lint": "cross-env DEBUG=eslint:eslint,eslint:linter eslint",
    "test": "vitest",
    "test:ci": "vitest run --coverage --reporter=verbose"
  },
  "engines": {
    "node": ">=22.18.0"
  }
}
```

- Keep dependency/devDependency versions aligned with the other tools (for example `typescript ~6.0.2`, `eslint ^10.0.0`, `vitest ^4.1.0`, `prettier 3.8.3`).
- Add the new package to the root `eng/tools/package.json` `devDependencies` as a `file:<tool>` entry.

### `tsconfig.json`

```jsonc
{
  "extends": "../tsconfig.json",
  "include": ["src/**/*.ts", "test/**/*.ts"]
}
```

- Also add the new package's `src` and `test` globs to the `include` list in `eng/tools/tsconfig.json`.

### `eslint.config.js`

```javascript
// @ts-check

import { defineBaseConfig } from "../eslint.base.config.js";

export default defineBaseConfig({
  // ensures the tsconfig path resolves relative to this file
  tsconfigRootDir: import.meta.dirname,
});
```

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

### Available npm Scripts

Run these from within an individual tool directory (`eng/tools/<tool>`):

```bash
npm run build           # Type-check with tsc --noEmit (no JS emitted)
npm run check           # build + lint + format:check + test:ci (run this before committing)
npm run lint            # Run ESLint
npm run format          # Format code with Prettier
npm run format:check    # Check formatting without modifying files
npm run format:check:ci # Check formatting with verbose debug output (for CI)
npm run test            # Run tests (watch by default; some tools use --run)
npm run test:ci         # Run tests once with coverage report
```

From the `eng/tools` directory, `npm run build` type-checks all tools at once.

### Before Committing

From the directory of each tool you changed, run:

```bash
npm run check
```

This runs the type-check, lint, format check, and tests. All must pass before committing. If a tool does not yet define a `check` script, run `build`, `lint`, `format:check`, and `test:ci` individually.

### Testing Conventions

- **Framework**: Vitest
- **Test files**: `*.test.ts` files under each tool's `test/` directory
- **Fixtures**: Place test fixtures under `test/` (the shared `.prettierignore` excludes `fixtures` and `specification`)
- **Assertions**: Use `expect()` from Vitest
- **Coverage**: Generated by `npm run test:ci`; exclude `cmd/**` and entry files (e.g. `src/index.ts`) from coverage where appropriate
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

Each tool is tested by a dedicated workflow (`.github/workflows/<tool>-test.yaml`) that calls the shared reusable workflow `.github/workflows/_reusable-eng-tools-test.yaml`. The reusable workflow runs `npm run build`, `npm run test:ci`, optionally `npm run lint`, and `npm run format:check:ci` against the tool's `working-directory`, on a matrix of Ubuntu (Node 22) and Windows (Node 24).

When adding a new tool:

1. Add a `<tool>-test.yaml` workflow that calls `_reusable-eng-tools-test.yaml` with `package: <tool>` (and `lint: true` to enable linting).
2. List the relevant `paths` filters (at minimum `eng/tools/package.json`, `eng/tools/tsconfig.json`, and `eng/tools/<tool>/**`) so the workflow runs when the tool changes.

## Common Tasks

### Adding a New Tool

1. Create `eng/tools/<tool>/` with `src/`, `test/`, and `cmd/` directories.
2. Add `package.json` (name `@azure-tools/<tool>`, `"type": "module"`, scripts and `engines` matching the template above).
3. Add `tsconfig.json` extending `../tsconfig.json`.
4. Add `eslint.config.js` extending `../eslint.base.config.js`.
5. Add a Vitest config (extend `../vitest.base.config.js` or provide a tool-specific config).
6. Add CLI wrapper(s) under `cmd/` and declare them in the `bin` field.
7. Register the package in `eng/tools/package.json` (`file:` devDependency) and `eng/tools/tsconfig.json` (`include` globs).
8. Add a `.github/workflows/<tool>-test.yaml` workflow calling `_reusable-eng-tools-test.yaml`.
9. Run `npm run check` in the new tool directory.

### Updating Dependencies

1. Update the tool's `package.json`.
2. Keep shared tooling versions (TypeScript, ESLint, Vitest, Prettier) aligned across tools.
3. Run `npm install` and commit the updated lock file.
4. Run `npm run check` to validate.

## For AI Agents

When modifying `eng/tools` code:

1. **Read existing code first**: Match the conventions of a sibling tool before changing anything.
2. **Run checks locally**: Always run `npm run check` in the affected tool directory before committing.
3. **Update tests**: Add or modify tests when changing functionality.
4. **Preserve typing**: Keep code fully typed and free of `tsc --noEmit` errors.
5. **Follow conventions**: Match the existing structure, scripts, and config layout.
6. **Minimize changes**: Make surgical, focused changes.
7. **Keep config in sync**: When adding a tool, update both `eng/tools/package.json` and `eng/tools/tsconfig.json`.

### Critical Don'ts

- ❌ Don't use non-erasable TypeScript syntax (`enum`, parameter properties, runtime namespaces) — Node runs the `.ts` directly via type stripping.
- ❌ Don't emit JavaScript from `tsc`; `build` is `tsc --noEmit` (type-check only).
- ❌ Don't commit without running `npm run check`.
- ❌ Don't edit `package-lock.json` manually (use `npm install`).
- ❌ Don't change formatting manually (use `npm run format`).
- ❌ Don't forget to register a new tool in `eng/tools/package.json` and `eng/tools/tsconfig.json`.

### Critical Do's

- ✅ Do extend the shared base configs (`tsconfig`, `eslint.base.config.js`, `vitest.base.config.js`, `.prettierrc.yaml`).
- ✅ Do write Vitest tests for new functionality under `test/`.
- ✅ Do use `import type` for type-only imports.
- ✅ Do reuse `@azure-tools/specs-shared` utilities instead of duplicating them.
- ✅ Do add a `<tool>-test.yaml` workflow for any new tool.
- ✅ Do run `npm run check` before committing.

## Related Files

- Main Copilot instructions: [`.github/copilot-instructions.md`](../copilot-instructions.md)
- GitHub Actions instructions: [`github-actions.instructions.md`](./github-actions.instructions.md)
- Other instruction files: [`.github/instructions/`](.)
- Reusable test workflow: [`.github/workflows/_reusable-eng-tools-test.yaml`](../workflows/_reusable-eng-tools-test.yaml)
- Vitest docs: https://vitest.dev/
- ESLint docs: https://eslint.org/
