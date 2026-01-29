import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Configuration settings for the Azure ContainerApp Service Authentication / Authorization feature.
 */
model AuthConfig is Azure.ResourceManager.ProxyResource<AuthConfigProperties> {
  ...ResourceNameParameter<
    Resource = AuthConfig,
    KeyName = "authConfigName",
    SegmentName = "authConfigs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AuthConfigs {
  /**
   * Get a AuthConfig of a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsAuthConfigs_Get")
  get is ArmResourceRead<AuthConfig>;

  /**
   * Create or update the AuthConfig for a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ContainerAppsAuthConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AuthConfig,
    Response = ArmResourceUpdatedResponse<AuthConfig>
  >;

  /**
   * Delete a Container App AuthConfig.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsAuthConfigs_Delete")
  delete is ArmResourceDeleteSync<AuthConfig>;

  /**
   * Get the Container App AuthConfigs in a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsAuthConfigs_ListByContainerApp")
  listByContainerApp is ArmResourceListByParent<
    AuthConfig,
    Response = ArmResponse<AuthConfigCollection>
  >;
}

@@doc(AuthConfig.name, "Name of the Container App AuthConfig.");
@@doc(AuthConfig.properties, "AuthConfig resource specific properties");
@@doc(AuthConfigs.createOrUpdate::parameters.resource,
  "Properties used to create a Container App AuthConfig"
);
