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
 * Definition of the dsc node configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(
  DscNodeConfigurationProperties
)
@includeInapplicableMetadataInPayload(false)
model DscNodeConfiguration extends ProxyResourceBase {
  /**
   * The Dsc node configuration name.
   */
  @path
  @key("nodeConfigurationName")
  @segment("nodeConfigurations")
  name: string;

  /**
   * Gets or sets the configuration properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DscNodeConfigurationProperties;
}

@armResourceOperations
interface DscNodeConfigurations {
  /**
   * Retrieve the Dsc node configurations by node configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscNodeConfiguration_Get")
  get is ArmResourceRead<DscNodeConfiguration>;

  /**
   * Create the node configuration identified by node configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscNodeConfiguration_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DscNodeConfiguration>;

  /**
   * Delete the Dsc node configurations by node configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscNodeConfiguration_Delete")
  delete is ArmResourceDeleteSync<DscNodeConfiguration>;

  /**
   * Retrieve a list of dsc node configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscNodeConfiguration_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    DscNodeConfiguration,
    {
      ...BaseParameters<DscNodeConfiguration>;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of rows to skip.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * The number of rows to take.
       */
      @query("$top")
      $top?: int32;

      /**
       * Return total rows.
       */
      @query("$inlinecount")
      $inlinecount?: string;
    }
  >;
}

@@projectedName(DscNodeConfigurations.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DscNodeConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DscNodeConfigurations.createOrUpdate::parameters.resource,
  "The create or update parameters for configuration."
);
