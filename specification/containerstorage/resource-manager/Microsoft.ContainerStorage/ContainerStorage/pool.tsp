import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ContainerStorage;

@armResourceOperations
interface Pools {
  get is ArmResourceRead<Pool>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DOT NOT COPY - migrate to LRO apis"
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "location" }
  )
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Pool,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Pool>;
  update is ArmCustomPatchAsync<
    Pool,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<Pool, PoolProperties>
  >;
  listByResourceGroup is ArmResourceListByParent<Pool>;
  listBySubscription is ArmListBySubscription<Pool>;
}

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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The operational status of the resource")
  @visibility(Lifecycle.Read)
  status?: ResourceOperationalStatus;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxItems(3)
  @doc("List of availability zones that resources can be created in.")
  zones?: Zone[];

  @doc("Resources represent the resources the pool should have.")
  resources?: Resources;

  @doc("Type of the Pool: ephemeralDisk, azureDisk, or elasticsan.")
  poolType: PoolType;

  @doc("ReclaimPolicy defines what happens to the backend storage when StoragePool is deleted")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  reclaimPolicy?: ReclaimPolicy;

  @doc("List of resources that should have access to the pool. Typically ARM references to AKS clusters or ACI Container Groups. For local and standard this must be a single reference. For ElasticSAN there can be many.")
  assignments?: Assignment[];
}

@doc("Availability Zones")
union Zone {
  string,

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
union ReclaimPolicy {
  string,

  @doc("Delete resource")
  "Delete",

  @doc("Retain resource")
  "Retain",
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
  @visibility(Lifecycle.Read)
  @doc("Managed resource group for the pool.")
  resourceGroup?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Sku name")
  skuName?: SkuType;

  @doc("Encryption specifies the encryption configuration for the Azure Disk pool")
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
union AzureDiskSkuName {
  string,

  @doc("Premium_LRS SKU")
  "Premium_LRS",

  @doc("Standard_LRS SKU")
  "Standard_LRS",

  @doc("StandardSSD_LRS SKU")
  "StandardSSD_LRS",

  @doc("UltraSSD_LRS SKU")
  "UltraSSD_LRS",

  @doc("Premium_ZRS SKU")
  "Premium_ZRS",

  @doc("PremiumV2_LRS SKU")
  "PremiumV2_LRS",

  @doc("StandardSSD_ZRS SKU")
  "StandardSSD_ZRS",
}

@doc("Encryption key properties for the pool.")
model Encryption {
  @doc("The name of the key vault key.")
  keyName: string;

  @doc("The URI of the key vault.")
  keyVaultUri: string;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
  ...Azure.ResourceManager.Legacy.ManagedServiceIdentityV4Property;
}

@doc("Elastic San Pool Properties")
model ElasticSan {
  ...ProvisionedPoolProperties<ElasticSanSkuName>;
}

/** Sku Name enum type */
@doc("ElasticSAN SKUs")
union ElasticSanSkuName {
  string,

  @doc("Premium_LRS SKU")
  "Premium_LRS",

  @doc("Premium_ZRS SKU")
  "Premium_ZRS",
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
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

@doc("Status of the resource")
model ResourceOperationalStatus {
  @doc("state of the resource")
  state: ResourceOperationStatusState;

  @doc("Reason for state.")
  message?: string;
}

@doc("State of the resource.")
union ResourceOperationStatusState {
  string,

  @doc("The resource is pending.")
  "Pending",

  @doc("The resource is available.")
  "Available",

  @doc("The resource is unavailable.")
  "Unavailable",
}
