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
 * Definition of the dsc node configuration.
 */
@parentResource(AutomationAccount)
model DscNodeConfiguration
  is Azure.ResourceManager.ProxyResource<DscNodeConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = DscNodeConfiguration,
    KeyName = "nodeConfigurationName",
    SegmentName = "nodeConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DscNodeConfigurations {
  /**
   * Retrieve the Dsc node configurations by node configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DscNodeConfiguration_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodeconfigurations")
  get is ArmResourceRead<DscNodeConfiguration>;

  /**
   * Create the node configuration identified by node configuration name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DscNodeConfiguration_CreateOrUpdate")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodeconfigurations")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    DscNodeConfiguration,
    Request = DscNodeConfigurationCreateOrUpdateParameters,
    Response = OkResponse | ArmResourceCreatedResponse<
      DscNodeConfiguration,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Delete the Dsc node configurations by node configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DscNodeConfiguration_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodeconfigurations")
  delete is ArmResourceDeleteSync<
    DscNodeConfiguration,
    Response = ArmDeletedResponse
  >;

  /**
   * Retrieve a list of dsc node configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DscNodeConfiguration_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/dscnodeconfigurations")
  listByAutomationAccount is ArmResourceListByParent<
    DscNodeConfiguration,
    Parameters = {
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
    },
    Response = ArmResponse<DscNodeConfigurationListResult>
  >;
}

@@doc(DscNodeConfiguration.name, "The Dsc node configuration name.");
@@doc(DscNodeConfiguration.properties,
  "Gets or sets the configuration properties."
);
@@doc(DscNodeConfigurations.createOrUpdate::parameters.resource,
  "The create or update parameters for configuration."
);
