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
/**
 * Configuration settings for the Azure ContainerApp Service Authentication / Authorization feature.
 */
@parentResource(ContainerApp)
model AuthConfig is ProxyResource<AuthConfigProperties> {
  /**
   * Name of the Container App AuthConfig.
   */
  @path
  @key("authConfigName")
  @segment("authConfigs")
  name: string;
}

@armResourceOperations
interface AuthConfigs {
  /**
   * Get a AuthConfig of a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsAuthConfigs_Get")
  get is ArmResourceRead<AuthConfig>;

  /**
   * Create or update the AuthConfig for a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsAuthConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AuthConfig>;

  /**
   * Delete a Container App AuthConfig.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsAuthConfigs_Delete")
  delete is ArmResourceDeleteSync<AuthConfig>;

  /**
   * Get the Container App AuthConfigs in a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
