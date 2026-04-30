<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-22
     Derived from:
       - Azure REST API Guidelines (vNext)
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
       - Azure Resource Provider Contract (RPC) v1.0
         https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0
     The upstream documents always take precedence if there is a conflict. -->

# Example File Quality Rules

Example files referenced by `x-ms-examples` (OpenAPI) or generated from
TypeSpec example directories are published in Microsoft's public Azure
documentation and embedded in SDK samples. They are often the first
thing a customer reads when learning how to use an API. These rules
ensure example files are accurate, complete, and professional.

**Authoritative references:**

- [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)
- [Azure Resource Provider Contract](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0)

---

## EX-ORPHAN — Orphan Detection

- **Rule ID:** `EX-ORPHAN`
- **Severity:** Warning

Every example file in a PR **MUST** be referenced by exactly one
`x-ms-examples` entry in the specification. An orphaned example file
(not referenced by any operation) **MUST** be flagged.

### Detection

- For OpenAPI: search all `.json` spec files in the same package tag for
  `x-ms-examples` entries that reference the example file path.
- For TypeSpec: verify the example file is in the correct
  `examples/<api-version>/` directory and corresponds to an operation
  defined in the TypeSpec project.

### Fix

- If the example is intentional, add the corresponding `x-ms-examples`
  reference to the operation definition.
- If the example is leftover from a refactoring, delete the orphaned
  file.

---

## EX-COVERAGE — Example Coverage

- **Rule ID:** `EX-COVERAGE`
- **Severity:** Warning

### Rules

- PUT and PATCH operations **SHOULD** have at least two examples: one
  with the minimum required properties and one with the full/maximum
  property set.
- Operations with multiple possible request shapes (e.g., polymorphic
  discriminators, mutually exclusive property groups) **SHOULD** have
  separate examples for each variant.
- LRO operations **SHOULD** have examples showing both the initial
  response (e.g., `202`) and the final response (e.g., `200`).

### Fix

Add the missing example files and wire them into the specification via
`x-ms-examples` (OpenAPI) or the `examples/` directory (TypeSpec).

---

## EX-DESCRIPTIVE-VALUES — Descriptive Example Values

- **Rule ID:** `EX-DESCRIPTIVE-VALUES`
- **Severity:** Warning

Example values **MUST** be realistic and descriptive. Examples are
published in Microsoft's public Azure documentation and embedded in SDK
samples — they are often the first thing a customer reads when learning
how to use an API.

### Rules

- **Resource names** in URLs and request/response bodies **MUST** use
  recognizable, human-readable names (e.g., `"myVmScaleSet"`,
  `"testVault"`, `"myResourceGroup"`) — not random strings or repeated
  characters.
- **Property values** (instance IDs, SKU names, locations, tags, etc.)
  **MUST** reflect realistic usage that helps the reader understand the
  parameter's purpose (e.g., `"Standard_DS1_v2"` for a VM size;
  `"eastus"` for a location; `{"env": "production"}` for tags).
- Auto-generated examples (e.g., from `oav generate-examples` or
  `tsp compile`) **SHOULD** be hand-edited to replace filler values
  before submitting.

### Specifically Forbidden Patterns

- Resource names consisting entirely of a single repeated character
  (e.g., `"aaa"`, `"aaaaaaa"`, `"xxxxxxx"`, `"zzzzzzz"`)
- Bare generic filler: `"string"` as a value for a property where a
  meaningful example exists (acceptable only when the property has no
  well-known values and the schema provides no further guidance)
- Numeric-looking garbage: `"12345"` or `"11111"` for a property that
  represents a real-world concept (e.g., a resource name, a display
  name)

### Acceptable Generic Values

- Subscription IDs, tenant IDs, principal IDs, and other GUIDs:
  <!-- cSpell:ignore subid -->
  stylized placeholders like `"00000000-0000-0000-0000-000000000000"`
  or `"subid"` per existing convention
- Operation IDs in LRO polling URLs:
  `"00000000-0000-0000-0000-000000000000"` is acceptable
- Properties with no well-known values where the schema description is
  the primary guidance: a short descriptive string like `"my-value"` is
  acceptable

### Fix

Replace filler values with short, meaningful names that help the reader
understand what the parameter represents. For example:

- `"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa"` → `"myVmScaleSet"`
- `"aaaaaaaaaaaaaaaaa"` (instance ID) → `"0"`
- `"string"` (location) → `"eastus"`

### Format-Specific Notes

#### OpenAPI JSON (Swagger)

Filler values typically appear in `x-ms-examples` JSON files under
`examples/`. Check both `parameters` and `responses` sections.

#### TypeSpec

Example files live in `examples/<api-version>/` directories. TypeSpec
compilation may auto-generate example files with placeholder values —
these **MUST** be hand-edited before merging.
