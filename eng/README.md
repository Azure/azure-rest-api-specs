# `eng` directory

The `eng` directory contains source code for automated tooling running on this repository pull requests.

For context on this directory, see [Design guidelines for spec repos validation tooling] (Microsoft-internal).

## Code conventions

Below are code convention we strive to follow in `eng` directory:

### package.json

- We align `package.json` dependencies versions across all `package.json` files.
- We align `package.json` dependencies numbers with [microsoft/typespec package.json].
  In few cases we allow more frequent update cadence.
- We avoid doing package overrides. For example, we use `v8` of `eslint` instead of `v9` to avoid an override.
  [See this comment for details][eslint override].
- We order `package.json` keys as follows: `name private type main bin scripts engines dependencies devDependencies`.

### pnpm and the lock file

- This repo uses [pnpm] workspaces. **Do not use `npm` or `yarn`.** Running
  `npm install`, `npm ci`, or `yarn` fails fast with an `EBADDEVENGINES` error that
  tells you to use pnpm — this is enforced by the `devEngines.packageManager` field in
  the root `package.json`.
- You do **not** need to install pnpm manually. The root `package.json` pins the pnpm
  version (`devEngines.packageManager.version`) with `onFail: "download"`, so pnpm
  self-versions: the first time you run any `pnpm` command it auto-downloads and
  switches to the pinned version.
- Install dependencies from the repo root with `pnpm install`. There is a single
  top-level `pnpm-lock.yaml`; do not add other lock files.
- We maintain a single `pnpm-workspace.yaml` at the root that lists workspace packages
  and a shared dependency `catalog:`. Align dependency versions through the catalog
  rather than per-package version strings where possible.
- When you add, modify, or remove `package.json` dependencies, run `pnpm install` and
  commit the resulting `pnpm-lock.yaml` changes so the lock file stays in sync and free
  of unused dependencies.
- CI installs the pinned pnpm version via `.github/actions/setup-node-install-deps`
  (which reads `devEngines.packageManager.version`) and runs
  `pnpm install --frozen-lockfile`.

## Linting and prettier

- We make eslint-based linting rules and prettier mandatory in CI for all projects.
- We use strict rulesets as baseline.
- We discuss any desired rule divergences from the strict ruleset
  and apply rule modifications to the configs with explanation for our decision.
- We align `prettier` rules with [microsoft/typespec .prettierrc.json].

[pnpm]: https://pnpm.io
[Design guidelines for spec repos validation tooling]: https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/1153/Design-guidelines-for-spec-repos-validation-tooling
[eslint override]: https://github.com/Azure/azure-rest-api-specs/pull/29820#pullrequestreview-2177045580
[microsoft/typespec .prettierrc.json]: https://github.com/microsoft/typespec/blob/main/.prettierrc.json
[microsoft/typespec package.json]: https://github.com/microsoft/typespec/blob/main/package.json
[npm/cli #7384]: https://github.com/npm/cli/issues/7384
