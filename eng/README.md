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

### package-lock.json

- We maintain only top-level `package-lock.json` file. Running `npm install` from top-level dir removes the need
  to ever have other files.
- We ensure the lock file remains clean by ensuring that a PR that adds or modifies any `package.json` dependencies,
  makes changes equivalent to following protocol:
  - `cd <local-specs-clone-root>`
  - `git clean -xdf` to remove all untracked files.
  - Copy-over [`package-lock.json` from `main`] to local clone.
  - `npm install` to reflect the added or modified dependencies.
- In case any dependencies have been removed from any `package.json`, we do `rm package-lock.json` and `npm install`.  
  This way we ensure the lock file remains free of unused dependencies.
- We do `npm update` only in stand-alone PRs.
- To avoid conflicting changes when updating `package-lock.json`, only use the latest LTS version of Node, and the bundled version of npm (but no newer).  You can use `nvm install --lts` (Linux) or `nvm install lts` (Windows).

## Linting and prettier

- We make eslint-based linting rules and prettier mandatory in CI for all projects.
- We use strict rulesets as baseline.
- We discuss any desired rule divergences from the strict ruleset
  and apply rule modifications to the configs with explanation for our decision.
- We align `prettier` rules with [microsoft/typespec .prettierrc.json].

[`package-lock.json` from `main`]: https://github.com/Azure/azure-rest-api-specs/blob/main/package-lock.json
[Design guidelines for spec repos validation tooling]: https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/1153/Design-guidelines-for-spec-repos-validation-tooling
[eslint override]: https://github.com/Azure/azure-rest-api-specs/pull/29820#pullrequestreview-2177045580
[microsoft/typespec .prettierrc.json]: https://github.com/microsoft/typespec/blob/main/.prettierrc.json
[microsoft/typespec package.json]: https://github.com/microsoft/typespec/blob/main/package.json
[npm/cli #7384]: https://github.com/npm/cli/issues/7384
