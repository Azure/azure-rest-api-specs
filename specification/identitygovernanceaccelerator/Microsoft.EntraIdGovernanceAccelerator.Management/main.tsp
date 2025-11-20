import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.EntraIdGovernanceAccelerator Resource Provider management API. */
@armProviderNamespace
@service(#{
  title: "Microsoft.EntraIdGovernanceAccelerator management service",
})
@versioned(Microsoft.EntraIdGovernanceAccelerator.Versions)
@doc("Microsoft EntraId Governance Accelerator Resource Provider management API.")
namespace Microsoft.EntraIdGovernanceAccelerator;

/** The available API versions. */
enum Versions {
  /** 2025-10-10-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_10_10_preview: "2025-10-10-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
