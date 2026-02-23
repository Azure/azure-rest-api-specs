import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./thread.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ResourceIntelligence;

// ============================================
// THREAD RUN RESOURCE
// ============================================

/**
 * A single execution run on a thread. Tracks run status, timing, and results.
 */
@parentResource(Thread)
model ThreadRun is ProxyResource<ThreadRunProperties> {
  /**
   * The unique identifier of the thread run.
   */
  @key("runId")
  @segment("threadRuns")
  @pattern("^[a-zA-Z0-9-]{1,64}$")
  @path
  name: string;
}

/**
 * Properties of a ThreadRun resource.
 */
model ThreadRunProperties {
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
// THREAD RUN OPERATIONS
// ============================================

@armResourceOperations
interface ThreadRuns {
  /**
   * Gets a thread run by ID.
   */
  get is ArmResourceRead<ThreadRun>;

  /**
   * Deletes a thread run.
   */
  delete is ArmResourceDeleteSync<ThreadRun>;

  /**
   * Lists thread runs for a thread.
   */
  listByParent is ArmResourceListByParent<ThreadRun>;
}

// ============================================
// LATEST THREAD RUN (SINGLETON)
// ============================================

/**
 * Singleton resource representing the latest thread run.
 * Provides PUT endpoint for ARM/Bicep compatibility at threadRuns/latest.
 */
@parentResource(Thread)
@singleton("latest")
model LatestThreadRun is ProxyResource<ThreadRunProperties> {
  /**
   * The name of the singleton resource (always "latest").
   */
  @key("runId")
  @segment("threadRuns")
  @pattern("^latest$")
  @path
  name: string;
}

@armResourceOperations
interface LatestThreadRuns {
  /**
   * Gets the latest thread run.
   */
  get is ArmResourceRead<LatestThreadRun>;

  /**
   * Creates or updates a thread run via PUT for ARM/Bicep compatibility.
   * The "latest" name is a logical identifier — the actual run ID is generated server-side.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<LatestThreadRun>;
}
