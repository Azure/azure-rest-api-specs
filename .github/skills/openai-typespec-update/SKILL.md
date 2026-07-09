---
name: openai-typespec-update
license: MIT
metadata:
  version: "1.0.0"
  distribution: shared
description: 'Update the `@azure-tools/openai-typespec` package that supplies OpenAI TypeSpec definitions and views used by this repo. WHEN: "update OpenAI TypeSpec definitions", "bump openai-typespec", "refresh OpenAI TypeSpec models/views", "upgrade @azure-tools/openai-typespec". DO NOT USE FOR: general `.tsp` authoring, changing service APIs, or SDK generation. ALWAYS install with `npm i @azure-tools/openai-typespec --save-exact` (or `npm i @azure-tools/openai-typespec@<version> --save-exact`). WARN the user if the dependency version spec contains a caret (`^`).'
compatibility:
  requires: "npm, repo root package.json"
---

# OpenAI TypeSpec Update

Use this skill when the task is specifically about updating the
`@azure-tools/openai-typespec` dependency that provides imported OpenAI
models and views consumed from `tspconfig.yaml` files in this repo.

## Repo-Specific Context

- The dependency is managed from the repo-root `package.json`.
- OpenAI TypeSpec definitions are imported from `tspconfig.yaml` files,
  such as:
  - `@azure-tools/openai-typespec/models/...`
  - `@azure-tools/openai-typespec/views/client-emitters/...`
- In this environment, npm may be configured with `min-release-age=7` in
  the global npm config at `C:\nvm4w\nodejs\etc\npmrc`. This blocks
  same-day package versions unless the lock file already pins them.

## Required Update Rule

Always install the dependency with an exact version:

```powershell
npm i @azure-tools/openai-typespec --save-exact
```

If the user asks for a specific version, pin that exact version:

```powershell
npm i @azure-tools/openai-typespec@<version> --save-exact
```

Do not use a caret range. Exact pins prevent accidental drift in the
OpenAI definition package.

## Steps

1. **Inspect the current pin** in the repo-root `package.json`.
2. **Update with an exact install** using `npm i
@azure-tools/openai-typespec --save-exact` (or append `@<version>` if
   the user specified a version).
   - If npm fails with an age-gate error like `No matching version found
for @azure-tools/openai-typespec@1.21.1 with a date before
2026-06-30, 10:37:15 a.m.`, check `npm config get min-release-age`
     and the global npm config path with `npm config get globalconfig`.
   - For a targeted install of a known-published version blocked only by
     this age gate, rerun the exact install with `--min-release-age=0`,
     for example:
     ```powershell
     npm i @azure-tools/openai-typespec@<version> --save-exact --min-release-age=0
     ```
3. **Check the resulting version spec** in `package.json`.
   - If the dependency value contains a caret (`^`), warn the user that
     the package is not pinned exactly and should be changed to an exact
     version.
4. **Keep package files aligned**.
   - Update `package.json` and `package-lock.json` together.
   - Do not hand-edit `package-lock.json`.
5. **Review affected imports** in relevant `tspconfig.yaml` files when
   the package update is meant to refresh models or views used by Azure
   AI Foundry specs.

## Examples

- "Update the OpenAI TypeSpec definitions to the latest version."
- "Bump `@azure-tools/openai-typespec` and make sure it is pinned
  exactly."
- "Refresh the OpenAI TypeSpec package for Foundry."
- "Check whether our `@azure-tools/openai-typespec` dependency uses a
  caret."

## Warnings

- If the dependency spec is `^<version>`, explicitly warn the user that
  caret ranges are not allowed for this package update flow.
- If the request is to modify `.tsp` API shapes rather than update the
  package dependency, use the `azure-typespec-author` skill instead.
