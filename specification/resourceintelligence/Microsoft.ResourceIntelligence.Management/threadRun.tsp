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
 * Based on AgentBuilder.md design and C# ThreadRunProperties contract.
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

  /**
   * The provisioning state of the thread run.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
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
   * Lists thread runs for a thread.
   */
  listByParent is ArmResourceListByParent<ThreadRun>;
}
