import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Application Configuration Service resource
 */
@parentResource(ServiceResource)
model ConfigurationServiceResource
  is Azure.ResourceManager.ProxyResource<ConfigurationServiceProperties> {
  ...ResourceNameParameter<
    Resource = ConfigurationServiceResource,
    KeyName = "configurationServiceName",
    SegmentName = "configurationServices",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

@armResourceOperations
interface ConfigurationServiceResources {
  /**
   * Get the Application Configuration Service and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationServices_Get")
  get is ArmResourceRead<ConfigurationServiceResource>;

  /**
   * Create the default Application Configuration Service or update the existing Application Configuration Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConfigurationServiceResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Disable the default Application Configuration Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ConfigurationServices_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ConfigurationServiceResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationServices_List")
  list is ArmResourceListByParent<
    ConfigurationServiceResource,
    Response = ArmResponse<ConfigurationServiceResourceCollection>
  >;

  /**
   * Check if the Application Configuration Service settings are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationServices_Validate")
  validate is ArmResourceActionAsync<
    ConfigurationServiceResource,
    ConfigurationServiceSettings,
    ArmResponse<ConfigurationServiceSettingsValidateResult>
  >;

  /**
   * Check if the Application Configuration Service resource is valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationServices_ValidateResource")
  validateResource is ArmResourceActionAsync<
    ConfigurationServiceResource,
    ConfigurationServiceResource,
    ArmResponse<ConfigurationServiceSettingsValidateResult>
  >;
}

@@doc(ConfigurationServiceResource.name,
  "The name of Application Configuration Service."
);
@@doc(ConfigurationServiceResource.properties,
  "Application Configuration Service properties payload"
);
@@doc(ConfigurationServiceResources.createOrUpdate::parameters.resource,
  "Parameters for the update operation"
);
@@doc(ConfigurationServiceResources.validate::parameters.body,
  "Application Configuration Service settings to be validated"
);
@@doc(ConfigurationServiceResources.validateResource::parameters.body,
  "Application Configuration Service resource to be validated"
);
