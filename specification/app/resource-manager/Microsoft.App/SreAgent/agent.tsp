import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./agent.models.tsp";

using Azure.ResourceManager;

using TypeSpec.Rest;

namespace Microsoft.App;

/** Site Reliability Engineer (SRE) Agent */
@doc("Site Reliability Engineer (SRE) Agent resource")
model Agent is TrackedResource<AgentProperties> {
  ...ResourceNameParameter<
    Resource = Agent,
    KeyName = "agentName",
    SegmentName = "agents",
    NamePattern = "^[A-Za-z]([-A-Za-z0-9]{0,30}[A-Za-z0-9])$"
  >;

  /** Managed identities for the Agent to interact with other Azure services */
  ...ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Agents {
  /** Get the properties of an Agent */
  get is ArmResourceRead<Agent>;

  /** Creates or updates an Agent */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Agent>;

  /** Update Agent's properties */
  update is ArmCustomPatchAsync<Agent, AgentPatch>;

  /** Delete an Agent */
  delete is ArmResourceDeleteWithoutOkAsync<Agent>;

  /** Get all the agents in a resource group */
  listByResourceGroup is ArmResourceListByParent<Agent>;

  /** Get all agents for a subscription */
  listBySubscription is ArmListBySubscription<Agent>;

  /** Start an Agent */
  start is ArmResourceActionAsync<Agent, void, Agent>;

  /** Stop an Agent */
  stop is ArmResourceActionAsync<Agent, void, Agent>;

  /** Get usage information for an Agent */
  @action("usages")
  @armResourceAction(Agent)
  @list
  usages is ArmResourceActionSync<Agent, void, ArmResponse<UsageCollection>>;

  /** Get daily usage information for an Agent */
  @action("dailyUsages")
  @armResourceAction(Agent)
  @list
  dailyUsages is ArmResourceActionSync<
    Agent,
    void,
    ArmResponse<DailyUsageCollection>
  >;
}
