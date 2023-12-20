import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Configuration settings for the Azure ContainerApp Service Authentication / Authorization feature.")
@parentResource(ContainerApp)
model ContainerAppAuthConfig is ProxyResource<AuthConfigProperties> {
  @doc("Name of the Container App AuthConfig.")
  @path
  @key("authConfigName")
  @segment("authConfigs")
  name: string;
}

@armResourceOperations
interface ContainerAppAuthConfigs {
  @doc("Get a AuthConfig of a Container App.")
  get is ArmResourceRead<ContainerAppAuthConfig>;
  @doc("Create or update the AuthConfig for a Container App.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ContainerAppAuthConfig>;
  @doc("Delete a Container App AuthConfig.")
  delete is ArmResourceDeleteSync<ContainerAppAuthConfig>;
  @doc("Get the Container App AuthConfigs in a given resource group.")
  listByContainerApp is ArmResourceListByParent<ContainerAppAuthConfig>;
}
