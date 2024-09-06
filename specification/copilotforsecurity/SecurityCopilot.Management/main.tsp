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
})
@doc("SecurityCopilot Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.SecurityCopilot;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-12-01-preview`,
}

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
  @maxValue(100)
  numberOfUnits: int64;

  @doc("Is cross geo compute allowed")
  crossGeoCompute: IsAllowed;

  @doc("Geo location of the capacity unit")
  @visibility("read", "create")
  geo: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Enum to represent Allowed or NotAllowed")
union IsAllowed {
  string,

  @doc("Allowed to do")
  Allowed: "Allowed",

  @doc("Not allowed to do")
  NotAllowed: "NotAllowed",
}

@doc("The provisioning state of a resource.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is in an unknown state")
  Unknown: "Unknown",

  @doc("The resource is creating")
  Creating: "Creating",

  @doc("The resource is moving")
  Moving: "Moving",

  @doc("The resource is soft deleting")
  SoftDeleting: "SoftDeleting",

  @doc("The resource is soft deleted")
  SoftDeleted: "SoftDeleted",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Capacities {
  get is ArmResourceRead<Capacity>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Capacity>;
  update is ArmCustomPatchSync<
    Capacity,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Capacity,
      CapacityProperties
    >
  >;
  delete is ArmResourceDeleteSync<Capacity>;
  listByResourceGroup is ArmResourceListByParent<Capacity>;
  listBySubscription is ArmListBySubscription<Capacity>;
}
