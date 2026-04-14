# Analyze Project & Classify Task

## Part 1 — Analyze Project

Collect the inputs below from the TypeSpec project. Ask **up to 6 concise questions** for any that are missing.

| #   | Input                       | Example                                                          |
| --- | --------------------------- | ---------------------------------------------------------------- |
| 1   | TypeSpec project root       | `/specification/widget/resource-manager/Microsoft.Widget/Widget` |
| 2   | Path to `tspconfig.yaml`    | `<spec-root>/tspconfig.yaml`                                     |
| 3   | Service type                | ARM / data-plane                                                 |
| 4   | Existing API versions       | `2024-01-01 (stable)`, `2024-06-01-preview`                      |
| 5   | Latest API version          | Most recent entry in the `Versions` enum                         |
| 6   | Current working API version | The version being added or modified this session                 |
| 7   | Intent                      | add / modify / fix                                               |
| 8   | Target resource/interface   | Resource or operation name (if known)                            |
| 9   | Constraints                 | Breaking-change limits, naming rules, emitter targets, etc.      |

## Part 2 — Classify Task

> **CRITICAL:** Classify into exactly one task type below and state your classification **before** proceeding to Step 2.

### Definitions

| Type                      | What it means                                                                                                                       | Tool Restriction                                                                        |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| **API Version Evolution** | Adding a new preview or stable API version to an existing ARM service. Data-plane API version evolution is not fully supported yet. | **MUST NOT** call `azsdk_typespec_generate_authoring_plan`. Uses web-fetched docs only. |
| **General Authoring**     | Any other TypeSpec authoring task that modifies `.tsp` files (resources, operations, models, properties, etc.)                      | **MUST** call `azsdk_typespec_generate_authoring_plan` in Step 3.                       |

### How to Classify

**API Version Evolution** — any request whose **primary intent** is to introduce a new API version string.
Keyword patterns:

- _"add a new … API version"_, _"new preview version"_, _"new stable version"_
- _"bump API version"_, _"introduce version"_, _"add … preview"_, _"add … stable"_

**General Authoring** — everything else that modifies `.tsp` files **without** introducing a new API version.

### Example Prompts

| Type                      | Examples                                                                                                                                                                                                                          |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **API Version Evolution** | "Add a new preview API version 2026-01-01-preview for widget resource manager", "Add preview version 2025-06-01-preview", "Bump to stable version 2026-01-01 for Microsoft.Widget", "Introduce a new preview API version for Foo" |
| **General Authoring**     | "Add an ARM resource named Asset with CRUD operations", "Add a new property to the Widget model"                                                                                                                                  |

## Output

Display the results before proceeding:

```
TypeSpec project root: /path/to/project
tspconfig.yaml:  /path/to/project/tspconfig.yaml
Service Type:    ARM
API Versions:    2024-01-01 (stable), 2024-06-01-preview (preview)
Latest Version:  2024-06-01-preview
Working Version: [TBD]
Intent:          [add/modify/fix]
Target:          [resource/operation if known]
Constraints:     [if any]
Task Type:       [API Version Evolution | General Authoring]
```
