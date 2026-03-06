# Task Prompt: Refresh the Azure Search Swagger Comparison Document

## Context

When the TypeSpec-compiled swagger for an Azure Search preview API version is updated (e.g., after a TypeSpec migration PR is merged or amended), the corresponding `swagger-comparison-<api-version>.md` document must be regenerated to reflect the latest differences between:

- **Old (baseline)**: the hand-authored swagger files from the immediately preceding API version  
  (typically `searchservice.json`, `searchindex.json`, and — if present — `knowledgeagent.json` or `knowledgebase.json`)
- **New (TSP-compiled)**: the single `search.json` produced by compiling the TypeSpec project at `specification/search/data-plane/Search/`

The comparison document lives at:

```
specification/search/data-plane/Search/swagger-comparison-<api-version>.md
```

For example, for `2025-11-01-preview`:

```
specification/search/data-plane/Search/swagger-comparison-2025-11-01-preview.md
```

---

## Trigger Condition

Run this task whenever **any** of the following occur:

1. The TSP-compiled `search.json` for the target API version is updated in `main` (e.g., a fixup commit after a TypeSpec migration PR is merged).
2. A previously hand-authored swagger file that serves as the baseline is corrected or updated.
3. The comparison document is stale and does not reflect the current state of `main`.

---

## Inputs Required

| Input | Where to find it |
|-------|-----------------|
| **Target API version** | The API version string, e.g. `2025-11-01-preview` |
| **New TSP-compiled swagger** | `specification/search/data-plane/Search/preview/<api-version>/search.json` |
| **Old hand-authored baseline** | The hand-authored swagger files from the immediately preceding preview version (see "Choosing the baseline" below) |
| **Migration PR number** | The GitHub PR number that originally introduced the TypeSpec migration for this version (used for links in the document) |

### Choosing the baseline

The baseline is the **immediately preceding preview version** — the last preview version whose swagger files were still hand-authored (not TSP-compiled). To find it:

1. List the preview subdirectories: `ls specification/search/data-plane/Search/preview/` sorted by date.
2. Starting from the version just before `<api-version>`, walk backwards until you find a directory that contains **multiple separate files** (`searchservice.json` + `searchindex.json`) rather than a single `search.json`. That version is the baseline.
3. For the `2025-11-01-preview` migration, the baseline is `2025-08-01-preview`.

**Required baseline files** (always present in hand-authored versions):
- `searchservice.json` — service-level operations (indexes, indexers, skillsets, etc.)
- `searchindex.json` — document-level operations (search, suggest, autocomplete, etc.)

**Optional baseline files** (include if present in the baseline directory):
- `knowledgeagent.json` — knowledge-agent operations (present in `2025-08-01-preview` and later hand-authored previews)
- `knowledgebase.json` — earlier name for the same file (present in some pre-2025-08 versions)

---

## Comparison Rules

Apply these rules consistently when classifying each observed difference:

1. **`$ref` ↔ inline conversion**: If a `$ref` to a named schema is replaced by an equivalent inline schema (or vice versa), this is **not** a breaking change — provided the two schemas produce an identical object graph when all `$ref` references are recursively resolved. "Fully unfolded" means: replace every `$ref` with the referenced schema's content, repeat recursively, and compare the resulting plain JSON objects. The comparison includes all fields: `type`, `format`, `properties`, `required`, `enum`, `items`, `additionalProperties`, and `x-ms-*` extensions. It excludes `description` and `title` (documentation only).
2. **Definition renames**: If a definition is renamed but its fully-unfolded content (see rule 1) is identical, this is **not** a breaking change. Document as a rename.
3. **New properties on existing models**: Adding optional properties to an existing response model is **not** a breaking change.
4. **New operations**: Adding a new HTTP endpoint is **not** a breaking change.
5. **New top-level definitions**: Adding new definitions that are not referenced from existing operations is **not** a breaking change.
6. **Removed parameters from requests**: Removing a parameter that was previously in a request should be classified as **High** impact if it was required (callers may be sending it; if the service now rejects it, that is a wire-format break) or **Medium** if it was optional (SDK method signature change only). Always verify the actual service behavior before downgrading to non-breaking.

---

## Breaking Change Impact Classification

Classify every identified breaking change into one of three tiers:

| Impact Level | When to use |
|---|---|
| **High** | Affects the HTTP wire format or removes a previously documented API contract feature, requiring callers to change their code or request structure (e.g., removing a discriminator type, changing a required field type in a response) |
| **Medium** | Affects only SDK-generated client code; the HTTP wire format is identical (e.g., renaming a swagger-level body parameter, changing a query param type from `string` to `array[string, csv]` where serialization is the same) |
| **Low** | Cosmetic or documentation-level change; no practical behavioral impact, or fixes a pre-existing bug in the old spec (e.g., making an implicit `Accept` header explicit, correcting an internally inconsistent enum value) |

---

## Step-by-Step Instructions

### Step 1 — Load and merge the baseline swagger

Determine the baseline version as described in "Choosing the baseline" above. Then:

```python
import json

BASELINE_VERSION = "2025-08-01-preview"   # replace with the actual baseline version
TARGET_VERSION   = "2025-11-01-preview"   # replace with the target version
BASE_PATH = "specification/search/data-plane/Search/preview"

# Required baseline files (always present)
with open(f"{BASE_PATH}/{BASELINE_VERSION}/searchservice.json") as f:
    old_service = json.load(f)
with open(f"{BASE_PATH}/{BASELINE_VERSION}/searchindex.json") as f:
    old_index = json.load(f)

# Optional baseline files
old_ka = {"definitions": {}, "paths": {}}
for optional_name in ("knowledgeagent.json", "knowledgebase.json"):
    try:
        with open(f"{BASE_PATH}/{BASELINE_VERSION}/{optional_name}") as f:
            old_ka = json.load(f)
        print(f"Loaded optional baseline file: {optional_name}")
        break
    except FileNotFoundError:
        pass

old_defs = {}
old_defs.update(old_service.get("definitions", {}))
old_defs.update(old_index.get("definitions", {}))
old_defs.update(old_ka.get("definitions", {}))

old_paths = {}
old_paths.update(old_service.get("paths", {}))
old_paths.update(old_index.get("paths", {}))
old_paths.update(old_ka.get("paths", {}))
```

### Step 2 — Load the new TSP-compiled swagger

```python
with open(f"{BASE_PATH}/{TARGET_VERSION}/search.json") as f:
    new_spec = json.load(f)

new_defs = new_spec.get("definitions", {})
new_paths = new_spec.get("paths", {})
```

### Step 3 — Identify definition-level changes

For each definition, determine whether it:
- Was **removed** (present in `old_defs`, absent in `new_defs`)
- Was **renamed** (absent in `new_defs` under old name, but a new definition with identical content exists)
- Was **added** (present only in `new_defs`)
- Was **modified** (same name, different content)

Verify renames by comparing the fully unfolded schemas (recursively resolve all `$ref`s before comparing).

### Step 4 — Identify operation-level changes

For each path + method combination, check:
- Parameter names, types, and `in` values (header, query, body, path)
- Request body schemas
- Response schemas
- Presence or absence of `x-ms-pageable`, `x-ms-long-running-operation`

Pay special attention to:
- Body parameter `name` fields (swagger metadata)
- Query parameter `type` (`string` vs `array`)
- Header parameters (e.g., `Accept` added as explicit required)

### Step 5 — Document the findings

Populate the comparison document using this structure:

```markdown
# Azure Search <api-version>: Breaking vs Non-Breaking Changes for TypeSpec Migration

**Scope**: `specification/search/data-plane/Search`

(intro paragraphs)

---

## Breaking Changes

(impact-level table)

### High Impact
...

### Medium Impact
...

### Low Impact
...

---

## Non-Breaking Changes

### 1. Schema File Consolidation
...

### 2. URL Path Consolidation (Equivalent Routing)
...

### 3. Definition Renames (N Equivalent Renames)
(table of old → new names)

### 4. Inline ↔ `$ref` Conversions (Same Content)
(table)

### 5. Number / Type Format Clarifications (Not Breaking)
...

### 6–N. Additional non-breaking additions
(new definitions, new operations, etc.)

---

## Summary

(summary table by impact level + bulleted lists)
```

---

## Quality Checklist

Before committing the updated document, verify:

- [ ] Every definition that disappeared from `old_defs` is accounted for (renamed, removed, or merged).
- [ ] Every new definition in `new_defs` that doesn't correspond to a rename is listed under "New Definitions Added."
- [ ] Every breaking change is assigned an impact level (High / Medium / Low).
- [ ] The summary table counts match the number of items in the breaking-changes sections.
- [ ] The document includes a `> **Refreshed**: ...` note near the top indicating it was updated.
- [ ] All `$ref`-to-inline (or reverse) conversions were verified as structurally equivalent before being classified as non-breaking.

---

## Example Agent Prompt

Use the following prompt when delegating this task to a coding agent (e.g., GitHub Copilot Coding Agent):

---

> **Task**: The TSP-compiled `search.json` for `<api-version>` has been updated in the current `main` branch.
> Please refresh the swagger comparison document at
> `specification/search/data-plane/Search/swagger-comparison-<api-version>.md`
> to reflect the latest differences between the new TSP-compiled swagger and the hand-authored baseline.
>
> **Baseline (old)**: The hand-authored swagger files in
> `specification/search/data-plane/Search/preview/<prev-version>/`
> — specifically `searchservice.json`, `searchindex.json`, and `knowledgeagent.json` (if present).
>
> **New spec**: `specification/search/data-plane/Search/preview/<api-version>/search.json`
>
> **Comparison rules**:
> 1. If a `$ref` to a named model is replaced by an equivalent inline schema (or vice versa) with the same unfolded content, that is **not** a breaking change.
> 2. If a definition is renamed but its content is identical, document it as a rename (non-breaking).
> 3. Classify every breaking change into: **High** (wire-format impact), **Medium** (SDK-code-gen only), or **Low** (cosmetic / bug-fix).
>
> Update the document in place, add a `> **Refreshed**: ...` banner near the top, and commit the change.

---

*This prompt file is intended to make the comparison task reproducible and consistent across API versions and future TypeSpec migrations.*
