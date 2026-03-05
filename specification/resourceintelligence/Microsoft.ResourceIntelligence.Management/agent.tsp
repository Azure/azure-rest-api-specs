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
  update is ArmCustomPatchSync<
    Agent,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Agent,
      AgentProperties
    >
  >;

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
  execute is ArmResourceActionAsync<Agent, RunRequest, Run>;
}
