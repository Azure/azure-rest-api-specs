import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./StorageAccount.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Storage;

/** The status of a metadata snapshot policy. */
@added(Versions.v2026_09_01)
union MetadataSnapshotPolicyStatus {
  string,

  /** The metadata snapshot policy is disabled. */
  Disabled: "Disabled",

  /** The metadata snapshot policy is enabled. */
  Enabled: "Enabled",
}

/** The frequency at which metadata snapshots are refreshed. */
@added(Versions.v2026_09_01)
union MetadataSnapshotRefreshFrequency {
  string,

  /** Metadata snapshots are refreshed hourly. */
  Hourly: "Hourly",

  /** Metadata snapshots are refreshed every six hours. */
  SixHourly: "6-Hourly",

  /** Metadata snapshots are refreshed daily. */
  Daily: "Daily",

  /** Metadata snapshots are refreshed weekly. */
  Weekly: "Weekly",
}

/** The server-managed definition of a metadata snapshot policy. */
@added(Versions.v2026_09_01)
model MetadataSnapshotPolicyDefinition {
  /** The frequency at which metadata snapshots are refreshed. */
  @visibility(Lifecycle.Read)
  refreshFrequency?: MetadataSnapshotRefreshFrequency;
}

/** A policy that controls metadata snapshots for a storage account. */
@added(Versions.v2026_09_01)
model MetadataSnapshotPolicy {
  /** The server-assigned metadata snapshot policy name. */
  @visibility(Lifecycle.Read)
  name?: string;

  /** The status of the metadata snapshot policy. */
  status: MetadataSnapshotPolicyStatus;

  /** The server-managed metadata snapshot policy definition. */
  definition?: MetadataSnapshotPolicyDefinition;
}

/** The properties of a storage account metadata policy. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The metadata policy does not have a provisioning state."
@added(Versions.v2026_09_01)
model MetadataPolicyProperties {
  /** The date and time when the metadata policy was last modified. */
  @visibility(Lifecycle.Read)
  lastModifiedTime?: utcDateTime;

  /** The metadata snapshot policy for the storage account. */
  snapshotPolicy: MetadataSnapshotPolicy;
}

/** The metadata policy for a storage account. */
@added(Versions.v2026_09_01)
@parentResource(StorageAccount)
@singleton("default")
model MetadataPolicy
  is Azure.ResourceManager.ProxyResource<MetadataPolicyProperties> {
  ...ResourceNameParameter<
    Resource = MetadataPolicy,
    KeyName = "metadataPolicyName",
    SegmentName = "metadataPolicies",
    NamePattern = ""
  >;
}

/** Operations for a storage account metadata policy. */
@armResourceOperations
@added(Versions.v2026_09_01)
interface MetadataPolicies {
  /** Gets the metadata policy associated with the specified storage account. */
  get is ArmResourceRead<MetadataPolicy>;

  /** Creates or replaces the metadata policy associated with the specified storage account. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MetadataPolicy>;

  /** Deletes the metadata policy associated with the specified storage account. */
  delete is ArmResourceDeleteSync<MetadataPolicy>;
}