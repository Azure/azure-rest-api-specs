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
//   npx tsp compile specification/deviceregistry/DeviceRegistry.DataPlane/schemas
//
// Output: ../../data-plane/schemas/*.json (one file per @@jsonSchema model).
// ─────────────────────────────────────────────────────────────────────────────

import "@typespec/json-schema";
import "../main.tsp";

using TypeSpec.JsonSchema;
using Microsoft.DeviceRegistry;

@@jsonSchema(DeviceAttribute);
@@jsonSchema(UpdateDeviceAttribute);
@@jsonSchema(UpdateDeviceAttributeProperties);
