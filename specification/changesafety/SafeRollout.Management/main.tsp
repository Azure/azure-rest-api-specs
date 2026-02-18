import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./saferollout.tsp";
import "./step.tsp";
import "./stage.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Suppress missing operations endpoint as the same is defined ../operations/ChangeControl.Management/main.tsp."
@armProviderNamespace
@service(#{ title: "Microsoft.ChangeSafety management service" })
@versioned(Microsoft.ChangeSafety.Versions)
namespace Microsoft.ChangeSafety;

enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_03_01_preview: "2025-03-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01_preview: "2026-01-01-preview",
}

@added(Versions.v2026_01_01_preview)
interface Operations extends Azure.ResourceManager.Operations {}
