import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Software update configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(
  SoftwareUpdateConfigurationProperties
)
@includeInapplicableMetadataInPayload(false)
model SoftwareUpdateConfiguration extends ProxyResourceBase {
  /**
   * The name of the software update configuration to be created.
   */
  @path
  @key("softwareUpdateConfigurationName")
  @segment("softwareUpdateConfigurations")
  name: string;

  /**
   * Software update configuration properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: SoftwareUpdateConfigurationProperties;
}

@armResourceOperations
interface SoftwareUpdateConfigurations {
  /**
   * Get a single software update configuration by name.
   */
  getByName is ArmResourceRead<
    SoftwareUpdateConfiguration,
    {
      ...BaseParameters<SoftwareUpdateConfiguration>;

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
    {
      ...BaseParameters<SoftwareUpdateConfiguration>;

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
    {
      ...BaseParameters<SoftwareUpdateConfiguration>;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Get all software update configurations for the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SoftwareUpdateConfigurations_List")
  list is ArmResourceListByParent<
    SoftwareUpdateConfiguration,
    {
      ...BaseParameters<SoftwareUpdateConfiguration>;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(SoftwareUpdateConfigurations.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(SoftwareUpdateConfigurations.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SoftwareUpdateConfigurations.create::parameters.resource,
  "Request body."
);
