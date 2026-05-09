import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./agentspace.models.tsp";

using Azure.ResourceManager;

namespace Microsoft.App;

/** SRE Agent Space */
@doc("SRE Agent Space resource")
model AgentSpace is TrackedResource<AgentSpaceProperties> {
  ...ResourceNameParameter<
    Resource = AgentSpace,
    KeyName = "agentSpaceName",
    SegmentName = "agentSpaces",
    NamePattern = "^[A-Za-z]([-A-Za-z0-9]*[A-Za-z0-9])$"
  >;

  /** Managed identities for the Agent Space */
  ...ManagedServiceIdentityProperty;
}

@armResourceOperations
interface AgentSpaces {
  /** Get the properties of an Agent Space */
  get is ArmResourceRead<AgentSpace>;

  /** Creates or updates an Agent Space */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentSpace>;

  /** Update Agent Space's properties */
  update is ArmCustomPatchAsync<AgentSpace, AgentSpacePatch>;

  /** Delete an Agent Space */
  delete is ArmResourceDeleteWithoutOkAsync<AgentSpace>;

  /** Get all the agent spaces in a resource group */
  listByResourceGroup is ArmResourceListByParent<AgentSpace>;

  /** Get all agent spaces for a subscription */
  listBySubscription is ArmListBySubscription<AgentSpace>;
}
