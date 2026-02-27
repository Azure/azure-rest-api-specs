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
}

// ============================================
// LATEST RUN (SINGLETON)
// ============================================

/**
 * Singleton resource representing the latest run.
 * Provides PUT endpoint for ARM/Bicep compatibility at runs/latest.
 */
@parentResource(Agent)
@singleton("latest")
model LatestRun is ProxyResource<RunProperties> {
  /**
   * The name of the singleton resource (always "latest").
   */
  @key("runId")
  @segment("runs")
  @pattern("^latest$")
  @path
  name: string;
}

@armResourceOperations
interface LatestRuns {
  /**
   * Gets the latest run.
   */
  get is ArmResourceRead<LatestRun>;

  /**
   * Creates or updates a run via PUT for ARM/Bicep compatibility.
   * The "latest" name is a logical identifier — the actual run ID is generated server-side.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<LatestRun>;
}
