---
name: sdk-breaking-change-detector
description: >
  "detect sdk breaking changes for a service"
---

# sdk-breaking-change-detector

Detect SDK breaking changes across all languages (Go, Java, .NET, JavaScript, Python) for a TypeSpec-based Azure service.

## Usage

**USE FOR:**
- Detecting SDK breaking changes across one or more languages for a TypeSpec project
- Reviewing changelog entries to identify breaking changes before merging API spec changes

**DO NOT USE FOR:**
- Full SDK generation, build, test, and release workflows (use the local-sdk-workflow instead)
- Fixing or mitigating breaking changes (use sdk-breaking-change-mitigator instead)

## MCP Tools

| Tool                                            | Purpose                                              |
| ----------------------------------------------- | ---------------------------------------------------- |
| `azure-sdk-mcp:azsdk_package_generate_code`     | Generate SDK code for a given language                |
| `azure-sdk-mcp:azsdk_package_update_changelog_content` | Update changelog with detected changes         |

**Prerequisite:** `azure-sdk-mcp` server must be running.

## Constraints

- **Process every requested language independently** — a failure in one language must not block the others.
- **Do not modify source `.tsp` files** — this skill is read-only with respect to the API spec.
- **Do not skip the changelog update step** — `azsdk_package_update_changelog_content` is required to produce an accurate changelog before analysis.
- **Report results per language** — always present a per-language summary at the end.

---

## Workflow

> Intake → Per-Language Loop (Generate → Update Changelog → Analyze) → Cross-Language Analysis → Summary

### Progress Checklist

Copy and update as you progress:

- [ ] Step 1: Collected inputs
- [ ] Step 2: Go — Generate → Changelog → Analyze
- [ ] Step 3: Java — Generate → Changelog → Analyze
- [ ] Step 4: .NET — Generate → Changelog → Analyze
- [ ] Step 5: JavaScript — Generate → Changelog → Analyze
- [ ] Step 6: Python — Generate → Changelog → Analyze
- [ ] Step 7: Cross-language breaking change analysis
- [ ] Step 8: Presented consolidated summary

---

### Step 1: Collect Inputs

**Goal**: Gather the parameters needed to run SDK generation for each language.

If these are already provided by the user (or collected earlier in the conversation), do not re-ask.

**Required inputs:**

| Parameter             | Description                                                                                          | Example (Windows)                                                                                 |
| --------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `tspConfigPath`       | Absolute path to `tspconfig.yaml`, or path relative to the specs repo root                           | `specification\contosowidgetmanager\Contoso.Management\tspconfig.yaml`                            |
| `localSdkRepoPath`        | Absolute path to each locally cloned Azure SDK language repo the user wants to check                 | See table below                                                                                   |

**SDK repo path per language:**

| Language   | Repository                | Example Path (Windows)              |
| ---------- | ------------------------- | ----------------------------------- |
| Go         | `azure-sdk-for-go`        | `C:\dev\azure-sdk-for-go`           |
| Java       | `azure-sdk-for-java`      | `C:\dev\azure-sdk-for-java`         |
| .NET       | `azure-sdk-for-net`       | `C:\dev\azure-sdk-for-net`          |
| JavaScript | `azure-sdk-for-js`        | `C:\dev\azure-sdk-for-js`           |
| Python     | `azure-sdk-for-python`    | `C:\dev\azure-sdk-for-python`       |

**Actions:**

1. Identify the `tspConfigPath` — locate `tspconfig.yaml` from the user's context or prompt for it.
2. Ask the user which languages to check. Default: **all five** (Go, Java, .NET, JavaScript, Python).
3. For each selected language, collect or confirm the absolute path to the locally cloned SDK repo.
4. Validate that `tspconfig.yaml` exists at the provided path before proceeding.

---

### Steps 2–6: Per-Language Breaking Change Detection

Repeat the following three sub-steps **for each selected language**, in order: Go → Java → .NET → JavaScript → Python.

If a language is not selected or the user does not have the SDK repo cloned, skip it and note it as **skipped** in the final summary.

**Prerequisite:**
Call `azsdk_verify_setup` for the Language. If environment is not valid, install required environment.

#### Sub-step A: Generate SDK

**Action:** Call `azsdk_package_generate_code` MCP tool with:
- `localSdkRepoPath`: The SDK repo path for the current language
- `tspConfigPath`: The path to the 'tspconfig.yaml' file.

If generation fails, record the error for this language, inform the user, and continue to the next language.

#### Sub-step B: Update Changelog

**Action:** Call `azsdk_package_update_changelog_content` MCP tool with:
- `packagePath`: The generated SDK project directory (identified from the generation output)

This produces an up-to-date `CHANGELOG.md` with breaking changes and new features.

If the changelog update fails, ask the user to manually provide the changelog content for this language, then continue.

#### Sub-step C: Analyze Breaking Changes

**Action:** Read the **first** `## <version>` entry from the generated `CHANGELOG.md` in the SDK project directory.

Extract and record:
- **Breaking Changes** — the full list under `### Breaking Changes`
- **Features Added** — the full list under `### Features Added`

If the `### Breaking Changes` section is absent or empty, record: **No breaking changes detected**.

---

### Step 7: Cross-Language Breaking Change Analysis

**Goal**: Analyze the collected breaking changes from all languages, identify the underlying API changes, and group identical or equivalent breaking changes that appear across multiple languages.

**Actions:**

1. Collect all breaking change entries from every language processed in Steps 2–6.
2. For each breaking change entry, identify the **underlying API change** — the TypeSpec-level or REST API–level change that caused it. Common categories include:
   - **Removed operation** — an operation/method was deleted from the API surface
   - **Removed model/type** — a model, struct, class, or interface was deleted
   - **Removed property/field** — a property was removed from an existing model
   - **Renamed operation/model/property** — a symbol was renamed
   - **Changed type** — a property or parameter type was changed
   - **Changed required/optional** — a property's optionality was changed
   - **Changed signature** — operation parameters were added, removed, or reordered
   - **Other** — any change that does not fit the above categories
3. Group entries that correspond to the **same underlying API change** across languages. Two entries are considered the same if they refer to the same operation, model, or property — even though the language-specific symbol names differ (e.g., Go uses `BeginCreate`, JavaScript uses `beginCreate`, Python uses `begin_create`).
4. Record any breaking changes that are **unique to a single language** (e.g., caused by language-specific SDK conventions rather than an API-level change).

---

### Step 8: Consolidated Summary

Present a **per-language status table** first:

```markdown
## SDK Breaking Change Detection Summary

| Language   | Status    | Breaking Changes | Features Added |
| ---------- | --------- | ---------------- | -------------- |
| Go         | ✅ Done    | 3                | 5              |
| Java       | ✅ Done    | 2                | 2              |
| .NET       | ❌ Failed  | —                | —              |
| JavaScript | ✅ Done    | 1                | 4              |
| Python     | ⏭ Skipped | —                | —              |
```

Then present the **cross-language breaking change analysis**. Each breaking change should be a concise, human-readable sentence that describes the underlying API change and lists the affected languages inline.

```markdown
## Breaking Change Analysis

### Shared Breaking Changes

These breaking changes stem from the same underlying API change and affect multiple languages.

1. Model `ResourceInfo` renamed to `WebPubSubResource`, which breaks **Go**, **Java**, and **JavaScript** SDK.
2. Operation `BeginCreate` removed from `FooClient`, which breaks **Go**, **Java**, and **JavaScript** SDK.
3. Property `endpoint` removed from model `ConnectionInfo`, which breaks **Go** and **Python** SDK.

### Language-Specific Breaking Changes

These breaking changes are unique to a single language (e.g., caused by SDK naming conventions, type mapping, or codegen differences).

1. [Go] Field `Baz` of struct `QuxOptions` has been removed.
2. [Java] Method `getConnectionString()` return type changed from `String` to `Mono<String>`.
```

**Format for each breaking change entry:**

Each entry must be a single sentence following this pattern:

> `<Category>` `<original name>` `<what changed>`, which breaks **Lang1**, **Lang2**, … SDK.

Where `<Category>` is one of: Model, Operation, Property, Parameter, Enum value, Type.

**Examples:**

- Model `ResourceInfo` renamed to `WebPubSubResource`, which breaks **Go** and **Java** SDK.
- Operation `BeginCreate` removed from `FooClient`, which breaks **Go**, **Java**, and **JavaScript** SDK.
- Property `endpoint` removed from model `ConnectionInfo`, which breaks **Go**, **Java**, **.NET**, **JavaScript**, and **Python** SDK.
- Property `timeout` type changed from `int32` to `string` on model `RequestOptions`, which breaks **Java** and **Python** SDK.
- Enum value `Standard` removed from `SkuTier`, which breaks **Go** and **.NET** SDK.

**Formatting rules:**

- If **no shared breaking changes** exist, omit the "Shared Breaking Changes" section.
- If **no language-specific breaking changes** exist, omit the "Language-Specific Breaking Changes" section.
- If **no language** has breaking changes, state: **No breaking changes detected across all checked languages.**
- Always include the per-language status table regardless of whether breaking changes are found.
- Language-specific entries must be prefixed with `[Language]` in square brackets.

---

## Examples

- "Detect breaking changes for all languages for the SignalR TypeSpec project"
- "Check Go and Python SDK breaking changes for specification\storage\Storage.Management\tspconfig.yaml"
- "Are there any SDK breaking changes in this TypeSpec PR?"

## Troubleshooting

- **MCP tool not available** — ensure `azure-sdk-mcp` server is running; run `azsdk_verify_setup` to check.
- **SDK generation fails for a language** — verify prerequisites (Go, Java/Maven, .NET SDK, Node.js, Python) are installed; check that the SDK repo is on a clean branch.
- **Changelog is empty after update** — this typically means there are no API changes compared to the currently released version. Confirm by checking `git diff` in the SDK repo.
- **User doesn't have all SDK repos** — run detection only for the languages whose repos are available; skip the rest.
