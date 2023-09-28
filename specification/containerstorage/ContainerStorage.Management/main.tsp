import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Azure-ContainerStorageRP",
  version: "2023-07-01-preview",
})
@doc("Azure Container Storage Resource Provider API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.ContainerStorage;

interface Operations extends Azure.ResourceManager.Operations {}

// START POOL

@doc("Pool resource")
model Pool is TrackedResource<PoolProperties> {
  @doc("Pool Object")
  @minLength(3)
  @maxLength(253)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @key("poolName")
  @path
  @segment("pools")
  name: string;
}

@doc("Pool Properties")
model PoolProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The operational status of the resource")
  @visibility("read")
  status?: ResourceOperationalStatus;

  @visibility("read", "create")
  @maxItems(3)
  @doc("List of availability zones that resources can be created in.")
  zones?: Zone[];

  @doc("Resources represent the resources the pool should have.")
  resources?: Resources;

  @doc("Type of the Pool: ephemeralDisk, azureDisk, or elasticsan.")
  poolType: PoolType;

  @doc("ReclaimPolicy defines what happens to the backend storage when StoragePool is deleted")
  @visibility("read", "create")
  reclaimPolicy?: ReclaimPolicy;

  @doc("List of resources that should have access to the pool. Typically ARM references to AKS clusters or ACI Container Groups. For local and standard this must be a single reference. For ElasticSAN there can be many.")
  assignments?: Assignment[];
}

@doc("Availability Zones")
enum Zone {
  @doc("First availability zone.")
  Zone1: "1",

  @doc("Second availability zone.")
  Zone2: "2",

  @doc("Third availability zone.")
  Zone3: "3",
}

@doc("Resource Requests for the pool.")
model Resources {
  @doc("Requests for capacity for the pool.")
  requests?: Requests;
}

@doc("Requests for capacity for the pool.")
model Requests {
  @doc("Requested capacity of the pool in GiB.")
  @minValue(1024)
  @maxValue(65536)
  storage?: int64 = 1024;
}

@doc("Type of the Pool: ephemeralDisk, azureDisk, or elasticsan")
model PoolType {
  @doc("Disk Pool Properties")
  azureDisk?: AzureDisk;

  @doc("Elastic San Pool Properties")
  elasticSan?: ElasticSan;

  @doc("Ephemeral Pool Properties")
  ephemeralDisk?: EphemeralDisk;
}

@doc("Reclaim policy")
enum ReclaimPolicy {
  @doc("Delete resource")
  Delete,

  @doc("Retain resource")
  Retain,
}

@doc("Model for disk for that pool is using")
model Disk {
  @doc("ID is the disk identifier visible to the OS. It is typically the WWN or disk ID in formats such as eui.e8238fa6bf530001001b448b45263379 or 0x5002cf6cbc5dd460")
  id: string;

  @doc("Reference is the location of the disk in an external system.")
  reference: string;
}

@doc("Properties shared between azureDisk and elasticSan")
model ProvisionedPoolProperties<SkuType> {
  @visibility("read")
  @doc("Managed resource group for the pool.")
  resourceGroup?: string;

  @visibility("read", "create")
  @doc("Sku name")
  skuName?: SkuType;

  @doc("Encryption specifies the encryption configuration for the Azure Disk pool")
  @visibility("read", "create")
  encryption?: Encryption;
}

@doc("Properties shared between the azureDisk and ephemeralDisk")
model DiskPoolProperties {
  @doc("Only required if individual disk selection is desired. Path to disk, e.g. <nodename>:/dev/sda or WWN. Supports specifying multiple disks (same syntax as tags).")
  disks?: Disk[];
}

@doc("Azure Disk Pool Properties")
model AzureDisk {
  ...ProvisionedPoolProperties<AzureDiskSkuName>;
  ...DiskPoolProperties;
}

@doc("SKU of the underlying managed disk")
enum AzureDiskSkuName {
  @doc("Premium_LRS SKU")
  Premium_LRS,

  @doc("Standard_LRS SKU")
  Standard_LRS,

  @doc("StandardSSD_LRS SKU")
  StandardSSD_LRS,

  @doc("UltraSSD_LRS SKU")
  UltraSSD_LRS,

  @doc("Premium_ZRS SKU")
  Premium_ZRS,

  @doc("PremiumV2_LRS SKU")
  PremiumV2_LRS,

  @doc("StandardSSD_ZRS SKU")
  StandardSSD_ZRS,
}

@doc("Encryption key properties for the pool.")
model Encryption {
  @doc("The name of the key vault key.")
  keyName: string;

  @doc("The URI of the key vault.")
  keyVaultUri: string;

  ...ManagedServiceIdentity;
}

@doc("Elastic San Pool Properties")
model ElasticSan {
  ...ProvisionedPoolProperties<ElasticSanSkuName>;
}

/** Sku Name enum type */
@doc("ElasticSAN SKUs")
enum ElasticSanSkuName {
  @doc("Premium_LRS SKU")
  Premium_LRS,

  @doc("Premium_ZRS SKU")
  Premium_ZRS,
}

@doc("Ephemeral Disk Pool Properties")
model EphemeralDisk {
  @doc("The number of data copies. Default 3.")
  @minValue(1)
  @maxValue(3)
  replicas?: int64 = 3;

  ...DiskPoolProperties;
}

@doc("Provisioning state of the resource.")
@Azure.Core.lroStatus
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

@doc("Status of the resource")
model ResourceOperationalStatus {
  @doc("state of the resource")
  state: ResourceOperationStatusState;

  @doc("Reason for state.")
  message?: string;
}

@doc("State of the resource.")
enum ResourceOperationStatusState {
  @doc("The resource is pending.")
  Pending,

  @doc("The resource is available.")
  Available,

  @doc("The resource is unavailable.")
  Unavailable,
}

// END POOL

// START VOLUME

@parentResource(Pool)
model Volume is ProxyResource<VolumeProperties> {
  @doc("Volume Resource")
  @minLength(3)
  @maxLength(253)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @key("volumeName")
  @path
  @segment("volumes")
  name: string;
}

@doc("Volume Properties")
model VolumeProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The status of the resource.")
  @visibility("read")
  status?: ResourceOperationalStatus;

  @doc("String KV pairs indicating labels")
  labels: Record<string>;

  @doc("Requested capacity in GiB")
  @maxValue(65536)
  @minValue(1)
  capacityGiB: int64;

  @visibility("read")
  @doc("Properties of the volume")
  volumeType?: VolumeType;
}

@doc("Properties of the volume")
model VolumeType {
  @visibility("read")
  @doc("Properties of the ElasticSAN iSCSI target")
  elasticSan?: ElasticSanVolumeProperties;
}

@doc("Properties of the ElasticSAN iSCSI target")
model ElasticSanVolumeProperties {
  @doc("iSCSI Target IQN (iSCSI Qualified Name); example: \"iqn.2005-03.org.iscsi:server\"")
  targetIqn: string;

  @doc("iSCSI Target Portal Host Name")
  targetPortalHostname: string;

  @doc("iSCSI Target Portal Port")
  targetPortalPort: int32;
}

// END VOLUME

// START VOLUME SNAPSHOT

@parentResource(Pool)
model Snapshot is ProxyResource<SnapshotProperties> {
  @doc("Volume Snapshot Resource")
  @minLength(3)
  @maxLength(253)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @key("snapshotName")
  @path
  @segment("snapshots")
  name: string;
}

@doc("Volume Snapshot Properties")
model SnapshotProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The status of the resource.")
  @visibility("read")
  status?: ResourceOperationalStatus;

  @doc("Reference to the source volume")
  @minLength(3)
  @maxLength(253)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @visibility("read", "create")
  source: string;
}

// END VOLUME SNAPSHOT

// START ASSIGNMENT

@doc("Status of the assignment resource")
model AssignmentStatus {
  @doc("State of the assignment resource")
  state: AssignmentStatusState;

  @doc("Reason for the status")
  message?: string;
}

@doc("Status of the assignment resource")
enum AssignmentStatusState {
  @doc("The assignment of the pool to the resource is in progress")
  Assigning,

  @doc("The assignment to the pool was successful.")
  Assigned,

  @doc("The pool is being unassigned.")
  Unassigning,

  @doc("The operation of assigning or unassigning the pool failed.")
  Failed,
}

scalar AssignmentId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters",
    }
  ]>;

@doc("Assignment Properties")
model Assignment {
  @visibility("read")
  @doc("Indicates if the assignment is in a usable state")
  status?: AssignmentStatus;

  @visibility("read", "create")
  @doc("Resource id for the assigned resource")
  id: AssignmentId;
}

// END ASSIGNMENT

@armResourceOperations
interface Pools {
  get is ArmResourceRead<Pool>;
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  createOrUpdate is ArmResourceCreateOrUpdate2Async<Pool>;
  delete is ArmResourceDelete2Async<Pool>;
  update is ArmResourcePatchAsync<Pool, PoolProperties>;
  listByResourceGroup is ArmResourceListByParent<Pool>;
  listBySubscription is ArmListBySubscription<Pool>;
}

@armResourceOperations
interface Volumes {
  get is ArmResourceRead<Volume>;
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  createOrUpdate is ArmResourceCreateOrUpdate2Async<Volume>;
  delete is ArmResourceDelete2Async<Volume>;
  update is ArmResourcePatchAsync<Volume, VolumeProperties>;
  listByPool is ArmResourceListByParent<Volume>;
}

@armResourceOperations
interface Snapshots {
  get is ArmResourceRead<Snapshot>;
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  createOrUpdate is ArmResourceCreateOrUpdate2Async<Snapshot>;
  delete is ArmResourceDelete2Async<Snapshot>;
  listByPool is ArmResourceListByParent<Snapshot>;
}

/** Compliant create or update template */
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
@autoRoute
@doc("Create a {name}", TResource)
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdate2Async<
  TResource extends Azure.ResourceManager.Foundations.ArmResource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@doc("ARM update operation completed successfully")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.ArmResource>
  is ArmResponse<TResource>;

/** Compliant create or update template */
/**
/**
 * @dev Delete a resource asynchronously.  DEPRECATED: Use ArmResourceDeleteWithoutOkAsync instead
 * @template TResource The resource being deleted
 * @template TBaseParameters Optional. Allows overriding the parameters for the operation
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
op ArmResourceDelete2Async<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
> is ArmResourceDeleteAsyncBase<
  TResource,
  ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
  TBaseParameters
>;
