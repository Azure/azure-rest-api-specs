import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;
/**
 * Agent Pool.
 */
@parentResource(ManagedCluster)
model AgentPool
  is Azure.ResourceManager.ProxyResource<ManagedClusterAgentPoolProfileProperties> {
  ...ResourceNameParameter<
    Resource = AgentPool,
    KeyName = "agentPoolName",
    SegmentName = "agentPools",
    NamePattern = "^[a-z][a-z0-9]{0,11}$"
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface AgentPools {
  /**
   * Gets the specified managed cluster agent pool.
   */
  get is ArmResourceRead<AgentPool>;

  /**
   * Creates or updates an agent pool in the specified managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AgentPool,
    Parameters = {
      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;

      /**
       * The request should only proceed if no entity matches this string.
       */
      @header
      ifNoneMatch?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = AgentPool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an agent pool in the specified managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AgentPool,
    Parameters = {
      /**
       * ignore-pod-disruption-budget=true to delete those pods on a node without considering Pod Disruption Budget
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("ignore-pod-disruption-budget")
      `ignore-pod-disruption-budget`?: boolean;

      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;
    }
  >;

  /**
   * Gets a list of agent pools in the specified managed cluster.
   */
  list is ArmResourceListByParent<AgentPool>;

  /**
   * Aborts the currently running operation on the agent pool. The Agent Pool will be moved to a Canceling state and eventually to a Canceled state when cancellation finishes. If the operation completes before cancellation can take place, a 409 error code is returned.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("abort")
  @summary("Aborts last operation running on agent pool.")
  abortLatestOperation is ArmResourceActionAsync<
    AgentPool,
    void,
    NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Completes the upgrade operation for the specified agent pool.
   */
  @added(Versions.v2025_10_02_preview)
  @summary("Completes the upgrade of an agent pool.")
  completeUpgrade is ArmResourceActionAsyncBase<
    AgentPool,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AgentPool>
  >;

  /**
   * Deletes specific machines in an agent pool.
   */
  deleteMachines is ArmResourceActionAsyncBase<
    AgentPool,
    AgentPoolDeleteMachinesParameter,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AgentPool>
  >;

  /**
   * Upgrading the node image version of an agent pool applies the newest OS and runtime updates to the nodes. AKS provides one new image per week with the latest updates. For more details on node image versions, see: https://docs.microsoft.com/azure/aks/node-image-upgrade
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Upgrades the node image version of an agent pool to the latest.")
  upgradeNodeImageVersion is ArmResourceActionAsyncBase<
    AgentPool,
    void,
    {
      ...AcceptedResponse;
      ...ArmAsyncOperationHeader<FinalResult = void>;
      ...Azure.Core.Foundations.RetryAfterHeader;

      @body
      body: AgentPool;
    } | OkResponse,
    Foundations.DefaultBaseParameters<AgentPool>
  >;

  /**
   * Get the status of a specific operation in the specified agent pool.
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ContainerService/managedClusters/{resourceName}/agentPools/{agentPoolName}/operations/{operationId}")
  @added(Versions.v2025_10_02_preview)
  getByAgentPool is AgentPoolsOps.ActionSync<
    AgentPool,
    void,
    ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>,
    Parameters = {
      /**
       * The ID of an ongoing async operation.
       */
      @minLength(1)
      @path
      operationId: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface AgentPoolsOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...ParentKeysOf<AgentPool>,
      },
      {
        /**
         * The name of the agent pool.
         */
        @path
        @pattern("^[a-z][a-z0-9]{0,11}$")
        @segment("agentPools")
        @maxLength(12)
        @minLength(1)
        agentPoolName: string,
      },
      ErrorResponse,
      #{ useStaticRoute: true }
    > {}

@@maxLength(AgentPool.name, 12);
@@minLength(AgentPool.name, 1);
@@doc(AgentPool.name, "The name of the agent pool.");
@@doc(AgentPool.properties, "Properties of an agent pool.");
@@doc(AgentPools.createOrUpdate::parameters.resource,
  "The agent pool to create or update."
);
@@doc(AgentPools.deleteMachines::parameters.body,
  "A list of machines from the agent pool to be deleted."
);
