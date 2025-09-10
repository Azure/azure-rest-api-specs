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
@service(#{ title: "Azure Monitor Control Plane API" })
@doc("Provides operations for working with Azure Monitor")
@versioned(Microsoft.Monitor.Versions)
namespace Microsoft.Monitor;

@doc("Microsoft.Monitor Versions")
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
  @doc("API Version 2023-10-01-preview")
  v2023_10_01_preview: "2023-10-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
  @doc("Version 2024-01-01-preview of Microsoft.Monitor")
  v2024_01_01_preview: "2024-01-01-preview",

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

interface Operations extends Azure.ResourceManager.Operations {}
