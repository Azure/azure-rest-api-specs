import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft.ManagedStorageClass",
  version: "2023-02-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.ManagedStorageClass;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Resource provision state")
enum ProvisioningState {
  ...ResourceProvisioningState,
}

@doc("Performance tier of a storage class")
enum PerformanceTier {
  @doc("Undefined Performance Tier")
  Undefined,

  @doc("Basic Performance Tier")
  Basic,

  @doc("Standard Performance Tier")
  Standard,

  @doc("Premium Performance Tier")
  Premium,

  @doc("Ultra Performance Tier")
  Ultra,
}

@doc("Failover tier of a storage class")
enum FailoverTier {
  @doc("Not available Failover Tier")
  NotAvailable,

  @doc("Slow Failover Tier")
  Slow,

  @doc("Fast Failover Tier")
  Fast,

  @doc("Super Failover Tier")
  Super,
}

@doc("Provision state of a managed storage class")
enum SCProvisioningState {
  @doc("Provisioning state is Provisioning")
  Provisioning,

  @doc("Provisioning state is Provisioned")
  Provisioned,

  @doc("Provisioning state is Failed")
  Failed,
}

@doc("Type of a managed storage class")
enum SCType {
  @doc("Native storage class")
  Native,

  @doc("RWX storage class")
  RWX,

  @doc("S3 storage class")
  S3,

  @doc("Blob storage class")
  Blob,
}

@doc("Data resilience tier of a storage class")
enum DataResilienceTier {
  @doc("Not data resilient")
  NotDataResilient,

  @doc("Data resilient")
  DataResilient,
}

@doc("Ability to expand volumes of a storage class")
enum VolumeExpansion {
  @doc("Allow volume expansion")
  Allow,

  @doc("Disallow volume expansion")
  Disallow,
}

@doc("The status of the ManagedStorageClass")
model ManagedStorageClassStatus {
  @doc("The status of the ManagedStorageClass")
  @visibility("read")
  scProvisioningState?: SCProvisioningState;
}

@discriminator("storageClassType")
@doc("The properties of ManagedStorageClass")
model ManagedStorageClassProperties {
  @doc("[Native] Volume can be expanded or not")
  @visibility("read")
  allowVolumeExpansion?: VolumeExpansion;

  @doc("[Native] Additional mount options")
  @visibility("read")
  mountOptions?: string[];

  @doc("[Native] Provisioner name")
  @visibility("read")
  provisioner?: string;

  @doc("[Native] Binding mode of volumes: Immediate, WaitForFirstConsumer")
  @visibility("read")
  volumeBindingMode?: string;

  @doc("The access mode: [ReadWriteOnce, ReadWriteMany] or [ReadWriteOnce]")
  @visibility("read")
  accessMode?: string[];

  @doc("Allow single data node failure")
  @visibility("read")
  dataResilience?: DataResilienceTier;

  @doc("Failover speed: NA, Slow, Fast")
  failoverSpeed?: FailoverTier;

  @doc("Limitations")
  @visibility("read")
  limitations?: string[];

  @doc("Performance tier")
  performance?: PerformanceTier;

  @doc("Selection priority when multiple storage classes meet the criteria. 0: Highest, -1: Never use")
  priority?: int64;

  @doc("Type of the ManagedStorageClass")
  storageClassType: SCType;

  @doc("Actual Status of the ManagedStorageClass")
  @visibility("read")
  status?: ManagedStorageClassStatus;

  @doc("Resource provision state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The properties of Native ManagedStorageClass")
model NativeTemplateParameters {}

@doc("The properties of RWX ManagedStorageClass")
model RwxTemplateParameters {
  @doc("The backing storageclass used to create new storageclass")
  backingStorageClassName?: string;
}

@doc("The properties of S3 ManagedStorageClass")
model S3TemplateParameters {
  @doc("[S3] accessKeyId")
  accessKeyId?: string;

  @doc("[S3] S3 SecretAccessKey")
  @secret
  secretAccessKey?: string;

  @doc("[S3] S3 Endpoint")
  endpoint?: string;

  @doc("[S3] S3 Region")
  region?: string;
}

@doc("The properties of S3 ManagedStorageClass")
model BlobTemplateParameters {
  @doc("[Blob] Azure Storage Account Name")
  azureStorageAccountName?: string;

  @doc("[Blob] Azure Storage Account Key")
  @secret
  azureStorageAccountKey?: string;
}

@doc("The properties of Native ManagedStorageClass")
model NativeManagedStorageClassProperties
  extends ManagedStorageClassProperties {
  @doc("Native ManagedStorageClass")
  storageClassType: SCType.Native;

  @doc("Native ManagedStorageClass template parameters")
  templateParameters?: NativeTemplateParameters;
}

@doc("The properties of RWX ManagedStorageClass")
model RwxManagedStorageClassProperties extends ManagedStorageClassProperties {
  @doc("RWX ManagedStorageClass")
  storageClassType: SCType.RWX;

  @doc("RWX ManagedStorageClass template parameters")
  templateParameters?: RwxTemplateParameters;
}

@doc("The properties of S3 ManagedStorageClass")
model S3ManagedStorageClassProperties extends ManagedStorageClassProperties {
  @doc("S3 ManagedStorageClass")
  storageClassType: SCType.S3;

  @doc("S3 ManagedStorageClass template parameters")
  templateParameters?: S3TemplateParameters;
}

@doc("The properties of Blob ManagedStorageClass")
model BlobManagedStorageClassProperties extends ManagedStorageClassProperties {
  @doc("Blob ManagedStorageClass")
  storageClassType: SCType.Blob;

  @doc("Blob ManagedStorageClass template parameters")
  templateParameters?: BlobTemplateParameters;
}

@doc("extended location")
model ExtendedLocation {
  @doc("extended location type: CustomLocation")
  type: string;

  @doc("extended location resource id")
  name: string;
}

@doc("A ManagedStorageClass")
model ManagedStorageClassResource
  is TrackedResource<ManagedStorageClassProperties> {
  @doc("Name of ManagedStorageClass")
  @key("managedstorageclassName")
  @segment("managedstorageclass")
  @path
  @visibility("read")
  @maxLength(64)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Azure Arc property, not supported in tsp yet"
  // Extended location is not included in TrackedResource yet
  @doc("Custom location of ManagedStorageClass")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface ManagedStorageClass
  extends TrackedResourceOperations<
      ManagedStorageClassResource,
      ManagedStorageClassProperties
    > {}
