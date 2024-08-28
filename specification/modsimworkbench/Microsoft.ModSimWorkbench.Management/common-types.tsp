import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

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

  @doc("Version 2024-05-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-05-01-preview`,
}

@doc("The provisioning state of a resource.")
@lroStatus
union ProvisioningState {
  string,

  // extend ARM common provisioning state
  ResourceProvisioningState,

  @doc("Resource has unknown state.")
  Unknown: "Unknown",

  @doc("Resource is being validated.")
  Validating: "Validating",

  @doc("Resource provisioning in progress.")
  Processing: "Processing",

  @doc("Resource is being deleted.")
  Deleting: "Deleting",

  @doc("Resource provisioning action accepted.")
  Accepted: "Accepted",

  @doc("Resource has been deleted.")
  Deleted: "Deleted",
}

@doc("The property for specifying the status of the last operation.")
model ProvisioningStateProperty {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The power state of a resource.")
union PowerState {
  string,

  @doc("Resource is Running.")
  Running: "Running",

  @doc("Resource is Stopped.")
  Stopped: "Stopped",

  @doc("Resource is Starting.")
  Starting: "Starting",

  @doc("Resource is Stopping.")
  Stopping: "Stopping",
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

/**
 * The resource model definition representing SKU
 */
@access(Access.internal)
@doc("Base sku")
@added(Versions.`2024-05-01-preview`)
model BaseSku {
  /** The name of the SKU. Ex - P3. It is typically a letter+number code */
  @visibility("read", "create", "update")
  @doc("Sku name.")
  name: string;

  /** This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT. */
  @visibility("read")
  @doc("Sku tier.")
  tier?: string;
}

@doc("Chamber sku")
@added(Versions.`2024-05-01-preview`)
model ChamberSku {
  ...BaseSku;
}

@doc("Storage sku")
@added(Versions.`2024-05-01-preview`)
model StorageSku {
  ...BaseSku;

  /** The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code. */
  // @visibility("read")
  // @doc("Sku size.")
  // size?: string;
  /** If the service has different generations of hardware, for the same SKU, then that can be captured here. */
  @visibility("read")
  @doc("Sku family.")
  family?: string;

  /** If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted. */
  // @visibility("read")
  // @doc("Sku capacity.")
  // capacity?: int32;
}

@doc("Common storage properties.")
@added(Versions.`2024-05-01-preview`)
@access(Access.internal)
model StorageBaseProperties {
  ...ProvisioningStateProperty;
  ...CapacityAllocatedProperty;
  ...CapacityUsedProperty;

  @removed(Versions.`2024-05-01-preview`)
  @visibility("read")
  @doc("Directory where the storage volume is mounted.")
  localMountPath?: string;
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
interface ProxyResourceOperations<T extends Azure.ResourceManager.Foundations.ProxyResource> {
  get is ArmResourceRead<T>;
  list is ArmResourceListByParent<T>;
}

@doc("Common interface for all tracked resources")
interface BaseResourceOperations<
  T extends Azure.ResourceManager.Foundations.TrackedResource,
  P extends TypeSpec.Reflection.Model
> {
  get is ArmResourceRead<T>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<T>;
  update is ArmResourcePatchAsync<T, P>;
  delete is ArmResourceDeleteWithoutOkAsync<T>;
}

@doc("Common interface of all nested resources")
interface NestedResourceOperations<
  T extends Azure.ResourceManager.Foundations.TrackedResource,
  P extends TypeSpec.Reflection.Model
> extends BaseResourceOperations<T, P> {
  list is ArmResourceListByParent<T>;
}

@doc("Resource that can be restarted")
interface Restartable<T extends Azure.ResourceManager.Foundations.TrackedResource> {
  @doc("Start connector")
  start is ArmResourceActionAsync<T, void, never>;

  @doc("Stop connector")
  stop is ArmResourceActionAsync<T, void, never>;

  @doc("Restart connector")
  restart is ArmResourceActionAsync<T, void, never>;
}

interface Operations extends Azure.ResourceManager.Operations {}
