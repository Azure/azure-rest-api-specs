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
/**
 * Represents an ARM resource for /subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.SecurityDevOps/gitHubConnectors.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(GitHubConnectorProperties)
model GitHubConnector extends TrackedResourceBase {
  /**
   * Name of the GitHub Connector.
   */
  @path
  @key("gitHubConnectorName")
  @segment("gitHubConnectors")
  @visibility("read")
  name: string;

  /**
   * Properties of the ARM resource for /subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.SecurityDevOps/gitHubConnectors.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GitHubConnectorProperties;
}

@armResourceOperations
interface GitHubConnectors {
  /**
   * Returns a monitored GitHub Connector resource for a given ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubConnector_Get")
  get is ArmResourceRead<GitHubConnector>;

  /**
   * Create or update a monitored GitHub Connector resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubConnector_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GitHubConnector,
    BaseParameters<GitHubConnector>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update monitored GitHub Connector details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("GitHubConnector_Update")
  update is ArmCustomPatchAsync<GitHubConnector, GitHubConnector>;

  /**
   * Delete monitored GitHub Connector details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubConnector_Delete")
  delete is ArmResourceDeleteAsync<GitHubConnector>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubConnector_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<GitHubConnector>;

  /**
   * Returns a list of monitored GitHub Connectors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubConnector_ListBySubscription")
  listBySubscription is ArmListBySubscription<GitHubConnector>;

  /**
   * Returns a list of monitored GitHub repositories.
   */
  // FIXME: GitHubRepo_ListByConnector could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubRepo_ListByConnector")
  @summary("Returns a list of monitored GitHub repositories.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/repos")
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
       * Name of the GitHub Connector.
       */
      @path
      gitHubConnectorName: string;
    },
    ResourceListResult<GitHubRepo>
  >;

  /**
   * Returns the summary of the GitHub Connector Stats.
   */
  // FIXME: GitHubConnectorStats_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GitHubConnectorStats_Get")
  @summary("Returns the summary of the GitHub Connector Stats.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/stats")
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
       * Name of the GitHub Connector.
       */
      @path
      gitHubConnectorName: string;
    },
    GitHubConnectorStatsListResponse
  >;
}

@@projectedName(GitHubConnectors.createOrUpdate::parameters.resource,
  "json",
  "gitHubConnector"
);
@@extension(GitHubConnectors.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "gitHubConnector"
);
@@doc(GitHubConnectors.createOrUpdate::parameters.resource,
  "Connector resource payload."
);
@@projectedName(GitHubConnectors.update::parameters.properties,
  "json",
  "gitHubConnector"
);
@@extension(GitHubConnectors.update::parameters.properties,
  "x-ms-client-name",
  "gitHubConnector"
);
@@doc(GitHubConnectors.update::parameters.properties,
  "Connector resource payload."
);
