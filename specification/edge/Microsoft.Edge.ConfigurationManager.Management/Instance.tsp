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
  string,

  @doc("Instance is active")
  active: "active",

  @doc("Instance is inactive")
  inactive: "inactive",
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

  @doc("Policy interval")
  interval: string;
}

@doc("Instance Properties")
model InstanceProperties {
  @doc("Solution version of instance")
  solutionVersionId: string;

  @doc("Target of instance")
  targetId: string;

  @doc("State of instance")
  activeState?: ActiveState;

  @doc("Reconciliation policy of instance")
  reconciliationPolicy?: ReconciliationPolicyProperties;

  @doc("Scope of instance")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  solutionScope?: string;

  @doc("Status of instance")
  @visibility(Lifecycle.Read)
  status?: DeploymentStatus;

  @doc("Deployment timestamp of instance")
  @visibility(Lifecycle.Read)
  deploymentTimestampEpoch?: int64;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Instance Resource. Represents a deployment object.")
@parentResource(Solution)
model Instance is Azure.ResourceManager.ProxyResource<InstanceProperties> {
  // Name will be set to solution
  @doc("Name of the instance")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
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

  @doc("Create or update Instance Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Instance>;

  @doc("Update an Instance Resource")
  update is ArmResourcePatchAsync<Instance, InstanceProperties>;

  @doc("Delete Instance Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Instance>;

  @doc("List Instance Resources")
  listBySolution is ArmResourceListByParent<Instance>;
}
