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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(NetworkSecurityPerimeter)
model NspLoggingConfiguration extends CommonProxyResource {
  /**
   * Properties of the NSP logging configuration.
   */
  properties?: NspLoggingConfigurationProperties;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("loggingConfigurationName")
  @segment("loggingConfigurations")
  @pattern("(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)")
  name: string;
}

@@doc(NspLoggingConfiguration.name, "The name of the resource");

@armResourceOperations
interface NspLoggingConfigurations {
  /**
   * Gets the NSP logging configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterLoggingConfigurations_Get")
  get is ArmResourceRead<NspLoggingConfiguration, Error = CloudError>;

  /**
   * Creates or updates NSP logging configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterLoggingConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    NspLoggingConfiguration,
    Error = CloudError
  >;

  /**
   * Deletes an NSP Logging configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterLoggingConfigurations_Delete")
  delete is ArmResourceDeleteSync<NspLoggingConfiguration, Error = CloudError>;

  /**
   * Lists the NSP logging configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterLoggingConfigurations_List")
  list is ArmResourceListByParent<NspLoggingConfiguration, Error = CloudError>;
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
