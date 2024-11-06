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

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API was moved to its own service."
@armProviderNamespace("Microsoft.Monitor")
@service({
  title: "Azure Monitor Pipelines Control Plane API",
})
@doc("Provides operations for working with Azure Monitor Pipelines")
@versioned(Microsoft.Monitor.Versions)
namespace Microsoft.Monitor;

@doc("Microsoft.Monitor Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("API Version 2024-10-01")
  v2024_10_01_preview: "2024-10-01-preview",
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
