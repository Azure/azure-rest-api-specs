import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Application Configuration Service resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceResource)
@Azure.ResourceManager.Private.armResourceInternal(
  ConfigurationServiceProperties
)
@includeInapplicableMetadataInPayload(false)
model ConfigurationServiceResource extends ProxyResource {
  /**
   * The name of Application Configuration Service.
   */
  @path
  @key("configurationServiceName")
  @segment("configurationServices")
  name: string;

  /**
   * Application Configuration Service properties payload
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConfigurationServiceProperties;
}

@armResourceOperations
interface ConfigurationServiceResources {
  /**
   * Get the Application Configuration Service and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationServices_Get")
  get is ArmResourceRead<ConfigurationServiceResource>;

  /**
   * Create the default Application Configuration Service or update the existing Application Configuration Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConfigurationServiceResource>;

  /**
   * Disable the default Application Configuration Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationServices_Delete")
  delete is ArmResourceDeleteAsync<ConfigurationServiceResource>;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationServices_List")
  list is ArmResourceListByParent<ConfigurationServiceResource>;

  /**
   * Check if the Application Configuration Service settings are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationServices_Validate")
  validate is ArmResourceActionAsync<
    ConfigurationServiceResource,
    ConfigurationServiceSettings,
    ConfigurationServiceSettingsValidateResult,
    BaseParameters<ConfigurationServiceResource>,
    ArmLroLocationHeader
  >;
}

@@projectedName(ConfigurationServiceResources.createOrUpdate::parameters.resource,
  "json",
  "configurationServiceResource"
);
@@extension(ConfigurationServiceResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "configurationServiceResource"
);
@@doc(ConfigurationServiceResources.createOrUpdate::parameters.resource,
  "Parameters for the update operation"
);
@@projectedName(ConfigurationServiceResources.validate::parameters.body,
  "json",
  "settings"
);
@@extension(ConfigurationServiceResources.validate::parameters.body,
  "x-ms-client-name",
  "settings"
);
@@doc(ConfigurationServiceResources.validate::parameters.body,
  "Application Configuration Service settings to be validated"
);
