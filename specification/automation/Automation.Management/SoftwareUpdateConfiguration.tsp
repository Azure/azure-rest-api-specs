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
model SoftwareUpdateConfiguration
  is Azure.ResourceManager.ProxyResource<
    SoftwareUpdateConfigurationProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SoftwareUpdateConfiguration,
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
  getByName is ArmResourceRead<
    SoftwareUpdateConfiguration,
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
  create is ArmResourceCreateOrReplaceSync<
    SoftwareUpdateConfiguration,
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
  delete is ArmResourceDeleteSync<
    SoftwareUpdateConfiguration,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;
}

@@doc(SoftwareUpdateConfiguration.name,
  "The name of the software update configuration to be created."
);
@@doc(SoftwareUpdateConfiguration.properties,
  "Software update configuration properties."
);
@@doc(SoftwareUpdateConfigurations.create::parameters.resource,
  "Request body."
);
