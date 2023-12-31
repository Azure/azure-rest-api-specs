import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "SecurityCopilotClient",
  version: "2023-12-01-preview",
})
@doc("SecurityCopilot Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.SecurityCopilot;

@doc("A Capacity resource")
model Capacity is TrackedResource<CapacityProperties> {
  @doc("Name of capacity unit")
  @pattern("^[a-zA-Z0-9-]{3,63}$")
  @key("name")
  @path
  @segment("capacities")
  name: string;
}

@doc("Capacity properties")
model CapacityProperties {
  @doc("No of Units")
  @minValue(1)
  @maxValue(999)
  numberOfUnits: int64;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Is cross region compute allowed")
  crossRegionCompute: IsAllowed;
}

@doc("Enum to represent Allowed or NotAllowed")
enum IsAllowed {
  @doc("Allowed to do")
  Allowed,

  @doc("Not allowed to do")
  NotAllowed,
}

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is being deleted")
  Deleting,

  @doc("The resource create request has been accepted")
  Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Capacities {
  get is ArmResourceRead<Capacity>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Capacity>;
  update is ArmResourcePatchSync<Capacity, CapacityProperties>;
  delete is ArmResourceDeleteSync<Capacity>;
  listByResourceGroup is ArmResourceListByParent<Capacity>;
  listBySubscription is ArmListBySubscription<Capacity>;
  checkGlobalNameAvailability is checkGlobalNameAvailability;
}
