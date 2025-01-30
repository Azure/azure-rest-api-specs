import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./DeploymentStatus.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Instance State")
union ActiveState {
  @doc("Instance is active")
  Active: "Active",

  @doc("Instance is inactive")
  Inactive: "Inactive",

  string,
}

@doc("Defines a state of the reconciliation policy.")
union ReconciliationState {
  string,

  @doc("Reconciliation is inactive")
  inactive: "inactive",

  @doc("Reconciliation is active")
  active: "active",
}

@doc("Defines a ReconciliationPolicy")
model ReconciliationPolicyProperties {
  @doc("The state of the ReconciliationPolicy")
  state: ReconciliationState;

  @doc("Policy interval.")
  interval: string;
}

@doc("Instance Properties")
model InstanceProperties {
  @doc("Solution version of instance")
  @visibility("read")
  solutionVersionId: string;

  @doc("Target of instance")
  @visibility("read")
  targetId: string;

  @doc("State of instance")
  @visibility("read")
  activeState?: ActiveState;

  @doc("Reconciliation policy of instance")
  @visibility("read")
  reconciliationPolicy?: ReconciliationPolicyProperties;

  @doc("Scope of instance")
  @visibility("read")
  solutionScope?: string;

  @doc("Status of instance")
  @visibility("read")
  status?: DeploymentStatus;

  @doc("Deployment timestamp of instance")
  @visibility("read")
  deploymentTimestampEpoch?: int64;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Instance Resource")
@parentResource(Solution)
model Instance is Azure.ResourceManager.ProxyResource<InstanceProperties> {
  // Name will be set to solution
  @doc("Name of the instance")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("instanceName")
  @segment("instances")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@armResourceOperations
interface Instances {
  @doc("Get Instance Resource")
  get is ArmResourceRead<Instance>;

  @doc("Delete Instance Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Instance>;

  @doc("List Instance Resources")
  listBySolution is ArmResourceListByParent<Instance>;
}
