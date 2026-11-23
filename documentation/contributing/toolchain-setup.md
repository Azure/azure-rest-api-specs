# Toolchain setup

For general contribution and pull request guidance, see [Contributing](../../CONTRIBUTING.md).

## Prerequisites
- [Node.js](https://nodejs.org/) satisfying the `engines.node` requirement in the root [package.json](https://github.com/Azure/azure-rest-api-specs/blob/main/package.json) (currently 24.14.1 or newer; LTS recommended).
  - Linux/MacOS
    - Install https://github.com/nvm-sh/nvm
    - `nvm install --lts`
  - Windows
    - Install https://github.com/coreybutler/nvm-windows
    - `nvm install lts`

## Install toolchain
This repository uses [pnpm](https://pnpm.io/), pinned by the `packageManager` field in the root `package.json`. From the **azure-rest-api-specs repository root**, bootstrap the pinned version and install the toolchain:

```sh
npm run install-pnpm
pnpm --version
pnpm ci
```

`npm run install-pnpm` is the bootstrap exception: it installs pnpm globally without installing repository dependencies. Do not use `npm install`, `npm ci`, or Yarn for repository dependencies; they are not supported by this pnpm workspace, which uses `workspace:` and `catalog:` dependencies.

`pnpm ci` cleans installed dependencies and reinstalls the versions recorded in the root `pnpm-lock.yaml`, including all workspace tools (e.g. `@typespec/compiler`). Run dependency installation from the repository root, not individual service folders.

Run installed tools with `pnpm <tool>`, such as `pnpm tsp --version` or `pnpm tsp compile .` from your TypeSpec project folder. See [Spec Model](./spec-model.md) for tools that require a specific workspace.

## Update toolchain
- Merge latest from your target branch (e.g. `main`, `RPSaaSMaster`) to your source branch
- Run `npm run install-pnpm` if pnpm is not installed; otherwise pnpm automatically uses the version pinned by `packageManager`
- Run `pnpm ci` again from the repository root
- If errors or incorrect tool versions, ensure no uncommitted changes, then run `git clean -xdf` to remove all old files, and try again

If you are intentionally changing dependencies rather than refreshing the toolchain, run `pnpm install` from the repository root and commit the updated `pnpm-lock.yaml` alongside your dependency changes. See [Dependencies](./dependencies.md) for workspace and catalog details.
