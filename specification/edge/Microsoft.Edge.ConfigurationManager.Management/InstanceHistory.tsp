import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionVersion.tsp";
import "./Target.tsp";
import "./Instance.tsp";
import "./DeploymentStatus.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Instance History Properties")
model InstanceHistoryProperties {
  @doc("Solution version of instance")
  @visibility("read")
  solutionVersion: SolutionVersion;

  @doc("Target of instance")
  @visibility("read")
  target: Target;

  @doc("Deployment Status of instance")
  @visibility("read")
  status?: DeploymentStatus;

  @doc("Scope of instance")
  @visibility("read")
  solutionScope?: string;

  @doc("Reconciliation policy of instance")
  @visibility("read")
  reconciliationPolicy?: ReconciliationPolicyProperties;

  @doc("Deployment timestamp of instance")
  @visibility("read")
  deploymentTimestampEpoch?: int64;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("InstanceHistory Resource")
@parentResource(Instance)
@resource("histories")
model InstanceHistory
  is Azure.ResourceManager.ProxyResource<InstanceHistoryProperties> {
  // Name will be set to solutionVersion-deploymentTimestamp
  @doc("Name of the instance history")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("instanceHistoryName")
  @segment("instanceHistories")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@armResourceOperations
interface InstanceHistories {
  @doc("Get InstanceHistory Resource")
  get is ArmResourceRead<InstanceHistory>;

  @doc("List InstanceHistory Resources")
  listByInstance is ArmResourceListByParent<InstanceHistory>;
}
