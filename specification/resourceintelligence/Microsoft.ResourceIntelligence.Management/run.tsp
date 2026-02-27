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

@armResourceOperations
interface LatestRuns {
  /**
   * Gets the latest run.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceIntelligence/agents/{agentName}/runs/latest")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupNameParameter,
    @path @pattern("^[a-zA-Z][a-zA-Z0-9-]{0,62}[a-zA-Z0-9]$") agentName: string,
  ): Run | ErrorResponse;

  /**
   * Creates or updates a run via PUT for ARM/Bicep compatibility.
   * The "latest" name is a logical identifier — the actual run ID is generated server-side.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceIntelligence/agents/{agentName}/runs/latest")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupNameParameter,
    @path @pattern("^[a-zA-Z][a-zA-Z0-9-]{0,62}[a-zA-Z0-9]$") agentName: string,
    @body body: RunRequest,
  ): Run | { @statusCode statusCode: 201; @body body: Run } | ErrorResponse;
}
