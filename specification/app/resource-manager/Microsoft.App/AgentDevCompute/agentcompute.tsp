import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./agentcompute.models.tsp";

using Azure.ResourceManager;

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;

/** An agent compute resource. */
@doc("Agent compute resource")
model AgentCompute is TrackedResource<AgentComputeProperties> {
  ...ResourceNameParameter<
    Resource = AgentCompute,
    KeyName = "agentComputeName",
    SegmentName = "agentCompute",
    NamePattern = "^[a-z][a-z0-9]{2,62}$"
  >;
}

@armResourceOperations
interface AgentComputeOps {
  /** Get the properties of an agent compute. */
  get is ArmResourceRead<AgentCompute>;

  /** Create or update an agent compute. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentCompute>;

  /** Update properties of an agent compute. */
  update is ArmTagsPatchSync<AgentCompute>;

  /** Delete an agent compute. */
  delete is ArmResourceDeleteWithoutOkAsync<AgentCompute>;

  /** Get the agent computes in a given resource group. */
  listByResourceGroup is ArmResourceListByParent<AgentCompute>;

  /** Get the agent computes in a given subscription. */
  listBySubscription is ArmListBySubscription<AgentCompute>;
}
