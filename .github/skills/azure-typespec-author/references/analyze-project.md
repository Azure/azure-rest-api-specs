# Analyze Project

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

## Output

Display the results before proceeding to Step 2:

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
```
