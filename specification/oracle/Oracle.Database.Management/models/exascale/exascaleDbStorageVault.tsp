import "../common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

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
  ...ResourceNameParameter<ExascaleDbStorageVault>;
  ...AvailabilityZonesProperty;
}

@added(Versions.v20241201_preview)
@doc("ExascaleDbStorageVault resource model")
model ExascaleDbStorageVaultProperties {
  @doc("The size of additional Flash Cache in percentage of High Capacity database storage.")
  @minValue(0)
  @visibility("create", "read")
  additionalFlashCacheInPercent?: int32;

  @doc("Exadata Database Storage Vault description.")
  @minLength(1)
  @maxLength(400)
  @visibility("create", "read")
  description?: string;

  @doc("The user-friendly name for the Exadata Database Storage Vault. The name does not need to be unique.")
  @minLength(1)
  @maxLength(255)
  @visibility("create", "read")
  displayName: string;

  @doc("Create exadata Database Storage Details")
  @visibility("create")
  highCapacityDatabaseStorageInput: ExascaleDbStorageInputDetails;

  @doc("Response exadata Database Storage Details")
  @visibility("read")
  highCapacityDatabaseStorage?: ExascaleDbStorageDetails;

  @doc("The time zone that you want to use for the Exadata Database Storage Vault")
  @minLength(1)
  @maxLength(255)
  @visibility("create", "read")
  timeZone?: string;

  @doc("Exadata Database Storage Vault provisioning state")
  @visibility("read")
  provisioningState?: AzureResourceProvisioningState;

  @doc("Exadata Database Storage Vault lifecycle state")
  @visibility("read")
  lifecycleState?: ExascaleDbStorageVaultLifecycleState;

  @doc("Additional information about the current lifecycle state.")
  @visibility("read")
  lifecycleDetails?: string;

  @doc("The number of Exadata VM clusters used the Exadata Database Storage Vault.")
  @visibility("read")
  vmClusterCount?: int32;

  @doc("The OCID of the Exadata Database Storage Vault.")
  @visibility("read")
  ocid?: Ocid;

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility("read")
  ociUrl?: url;
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
