import "./../LiftrBase/main.tsp";

import "@typespec/openapi";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@versioned(LiftrBase.Storage.Versions)
@armLibraryNamespace
namespace LiftrBase.Storage;

@doc("Supported versions for LiftrBase.Storage resource model")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1 and LiftrBase.Versions.v1_preview")
  @useDependency(LiftrBase.Versions.v2_preview)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2_preview: "2024-02-01-preview",
}

/**
 * Properties specific to the Qumulo File System resource
 */
model FileSystemResourceProperties {
  /**
   * Marketplace details
   */
  marketplaceDetails: MarketplaceDetails;

  /**
   * Provisioning State of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Storage Sku
   */
  storageSku: string;

  /**
   * User Details
   */
  userDetails: UserDetails;

  /**
   * Delegated subnet id for Vnet injection
   */
  delegatedSubnetId: string;

  /**
   * File system Id of the resource
   */
  clusterLoginUrl?: string;

  /**
   * Private IPs of the resource
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is the correct name"
  privateIPs?: string[];

  /**
   * Initial administrator password of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Mark this property with @secret if the contents should be kept private."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME:  If this is a real secret, mark with @secret"
  @OpenAPI.extension("x-ms-secret", true)
  adminPassword: string;

  /**
   * Availability zone
   */
  availabilityZone?: string;
}

/**
 * The type used for update operations of the FileSystemResource.
 */
model FileSystemResourceUpdate {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  tags?: Record<string>;

  /**
   * The updatable properties of the FileSystemResource.
   */
  properties?: FileSystemResourceUpdateProperties;
}

/**
 * The updatable properties of the FileSystemResource.
 */
model FileSystemResourceUpdateProperties {
  /**
   * Marketplace details
   */
  marketplaceDetails?: MarketplaceDetails;

  /**
   * User Details
   */
  userDetails?: UserDetails;

  /**
   * Delegated subnet id for Vnet injection
   */
  delegatedSubnetId?: string;
}

model FileSystemResource
  is Azure.ResourceManager.TrackedResource<FileSystemResourceProperties> {
  /**
   * Name of the File System resource
   */
  @path
  @key("fileSystemName")
  @segment("fileSystems")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9_-]*$")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}
