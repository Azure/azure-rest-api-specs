import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
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
})
@doc("Provides operations for working with Azure Monitor")
@versioned(Microsoft.Monitor.Versions)
namespace Microsoft.Monitor;

@doc("Microsoft.Monitor Versions")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("API Version 2023-10-01-preview")
  v2023_10_01_preview: "2023-10-01-preview",
 //`2023-10-01-preview`,

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Version 2024-01-01-preview of Microsoft.Monitor")
  v2024_01_01_preview: "2024-01-01-preview",
  //`2024-01-01-preview`,
}

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
  @doc("Custom location.")
  CustomLocation,
}

interface Operations extends Azure.ResourceManager.Operations {}
