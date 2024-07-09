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
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
  @doc("API Version 2023-10-01-preview")
  v2023_10_01_preview: "2023-10-01-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
  @doc("Version 2024-01-01-preview of Microsoft.Monitor")
  v2024_01_01_preview: "2024-01-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("API Version 2024-10-01")
  v2024_10_01: "2024-10-01",
}

@doc("The provisioning state of a resource.")
@lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being created.")
  Creating: "Creating",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",
}

@doc("The extended location info.")
model ExtendedLocation {
  @doc("The type of extended location.")
  type: ExtendedLocationType;

  @doc("The name of extended location.")
  name: string;
}

@doc("The extended location type.")
union ExtendedLocationType {
  string,

  @doc("Custom location.")
  CustomLocation: "CustomLocation",
}

interface Operations extends Azure.ResourceManager.Operations {}
