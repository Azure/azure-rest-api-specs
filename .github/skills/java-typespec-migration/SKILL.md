---
name: java-typespec-migration
description: "Mitigate Java SDK breaking changes after migrating from Swagger (OpenAPI) to TypeSpec. USE FOR: mitigate Java breaking changes from TypeSpec, Java SDK TypeSpec migration, fix Java SDK breaks, rename models for Java, rename properties for Java, TypeSpec migration PR review for Java. DO NOT USE FOR: generating SDK for other languages, authoring new TypeSpec specs, SDK release or deployment."
license: MIT
metadata:
  author: Microsoft
  version: "1.0.0"
tools:
  - mcp_azure-sdk-jav_generateJavaSdk
  - mcp_azure-sdk-jav_buildJavaSdk
  - mcp_azure-sdk-jav_getJavaSdkChangelog
  - mcp_azure-sdk-jav_mitigateMigrationBreaks
---

# Mitigate Java SDK Breaking Changes from TypeSpec Migration

## Overview

This skill mitigates breaking changes in the Java SDK caused by converting Swagger (OpenAPI) specifications to TypeSpec. It modifies only `client.tsp` and `tspconfig.yaml` — no other files should be changed.

## Execution Policy

**Run autonomously by default. Do NOT ask the user for confirmation between steps.**

The pattern rules below are deterministic — every break category has a fixed action (`Expected` / `MUST FIX` / `Recommended fix` / `Acceptable break` / `MUST REPORT`). Apply them without prompting:

- `Expected` → ignore, log only.
- `MUST FIX` → apply the fix automatically.
- `Recommended fix` → apply the fix automatically.
- `Acceptable break` → apply the fix automatically (add the `tspconfig.yaml` flag).
- `MUST REPORT` → record in the final report; do not prompt mid-run.

**Only stop and ask the user when**:
1. A break does not match any pattern rule and cannot be classified.
2. `tsp compile` fails after a fix and the agent cannot resolve the error from the compiler output in 2 attempts.
3. The user invoked the skill in `interactive` mode (see below).

For everything else: log the action to the run log and continue.

### Modes

- `silent` (default): run end-to-end through all phases without prompts.
- `phased`: run a single phase, persist artifacts, stop. Resume later by invoking the next phase.
- `interactive`: prompt before applying each `MUST FIX` / `Recommended fix`. Use only when the user explicitly requests it.

The mode is selected from the user's invocation phrasing. If unspecified, use `silent`.

## Prerequisites

- Node.js 22+
- npm-check-updates (`npm install -g npm-check-updates`)
- Java 11+ (`javac --version`)
- Maven (`mvn --version`)
- The `azure-sdk-java-mcp` MCP server must be configured

Verify silently. Only surface a prerequisite to the user if it is missing.

## Workspace and Intermediate Artifacts

To support `phased` mode and recovery, persist intermediate state under the TypeSpec project directory in `.java-migration/` (do NOT commit this folder — add to `.gitignore` if not already ignored). All artifacts are kept across phases so a later phase can resume without redoing earlier work.

```
<typespec-dir>/.java-migration/
├── state.json              # phase pointer, iteration count, mode
├── changelog-iter-0.md     # changelog snapshot before any fix
├── changelog-iter-1.md     # changelog after first fix pass
├── changelog-iter-2.md     # changelog after second fix pass (if needed)
├── applied-fixes.log       # one line per fix: timestamp, rule, target, file
├── unfixable-breaks.json   # MUST REPORT items + unmatched breaks
└── run.log                 # full run trace (tool calls, errors)
```

`state.json` schema:

```json
{
  "mode": "silent|phased|interactive",
  "phase": "init|generate|analyze|mitigate|verify|report|done",
  "iteration": 0,
  "tspDir": "<absolute path>",
  "javaSdkDir": "<absolute path>",
  "groupId": "...",
  "artifactId": "...",
  "lastUpdated": "<iso timestamp>"
}
```

Also keep the generated `java-sdk` folder in place between phases — do not delete it. Its `target/*.jar` is the input for the changelog tool in later phases.

## Phases

Each phase is idempotent. Re-running a phase reads `state.json`, picks up where it left off, and overwrites only its own outputs.

### Phase 1 — `init`

1. Resolve TypeSpec project directory from context (folder containing `tspconfig.yaml` + `main.tsp`).
2. Verify prerequisites silently. If a prerequisite is missing, stop and tell the user exactly what to install — this is the one allowed prompt in this phase.
3. Call `mcp_azure-sdk-jav_mitigateMigrationBreaks` once and cache the response in memory for the remainder of the run.
4. Create `.java-migration/` and write initial `state.json` with `phase: "generate"`.

### Phase 2 — `generate`

1. Call `mcp_azure-sdk-jav_generateJavaSdk` with the TypeSpec source directory.
2. On `duplicate-client-name` error: extract the duplicate model name from the error, append `@@clientName({model}, "{deduplicated-name}", "java")` to `client.tsp`, and retry. Repeat up to 3 times. Log every attempt to `run.log`.
3. Call `mcp_azure-sdk-jav_buildJavaSdk` with the `java-sdk` folder.
4. On build failure, capture the Maven error tail to `run.log` and stop with an actionable message. Do not silently swallow build errors.
5. Update `state.json` → `phase: "analyze"`.

### Phase 3 — `analyze`

1. Read `java-sdk/pom.xml` for `groupId` and `artifactId`.
2. Call `mcp_azure-sdk-jav_getJavaSdkChangelog` with:
   - `jarPath`: `<tspDir>/java-sdk/target/<artifactId>-<version>.jar`
   - `groupId`, `artifactId`: from pom.xml
3. Save the changelog to `changelog-iter-{iteration}.md`.
4. Classify every line in "Breaking Changes" and "Features Added" against the pattern rules. Build an in-memory action list:
   - `{ rule, action: "skip|fix-tsp|fix-config|report", target, payload }`
5. Append unmatched entries to `unfixable-breaks.json` (do NOT prompt — they go in the final report).
6. Update `state.json` → `phase: "mitigate"`.

### Phase 4 — `mitigate`

1. Apply each action from the analyze list autonomously:
   - `fix-tsp`: append `@@clientName` / `@@clientLocation` / `@@alternateType` lines to the bottom of `client.tsp` (grouped, with a `// Java-specific overrides` comment header on first insert).
   - `fix-config`: set the corresponding key under `@azure-tools/typespec-java` in `tspconfig.yaml`. If the section does not exist, create it. If the key already exists with a different value, log a conflict to `run.log` but keep the existing value.
   - `skip` / `report`: no file change; record to `applied-fixes.log` / `unfixable-breaks.json`.
2. Run `tsp compile .` then `tsp format .` in the TypeSpec source directory.
3. On compile error: examine the error, attempt up to 2 fixes in `client.tsp`. If still failing, write the failure to `run.log` and surface to the user (this is one of the allowed stop points).
4. Update `state.json` → `phase: "verify"`.

### Phase 5 — `verify`

1. Re-run Phase 2 (`generate`) and Phase 3 (`analyze`) once. Save the new changelog as `changelog-iter-{iteration+1}.md`.
2. Diff against the previous iteration's classified action list.
   - If no new `MUST FIX` / `Recommended fix` items appeared → success, advance to `report`.
   - If new fixable items appeared and `iteration < 2` → increment `iteration`, jump back to `mitigate`.
   - If `iteration == 2` and items remain → record them in `unfixable-breaks.json` and advance to `report`. Do not loop indefinitely.
3. Update `state.json` → `phase: "report"`.

### Phase 6 — `report`

Produce the final summary from `applied-fixes.log` and `unfixable-breaks.json`. Group by category (see "Reporting Unfixable Breaks" below). Use grouped lists, not tables. Mark `phase: "done"` in `state.json`.

## Resuming and Re-running

- `silent` mode runs phases 1 → 6 in one invocation.
- `phased` mode runs the next phase indicated by `state.json` and stops. The user can invoke the skill again to advance.
- To force a clean run, delete `.java-migration/` and the `java-sdk/` folder before invoking.
- To re-run only a specific phase, edit `state.json` `phase` field and invoke again.

## Pattern Rules for Mitigation

### Models removed: `*ListResult` / `*ListResponse` / `*List`

**Expected.** No action needed — these are pagination types handled by the framework.

### Models removed: `Operation*`

**Expected.** No action needed.

### Constructor changed to private access

**Expected.** No action needed.

### Service client renamed

**Expected.** No action needed (e.g., `fluent.{ClientName} serviceClient()` → `fluent.{NewClientName} serviceClient()`).

### Manager class renamed

**MUST FIX.** Add to `tspconfig.yaml` under `@azure-tools/typespec-java`:

```yaml
service-name: {Service Name}
```

### Model renamed (e.g., casing difference like `OCI` → `Oci`)

**MUST FIX.** Check if `{NewModelName}` is a model or interface in `.tsp` files.

If model:
```typespec
@@clientName({Namespace}.{NewModelName}, "{OldModelName}", "java");
```

If interface, for each operation:
```typespec
@@clientLocation({Namespace}.{NewInterfaceName}.{OperationName}, "{OldModelName}", "java");
```

### Property renamed (usually casing: `userName` → `username`, `firstLSN` → `firstLsn`)

**MUST FIX.**
```typespec
@@clientName({Namespace}.{ModelName}.{newPropertyName}, "{oldPropertyName}", "java");
```

### `java.lang.Object` → `java.util.Map`

**Recommended fix.**
```typespec
@@alternateType({Namespace}.{ModelName}.{PropertyName}, unknown, "java");
```

### `java.lang.Object` → `com.azure.core.util.BinaryData`

**Recommended fix.** Add to `tspconfig.yaml`:
```yaml
use-object-for-unknown: true
```

### `validate()` removed

**Acceptable break.** Add to `tspconfig.yaml`:
```yaml
client-side-validations: true
```

### `java.lang.String` → `java.util.UUID`

**Acceptable break.** Add to `tspconfig.yaml`:
```yaml
uuid-as-string: false
```

### `java.lang.Float` → `java.lang.Double`

**Acceptable break.** Add to `tspconfig.yaml`:
```yaml
float32-as-double: false
```

### `*Headers` / `*AutoGenerated` / `*FinalResult` models added

**MUST REPORT.** This is likely an error in the TypeSpec source. Report to dev immediately.

## Constraints

- Only modify `client.tsp` and `tspconfig.yaml` (plus the skill's own `.java-migration/` workspace).
- Group Java-specific `@@clientName` additions at the end of `client.tsp` under a `// Java-specific overrides` header.
- `client.tsp` must import `main.tsp` (not vice versa).
- Do NOT modify `back-compatible.tsp` or other `.tsp` files.
- Do NOT commit the generated `java-sdk` folder, the `.java-migration/` workspace, or root `package.json` changes.
- Do NOT prompt the user between deterministic steps. Only the stop conditions listed under "Execution Policy" justify a prompt.

## tspconfig.yaml Options (Java)

All options go under `@azure-tools/typespec-java`:

| Option | Effect |
|--------|--------|
| `service-name: "Service Name"` | Fix Manager class name |
| `use-object-for-unknown: true` | Keep `Object` instead of `BinaryData` for `unknown` |
| `client-side-validations: true` | Restore `validate()` methods |
| `uuid-as-string: false` | Keep `UUID` type instead of `String` |
| `float32-as-double: false` | Keep `Float` type instead of `Double` |
| `generate-samples: false` | Disable sample generation |

## Reporting Unfixable Breaks

Generate the final report from `unfixable-breaks.json` at the end of phase 6. Group by category:

1. `validate()` removed (if `client-side-validations` was not enabled)
2. UUID → String type changes (if `uuid-as-string` was not enabled)
3. Float → Double type changes (if `float32-as-double` was not enabled)
4. Setter methods removed (properties marked read-only in TypeSpec)
5. Operation interface restructuring (parameter changes, return type changes)
6. Models removed (unreachable in TypeSpec graph)
7. `*Headers` / `*AutoGenerated` / `*FinalResult` models added (likely TypeSpec source error — flag for dev review)
8. Unmatched breaks (no pattern rule applied — needs human triage)

Use grouped lists with model/method names. Do NOT use tables.
