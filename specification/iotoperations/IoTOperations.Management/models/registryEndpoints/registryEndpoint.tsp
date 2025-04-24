import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./auth.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations.RegistryEndpoints;

@doc("RegistryEndpoint resource")
@parentResource(InstanceResource)
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointResource is ProxyResource<RegistryEndpointProperties> {
  @doc("Name of RegistryEndpoint resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("registryEndpointName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("registryEndpoints")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@doc("RegistryEndpoint properties")
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointProperties {
  @doc("The Azure Container Registry endpoint hostname.")
  @pattern("^[a-z0-9]+\\.azurecr\\.io$")
  @maxLength(63)
  @minLength(3)
  host: string;

  @doc("The authentication settings for the Azure Container Registry.")
  authentication: Authentication;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
