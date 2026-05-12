// ─────────────────────────────────────────────────────────────────────────────
// Standalone JSON Schema emission for the DeviceAttribute discriminated hierarchy.
//
// Why this is NOT a regular TypeSpec project (no tspconfig.yaml):
//   The Azure SDK pipelines (tsp-client init) and APIView discovery both walk the
//   tree looking for directories with `tspconfig.yaml` + `main.tsp` and try to
//   compile them. Neither pipeline installs `@typespec/json-schema`, so being
//   discovered as a project breaks them with `import-not-found`. By having only a
//   `main.tsp` here (no tspconfig.yaml), discovery skips this directory and the
//   schema generation runs only when invoked explicitly with the command below.
//
//   `@typespec/json-schema` is also intentionally NOT in the repo's package.json
//   (that file is owned by the Azure SDK team and PR validation rejects edits).
//
// To regenerate schemas (run from this repo's root):
//   npm install --no-save @typespec/json-schema@1.11.0
//   npx tsp compile specification/deviceregistry/DeviceRegistry.DataPlane/schemas/main.tsp `
//     --emit @typespec/json-schema `
//     --option "@typespec/json-schema.emitter-output-dir={cwd}/specification/deviceregistry/schemas" `
//     --option "@typespec/json-schema.file-type=json" `
//     --option "@typespec/json-schema.int64-strategy=string"
//   npx prettier --write "specification/deviceregistry/schemas/*.json"
//
// The `--no-save` flag prevents npm from dirtying package.json. Pin the json-schema
// version to match the `@typespec/compiler` version in the repo's package.json.
//
// The `{cwd}` template variable is required for the output path; bare relative paths
// are rejected by the TypeSpec compiler. The quotes around each `--option` value are
// required so PowerShell does not try to parse `{cwd}` as a script block.
//
// The prettier pass is required because the json-schema emitter writes 4-space
// indentation, but this repo's prettier config (and the CI prettier check) expects
// 2-space indentation. Skipping prettier will fail the `Spec PR Tools - Prettier`
// CI check.
//
// Output: specification/deviceregistry/schemas/*.json (one file per @@jsonSchema model).
//
// Note: output lives at specification/deviceregistry/schemas/ — deliberately NOT
// under data-plane/ so the OAV swagger validator does not try to interpret these
// JSON Schema files as swagger documents.
// ─────────────────────────────────────────────────────────────────────────────

import "@typespec/json-schema";
import "../main.tsp";

using TypeSpec.JsonSchema;
using Microsoft.DeviceRegistry;

@@jsonSchema(UpdateDeviceAttributeProperties);
