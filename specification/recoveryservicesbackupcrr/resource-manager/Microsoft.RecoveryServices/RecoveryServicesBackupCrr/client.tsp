import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using Http;
using Microsoft.RecoveryServices;

// rename for duplicate model from Azure.ResourceManager.CommonTypes.
// The local legacy CRR envelope `Resource` (wire-faithful to the frozen 2023-01-15
// definition name "Resource") collides with the ARM common-types `Resource` in the
// SDK client scope (duplicate-client-name). Rename both to distinct client names -
// mirrors the active-stamp's ErrorDetail two-sided style. The autorest emitter is
// intentionally not in scope, so the emitted swagger definition remains "Resource".
@@clientName(Azure.ResourceManager.CommonTypes.Resource, "ArmResource");
@@clientName(Resource, "CrrResource", "csharp");

// rename for duplicate model from Azure.ResourceManager.CommonTypes.
// The local legacy `ErrorDetail` (code/message/recommendations) collides with the
// ARM common-types `ErrorDetail` (target/details/additionalInfo) in the SDK client
// scope. Rename both to distinct client names - mirrors the active-stamp exactly.
@@clientName(Azure.ResourceManager.CommonTypes.ErrorDetail, "ArmErrorDetail");
@@clientName(ErrorDetail, "BackupErrorDetail", "csharp");
