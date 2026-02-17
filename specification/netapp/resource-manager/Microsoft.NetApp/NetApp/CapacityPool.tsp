import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./NetAppAccount.tsp";
import "@azure-tools/typespec-client-generator-core";

using Rest;
using Azure.ResourceManager;
using Http;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.NetApp;
/**
 * Capacity pool resource
 */
@parentResource(NetAppAccount)
model CapacityPool
  is Azure.ResourceManager.TrackedResource<PoolProperties, false> {
  ...ResourceNameParameter<
    Resource = CapacityPool,
    KeyName = "poolName",
    SegmentName = "capacityPools",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy EntityTagProperty for back compatibility"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

/**
 * List of capacity pool resources
 */
model CapacityPoolList is Azure.Core.Page<CapacityPool>;

/**
 * Pool properties
 */
model PoolProperties {
  /**
   * UUID v4 used to identify the Pool
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  poolId?: string;

  /**
   * Provisioned size of the pool (in bytes). Allowed values are in 1TiB chunks (value must be multiple of 1099511627776).
   */
  @removed(Versions.v2025_12_15_preview)
  @renamedFrom(Versions.v2025_12_15_preview, "size")
  sizeOld: int64 = 4398046511104;

  /**
   * Provisioned size of the pool (in bytes). Allowed values are 512GiB (549755813888 bytes) or in 1TiB chunks (value must be multiple of 1099511627776).
   */
  @added(Versions.v2025_12_15_preview)
  size: int64 = 4398046511104;

  /**
   * The service level of the file system
   */
  serviceLevel: ServiceLevel = ServiceLevel.Premium;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Total throughput of pool in MiB/s
   */
  @visibility(Lifecycle.Read)
  totalThroughputMibps?: float32;

  /**
   * Utilized throughput of pool in MiB/s
   */
  @visibility(Lifecycle.Read)
  utilizedThroughputMibps?: float32;

  /**
   * Maximum throughput in MiB/s that can be achieved by this pool and this will be accepted as input only for manual qosType pool with Flexible service level
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  customThroughputMibps?: int32 | null;

  /**
   * The qos type of the pool
   */
  qosType?: QosType = QosType.Auto;

  /**
   * If enabled (true) the pool can contain cool Access enabled volumes.
   */
  coolAccess?: boolean = false;

  /**
   * Encryption type of the capacity pool, set encryption type for data at rest for this pool and all volumes in it. This value can only be set when creating new pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  encryptionType?: EncryptionType | null = EncryptionType.Single;
}

/**
 * Capacity pool patch resource
 */
model CapacityPoolPatch {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Capacity pool properties
   */
  properties?: PoolPatchProperties;
}

/**
 * Patchable pool properties
 */
model PoolPatchProperties {
  /**
   * Provisioned size of the pool (in bytes). Allowed values are in 1TiB chunks (value must be multiple of 1099511627776).
   */
  @removed(Versions.v2025_12_15_preview)
  @renamedFrom(Versions.v2025_12_15_preview, "size")
  sizeOld?: int64;

  /**
   * Provisioned size of the pool (in bytes). Allowed values are 512GiB (549755813888 bytes) or in 1TiB chunks (value must be multiple of 1099511627776).
   */
  @added(Versions.v2025_12_15_preview)
  size?: int64;

  /**
   * The qos type of the pool
   */
  qosType?: QosType;

  /**
   * If enabled (true) the pool can contain cool Access enabled volumes.
   */
  coolAccess?: boolean;

  /**
   * Maximum throughput in MiB/s that can be achieved by this pool and this will be accepted as input only for manual qosType pool with Flexible service level
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @clientName("customThroughputMibpsInt", "csharp")
  customThroughputMibps?: int32 | null;
}

/**
 * Encryption type of the capacity pool, set encryption type for data at rest for this pool and all volumes in it. This value can only be set when creating new pool.
 */
@clientName("CapacityPoolEncryptionType", "csharp")
union EncryptionType {
  string,

  /**
   * EncryptionType Single, volumes will use single encryption at rest
   */
  Single: "Single",

  /**
   * EncryptionType Double, volumes will use double encryption at rest
   */
  Double: "Double",
}

/**
 * The service level of the file system
 */
@clientName("NetAppFileServiceLevel", "csharp")
union ServiceLevel {
  string,

  /**
   * Standard service level
   */
  Standard: "Standard",

  /**
   * Premium service level
   */
  Premium: "Premium",

  /**
   * Ultra service level
   */
  Ultra: "Ultra",

  /**
   * Zone redundant storage service level. This will be deprecated soon.
   */
  StandardZRS: "StandardZRS",

  /**
   * Flexible service level
   */
  Flexible: "Flexible",
}

/**
 * The qos type of the pool
 */
union QosType {
  string,

  /**
   * qos type Auto
   */
  Auto: "Auto",

  /**
   * qos type Manual
   */
  Manual: "Manual",
}

@armResourceOperations
interface CapacityPools {
  /**
   * Get details of the specified capacity pool
   */
  get is ArmResourceRead<CapacityPool>;

  /**
   * Create or Update a capacity pool
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CapacityPool,
    LroHeaders = ArmLroLocationHeader<FinalResult = CapacityPool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Patch the specified capacity pool
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<CapacityPool, PatchModel = CapacityPoolPatch>;

  /**
   * Delete the specified capacity pool
   */
  delete is ArmResourceDeleteWithoutOkAsync<CapacityPool>;

  /**
   * List all capacity pools in the NetApp Account
   */
  list is ArmResourceListByParent<
    CapacityPool,
    Response = ArmResponse<CapacityPoolList>
  >;
}

@@maxLength(CapacityPool.name, 64);
@@minLength(CapacityPool.name, 1);
@@doc(CapacityPool.name, "The name of the capacity pool");
@@doc(CapacityPool.properties, "Capacity pool properties");
@@doc(CapacityPools.createOrUpdate::parameters.resource,
  "Capacity pool object supplied in the body of the operation."
);
@@doc(CapacityPools.update::parameters.properties,
  "Capacity pool object supplied in the body of the operation."
);
