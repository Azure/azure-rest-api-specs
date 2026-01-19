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

@doc("Solution Version Snapshot")
model SolutionVersionSnapshot {
  @doc("Solution version of instance")
  solutionVersionId?: armResourceIdentifier<[
    {
      type: "Microsoft.Edge/targets/solutions/versions";
    }
  ]>;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("App components spec")
  specification?: Record<unknown>;
}

@doc("Target Snapshot")
model TargetSnapshot {
  @doc("Target of instance")
  targetId?: armResourceIdentifier<[
    {
      type: "Microsoft.Edge/targets";
    }
  ]>;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("target spec")
  targetSpecification?: Record<unknown>;

  @doc("Scope of the target resource")
  solutionScope?: string;
}

@doc("Instance History Properties")
model InstanceHistoryProperties {
  @doc("Solution version of instance")
  @visibility(Lifecycle.Read)
  solutionVersion: SolutionVersionSnapshot;

  @doc("Target of instance")
  @visibility(Lifecycle.Read)
  target: TargetSnapshot;

  @doc("Scope of instance")
  @visibility(Lifecycle.Read)
  solutionScope?: string;

  @doc("State of instance")
  activeState?: ActiveState;

  @doc("Reconciliation policy of instance")
  @visibility(Lifecycle.Read)
  reconciliationPolicy?: ReconciliationPolicyProperties;

  @doc("Deployment Status of instance")
  @visibility(Lifecycle.Read)
  status?: DeploymentStatus;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
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
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
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
