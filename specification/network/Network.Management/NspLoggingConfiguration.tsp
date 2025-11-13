import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSecurityPerimeter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The NSP logging configuration
 */
@parentResource(NetworkSecurityPerimeter)
model NspLoggingConfiguration
  is Azure.ResourceManager.ProxyResource<NspLoggingConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NspLoggingConfiguration,
    KeyName = "loggingConfigurationName",
    SegmentName = "loggingConfigurations",
    NamePattern = "(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)"
  >;
}

@armResourceOperations
interface NspLoggingConfigurations {
  /**
   * Gets the NSP logging configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterLoggingConfigurations_Get")
  get is ArmResourceRead<NspLoggingConfiguration>;

  /**
   * Creates or updates NSP logging configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterLoggingConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NspLoggingConfiguration>;

  /**
   * Deletes an NSP Logging configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterLoggingConfigurations_Delete")
  delete is ArmResourceDeleteSync<NspLoggingConfiguration>;

  /**
   * Lists the NSP logging configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterLoggingConfigurations_List")
  list is ArmResourceListByParent<NspLoggingConfiguration>;
}

@@maxLength(NspLoggingConfiguration.name, 80);
@@doc(NspLoggingConfiguration.name,
  "The name of the NSP logging configuration. Accepts 'instance' as name."
);
@@doc(NspLoggingConfiguration.properties,
  "Properties of the NSP logging configuration."
);
@@doc(NspLoggingConfigurations.createOrUpdate::parameters.resource,
  "Parameters that hold the NspLoggingConfiguration to be created/updated."
);
