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
@parentResource(ContainerApp)
model AuthConfig is Azure.ResourceManager.ProxyResource<AuthConfigProperties> {
  ...ResourceNameParameter<
    Resource = AuthConfig,
    KeyName = "authConfigName",
    SegmentName = "authConfigs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ContainerAppsAuthConfigs {
  /**
   * Get a AuthConfig of a Container App.
   */
  @summary("Get a AuthConfig of a Container App.")
  get is ArmResourceRead<AuthConfig, Error = DefaultErrorResponse>;

  /**
   * Create or update the AuthConfig for a Container App.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update the AuthConfig for a Container App.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AuthConfig,
    Response = ArmResourceUpdatedResponse<AuthConfig>,
    Error = DefaultErrorResponse
  >;

  /**
   * Delete a Container App AuthConfig.
   */
  @summary("Delete a Container App AuthConfig.")
  delete is ArmResourceDeleteSync<AuthConfig, Error = DefaultErrorResponse>;

  /**
   * Get the Container App AuthConfigs in a given resource group.
   */
  @get
  @list
  @action("authConfigs")
  @summary("Get the Container App AuthConfigs in a given resource group.")
  listByContainerApp is ArmResourceActionSync<
    ContainerApp,
    void,
    Response = ArmResponse<AuthConfigCollection>,
    Error = DefaultErrorResponse
  >;
}

@@doc(AuthConfig.name, "Name of the Container App AuthConfig.");
@@doc(AuthConfig.properties, "AuthConfig resource specific properties");
@@doc(ContainerAppsAuthConfigs.createOrUpdate::parameters.resource,
  "Properties used to create a Container App AuthConfig"
);
