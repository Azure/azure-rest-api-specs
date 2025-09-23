import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Sovereign;

@doc("The Microsoft Sovereign Provider version.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Public preview version.")
  Preview20250227: "2025-02-27-preview",
}

@added(Versions.Preview20250227)
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
