import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Mixed version"
@armProviderNamespace("Microsoft.Monitor")
@service(#{ title: "Azure Monitor Control Plane API" })
@doc("Provides operations for working with Azure Monitor")
@versioned(Versions)
namespace Microsoft.Monitor;

@doc("Microsoft.Monitor Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
  @doc("API Version 2023-10-01-preview")
  `2023-10-01-preview`,
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
