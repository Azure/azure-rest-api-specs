import "../common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

@added(Versions.v20241201_preview)
scalar ExascaleDbStorageVaultResourceId
  extends armResourceIdentifier<[
    {
      type: "Oracle.Database/exascaleDbStorageVaults",
    }
  ]>;

@added(Versions.v20241201_preview)
@doc("ExascaleDbStorageVault resource definition")
model ExascaleDbStorageVault
  is TrackedResource<ExascaleDbStorageVaultProperties> {
  ...ResourceNameParameter<ExascaleDbStorageVault, NamePattern = ".*">;
  ...AvailabilityZonesProperty;
}

@added(Versions.v20241201_preview)
@doc("ExascaleDbStorageVault resource model")
model ExascaleDbStorageVaultProperties {
  @doc("The size of additional Flash Cache in percentage of High Capacity database storage.")
  @minValue(0)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  additionalFlashCacheInPercent?: int32;

  @doc("Exadata Database Storage Vault description.")
  @minLength(1)
  @maxLength(400)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  description?: string;

  @doc("The user-friendly name for the Exadata Database Storage Vault. The name does not need to be unique.")
  @minLength(1)
  @maxLength(255)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  displayName: string;

  @doc("Create exadata Database Storage Details")
  @visibility(Lifecycle.Create)
  highCapacityDatabaseStorageInput: ExascaleDbStorageInputDetails;

  @doc("Response exadata Database Storage Details")
  @visibility(Lifecycle.Read)
  highCapacityDatabaseStorage?: ExascaleDbStorageDetails;

  @doc("The time zone that you want to use for the Exadata Database Storage Vault")
  @minLength(1)
  @maxLength(255)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  timeZone?: string;

  @doc("Exadata Database Storage Vault provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("Exadata Database Storage Vault lifecycle state")
  @visibility(Lifecycle.Read)
  lifecycleState?: ExascaleDbStorageVaultLifecycleState;

  @doc("Additional information about the current lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("The number of Exadata VM clusters used the Exadata Database Storage Vault.")
  @visibility(Lifecycle.Read)
  vmClusterCount?: int32;

  @doc("The OCID of the Exadata Database Storage Vault.")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility(Lifecycle.Read)
  ociUrl?: url;

  @added(Versions.v20250801_preview)
  @doc("Cloud Exadata infrastructure ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  exadataInfrastructureId?: CloudExadataInfrastructureId;

  @added(Versions.v20250801_preview)
  @doc("The shapeAttribute of the Exadata VM cluster(s) associated with the Exadata Database Storage Vault.")
  @visibility(Lifecycle.Read)
  @maxItems(2)
  attachedShapeAttributes?: ShapeAttribute[];
}

@added(Versions.v20241201_preview)
@doc("Exadata Database Storage Details")
model ExascaleDbStorageDetails {
  @doc("Available Capacity")
  availableSizeInGbs?: int32;

  @doc("Total Capacity")
  totalSizeInGbs?: int32;
}

@added(Versions.v20241201_preview)
@doc("Create exadata Database Storage Details model")
model ExascaleDbStorageInputDetails {
  @doc("Total Capacity")
  totalSizeInGbs: int32;
}

@added(Versions.v20241201_preview)
@doc("Exadata Database Storage Vault lifecycle state enum")
union ExascaleDbStorageVaultLifecycleState {
  @doc("Indicates that resource in Provisioning state")
  Provisioning: "Provisioning",

  @doc("Indicates that resource in Available state")
  Available: "Available",

  @doc("Indicates that resource in Updating state")
  Updating: "Updating",

  @doc("Indicates that resource in Terminating state")
  Terminating: "Terminating",

  @doc("Indicates that resource in Terminated state")
  Terminated: "Terminated",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  string,
}
