import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Software update configuration properties.
 */
@parentResource(AutomationAccount)
model softwareUpdateConfiguration
  is Azure.ResourceManager.ProxyResource<
    softwareUpdateConfigurationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = softwareUpdateConfiguration,
    KeyName = "softwareUpdateConfigurationName",
    SegmentName = "softwareUpdateConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SoftwareUpdateConfigurations {
  /**
   * Get a single software update configuration by name.
   */
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/softwareupdateconfigurationoperations")
  getByName is ArmResourceRead<
    softwareUpdateConfiguration,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Create a new software update configuration with the name given in the URI.
   */
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/softwareupdateconfigurationoperations")
  create is ArmResourceCreateOrReplaceSync<
    softwareUpdateConfiguration,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * delete a specific software update configuration.
   */
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/softwareupdateconfigurationoperations")
  delete is ArmResourceDeleteSync<
    softwareUpdateConfiguration,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;
}

@@doc(softwareUpdateConfiguration.name,
  "The name of the software update configuration to be created."
);
@@doc(softwareUpdateConfiguration.properties,
  "Software update configuration properties."
);
@@doc(SoftwareUpdateConfigurations.create::parameters.resource,
  "Request body."
);
