# `eng` directory

The `eng` directory contains source code for automated tooling running on this repository pull requests.

For context on this directory, see [Design guidelines for spec repos validation tooling] (Microsoft-internal).

## Code conventions

Below are code convention we strive to follow in `eng` directory:

### package.json

- We align `package.json` dependencies versions across all `package.json` files.
- We align `package.json` dependencies numbers with [microsoft/typespec package.json].
  In few cases we allow more frequent update cadence.
- We avoid doing package overrides where possible.
- We order `package.json` keys as follows: `name private type main bin scripts engines dependencies devDependencies`.

### pnpm and the lock file

- This repo uses [pnpm] workspaces. **Do not use `npm` or `yarn`.** Running
  `npm install`, `npm ci`, or `yarn` fails fast (npm cannot resolve the `catalog:` and
  `workspace:` dependency protocols), so contributors must use pnpm.
- You must have pnpm installed globally on your machine. The simplest way is to run
  `npm run install-pnpm`, which installs the exact pinned pnpm version via
  `npm install -g pnpm@<version>` (the version is read from the root `package.json`
  `packageManager` field). The command is idempotent and supports `--dry-run`. You can
  also install pnpm yourself with `npm install -g pnpm`.
- Once a global pnpm exists, the `packageManager` field keeps it on the pinned version:
  pnpm self-versions, so running any `pnpm` command auto-downloads and switches to the
  pinned version. This only works when pnpm is already installed — it cannot bootstrap
  the initial install, which is what `npm run install-pnpm` is for.
- Install dependencies from the repo root with `pnpm install`. There is a single
  top-level `pnpm-lock.yaml`; do not add other lock files.
- We maintain a single `pnpm-workspace.yaml` at the root that lists workspace packages
  and a shared dependency `catalog:`. Align dependency versions through the catalog
  rather than per-package version strings where possible.
- When you add, modify, or remove `package.json` dependencies, run `pnpm install` and
  commit the resulting `pnpm-lock.yaml` changes so the lock file stays in sync and free
  of unused dependencies.
- CI installs the pinned pnpm version via `.github/actions/setup-node-install-deps`
  (which reads the `packageManager` field) and runs `pnpm ci`.

## Linting and formatting

- Run `pnpm lint` from the repository root to lint all code in `.github` and `eng/tools`
  in one oxlint invocation. Use `pnpm lint:fix` to apply safe fixes.
- The root `.oxlintrc.json` is the single lint configuration. It preserves the previous
  ESLint recommended and TypeScript recommended type-checked rules, with type-aware
  linting provided by `oxlint-tsgolint`. Duplicate arguments and octal literals are
  rejected by strict-mode parsing instead of separate lint rules.
- `.github/workflows/lint.yaml` runs linting once on Linux for all packages, outside
  the package/OS test matrices. Package workflows still run type checks and tests;
  they must not invoke code linting again. Package-local `pnpm lint` scripts
  remain available for development.
- Existing violations in the previously unlinted `openapi-diff-runner`, `sdk-suppressions`,
  `summarize-impact`, and `typespec-migration-validation` packages are baselined with
  rule-specific `oxlint-disable-next-line` comments, or scoped disable/enable pairs for
  multiline expressions, marked `Existing lint debt`. These suppress only the existing
  locations, not entire packages. Remove each suppression when fixing the underlying
  violation; unused suppressions fail linting. Do not extend the baseline to new code.
  Pre-existing suppressions in other
  packages are retained.
- Discuss any desired rule divergences and explain them in the configuration.
- Run `pnpm format` or `pnpm format:check` from the repository root to format or
  check `.github` and `eng/tools` in one Oxfmt invocation. Package-local commands
  remain available and inherit the root `.oxfmtrc.json`.
- `.github/workflows/format.yaml` checks formatting once on Linux, outside the
  package/OS test matrices. Do not add formatting steps to individual package CI jobs.
- Tooling uses a line width of 100 with the existing fixture, generated-file, and
  unmanaged-content exclusions. Import organization and package.json sorting are
  intentionally disabled; lint/type checks still report unused imports.
- Swagger/OpenAPI definitions and examples under `specification/**/*.json` are
  excluded from formatting, including editor and explicit CLI requests.
  TypeSpec validation retains `tsp format` for `.tsp` files and uses Oxfmt for
  `tspconfig.yaml` with a line width of 80.
- Install the recommended Oxc VS Code extension for tooling formatting, and retain
  the TypeSpec extension for `.tsp` files. Prettier can still appear as an upstream
  dependency or bundled implementation detail; it is not a repository formatter.

[pnpm]: https://pnpm.io
[Design guidelines for spec repos validation tooling]: https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/1153/Design-guidelines-for-spec-repos-validation-tooling
[microsoft/typespec package.json]: https://github.com/microsoft/typespec/blob/main/package.json
[npm/cli #7384]: https://github.com/npm/cli/issues/7384
