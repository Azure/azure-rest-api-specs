import "../LiftrBase/main.tsp";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using LiftrBase;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@versioned(LiftrBase.Storage.Versions)
@armLibraryNamespace
namespace LiftrBase.Storage;

/**
 * The available API versions.
 */
enum Versions {
  @useDependency(LiftrBase.Versions.v2025_03_21_preview)
  @useDependency(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_03_21_preview: "2025-03-21-preview",

  @useDependency(LiftrBase.Versions.v2025_03_21)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_03_21: "2025-03-21",
}

/**
 * Properties specific to the Dell File System resource
 */
model FileSystemResourceProperties {
  /**
   * Capacity for Dell Filesystem, Will be received as part of Job Status
   */
  capacity?: Capacity;

  /**
   * Marketplace details
   */
  marketplace: LiftrBase.MarketplaceDetails;

  /**
   * Provisioning State of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Delegated subnet id for Vnet injection
   */
  delegatedSubnetId: string;

  /**
   * Domain range for the delegated subnet
   */
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}/(16|24)$")
  delegatedSubnetCidr: string;

  /**
   * User Details
   */
  user: LiftrBase.UserDetails;

  /**
   * File system Id of the resource
   */
  fileSystemId?: string;

  /**
   * Smart Connect FQDN of the resource
   */
  smartConnectFqdn?: string;

  /**
   * OneFS url
   */
  oneFsUrl?: string;

  /**
   * DellReferenceNumber of the resource
   */
  dellReferenceNumber: string;

  /**
   * EncryptionProperties of the resource
   */
  encryption: LiftrBase.EncryptionProperties;
}
/**
 * Capacity for a Resource
 */
model Capacity {
  /**
   * Minimum Capacity
   */
  min?: string;

  /**
   * Maximum Capacity
   */
  max?: string;

  /**
   * Units to be increased
   */
  incremental?: string;

  /**
   * Current Capacity of the resource
   */
  current?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The type used for update operations of the FileSystemResource.
 */
model FileSystemResourceUpdate {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: ManagedServiceIdentityUpdate;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;

  /**
   * The updatable properties of the FileSystemResource.
   */
  properties?: FileSystemResourceUpdateProperties;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentityUpdate {
  /**
   * The type of managed identity assigned to this resource.
   */
  type?: ManagedServiceIdentityType;

  /**
   * The identities assigned to this resource by the user.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  userAssignedIdentities?: Record<UserAssignedIdentity | null>;
}

/**
 * The updatable properties of the FileSystemResource.
 */
model FileSystemResourceUpdateProperties {
  /**
   * Delegated subnet id for Vnet injection
   */
  delegatedSubnetId?: string;

  /**
   * Capacity for Dell Filesystem
   */
  capacity?: Capacity;

  /**
   * Encryption Details of the resource
   */
  encryption?: LiftrBase.EncryptionUpdateProperties;
}

/**
 * Concrete tracked resource types can be created by aliasing this type using a specific property type.
 */
model FileSystemResource
  is Azure.ResourceManager.TrackedResource<LiftrBase.Storage.FileSystemResourceProperties> {
  ...ResourceNameParameter<
    Resource = LiftrBase.Storage.FileSystemResource,
    KeyName = "filesystemName",
    SegmentName = "filesystems",
    NamePattern = "^[a-zA-Z0-9_-]*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}
