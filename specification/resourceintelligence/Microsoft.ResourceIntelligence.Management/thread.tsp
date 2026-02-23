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
// THREAD RESOURCE
// ============================================

/**
 * A conversation thread for an agent. Tracks message history and run state.
 */
@parentResource(Agent)
model Thread is ProxyResource<ThreadProperties> {
  /**
   * The unique identifier of the thread.
   */
  @key("threadId")
  @segment("threads")
  @pattern("^[a-zA-Z0-9-]{1,64}$")
  @path
  name: string;
}

/**
 * Properties of a Thread resource.
 */
model ThreadProperties {
  /**
   * The lifecycle status of the thread.
   */
  @visibility(Lifecycle.Read)
  status?: ThreadStatus;

  /**
   * The ID of the most recent thread run.
   */
  @visibility(Lifecycle.Read)
  lastRunId?: string;
}

// ============================================
// THREAD OPERATIONS
// ============================================

@armResourceOperations
interface Threads {
  /**
   * Gets a thread by ID.
   */
  get is ArmResourceRead<Thread>;

  /**
   * Creates a new thread.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Thread>;

  /**
   * Deletes a thread.
   */
  delete is ArmResourceDeleteSync<Thread>;

  /**
   * Lists threads for an agent.
   */
  listByParent is ArmResourceListByParent<Thread>;

  /**
   * Creates a new run on an existing thread. Returns 202 Accepted with run tracking info.
   * The client should poll GET threadRuns/{runId} for completion.
   */
  @action("threadRuns")
  createRun is ArmResourceActionAsync<Thread, ThreadRunRequest, ThreadRunResponse>;
}
