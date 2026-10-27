# Overview
`spec-model` is a shared component that returns a "model" of a spec folder.  The "model" includes data like the readme.md files, the tags within those readmes, the swagger files within those tags, etc.  This code was recently made more strict, so existing specs that were previously passing checks, may now start seeing errors that must be fixed.

# Running Locally
Complete the Node.js and pnpm setup in [Contributing](./toolchain-setup.md) first. Install dependencies from the repository root. The `spec-model` binary is provided by the `.github` workspace's `@azure-tools/specs-shared` dependency, so use `--dir .github` to run it. Spec paths are then relative to `.github`, hence the `../specification/` prefix.

```
$ cd azure-rest-api-specs
$ pnpm ci
$ pnpm --dir .github exec spec-model ../specification/contosowidgetmanager

{
  "folder": "/home/user/specs/specification/contosowidgetmanager",
  "readmes": [
    {
      "path": "/home/user/specs/specification/contosowidgetmanager/data-plane/readme.md",
      "globalConfig": {
        "openapi-type": "data-plane",
...
```

# Errors
If spec-model detects any errors in your spec (e.g. unreferenced or missing swagger files), it will throw an error like this:

```
$ pnpm --dir .github exec spec-model ../specification/with-errors

Multiple input-file definitions for tag package-preview-2024-01 in
/home/user/specs-pr/specification/with-errors/resource-manager/readme.md
file:///home/user/specs-pr/.github/shared/src/readme.js:148
          throw new Error(message);
                ^

Error: Multiple input-file definitions for tag package-preview-2024-01 in
/home/user/specs-pr/specification/with-errors/resource-manager/readme.md
    at #getData (file:///home/user/specs-pr/.github/shared/src/readme.js:148:17)
    at async Readme.getTags (file:///home/user/specs-pr/.github/shared/src/readme.js:188:13)
```

Any errors from spec-model are fatal, and must be fixed before proceeding.  There are no exceptions or suppressions.
