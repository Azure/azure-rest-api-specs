import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

using Azure.ResourceManager.Foundations;
using Azure.Core;

@service({
  title: "ModSimWorkbench Control Plane API",
})
@versioned(Microsoft.ModSimWorkbench.Versions)
namespace Microsoft.ModSimWorkbench;

@doc("The ModSimWorkbench Control Plane API version.")
enum Versions {
  @doc("Version 2021-03-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2021-03-01-preview`,
}

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Resource has unknown state.")
  Unknown,

  @doc("Resource is being validated.")
  Validating,

  @doc("Resource provisioning in progress.")
  Processing,

  @doc("Resource is being deleted.")
  Deleting,

  @doc("Resource provisioning action accepted.")
  Accepted,

  @doc("Resource has been deleted.")
  Deleted,
}

@doc("The property for specifying the status of the last operation.")
model ProvisioningStateProperty {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The power state of a resource.")
enum PowerState {
  @doc("Resource is Running.")
  Running,

  @doc("Resource is Stopped.")
  Stopped,

  @doc("Resource is Starting.")
  Starting,

  @doc("Resource is Stopping.")
  Stopping,
}

@doc("The property for specifying the power state.")
model PowerStateProperty {
  @visibility("read")
  @doc("Power state.")
  powerState?: PowerState; // TODO: Change this as not optional for public release.
}

@doc("The property for specifying capacity allocated.")
model CapacityAllocatedProperty {
  @visibility("read", "create", "update")
  @doc("Provisioned size: Capacity allocated to the storage volume in terabytes.")
  capacityAllocated: int64;
}

@doc("The property for specifying capacity used.")
model CapacityUsedProperty {
  @visibility("read")
  @doc("Capacity used in the storage volume in gigabytes.")
  capacityUsed?: int64;
}

@doc("The property for specifying timestamp when restart is required.")
model RestartAtProperty {
  @visibility("read")
  @doc("Timestamp when restart is required.")
  restartAt?: utcDateTime;
}

@doc("Property for timestamp.")
model TimestampProperty {
  @visibility("read")
  @doc("Timestamp in UTC format")
  timestamp: utcDateTime;
}

@doc("Property for result.")
model ResultProperty {
  @doc("Result of the operation.")
  result?: string;
}

@doc("Common interface for all tracked resources")
interface ProxyResourceOperations<T extends ProxyResourceBase> {
  get is ArmResourceRead<T>;
  list is ArmResourceListByParent<T>;
}

@doc("Common interface for all tracked resources")
interface BaseResourceOperations<
  T extends TrackedResourceBase,
  P extends TypeSpec.Reflection.Model
> {
  get is ArmResourceRead<T>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<T>;
  update is ArmResourcePatchAsync<T, P>;
  delete is ArmResourceDeleteWithoutOkAsync<T>;
}

@doc("Common interface of all nested resources")
interface NestedResourceOperations<
  T extends TrackedResourceBase,
  P extends TypeSpec.Reflection.Model
> extends BaseResourceOperations<T, P> {
  list is ArmResourceListByParent<T>;
}

@doc("Resource that can be restarted")
interface Restartable<T extends ArmResource> {
  @doc("Start connector")
  start is ArmResourceActionAsync<T, void, never>;

  @doc("Stop connector")
  stop is ArmResourceActionAsync<T, void, never>;

  @doc("Restart connector")
  restart is ArmResourceActionAsync<T, void, never>;
}

interface Operations extends Azure.ResourceManager.Operations {}
