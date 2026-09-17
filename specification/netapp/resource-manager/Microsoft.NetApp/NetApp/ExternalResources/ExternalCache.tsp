import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "../models.tsp";
import "./ExternalResourceEnums.tsp";

using Azure.ResourceManager;
using Versioning;
using Rest;

namespace Microsoft.NetApp;

/**
 * External Cache resource, representing a cache volume on an external ONTAP system
 */
@added(Versions.v2026_08_15_preview)
@parentResource(ExternalSvm)
model ExternalCache
  is Azure.ResourceManager.ProxyResource<ExternalCacheProperties> {
  ...ResourceNameParameter<
    Resource = ExternalCache,
    KeyName = "externalCacheResourceName",
    SegmentName = "externalCaches",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-_]{0,202}_[0-9a-fA-F]{4}$"
  >;
}

/**
 * External Cache properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only informational proxy resource with no async provisioning lifecycle"
@added(Versions.v2026_08_15_preview)
model ExternalCacheProperties {
  /**
   * Name of the cache volume on the external ONTAP system
   */
  @visibility(Lifecycle.Read)
  externalCacheName?: string;

  /**
   * Origin volume resource ID, the ANF volume that acts as the origin for this cache
   */
  @visibility(Lifecycle.Read)
  originVolumeResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>;

  /**
   * Name of the origin volume associated with this cache
   */
  @visibility(Lifecycle.Read)
  originVolumeName?: string;

  /**
   * Name of the origin SVM (Storage Virtual Machine) associated with this cache
   */
  @visibility(Lifecycle.Read)
  originSvmName?: string;

  /**
   * Size of the cache in bytes
   */
  @visibility(Lifecycle.Read)
  sizeInBytes?: int64;

  /**
   * State of the remote cache volume
   */
  @visibility(Lifecycle.Read)
  state?: ExternalCacheState;

  /**
   * The ONTAP CLI command to create this cache
   */
  @visibility(Lifecycle.Read)
  createCommand?: string;

  /**
   * Connection status of the external cache
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: ExternalCacheConnectionStatus;
}

/**
 * List of External Cache resources
 */
@added(Versions.v2026_08_15_preview)
model ExternalCacheList is Azure.Core.Page<ExternalCache>;

@added(Versions.v2026_08_15_preview)
@armResourceOperations
interface ExternalCaches {
  /**
   * Get the External Cache
   */
  get is ArmResourceRead<ExternalCache>;

  /**
   * List all External Caches under an External SVM
   */
  listByParent is ArmResourceListByParent<ExternalCache>;
}

@@doc(
  ExternalCache.name,
  "The externalCacheName with unique identifier added and leading underscores (if any) removed."
);
