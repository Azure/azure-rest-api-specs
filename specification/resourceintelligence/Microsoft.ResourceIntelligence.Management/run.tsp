import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./agent.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ResourceIntelligence;

// ============================================
// RUN RESOURCE
// ============================================

/**
 * A single execution run on an agent. Tracks run status, timing, and results.
 */
@parentResource(Agent)
model Run is ProxyResource<RunProperties> {
  /**
   * The unique identifier of the run.
   */
  @key("runId")
  @segment("runs")
  @pattern("^[a-zA-Z0-9-]{1,64}$")
  @path
  name: string;
}

/**
 * Properties of a Run resource.
 */
model RunProperties {
  /**
   * The provisioning state of the run.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The lifecycle status of the run.
   */
  @visibility(Lifecycle.Read)
  status?: RunStatus;

  /**
   * The timestamp when the run started.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The timestamp when the run completed.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * Error details if the run failed.
   */
  @visibility(Lifecycle.Read)
  error?: string;
}

// ============================================
// RUN OPERATIONS
// ============================================

@armResourceOperations
interface Runs {
  /**
   * Gets a run by ID.
   */
  get is ArmResourceRead<Run>;

  /**
   * Creates or updates a run.
   */
  @armResourceCreateOrUpdate(Run)
  @put
  createOrUpdate(
    ...ResourceInstanceParameters<Run>,

    /** The run request parameters. */
    @body resource: RunRequest,
  ): ArmResponse<Run> | ArmCreatedResponse<Run> | ErrorResponse;

  /**
   * Deletes a run.
   */
  delete is ArmResourceDeleteSync<Run>;

  /**
   * Lists runs for an agent.
   */
  listByParent is ArmResourceListByParent<Run>;
}

// ============================================
// LATEST RUN OPERATIONS
// ============================================

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "LatestRuns uses a custom route for the singleton 'latest' endpoint"
@tag("Runs")
interface LatestRuns {
  /**
   * Gets the latest run.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceIntelligence/agents/{agentName}/runs/latest")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the agent.
     */
    @path @pattern("^[a-zA-Z][a-zA-Z0-9-]{0,62}[a-zA-Z0-9]$") agentName: string,
  ): Run | ErrorResponse;
}
