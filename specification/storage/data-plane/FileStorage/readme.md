# FileStorage

> see https://aka.ms/autorest

This is the configuration file for FileStorage swaggers.

---

## Getting Started

To generate the swagger in this folder, run:

> `tsp compile .`

To see additional help and options, run:

> `tsp --help`

---

## Configuration

### Basic Information

These are the global settings for the FileStorage API.

```yaml
openapi-type: data-plane
tag: package-2026-04-tsp
use-internal-constructors: true
add-credentials: true
```

### Tag: package-2026-04-tsp

These settings apply only when `--tag=package-2026-04-tsp` is specified on the command line.

```yaml $(tag) == 'package-2026-04-tsp'
input-file:
  - stable/2026-04-06/generated_file.json
```

### Suppression

```yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: These parameters are predfined by storage specifications
  - suppress: XmsPathsMustOverloadPaths
  - suppress: XmsExamplesRequired
  - suppress: LongRunningOperationsWithLongRunningExtension
  - suppress: OAV107
```

---
