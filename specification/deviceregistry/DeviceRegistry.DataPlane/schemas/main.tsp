// ─────────────────────────────────────────────────────────────────────────────
// Standalone JSON Schema emission for the DeviceAttribute discriminated hierarchy.
//
// Why this is a separate compilation unit (not part of ../main.tsp):
//   The Azure SDK pipelines (tsp-client init) install only language emitters
//   declared in the main tspconfig.yaml. They do NOT install
//   `@typespec/json-schema`, so importing it from any file reachable by
//   ../main.tsp breaks every SDK pipeline with `import-not-found`.
//
//   Keeping this as its own entry point lets developers and CI regenerate the
//   JSON Schema files on demand without affecting SDK generation.
//
// To regenerate schemas (run from this repo's root):
//   npm install --no-save @typespec/json-schema@1.11.0
//   npx tsp compile specification/deviceregistry/DeviceRegistry.DataPlane/schemas
//   npx prettier --write "specification/deviceregistry/schemas/*.json"
//
// `@typespec/json-schema` is intentionally NOT in the repo's package.json (that file
// is owned by the Azure SDK team and PR validation rejects edits to it). Install it
// transiently with `--no-save` so it doesn't dirty package.json. The version should
// match the `@typespec/compiler` version pinned in the repo's package.json.
//
// The prettier pass is required because the json-schema emitter writes 4-space
// indentation, but this repo's prettier config (and the CI prettier check) expects
// 2-space indentation. Skipping prettier will fail the `Spec PR Tools - Prettier`
// CI check.
//
// Output: ../../../schemas/*.json (one file per @@jsonSchema model).
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
