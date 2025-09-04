namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface PlacementPolicies {
  list is ArmResourceListByParent<
    PlacementPolicy,
    Response = ArmResponse<ResourceList<
      PlacementPolicy,
      "PlacementPoliciesList"
    >>
  >;

  get is ArmResourceRead<PlacementPolicy>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PlacementPolicy,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  update is ArmCustomPatchAsync<
    PlacementPolicy,
    PlacementPolicyUpdate,
    Response = ArmResponse<PlacementPolicy> | ArmAcceptedLroResponseWithResponseBody<
      PlacementPolicy,
      LroHeaders = ArmLroLocationHeader<
        Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
        PlacementPolicy,
        string
      > &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<PlacementPolicy>;
}

@@clientName(PlacementPolicies.createOrUpdate::parameters.resource,
  "placementPolicy"
);

@@clientName(PlacementPolicies.update::parameters.properties,
  "placementPolicyUpdate"
);

@doc("Placement Policy state")
union PlacementPolicyState {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Placement Policy provisioning state")
union PlacementPolicyProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("Affinity Strength")
union AffinityStrength {
  string,

  @doc("is should")
  Should: "Should",

  @doc("is must")
  Must: "Must",
}

@doc("Azure Hybrid Benefit type")
union AzureHybridBenefitType {
  string,

  @doc("is SqlHost")
  SqlHost: "SqlHost",

  @doc("is None")
  None: "None",
}

@doc("Affinity type")
union AffinityType {
  string,

  @doc("is affinity")
  Affinity: "Affinity",

  @doc("is anti-affinity")
  AntiAffinity: "AntiAffinity",
}

@doc("A vSphere Distributed Resource Scheduler (DRS) placement policy")
@parentResource(Cluster)
model PlacementPolicy is ProxyResource<PlacementPolicyProperties> {
  @doc("Name of the placement policy.")
  @pattern("^[-\\w\\._]+$")
  @key("placementPolicyName")
  @path
  @segment("placementPolicies")
  name: string;
}

@doc("Placement Policy type")
union PlacementPolicyType {
  VmVm: "VmVm",
  VmHost: "VmHost",
  string,
}

@doc("Abstract placement policy properties")
@discriminator("type")
model PlacementPolicyProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("Placement Policy type")
  type: PlacementPolicyType;

  @doc("Whether the placement policy is enabled or disabled")
  state?: PlacementPolicyState;

  @doc("Display name of the placement policy")
  displayName?: string;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: PlacementPolicyProvisioningState;
}

@doc("An update of a DRS placement policy resource")
model PlacementPolicyUpdate {
  #suppress "deprecated" "Legacy flatten"
  @doc("The properties of a placement policy resource that may be updated")
  @Azure.ClientGenerator.Core.flattenProperty
  properties?: PlacementPolicyUpdateProperties;
}

@doc("The properties of a placement policy resource that may be updated")
model PlacementPolicyUpdateProperties {
  @doc("Whether the placement policy is enabled or disabled")
  state?: PlacementPolicyState;

  @doc("Virtual machine members list")
  vmMembers?: string[];

  @doc("Host members list")
  hostMembers?: string[];

  @doc("vm-host placement policy affinity strength (should/must)")
  affinityStrength?: AffinityStrength;

  @doc("placement policy azure hybrid benefit opt-in type")
  azureHybridBenefitType?: AzureHybridBenefitType;
}

@doc("VM-VM placement policy properties")
model VmVmPlacementPolicyProperties extends PlacementPolicyProperties {
  @doc("Virtual machine members list")
  vmMembers: string[];

  @doc("placement policy affinity type")
  affinityType: AffinityType;

  @doc("placement policy type")
  type: PlacementPolicyType.VmVm;
}

@doc("VM-Host placement policy properties")
model VmHostPlacementPolicyProperties extends PlacementPolicyProperties {
  @doc("Virtual machine members list")
  vmMembers: string[];

  @doc("Host members list")
  hostMembers: string[];

  @doc("placement policy affinity type")
  affinityType: AffinityType;

  @doc("vm-host placement policy affinity strength (should/must)")
  affinityStrength?: AffinityStrength;

  @doc("placement policy azure hybrid benefit opt-in type")
  azureHybridBenefitType?: AzureHybridBenefitType;

  @doc("placement policy type")
  type: PlacementPolicyType.VmHost;
}
