---
name: openai-typespec-update
license: MIT
metadata:
  version: "1.1.0"
  distribution: shared
description: 'Update the `@azure-tools/openai-typespec` package that supplies OpenAI TypeSpec definitions and views used by this repo. WHEN: "update OpenAI TypeSpec definitions", "bump openai-typespec", "refresh OpenAI TypeSpec models/views", "upgrade @azure-tools/openai-typespec". DO NOT USE FOR: general `.tsp` authoring, changing service APIs, or SDK generation. ALWAYS keep an exact pin in the root pnpm-workspace.yaml catalog, retain catalog: in package.json, and run pnpm install from the repository root. WARN the user if the resolved catalog version spec contains a caret (`^`).'
compatibility:
  requires: "pnpm, repo root package.json and pnpm-workspace.yaml"
---

# OpenAI TypeSpec Update

Use this skill when the task is specifically about updating the
`@azure-tools/openai-typespec` dependency that provides imported OpenAI
models and views consumed from `tspconfig.yaml` files in this repo.

## Repo-Specific Context

- The repo-root `package.json` references the dependency with `catalog:`.
  Its exact version is managed in the default `catalog` in the root
  `pnpm-workspace.yaml`.
- OpenAI TypeSpec definitions are imported from `tspconfig.yaml` files,
  such as:
  - `@azure-tools/openai-typespec/models/...`
  - `@azure-tools/openai-typespec/views/client-emitters/...`
- The workspace config defines pnpm release-age settings and exclusions.
  Preserve those settings when updating this dependency.

## Required Update Rule

Always set the catalog entry to an exact version. Keep the root `package.json`
dependency value as `catalog:`, then run from the repository root:

```powershell
pnpm install
```

Do not use a caret range. Exact pins prevent accidental drift in the
OpenAI definition package. `catalog:` itself is not a version range; inspect
the value it resolves to before deciding whether the package is pinned.

Update the catalog entry rather than replacing the manifest's `catalog:`
reference with a literal version.

## Steps

1. **Inspect the current pin** by following the repo-root `package.json`
   `catalog:` reference to `catalog["@azure-tools/openai-typespec"]` in
   `pnpm-workspace.yaml`.
2. **Select the exact target version**. Use the version requested by the user;
   for a latest-version request, obtain the published version with
   `pnpm view @azure-tools/openai-typespec version`.
3. **Update and install**. Set the catalog entry to that exact version, retain
   `catalog:` in `package.json`, and run `pnpm install` from the repository root.
   Report installation or release-age errors explicitly without disabling
   workspace policies.
4. **Check the resulting pin**. Warn if the resolved catalog entry contains a
   caret (`^`); ensure it is an exact version and that the lockfile resolves the
   requested version.
5. **Keep package files aligned**. Include `pnpm-workspace.yaml` and the
   pnpm-generated `pnpm-lock.yaml` together. An existing `catalog:` reference
   should not need a manifest change. Do not hand-edit the lockfile.
6. **Review affected imports** in relevant `tspconfig.yaml` files when
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

- If the resolved catalog entry is `^<version>`, explicitly warn the user that
  caret ranges are not allowed for this package update flow.
- If the request is to modify `.tsp` API shapes rather than update the
  package dependency, use the `azure-typespec-author` skill instead.
