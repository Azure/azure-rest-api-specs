import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
@doc("Configuration settings for the Azure ContainerApp Service Authentication / Authorization feature.")
@parentResource(ContainerApp)
model AuthConfig is ProxyResource<AuthConfigProperties> {
  @doc("Name of the Container App AuthConfig.")
  @path
  @key("authConfigName")
  @segment("authConfigs")
  name: string;
}

@armResourceOperations
interface AuthConfigs {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a AuthConfig of a Container App.")
  @operationId("ContainerAppsAuthConfigs_Get")
  get is ArmResourceRead<AuthConfig>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the AuthConfig for a Container App.")
  @operationId("ContainerAppsAuthConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AuthConfig>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Container App AuthConfig.")
  @operationId("ContainerAppsAuthConfigs_Delete")
  delete is ArmResourceDeleteSync<AuthConfig>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Container App AuthConfigs in a given resource group.")
  @operationId("ContainerAppsAuthConfigs_ListByContainerApp")
  listByContainerApp is ArmResourceListByParent<AuthConfig>;
}

@@projectedName(AuthConfigs.createOrUpdate::parameters.resource,
  "json",
  "authConfigEnvelope"
);
@@extension(AuthConfigs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "authConfigEnvelope"
);
@@doc(AuthConfigs.createOrUpdate::parameters.resource,
  "Properties used to create a Container App AuthConfig"
);
