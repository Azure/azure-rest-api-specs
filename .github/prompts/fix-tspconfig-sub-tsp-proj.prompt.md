---
description: Fix tspconfig.yaml of sub tsp project for api version
---

# Fix tspconfig.yaml Relative Paths

Edit `tspconfig.yaml` to align relative paths with the standard pattern used in this project.

## Changes to make

1. Remove `azure-resource-provider-folder: "resource-manager"` line
2. Simplify `output-file` — remove the `{azure-resource-provider-folder}/{service-name}/` prefix, keeping only `"{version-status}/{version}/<filename>.json"`
3. Add `arm-types-dir: "{project-root}/../../../../../common-types/resource-management"` after `emit-lro-options`

## Before

```yaml
options:
  "@azure-tools/typespec-autorest":
    omit-unreachable-types: true
    emitter-output-dir: "{project-root}/.."
    azure-resource-provider-folder: "resource-manager"
    output-file: "{azure-resource-provider-folder}/{service-name}/{version-status}/{version}/<filename>.json"
    emit-lro-options: "all"
    examples-dir: "{project-root}/examples"
```

## After

```yaml
options:
  "@azure-tools/typespec-autorest":
    omit-unreachable-types: true
    emitter-output-dir: "{project-root}/.."
    output-file: "{version-status}/{version}/<filename>.json"
    emit-lro-options: "all"
    arm-types-dir: "{project-root}/../../../../../common-types/resource-management"
    examples-dir: "{project-root}/examples"
```
