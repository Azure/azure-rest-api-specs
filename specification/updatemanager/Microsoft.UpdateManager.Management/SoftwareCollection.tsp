import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.UpdateManager;

@doc("Software Collection resource representing a collection of software updates.")
@added(Versions.v2025_08_01_preview)
model SoftwareCollection is TrackedResource<SoftwareCollectionProperties> {
  ...ResourceNameParameter<SoftwareCollection>;
}

@doc("Properties of the SoftwareCollection resource.")
@added(Versions.v2025_08_01_preview)
model SoftwareCollectionProperties {
  @doc("The operating system type for this collection.")
  osType: OSType;

  @doc("Publishing configuration for the software collection.")
  publishing: PublishingConfiguration;

  @doc("Cleanup configurations for the software collection.")
  cleanupConfigurations?: CleanupConfiguration;

  @doc("Unique identifier used to create managed resource group.")
  @visibility(Lifecycle.Read)
  collectionId: string;

  @doc("Provisioning state of the software collection.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Operating system type enumeration.")
@added(Versions.v2025_08_01_preview)
union OSType {
  string,

  @doc("Windows operating system")
  Windows: "Windows",
}

@doc("Publishing state enumeration.")
@added(Versions.v2025_08_01_preview)
union PublishingState {
  string,

  @doc("Publishing is enabled")
  Enabled: "Enabled",

  @doc("Publishing is disabled")
  Disabled: "Disabled",
}

@doc("Publishing kind enumeration.")
@added(Versions.v2025_08_01_preview)
union PublishingKind {
  string,

  @doc("Managed publishing")
  Managed: "Managed",
}

@doc("Base publishing configuration for software collection.")
@added(Versions.v2025_08_01_preview)
@discriminator("kind")
model PublishingConfiguration {
  @doc("Indicates whether publishing is enabled.")
  enabled: PublishingState;

  @doc("Publishing kind configuration.")
  kind?: PublishingKind;
}

@doc("Managed publishing configuration for software collection.")
@added(Versions.v2025_08_01_preview)
model ManagedPublishingConfiguration extends PublishingConfiguration {
  @doc("The kind of publishing configuration.")
  kind: PublishingKind.Managed;

  @doc("Array of replication regions for managed configuration.")
  replicationRegions: ReplicationRegion[];
}

@doc("Replication region configuration.")
@added(Versions.v2025_08_01_preview)
model ReplicationRegion {
  @doc("Name of the replication region.")
  name: string;

  @doc("Replication count for the region.")
  @minValue(1)
  @maxValue(1)
  replicationCount: int32;
}

@doc("Cleanup configuration for software collection.")
@added(Versions.v2025_08_01_preview)
model CleanupConfiguration {
  @doc("Total number of versions to retain during cleanup.")
  @minValue(1)
  @maxValue(5)
  versionsToRetain: int32;
}

@armResourceOperations
@added(Versions.v2025_08_01_preview)
interface SoftwareCollections {
  get is ArmResourceRead<SoftwareCollection>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SoftwareCollection>;
  update is ArmTagsPatchAsync<SoftwareCollection>;
  delete is ArmResourceDeleteWithoutOkAsync<SoftwareCollection>;
  listByResourceGroup is ArmResourceListByParent<SoftwareCollection>;
  listBySubscription is ArmListBySubscription<SoftwareCollection>;
}
