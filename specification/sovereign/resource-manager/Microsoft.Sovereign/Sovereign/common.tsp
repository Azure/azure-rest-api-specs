import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Sovereign;

@doc("The Microsoft Sovereign Provider version.")
enum Versions {
  @doc("The 2026-10-31 preview version.")
  @previewVersion
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  Preview20261031: "2026-10-31-preview",
}

@doc("The custom provisioning state.")
union provisioningState {
  ResourceProvisioningState,

  @doc("The state of the resource when creating")
  Creating: "Creating",

  @doc("The state of the resource when updating")
  Updating: "Updating",

  @doc("The state of the resource when deleting")
  Deleting: "Deleting",
}
