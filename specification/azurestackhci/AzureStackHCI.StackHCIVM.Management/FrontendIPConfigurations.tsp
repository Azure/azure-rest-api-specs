import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
@doc("FrontendIPConfiguration resource.")
@parentResource(LoadBalancer)
@added(Versions.v2025_09_01_preview)
model FrontendIPConfiguration
  is ProxyResource<FrontendIPConfigurationProperties> {
  @doc("Name of the frontend ip configuration.")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("frontendIPConfigurationName")
  @segment("frontendIPConfigurations")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface FrontendIPConfigurations {
  @doc("Gets the specified frontendIPConfiguration.")
  get is ArmResourceRead<FrontendIPConfiguration>;

  @doc("Creates or updates a frontendIPConfiguration in the specified resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FrontendIPConfiguration>;

  @doc("Deletes the specified frontendIPConfiguration.")
  delete is ArmResourceDeleteWithoutOkAsync<FrontendIPConfiguration>;

  @doc("Gets all frontendIPConfigurations in a LoadBalancer.")
  listByLoadBalancer is ArmResourceListByParent<FrontendIPConfiguration>;
}
