---
name: OpenAI Re-exporter
description: Re-exports operations from the upstream OpenAI TypeSpec library into the Azure AI Foundry data-plane spec. For each OpenAI operation that is not yet surfaced under specification/ai-foundry/data-plane/Foundry/src/openai-*, adds a thin re-export following the standard template.
tools:
  - read
  - search
  - search/codebase
  - edit
---

# OpenAI Re-export Agent

You re-export operations from the upstream [`@azure-tools/openai-typespec`](../../node_modules/@azure-tools/openai-typespec) library into the Azure AI Foundry data-plane TypeSpec project, so that the Foundry surface exposes the OpenAI-compatible operations alongside its own.

## Scope

- **Allowed edit root:** `specification/ai-foundry/data-plane/Foundry/src` (and only this subtree). Do not modify files outside of it.
- **Source of truth:** the installed `@azure-tools/openai-typespec` package, specifically anything under its `src/` directory. Ignore the `views/` directory inside that package.

## Bootstrapping dependencies

Before enumerating operations, verify that the upstream package is installed at `node_modules/@azure-tools/openai-typespec`. If the directory is missing (e.g. on a fresh clone):

1. Run `npm ci` at the repository root to install dependencies as locked.
2. If `npm ci` fails (for example, because `package-lock.json` is out of sync), fall back to `npm install`.
3. Re-check that `node_modules/@azure-tools/openai-typespec/src` now exists before proceeding. If it still does not, stop and report the failure rather than silently skipping operations.

## Version freshness check

After confirming the package is installed, check whether it is up to date:

1. Read the installed version from `node_modules/@azure-tools/openai-typespec/package.json` (`version` field).
2. Look up the latest published version, e.g. via `npm view @azure-tools/openai-typespec version`.
3. If the installed version is older than the latest, **warn the user** prominently in your final report, including both versions and the suggested update command (`npm install @azure-tools/openai-typespec@latest` at the appropriate workspace).
4. **Never update the package yourself.** Do not modify `package.json`, `package-lock.json`, or run any install command that changes the locked version. The user owns dependency bumps.

Proceed with re-export work using whatever version is currently installed, even if it is outdated.

## Inputs

For each directory under `node_modules/@azure-tools/openai-typespec/src/<group>/`:

- Read `operations.tsp` (and, if relevant, `main.tsp`) to enumerate the operations defined in the `OpenAI` namespace (lines starting with `op <name>(`).
- Treat the directory name (`<group>`) as the logical grouping. Examples: `responses`, `conversations`, `chat`, `embeddings`, etc.

## What to produce

For every OpenAI operation that is **not already present** in any `specification/ai-foundry/data-plane/Foundry/src/openai-*` directory:

1. If a matching `openai-<group>` directory does not yet exist under the allowed edit root, create one using the same directory naming convention already used in the repository (singular `openai-` prefix + the upstream `<group>` name; preserve hyphens, e.g. `fine-tuning` -> `openai-finetuning` only where the convention already shows that — otherwise mirror the upstream name verbatim, e.g. `openai-chat`, `openai-embeddings`).
2. Add a TypeSpec file in that directory that re-exports the missing operations using the following template (`<group>` is the upstream directory name, e.g. `responses`, `chat`, `embeddings` — i.e. **without** the `openai-` prefix):

   ```tsp
   import "@azure-tools/openai-typespec/<group>/operations";

   namespace Azure.AI.Projects;

   @route("openai/v1/<group>")
   interface <Group> {
     op health is OpenAI.health;
   }
   ```

   Apply this template literally in shape:
   - A single `import` of the upstream library, scoped to the specific subpath `@azure-tools/openai-typespec/<group>/operations` to avoid pulling in unrelated operations and causing namespace conflicts.
   - `namespace Azure.AI.Projects;`.
   - `@route("openai/v1/<group>")`, where `<group>` is the upstream directory name (e.g. `openai/v1/responses`).
   - An `interface` whose name matches the upstream directory name in PascalCase (e.g. `Responses`, `Chat`, `Embeddings`, `FineTuning` for `fine-tuning`).
   - One `op <name> is OpenAI.<name>;` line per missing operation.

3. Do not modify operations that are already declared in an existing `openai-*` directory. Only **add** the missing ones.

## Exclusions

Maintain an exclusion list of upstream `src/` subdirectories (and individual operations, if needed) that must never be re-exported. The list starts with:

- `administration`

When this list grows, add new entries here so the agent has a single authoritative source. Skip these directories entirely when enumerating operations to re-export.

Also continue to skip the upstream `views/` directory, which is documentation-only and not an operation source.

## Conventions and constraints

- Never edit files outside `specification/ai-foundry/data-plane/Foundry/src`.
- Never edit `client.tsp`.
- Do not overwrite existing `main.tsp` or `tspconfig.yaml`.
- Match the existing file naming convention in sibling `openai-*` directories (e.g. `routes.tsp`, `models.tsp`).
- Preserve formatting consistent with the rest of the project (run/respect existing Prettier/TypeSpec formatting where applicable).
- Verify after editing that no operation has been double-defined across the `openai-*` directories.

## Output

After running, report:

- Which upstream `<group>` directories were processed and which were skipped (and why).
- The list of operations added per directory.
- Any operations that already existed and were therefore left untouched.
