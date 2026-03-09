import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ResourceIntelligence;

// ============================================
// AGENT RESOURCE
// ============================================

/**
 * An AI Agent resource that can execute runs.
 */
model Agent is TrackedResource<AgentProperties> {
  /**
   * The name of the agent.
   */
  @key("agentName")
  @segment("agents")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]{0,62}[a-zA-Z0-9]$")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

/**
 * Properties of an Agent resource.
 */
model AgentProperties {
  /**
   * The friendly display name for the agent.
   */
  displayName?: string;

  /**
   * A description of the agent's purpose.
   */
  description?: string;

  /**
   * The provisioning state of the agent.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/**
 * The type used for update operations of the Agent.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Only tags are updatable via PATCH for Agent"
model AgentUpdate {
  /** Resource tags. */
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

// ============================================
// AGENT OPERATIONS
// ============================================

@armResourceOperations
interface Agents {
  /**
   * Gets an agent by name.
   */
  get is ArmResourceRead<Agent>;

  /**
   * Creates or updates an agent.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Agent>;

  /**
   * Updates an agent.
   */
  update is ArmCustomPatchSync<Agent, AgentUpdate>;

  /**
   * Deletes an agent.
   */
  delete is ArmResourceDeleteSync<Agent>;

  /**
   * Lists agents in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Agent>;

  /**
   * Lists agents in a subscription.
   */
  listBySubscription is ArmListBySubscription<Agent>;

  /**
   * Creates a new run for the agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Execute returns 201 with Location header for LRO polling"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "LRO execute returns 201 with Location/Retry-After headers only, no body"
  @armResourceAction(Agent)
  @post
  execute(
    ...ResourceInstanceParameters<Agent>,

    /** The content of the action request. */
    @body body: RunRequest,
  ): ArmAccepted201LroResponse | ErrorResponse;
}
