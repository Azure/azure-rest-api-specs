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
  and a shared dependency `catalog:`. All external dependencies must reference the
  catalog with `catalog:` (or `catalog:<name>` for a named catalog); use `workspace:`
  for local workspace dependencies.
- Run `pnpm check:workspace` from the repo root to validate catalog usage and lockfile
  portability. The [Eng workflow](../.github/workflows/eng.yml) runs these checks in CI.
  It checks `dependencies`, `devDependencies`, `peerDependencies`, and
  `optionalDependencies` in the root and all packages selected by pnpm. Manifests
  outside the workspace, including test fixtures and specification projects, are
  not checked. pnpm validates catalog entries themselves during installation.
  `catalogMode: strict` only controls `pnpm add`, so it does not replace this check.
  Unused entries in default and named catalogs produce warnings, not failures.
  The lockfile check rejects explicit tarball resolutions for registry packages,
  which can point to environment-specific proxies. Git-hosted dependencies
  (`gitHosted: true`) are allowed to retain their tarball URLs.
- When you add, modify, or remove `package.json` dependencies, run `pnpm install` and
  commit the resulting `pnpm-lock.yaml` changes so the lock file stays in sync and free
  of unused dependencies.
- CI installs the pinned pnpm version via `.github/actions/setup-node-install-deps`
  (which reads the `packageManager` field) and runs `pnpm ci`.
- In repeated validation loops, run installed Node.js tools directly rather than starting
  `pnpm exec` or `npm exec` for each file or project. TypeScript consumers can use
  `execNodeBin` from `@azure-tools/specs-shared/exec`; PowerShell scripts can invoke
  `node` with a CLI entrypoint anchored to the repository or script directory. Keep pnpm
  for dependency installation and package-management operations.

## Building and testing

Run these commands from the repository root after `pnpm install`:

```bash
pnpm build       # Run each tooling package's build script with pnpm -r
pnpm test        # Run all Vitest projects (watch mode locally)
pnpm test:ci     # Run all projects once with coverage
pnpm check       # Workspace validation, build, lint, format:check, and test:ci
```

Root `pnpm build` delegates to `.github`, `.github/shared`, `eng/scripts`, and
each tool's build script. It excludes the `eng/tools` aggregate package to avoid
building the tools twice; that package's local `pnpm build` remains available.
Builds perform type checking only, with no JavaScript output.

Root `vitest.config.mts` defines one workspace using `test.projects` and exports
`defaultVitestConfig` for standalone package configs. Packages inherit shared
defaults without inheriting the workspace project list, so their existing local
Vitest commands, watch/run behavior, and coverage flags remain available:

```bash
pnpm test --project @azure-tools/typespec-validation
pnpm --filter @azure-tools/typespec-validation run test:ci
```

Shared coverage defaults exclude CLI wrappers, test code, and generated coverage.
Workspace runs write reports to root `coverage/` and enforce 100% coverage for
shared-library sources across the selected projects. Standalone runs write
reports in the package and honor local overrides, including the shared package's
independent 100% gate. The two integration-only packages retain their standalone
coverage-free commands. `typespec-migration-validation` has no Vitest project
and participates only in the root build.

The full test run requires PowerShell (`pwsh`). Test fixtures live alongside their
suites under `.github` and `eng`, or are created in temporary directories; tests
do not require the repository's `specification/` tree. Sparse checkouts only need
`.github` and `eng`, along with the root configuration files. Resolve test fixture
paths from `import.meta.dirname`, not the invocation working directory, to support both modes.
Mirrored `eng/common` packages and arbitrary specification projects are not part
of the tooling workspace.

The `.mts` extension keeps the root Vitest config as ESM without changing the
repository's default module type. Root `tsconfig.json` checks this config and is
also covered by the GitHub package build.

[Eng](../.github/workflows/eng.yml) validates the workspace, type-checks once on Linux,
and runs the Vitest workspace on Ubuntu and Windows with Node 24.
New tools do not need their own workflows. `github-test.yaml` separately verifies
production-only module imports, workflow YAML, and compiled agentic workflow locks.

## Linting and formatting

- Run `pnpm lint` from the repository root to lint the enabled packages
  in `.github` and `eng/tools`, plus root `vitest.config.mts`, in one oxlint invocation.
  Use `pnpm lint:fix` to apply
  safe fixes. File selection lives in the root `.oxlintrc.json`, so the root command
  is simply `oxlint .`; other repository folders and root-level files are excluded.
- The root `.oxlintrc.json` is the single lint configuration. It preserves the previous
  ESLint recommended and TypeScript recommended type-checked rules, with type-aware
  linting provided by `oxlint-tsgolint`. Duplicate arguments and octal literals are
  rejected by strict-mode parsing instead of separate lint rules.
- `.github/workflows/lint.yaml` runs linting once on Linux for all packages, outside
  the test OS matrix. Build/test jobs must not invoke code linting again.
  Package-local `pnpm lint` scripts
  remain available for development.
- `openapi-diff-runner` and `typespec-migration-validation`
  are excluded in the root configuration. Their type checks and tests run separately.
  Unused suppressions in linted packages fail linting.
- Discuss any desired rule divergences and explain them in the configuration.
- Run `pnpm format` or `pnpm format:check` from the repository root to format or
  check `.github`, `eng/tools`, and `vitest.config.mts` in one Oxfmt invocation. Package-local commands
  remain available and inherit the root `.oxfmtrc.json`.
- `.github/workflows/format.yaml` checks formatting once on Linux, outside the
  test OS matrix. Do not add formatting steps to build/test jobs.
- Tooling uses a line width of 100 with the existing fixture, generated-file, and
  unmanaged-content exclusions. Import organization and package.json sorting are
  intentionally disabled; lint/type checks still report unused imports.
- Swagger/OpenAPI definitions and examples under `specification/**/*.json` are
  excluded from Oxfmt. The custom Prettier plugin and root Prettier dependency
  remain in use for these JSON files, preserving numeric literals such as `100.00`.
  The existing Swagger PrettierCheck pipeline and root `.prettierrc.json` are
  unchanged. Run `pnpm exec prettier --write <path-to-example.json>` to format an
  example.
  TypeSpec validation uses `tsp format` for both `.tsp` files and `tspconfig.yaml`.
  Run `pnpm exec tsp format "../**/*.tsp" tspconfig.yaml` from the TypeSpec project
  folder to format both.
- Install the recommended Oxc VS Code extension for tooling formatting, Prettier
  for Swagger/example JSON, and the TypeSpec extension for `.tsp` files. For JSON
  excluded from Oxfmt, use **Format Document With... > Prettier** without changing
  the default formatter for tooling files.

[pnpm]: https://pnpm.io
[Design guidelines for spec repos validation tooling]: https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/1153/Design-guidelines-for-spec-repos-validation-tooling
[microsoft/typespec package.json]: https://github.com/microsoft/typespec/blob/main/package.json
[npm/cli #7384]: https://github.com/npm/cli/issues/7384
