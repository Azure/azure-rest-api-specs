import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.KubernetesRuntime;

@doc("Performance tier of a storage class")
union PerformanceTier {
  string,

  @doc("Undefined Performance Tier")
  Undefined: "Undefined",

  @doc("Basic Performance Tier")
  Basic: "Basic",

  @doc("Standard Performance Tier")
  Standard: "Standard",

  @doc("Premium Performance Tier")
  Premium: "Premium",

  @doc("Ultra Performance Tier")
  Ultra: "Ultra",
}

@doc("Failover tier of a storage class")
union FailoverTier {
  string,

  @doc("Not available Failover Tier")
  NotAvailable: "NotAvailable",

  @doc("Slow Failover Tier")
  Slow: "Slow",

  @doc("Fast Failover Tier")
  Fast: "Fast",

  @doc("Super Failover Tier")
  Super: "Super",
}

@doc("Type of a storage class")
union SCType {
  string,

  @doc("Native storage class")
  Native: "Native",

  @doc("RWX storage class")
  RWX: "RWX",

  @doc("Blob storage class")
  Blob: "Blob",

  @doc("NFS storage class")
  NFS: "NFS",

  @doc("SMB storage class")
  SMB: "SMB",
}

@doc("Data resilience tier of a storage class")
union DataResilienceTier {
  string,

  @doc("Not data resilient")
  NotDataResilient: "NotDataResilient",

  @doc("Data resilient")
  DataResilient: "DataResilient",
}

@doc("Ability to expand volumes of a storage class")
union VolumeExpansion {
  string,

  @doc("Allow volume expansion")
  Allow: "Allow",

  @doc("Disallow volume expansion")
  Disallow: "Disallow",
}

@doc("Storage Class Access Mode")
union AccessMode {
  string,

  @doc("Read Write Once (RWO) access mode")
  ReadWriteOnce: "ReadWriteOnce",

  @doc("Read Write Many (RWX) access mode")
  ReadWriteMany: "ReadWriteMany",
}

@doc("Storage class volume binding mode")
union VolumeBindingMode {
  string,

  @doc("Immediate binding mode")
  Immediate: "Immediate",

  @doc("Wait for first consumer binding mode")
  WaitForFirstConsumer: "WaitForFirstConsumer",
}

@doc("Details of the StorageClass StorageClass.")
model StorageClassProperties {
  @doc("Volume can be expanded or not")
  allowVolumeExpansion?: VolumeExpansion;

  @doc("Additional mount options")
  mountOptions?: string[];

  @doc("Provisioner name")
  @visibility("read", "create")
  provisioner?: string;

  @doc("Binding mode of volumes: Immediate, WaitForFirstConsumer")
  @visibility("read", "create")
  volumeBindingMode?: VolumeBindingMode;

  @doc("The access mode: [ReadWriteOnce, ReadWriteMany] or [ReadWriteOnce]")
  accessModes?: AccessMode[];

  @doc("Allow single data node failure")
  dataResilience?: DataResilienceTier;

  @doc("Failover speed: NA, Slow, Fast")
  failoverSpeed?: FailoverTier;

  @doc("Limitations of the storage class")
  limitations?: string[];

  @doc("Performance tier")
  performance?: PerformanceTier;

  @doc("Selection priority when multiple storage classes meet the criteria. 0: Highest, -1: Never use")
  priority?: int64;

  @doc("Properties of the StorageClass")
  // prevent generation of buggy StorageClassPropertiesUpdate model
  @visibility("read", "create")
  typeProperties: StorageClassTypeProperties;

  @doc("Resource provision state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@discriminator("type")
@doc("The properties of storage class of the StorageClass")
model StorageClassTypeProperties {
  @doc("Type of the storage class.")
  type: SCType;
}

@doc("The properties of Native StorageClass")
model NativeStorageClassTypeProperties extends StorageClassTypeProperties {
  @doc("Native StorageClass")
  type: SCType.Native;
}

@doc("The properties of RWX StorageClass")
model RwxStorageClassTypeProperties extends StorageClassTypeProperties {
  @doc("RWX StorageClass")
  type: SCType.RWX;

  @doc("The backing storageclass used to create new storageclass")
  backingStorageClassName: string;
}

@doc("The properties of Blob StorageClass")
model BlobStorageClassTypeProperties extends StorageClassTypeProperties {
  @doc("Blob StorageClass")
  type: SCType.Blob;

  @doc("Azure Storage Account Name")
  azureStorageAccountName: string;

  @doc("Azure Storage Account Key")
  @secret
  azureStorageAccountKey: string;
}

@doc("The action to take when a NFS volume is deleted")
union NfsDirectoryActionOnVolumeDeletion {
  string,

  @doc("When the volume is deleted, delete the directory")
  Delete: "Delete",

  @doc("When the volume is deleted, retain the directory")
  Retain: "Retain",
}

@doc("The properties of NFS StorageClass")
model NfsStorageClassTypeProperties extends StorageClassTypeProperties {
  @doc("NFS StorageClass")
  type: SCType.NFS;

  @doc("NFS Server")
  server: string;

  @doc("NFS share")
  share: string;

  @doc("Sub directory under share. If the sub directory doesn't exist, driver will create it")
  subDir?: string;

  @doc("Mounted folder permissions. Default is 0. If set as non-zero, driver will perform `chmod` after mount")
  mountPermissions?: string;

  @doc("The action to take when a NFS volume is deleted. Default is Delete")
  onDelete?: NfsDirectoryActionOnVolumeDeletion;
}

@doc("The properties of SMB StorageClass")
model SmbStorageClassTypeProperties extends StorageClassTypeProperties {
  @doc("SMB StorageClass")
  type: SCType.SMB;

  @doc("SMB Source")
  source: string;

  @doc("Sub directory under share. If the sub directory doesn't exist, driver will create it")
  subDir?: string;

  @doc("Server username")
  username?: string;

  @doc("Server password")
  @secret
  password?: string;

  @doc("Server domain")
  domain?: string;
}

@doc("The model for update a storageClass")
model StorageClassTypePropertiesUpdate {
  ...OptionalProperties<OmitProperties<RwxStorageClassTypeProperties, "type">>;
  ...OptionalProperties<OmitProperties<BlobStorageClassTypeProperties, "type">>;
  ...OptionalProperties<OmitProperties<NfsStorageClassTypeProperties, "type">>;
  ...OptionalProperties<OmitProperties<
    SmbStorageClassTypeProperties,
    "type" | "subDir"
  >>;
}

@doc("The model for updating storageClass properties")
model StorageClassPropertiesUpdate {
  ...Azure.ResourceManager.Foundations.ResourceUpdateModelProperties<
    StorageClassResource,
    StorageClassProperties
  >;

  @doc("New storage class type of storageClass")
  typeProperties?: StorageClassTypePropertiesUpdate;
}

@doc("The model for updating a storageClass")
model StorageClassResourceUpdate {
  @doc("The properties of StorageClass")
  properties?: StorageClassPropertiesUpdate;
}

@doc("A StorageClass resource for an Arc connected cluster (Microsoft.Kubernetes/connectedClusters)")
model StorageClassResource is ExtensionResource<StorageClassProperties> {
  @doc("The name of the the storage class")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("storageClassName")
  @segment("storageClasses")
  @path
  name: string;
}

@armResourceOperations(StorageClassResource)
interface StorageClass {
  get is ArmResourceRead<StorageClassResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageClassResource>;
  update is ArmCustomPatchAsync<
    StorageClassResource,
    StorageClassResourceUpdate
  >;
  delete is ArmResourceDeleteWithoutOkAsync<StorageClassResource>;
  listByParent is ArmResourceListByParent<StorageClassResource>;
}
