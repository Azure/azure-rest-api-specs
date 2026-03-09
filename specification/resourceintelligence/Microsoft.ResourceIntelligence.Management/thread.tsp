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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Threads use a custom status field for lifecycle tracking; provisioningState is not applicable."
model ThreadProperties {
  /**
   * The lifecycle status of the run.
   */
  @visibility(Lifecycle.Read)
  status?: RunStatus;
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
   * Creates or updates a thread.
   */
  @armResourceCreateOrUpdate(Thread)
  @put
  createOrUpdate(
    ...ResourceInstanceParameters<Thread>,

    /** The content of the action request. */
    @body body: RunRequest,
  ): ArmResponse<Thread> | ArmResourceCreatedResponse<Thread> | ErrorResponse;

  /**
   * Deletes a thread.
   */
  delete is ArmResourceDeleteSync<Thread>;

  /**
   * Lists threads for an agent.
   */
  listByParent is ArmResourceListByParent<Thread>;

  /**
   * Creates a new run for the thread.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Execute returns 201 with Location header for LRO polling"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "LRO execute returns 201 with Location/Retry-After headers only, no body"
  @armResourceAction(Thread)
  @post
  execute(
    ...ResourceInstanceParameters<Thread>,

    /** The content of the action request. */
    @body body: RunRequest,
  ): ArmAccepted201LroResponse | ErrorResponse;
}
