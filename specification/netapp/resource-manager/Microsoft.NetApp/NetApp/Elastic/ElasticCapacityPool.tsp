import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./../models.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;

/**
 * NetApp Elastic Capacity Pool resource
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
@parentResource(ElasticAccount)
model ElasticCapacityPool is TrackedResource<ElasticCapacityPoolProperties> {
  ...ResourceNameParameter<
    Resource = ElasticCapacityPool,
    KeyName = "poolName",
    SegmentName = "elasticCapacityPools",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

/**
 * Elastic capacity pool properties
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model ElasticCapacityPoolProperties {
  /**
   * Provisioned size of the pool (in bytes). For zoneRedundant service level pool, value must be in the range 1TiB to 16TiB or 1TiB to 128TiB for supported region. Values expressed in bytes as multiples of 1TiB till 16TiB and in multiples of 8TiB from 24TiB to 128TiB. Pool size can't be shrunk once it is created.
   */
  @minValue(1099511627776)
  @maxValue(140737488355330)
  size: int64;

  /**
   * The service level of the elastic capacity pool
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceLevel: ElasticServiceLevel;

  /**
   * Azure lifecycle management.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /**
   * Encryption settings
   */
  encryption?: ElasticEncryptionConfiguration;

  /**
   * Total throughput of the pool in MiB/s
   */
  @visibility(Lifecycle.Read)
  totalThroughputMibps?: float64;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/elasticVolumes, this is used by all the volumes within the pool
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Indicates the current zone of the pool. This can be changed for zoneRedundant service level pool with the changeZone action
   */
  @minLength(1)
  @maxLength(1)
  @visibility(Lifecycle.Read)
  currentZone?: string;

  /**
   * Current availability status of the resource.
   */
  @visibility(Lifecycle.Read)
  availabilityStatus?: ElasticResourceAvailabilityStatus;

  /**
   * The Azure Resource URI for an Active Directory configuration. This is used by all the SMB volumes within the pool
   */
  activeDirectoryConfigResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Netapp/activeDirectoryConfigs";
    }
  ]>;
}

/** Service level for elastic capacity pool */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union ElasticServiceLevel {
  string,

  /** Zone redundant storage service level. */
  ZoneRedundant: "ZoneRedundant",
}

/**
 * CMK Encryption Configuration
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model ElasticEncryptionConfiguration {
  /**
   * Pool Encryption Key Source.
   */
  elasticPoolEncryptionKeySource: ElasticPoolEncryptionKeySource;

  /**
   * The resource ID of private endpoint for KeyVault. It must reside in the same VNET as the volume. Only applicable if encryptionKeySource = 'Microsoft.KeyVault'.
   */
  keyVaultPrivateEndpointResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateEndpoints";
    }
  ]>;
}

/**
 * Pool Encryption Key Source.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union ElasticPoolEncryptionKeySource {
  string,

  /**
   * Represents the encryption key source of Elastic pool is Microsoft.NetApp
   */
  NetApp: "NetApp",

  /**
   * Represents the encryption key source of Elastic pool is Microsoft.KeyVault
   */
  KeyVault: "KeyVault",
}

/**
 * Current availability status of the resource.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union ElasticResourceAvailabilityStatus {
  string,

  /**
   * The resource is currently Online and accessible
   */
  Online: "Online",

  /**
   * The resource is currently Offline and not accessible
   */
  Offline: "Offline",
}

/**
 * Availability status
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union CheckElasticResourceAvailabilityStatus {
  string,

  /** Value indicating the name is valid and available */
  True: "True",

  /** Value indicating the the name is invalid, unavailable, or both. */
  False: "False",
}

/**
 * Availability reason
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union CheckElasticResourceAvailabilityReason {
  string,

  /** Value indicating the name provided does not match Azure NetApp Files naming requirements */
  Invalid: "Invalid",

  /** Value indicating the name is already in use and is therefore unavailable */
  AlreadyExists: "AlreadyExists",
}

/** Changes the zone for the Zone Redundant elastic capacity pool */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model ChangeZoneRequest {
  /** Availability zone to move Zone Redundant elastic capacity pool to */
  @minLength(1)
  @maxLength(1)
  newZone: string;
}

/**
 * File path availability request content - availability is based on the elastic volume filePath within the given elastic capacityPool.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model CheckElasticVolumeFilePathAvailabilityRequest {
  /**
   * A unique file path for the volume. Used when creating mount targets. This needs to be unique within the elastic capacity pool.
   */
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,79}$")
  @minLength(1)
  @maxLength(80)
  filePath: string;
}

/**
 * Information regarding availability of a resource.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
@clientName("CheckElasticResourceAvailabilityResult", "csharp")
model CheckElasticResourceAvailabilityResponse {
  /**
   * True indicates name is valid and available. False indicates the name is invalid, unavailable, or both.
   */
  isAvailable?: CheckElasticResourceAvailabilityStatus;

  /**
   * Invalid indicates the name provided does not match Azure NetApp Files naming requirements. AlreadyExists indicates that the name is already in use and is therefore unavailable.
   */
  reason?: CheckElasticResourceAvailabilityReason;

  /**
   * If reason == invalid, provide the user with the reason why the given name is invalid, and provide the resource naming requirements so that the user can select a valid name. If reason == AlreadyExists, explain that resource name is already in use, and direct them to select a different name.
   */
  message?: string;
}

@armResourceOperations
interface ElasticCapacityPools {
  /** Get the NetApp Elastic Capacity Pool */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  get is ArmResourceRead<ElasticCapacityPool>;

  /** Create or update the specified NetApp Elastic Capacity Pool within the resource group and NetApp Elastic Account */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticCapacityPool>;

  /** Patch the specified NetApp Elastic Capacity Pool */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    ElasticCapacityPool,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ElasticCapacityPool,
      ElasticCapacityPoolProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ElasticCapacityPool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Delete the specified NetApp Elastic Capacity Pool */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  delete is ArmResourceDeleteWithoutOkAsync<ElasticCapacityPool>;

  /** List and describe all NetApp Elastic Capacity Pools in the Elastic NetApp Account. */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  listByElasticAccount is ArmResourceListByParent<ElasticCapacityPool>;

  /**
   * Moves pool to another zone
   */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  changeZone is ArmResourceActionAsync<
    ElasticCapacityPool,
    ChangeZoneRequest,
    ElasticCapacityPool
  >;

  /** Check if an Elastic Volume file path is available within the given Elastic Capacity Pool. */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  checkVolumeFilePathAvailability is ArmResourceActionSync<
    ElasticCapacityPool,
    CheckElasticVolumeFilePathAvailabilityRequest,
    CheckElasticResourceAvailabilityResponse
  >;
}

@@maxLength(ElasticCapacityPool.name, 64);
@@minLength(ElasticCapacityPool.name, 1);

@@clientName(ElasticCapacityPools.createOrUpdate::parameters.resource, "body");
@@clientName(ElasticCapacityPools.update::parameters.properties, "body");
