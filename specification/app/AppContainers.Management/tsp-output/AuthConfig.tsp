import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.App;
@doc("Configuration settings for the Azure ContainerApp Service Authentication / Authorization feature.")
@parentResource(ContainerApp)
model AuthConfig is ProxyResource<AuthConfigProperties> {
  @doc("Name of the Container App AuthConfig.")
  @key("authConfigName")
  @segment("authConfigs")
  name: string;
}

@armResourceOperations
@projectedName("client", "ContainerAppsAuthConfigs")
interface AuthConfigs_ContainerAppsAuthConfigs {
  @doc("Get a AuthConfig of a Container App.")
  get is ArmResourceRead<AuthConfig>;

  @doc("Create or update the AuthConfig for a Container App.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AuthConfig>;

  @doc("Delete a Container App AuthConfig.")
  delete is ArmResourceDeleteSync<AuthConfig>;

  @doc("Get the Container App AuthConfigs in a given resource group.")
  listByContainerApp is ArmResourceListByParent<AuthConfig>;
}
