import "./../LiftrBase/main.tsp";

import "@typespec/openapi";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.ResourceManager;
using LiftrBase;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.Reflection;
using Azure.ResourceManager.Foundations;

@versioned(LiftrBase.Storage.Versions)
@armLibraryNamespace
namespace LiftrBase.Storage;

@doc("Supported versions for LiftrBase.Storage resource model")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1 and LiftrBase.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v2_preview)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2_preview: "2024-02-01-preview",
}

/**
 * Properties specific to the Dell File System resource
 */
model FileSystemResourceProperties {
  /**
   * Initial capacity for Dell Filesystem in bytes
   */
  initialCapacity: int64;

  /**
   * Marketplace details
   */
  marketplaceDetails: MarketplaceDetails;

  /**
   * Provisioning State of the resource
   */
  @visibility("read")
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
  userDetails: UserDetails;

  /**
   * File system Id of the resource
   */
  clusterLoginUrl?: string;

  /**
   * Private IPs of the resource
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is the correct name"
  privateIPs?: string[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The type used for update operations of the FileSystemResource.
 */
model FileSystemResourceUpdate {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The updatable properties of the FileSystemResource.
   */
  properties?: FileSystemResourceUpdateProperties;

  /**
   * The managed service identities assigned to this resource.
   */
  ...ManagedServiceIdentityProperty;
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
   * Initial capacity for Dell Filesystem in bytes
   */
  initialCapacity?: int64;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(FileSystemResourceProperties)
model FileSystemResource
  is Azure.ResourceManager.TrackedResource<FileSystemResourceProperties> {
  /**
   * A FileSystem Resource by Dell
   */
  @path
  @key("filesystemName")
  @segment("filesystems")
  @visibility("read")
  @pattern("^[a-zA-Z0-9_-]*$")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}
