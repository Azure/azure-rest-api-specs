import "./shared.tsp";
import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Mode of high availability supported for this compute.
 */
union HighAvailabilityMode {
  string,

  /** High availability is supported for this compute, with standby server in a different availability zone than that of the primary. */
  ZoneRedundant: "ZoneRedundant",

  /** High availability is supported for this compute, with standby server in the same availability zone as the primary. */
  SameZone: "SameZone",
}

/**
 * Status of the feature. Indicates if the feature is enabled or not.
 */
union FeatureStatus {
  string,

  /** Feature is enabled. */
  Enabled: "Enabled",

  /** Feature is disabled. */
  Disabled: "Disabled",
}

/**
 * Indicates if fast provisioning is supported. 'Enabled' means fast provisioning is supported. 'Disabled' stands for fast provisioning is not supported. Will be deprecated in the future. Look to Supported Features for 'FastProvisioning'.
 */
union FastProvisioningSupport {
  string,

  /** Fast provisioning is supported. */
  Enabled: "Enabled",

  /** Fast provisioning is not supported. */
  Disabled: "Disabled",
}

/**
 * Indicates if geographically redundant backups are supported in this location. Will be deprecated in the future. Look to Supported Features for 'GeoBackup'.
 */
union GeographicallyRedundantBackupSupport {
  string,

  /** Geographically redundant backups are supported in this location. */
  Enabled: "Enabled",

  /** Geographically redundant backups are not supported in this location. */
  Disabled: "Disabled",
}

/**
 * Indicates if high availability with zone redundancy is supported in this location. Will be deprecated in the future. Look to Supported Features for  'ZoneRedundantHa'.
 */
union ZoneRedundantHighAvailabilitySupport {
  string,

  /** High availability with zone redundancy is supported. */
  Enabled: "Enabled",

  /** High availability with zone redundancy is not supported. */
  Disabled: "Disabled",
}

/**
 * Indicates if high availability with zone redundancy is supported in conjunction with geographically redundant backups in this location. Will be deprecated in the future. Look to Supported Features for 'ZoneRedundantHaAndGeoBackup'.
 */
union ZoneRedundantHighAvailabilityAndGeographicallyRedundantBackupSupport {
  string,

  /** High availability with zone redundancy is supported in conjunction with geographically redundant backups. */
  Enabled: "Enabled",

  /** High availability with zone redundancy is not supported in conjunction with geographically redundant backups. */
  Disabled: "Disabled",
}

/**
 * Indicates if storage autogrow is supported in this location. Will be deprecated in the future. Look to Supported Features for 'StorageAutoGrowth'.
 */
union StorageAutoGrowthSupport {
  string,

  /** Storage autogrow is supported. */
  Enabled: "Enabled",

  /** Storage autogrow is not supported. */
  Disabled: "Disabled",
}

/**
 * Indicates if resizing the storage, without interrupting the operation of the database engine, is supported in this location for the given subscription. Will be deprecated in the future. Look to Supported Features for 'OnlineResize'.
 */
union OnlineStorageResizeSupport {
  string,

  /** Resizing the storage without interrupting the operation of the database engine is supported. */
  Enabled: "Enabled",

  /** Resizing the storage without interrupting the operation of the database engine is not supported. */
  Disabled: "Disabled",
}

/**
 * Indicates if this location is restricted. Will be deprecated in the future. Look to Supported Features for 'Restricted'.
 */
union LocationRestricted {
  string,

  /** Location is restricted. */
  Enabled: "Enabled",

  /** Location is not restricted. */
  Disabled: "Disabled",
}

/**
 * Status of the capability.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CapabilityStatus {
  Visible,
  Available,
  Default,
  Disabled,
}

/**
 * List of capabilities for the Azure Database for PostgreSQL flexible server.
 */
model CapabilityList is Azure.Core.Page<Capability>;

/**
 * Capability for the Azure Database for PostgreSQL flexible server.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Capability extends CapabilityBase {
  /**
   * Name of flexible servers capabilities.
   */
  name?: string;

  /**
   * List of supported compute tiers.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedServerEditions?: ServerEditionCapability[];

  /**
   * List of supported major versions of PostgreSQL database engine.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedServerVersions?: ServerVersionCapability[];

  /**
   * Features supported.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedFeatures?: SupportedFeature[];

  /**
   * Indicates if fast provisioning is supported. 'Enabled' means fast provisioning is supported. 'Disabled' stands for fast provisioning is not supported. Will be deprecated in the future. Look to Supported Features for 'FastProvisioning'.
   */
  @visibility(Lifecycle.Read)
  fastProvisioningSupported?: FastProvisioningSupport;

  /**
   * List of compute tiers supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["supportedSku"])
  supportedFastProvisioningEditions?: FastProvisioningEditionCapability[];

  /**
   * Indicates if geographically redundant backups are supported in this location. 'Enabled' means geographically redundant backups are supported. 'Disabled' stands for geographically redundant backup is not supported. Will be deprecated in the future. Look to Supported Features for 'GeoBackup'.
   */
  @visibility(Lifecycle.Read)
  geoBackupSupported?: GeographicallyRedundantBackupSupport;

  /**
   * Indicates if high availability with zone redundancy is supported in this location. 'Enabled' means high availability with zone redundancy is supported. 'Disabled' stands for high availability with zone redundancy is not supported. Will be deprecated in the future. Look to Supported Features for  'ZoneRedundantHa'.
   */
  @visibility(Lifecycle.Read)
  zoneRedundantHaSupported?: ZoneRedundantHighAvailabilitySupport;

  /**
   * Indicates if high availability with zone redundancy is supported in conjunction with geographically redundant backups in this location. 'Enabled' means high availability with zone redundancy is supported in conjunction with geographically redundant backups is supported. 'Disabled' stands for high availability with zone redundancy is supported in conjunction with geographically redundant backups is not supported. Will be deprecated in the future. Look to Supported Features for 'ZoneRedundantHaAndGeoBackup'.
   */
  @visibility(Lifecycle.Read)
  zoneRedundantHaAndGeoBackupSupported?: ZoneRedundantHighAvailabilityAndGeographicallyRedundantBackupSupport;

  /**
   * Indicates if storage autogrow is supported in this location. 'Enabled' means storage autogrow is supported. 'Disabled' stands for storage autogrow is not supported. Will be deprecated in the future. Look to Supported Features for 'StorageAutoGrowth'.
   */
  @visibility(Lifecycle.Read)
  storageAutoGrowthSupported?: StorageAutoGrowthSupport;

  /**
   * Indicates if resizing the storage, without interrupting the operation of the database engine, is supported in this location for the given subscription. 'Enabled' means resizing the storage without interrupting the operation of the database engine is supported. 'Disabled' means resizing the storage without interrupting the operation of the database engine is not supported. Will be deprecated in the future. Look to Supported Features for 'OnlineResize'.
   */
  @visibility(Lifecycle.Read)
  onlineResizeSupported?: OnlineStorageResizeSupport;

  /**
   * Indicates if this location is restricted. 'Enabled' means location is restricted. 'Disabled' stands for location is not restricted. Will be deprecated in the future. Look to Supported Features for 'Restricted'.
   */
  @visibility(Lifecycle.Read)
  restricted?: LocationRestricted;
}

/**
 * Capabilities in terms of compute tier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerEditionCapability extends CapabilityBase {
  /**
   * Name of compute tier.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Default compute name (SKU) for this computer tier.
   */
  @visibility(Lifecycle.Read)
  defaultSkuName?: string;

  /**
   * List of storage editions supported by this compute tier and compute name.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedStorageEditions?: StorageEditionCapability[];

  /**
   * List of supported compute names (SKUs).
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedServerSkus?: ServerSkuCapability[];
}

/**
 * Capabilities in terms of storage tier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageEditionCapability extends CapabilityBase {
  /**
   * Name of storage tier.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Default storage size (in MB) for this storage tier.
   */
  @visibility(Lifecycle.Read)
  defaultStorageSizeMb?: int64;

  /**
   * Configurations of storage supported for this storage tier.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["storageSizeMb"])
  supportedStorageMb?: StorageMbCapability[];
}

/**
 * Storage size (in MB) capability.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageMbCapability extends CapabilityBase {
  /**
   * Minimum IOPS supported by the storage size.
   */
  @visibility(Lifecycle.Read)
  supportedIops?: int32;

  /**
   * Maximum IOPS supported by the storage size.
   */
  @visibility(Lifecycle.Read)
  supportedMaximumIops?: int32;

  /**
   * Minimum supported size (in MB) of storage.
   */
  @visibility(Lifecycle.Read)
  storageSizeMb?: int64;

  /**
   * Maximum supported size (in MB) of storage.
   */
  @visibility(Lifecycle.Read)
  maximumStorageSizeMb?: int64;

  /**
   * Minimum supported throughput (in MB/s) of storage.
   */
  @visibility(Lifecycle.Read)
  supportedThroughput?: int32;

  /**
   * Maximum supported throughput (in MB/s) of storage.
   */
  @visibility(Lifecycle.Read)
  supportedMaximumThroughput?: int32;

  /**
   * Default IOPS for this tier and storage size.
   */
  @visibility(Lifecycle.Read)
  defaultIopsTier?: string;

  /**
   * List of all supported storage tiers for this tier and storage size.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedIopsTiers?: StorageTierCapability[];
}

/**
 * Capability of a storage tier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageTierCapability extends CapabilityBase {
  /**
   * Name of the storage tier.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Supported IOPS for the storage tier.
   */
  @visibility(Lifecycle.Read)
  iops?: int32;
}

/**
 * Base object for representing capability
 */
model CapabilityBase {
  /**
   * Status of the capability.
   */
  @visibility(Lifecycle.Read)
  status?: CapabilityStatus;

  /**
   * Reason for the capability not being available.
   */
  @visibility(Lifecycle.Read)
  reason?: string;
}

/**
 * Capabilities in terms of compute.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerSkuCapability extends CapabilityBase {
  /**
   * Name of the compute (SKU).
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * vCores available for this compute.
   */
  @visibility(Lifecycle.Read)
  vCores?: int32;

  /**
   * Maximum IOPS supported by this compute.
   */
  @visibility(Lifecycle.Read)
  supportedIops?: int32;

  /**
   * Supported memory (in MB) per virtual core assigned to this compute.
   */
  @visibility(Lifecycle.Read)
  supportedMemoryPerVcoreMb?: int64;

  /**
   * List of supported availability zones. E.g. '1', '2', '3'
   */
  @visibility(Lifecycle.Read)
  supportedZones?: string[];

  /**
   * Modes of high availability supported for this compute.
   */
  @visibility(Lifecycle.Read)
  supportedHaMode?: HighAvailabilityMode[];

  /**
   * Features supported.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedFeatures?: SupportedFeature[];

  /**
   * Security profile of the compute. Indicates if it's a Confidential Compute virtual machine.
   */
  @visibility(Lifecycle.Read)
  securityProfile?: string;
}

/**
 * Features supported.
 */
model SupportedFeature {
  /**
   * Name of the feature.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the feature. Indicates if the feature is enabled or not.
   */
  @visibility(Lifecycle.Read)
  status?: FeatureStatus;
}

/**
 * Capabilities in terms of major versions of PostgreSQL database engine.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServerVersionCapability extends CapabilityBase {
  /**
   * Major version of PostgreSQL database engine.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Major versions of PostgreSQL database engine to which this version can be automatically upgraded.
   */
  @visibility(Lifecycle.Read)
  supportedVersionsToUpgrade?: string[];

  /**
   * Features supported.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  supportedFeatures?: SupportedFeature[];
}

/**
 * Capability of a fast provisioning compute tier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FastProvisioningEditionCapability extends CapabilityBase {
  /**
   * Compute tier supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  supportedTier?: string;

  /**
   * Compute name (SKU) supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  supportedSku?: string;

  /**
   * Storage size (in GB) supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  supportedStorageGb?: int32;

  /**
   * Major version of PostgreSQL database engine supporting fast provisioning.
   */
  @visibility(Lifecycle.Read)
  supportedServerVersions?: string;

  /**
   * Count of servers in cache matching this specification.
   */
  @visibility(Lifecycle.Read)
  serverCount?: int32;
}

@@visibility(CapabilityList.value, Lifecycle.Read);

@@identifiers(CapabilityList.value, #["name"]);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CapabilitiesByLocationOperationGroup {
  /**
   * Lists the capabilities available in a given location for a specific subscription.
   */
  @list
  @autoRoute
  @get
  @action("capabilities")
  list is ArmProviderActionSync<
    Response = CapabilityList,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
