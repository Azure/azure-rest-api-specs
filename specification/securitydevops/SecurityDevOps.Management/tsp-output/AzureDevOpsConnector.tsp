import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityDevOps;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  AzureDevOpsConnectorProperties
)
@includeInapplicableMetadataInPayload(false)
model AzureDevOpsConnector extends TrackedResourceBase {
  /**
   * Name of the AzureDevOps Connector.
   */
  @path
  @key("azureDevOpsConnectorName")
  @segment("azureDevOpsConnectors")
  name: string;

  @extension("x-ms-client-flatten", true)
  properties?: AzureDevOpsConnectorProperties;
}

@armResourceOperations
interface AzureDevOpsConnectors {
  /**
   * Returns a monitored AzureDevOps Connector resource for a given ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsConnector_Get")
  get is ArmResourceRead<AzureDevOpsConnector>;

  /**
   * Creates or updates an Azure DevOps Connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsConnector_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AzureDevOpsConnector,
    BaseParameters<AzureDevOpsConnector>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update monitored AzureDevOps Connector details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("AzureDevOpsConnector_Update")
  update is ArmCustomPatchAsync<AzureDevOpsConnector, AzureDevOpsConnector>;

  /**
   * Delete monitored AzureDevOps Connector details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsConnector_Delete")
  delete is ArmResourceDeleteAsync<AzureDevOpsConnector>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsConnector_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AzureDevOpsConnector>;

  /**
   * Returns a list of monitored AzureDevOps Connectors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsConnector_ListBySubscription")
  listBySubscription is ArmListBySubscription<AzureDevOpsConnector>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"

  // FIXME: AzureDevOpsRepo_ListByConnector could not be converted to a resource operation
  @operationId("AzureDevOpsRepo_ListByConnector")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/repos")
  @get
  listByConnector is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * Name of the AzureDevOps Connector.
       */
      @path
      azureDevOpsConnectorName: string;
    },
    ResourceListResult<AzureDevOpsRepo>
  >;

  /**
   * Returns the summary of the AzureDevOps Connector Stats.
   */
  // FIXME: AzureDevOpsConnectorStats_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsConnectorStats_Get")
  @summary("Returns the summary of the AzureDevOps Connector Stats.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/stats")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * Name of the AzureDevOps Connector.
       */
      @path
      azureDevOpsConnectorName: string;
    },
    AzureDevOpsConnectorStatsListResponse
  >;
}

@@projectedName(AzureDevOpsConnectors.createOrUpdate::parameters.resource,
  "json",
  "azureDevOpsConnector"
);
@@extension(AzureDevOpsConnectors.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "azureDevOpsConnector"
);
@@doc(AzureDevOpsConnectors.createOrUpdate::parameters.resource,
  "Connector resource payload."
);
@@projectedName(AzureDevOpsConnectors.update::parameters.properties,
  "json",
  "azureDevOpsConnector"
);
@@extension(AzureDevOpsConnectors.update::parameters.properties,
  "x-ms-client-name",
  "azureDevOpsConnector"
);
@@doc(AzureDevOpsConnectors.update::parameters.properties,
  "Connector resource payload."
);
