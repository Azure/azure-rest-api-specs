import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
namespace Microsoft.Resilience;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Resilience Resource")
model ResilienceResource is ExtensionResource<ResilienceProperties> {
  @doc("The parent resource name")
  @segment("resilienceStates")
  @key("resilienceState")
  @visibility("read")
  @path
  name: string;
}

@doc("Resilience Properties")
model ResilienceProperties {
  @doc("Resilience Type")
  @visibility("read")
  resilienceType: ResilienceType;

  @doc("The parent resource id")
  @visibility("read")
  parentResourceId: ParentResourceId;

  @doc("The parent resource type")
  @visibility("read")
  parentResourceType: string;

  @doc("The parent resource location")
  @visibility("read")
  parentResourceLocation: string;

  @doc("Is the resource ZoneAligned, ZoneRedundant, AlwaysAvailable, None")
  @visibility("read")
  zoneResilienceState?: ZoneResilienceState;

  @doc("Zones where the resource is deployed")
  @visibility("read")
  zonesDeployed?: int32[];

  @doc("Findings of the zone resilience evaluation")
  @visibility("read")
  findings: int32[];

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Resilience {
  get is ArmResourceRead<ResilienceResource>;
  listByParent is ArmResourceListByParent<ResilienceResource>;
}
