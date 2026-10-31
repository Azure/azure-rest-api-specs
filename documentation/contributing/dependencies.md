This repo depends on many JS packages, as defined in the root [package.json](https://github.com/Azure/azure-rest-api-specs/blob/main/package.json).

## Package management

Use [pnpm](https://pnpm.io/), with the version pinned by `packageManager` in the root `package.json`. See [Contributing](./toolchain-setup.md) for Node.js requirements, the `npm run install-pnpm` bootstrap, and installing the toolchain with `pnpm ci`.

The root [pnpm-workspace.yaml](https://github.com/Azure/azure-rest-api-specs/blob/main/pnpm-workspace.yaml) defines the workspace packages (`.github`, `.github/shared`, `eng/tools`, and `eng/tools/*`) and a shared dependency catalog. Workspace packages use `workspace:` for local dependencies and `catalog:` for shared versions.

Repository workspaces share the root [pnpm-lock.yaml](https://github.com/Azure/azure-rest-api-specs/blob/main/pnpm-lock.yaml). When changing dependencies, update the appropriate `package.json` or catalog entry, run `pnpm install` from the repository root, and commit the updated lockfile with the dependency changes. Do not add per-workspace lockfiles. Independent projects outside the workspace, such as `eng/common/tsp-client` and `eng/common/spelling`, retain their own dependency-management instructions.

## `@typespec/*`
- Owner: TypeSpec
- Repo: https://github.com/microsoft/typespec

## `@azure-tools/typespec-*`
- Owner: TypeSpec
- Repo: https://github.com/Azure/typespec-azure

## `@azure-tools/openai-typespec`
- Owner: Azure OpenAI

## `@azure-tools/typespec-liftr-base`
- Owner: LiftR

## Partner Dependency Guidelines
TBD
