import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.Monitor")
@service({
  title: "Azure Monitor Control Plane API",
  version: "2023-10-01-preview",
})
@doc("Provides operations for working with Azure Monitor")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Monitor;

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is being created.")
  Creating,

  @doc("The resource is being deleted.")
  Deleting,
}

@doc("The extended location info.")
model ExtendedLocation {
  @doc("The type of extended location.")
  type: ExtendedLocationType;

  @doc("The name of extended location.")
  name: string;
}

@doc("The extended location type.")
enum ExtendedLocationType {
  @doc("CustomLocation.")
  CustomLocation,
}

interface Operations extends Azure.ResourceManager.Operations {}
