import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Oracle.Database;

@doc("Patching mode enum")
union PatchingMode {
  @doc("Rolling patching")
  Rolling: "Rolling",

  @doc("Non Rolling patching")
  NonRolling: "NonRolling",

  string,
}

@doc("Preference enum")
union Preference {
  @doc("No preference")
  NoPreference: "NoPreference",

  @doc("Custom preference")
  CustomPreference: "CustomPreference",

  string,
}

@doc("CloudExadataInfrastructureLifecycleState enum")
union CloudExadataInfrastructureLifecycleState {
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

  @doc("Indicates that resource maintenance in progress state")
  MaintenanceInProgress: "MaintenanceInProgress",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  string,
}

@doc("MaintenanceWindow resource properties")
model MaintenanceWindow {
  @doc("The maintenance window scheduling preference.")
  preference?: Preference;

  @doc("Months during the year when maintenance should be performed.")
  @extension("x-ms-identifiers", #["name"])
  months?: Month[];

  @doc("Weeks during the month when maintenance should be performed. Weeks start on the 1st, 8th, 15th, and 22nd days of the month, and have a duration of 7 days. Weeks start and end based on calendar dates, not days of the week. For example, to allow maintenance during the 2nd week of the month (from the 8th day to the 14th day of the month), use the value 2. Maintenance cannot be scheduled for the fifth week of months that contain more than 28 days. Note that this parameter works in conjunction with the  daysOfWeek and hoursOfDay parameters to allow you to specify specific days of the week and hours that maintenance will be performed. ")
  weeksOfMonth?: int32[];

  @doc("Days during the week when maintenance should be performed.")
  @extension("x-ms-identifiers", #["name"])
  daysOfWeek?: DayOfWeek[];

  @doc("The window of hours during the day when maintenance should be performed. The window is a 4 hour slot. Valid values are - 0 - represents time slot 0:00 - 3:59 UTC - 4 - represents time slot 4:00 - 7:59 UTC - 8 - represents time slot 8:00 - 11:59 UTC - 12 - represents time slot 12:00 - 15:59 UTC - 16 - represents time slot 16:00 - 19:59 UTC - 20 - represents time slot 20:00 - 23:59 UTC")
  hoursOfDay?: int32[];

  @doc("Lead time window allows user to set a lead time to prepare for a down time. The lead time is in weeks and valid value is between 1 to 4. ")
  leadTimeInWeeks?: int32;

  @doc("Cloud Exadata infrastructure node patching method.")
  patchingMode?: PatchingMode;

  // OCI Docs say min value is 15, but when making the call in OCI, observed a value of 0, so setting minimum value to 0.
  // Link: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/datatypes/MaintenanceWindow
  @doc("Determines the amount of time the system will wait before the start of each database server patching operation. Custom action timeout is in minutes and valid value is between 15 to 120 (inclusive).")
  @minValue(0)
  @maxValue(120)
  customActionTimeoutInMins?: int32;

  @doc("If true, enables the configuration of a custom action timeout (waiting period) between database server patching operations.")
  isCustomActionTimeoutEnabled?: boolean;

  // isMonthlyPatchingEnabled parameter was found in response in OCI, but is not found in OCI Docs: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/datatypes/MaintenanceWindow
  @doc("is Monthly Patching Enabled")
  isMonthlyPatchingEnabled?: boolean;
}

@doc("The estimated total time required in minutes for all patching operations (database server, storage server, and network switch patching).")
model EstimatedPatchingTime {
  @doc("The estimated time required in minutes for database server patching.")
  @minValue(1)
  @maxValue(3000)
  @visibility(Lifecycle.Read)
  estimatedDbServerPatchingTime?: int32;

  @doc("The estimated time required in minutes for network switch patching.")
  @minValue(1)
  @maxValue(3000)
  @visibility(Lifecycle.Read)
  estimatedNetworkSwitchesPatchingTime?: int32;

  @doc("The estimated time required in minutes for storage server patching.")
  @minValue(1)
  @maxValue(3000)
  @visibility(Lifecycle.Read)
  estimatedStorageServerPatchingTime?: int32;

  @doc("The estimated total time required in minutes for all patching operations.")
  @minValue(1)
  @maxValue(3000)
  @visibility(Lifecycle.Read)
  totalEstimatedPatchingTime?: int32;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("CloudExadataInfrastructure resource definition")
model CloudExadataInfrastructure
  is TrackedResource<CloudExadataInfrastructureProperties> {
  @doc("CloudExadataInfrastructure name")
  @key("cloudexadatainfrastructurename")
  @path
  @segment("cloudExadataInfrastructures")
  @pattern(".*")
  name: string;

  @doc("CloudExadataInfrastructure zones")
  zones: string[];
}

@doc("CloudExadataInfrastructure resource model")
model CloudExadataInfrastructureProperties {
  @doc("Exadata infra ocid")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("The number of compute servers for the cloud Exadata infrastructure.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  computeCount?: int32;

  @doc("The number of storage servers for the cloud Exadata infrastructure.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  storageCount?: int32;

  @doc("The total storage allocated to the cloud Exadata infrastructure resource, in gigabytes (GB).")
  @visibility(Lifecycle.Read)
  totalStorageSizeInGbs?: int32;

  @doc("The available storage can be allocated to the cloud Exadata infrastructure resource, in gigabytes (GB).")
  @visibility(Lifecycle.Read)
  availableStorageSizeInGbs?: int32;

  @doc("The date and time the cloud Exadata infrastructure resource was created.")
  @visibility(Lifecycle.Read)
  timeCreated?: string;

  @doc("Additional information about the current lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("maintenanceWindow property")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindow;

  @doc("The estimated total time required in minutes for all patching operations (database server, storage server, and network switch patching).")
  @visibility(Lifecycle.Read)
  estimatedPatchingTime?: EstimatedPatchingTime;

  @doc("The list of customer email addresses that receive information from Oracle about the specified OCI Database service resource. Oracle uses these email addresses to send notifications about planned and unplanned software maintenance updates, information about system hardware, and other information needed by administrators. Up to 10 email addresses can be added to the customer contacts for a cloud Exadata infrastructure instance. ")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @extension("x-ms-identifiers", #[])
  customerContacts?: CustomerContact[];

  @doc("CloudExadataInfrastructure provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("CloudExadataInfrastructure lifecycle state")
  @visibility(Lifecycle.Read)
  lifecycleState?: CloudExadataInfrastructureLifecycleState;

  @doc("The model name of the cloud Exadata infrastructure resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  shape: string;

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility(Lifecycle.Read)
  ociUrl?: url;

  @doc("The total number of CPU cores allocated.")
  @visibility(Lifecycle.Read)
  cpuCount?: int32;

  @doc("The total number of CPU cores available.")
  @visibility(Lifecycle.Read)
  maxCpuCount?: int32;

  @doc("The memory allocated in GBs.")
  @visibility(Lifecycle.Read)
  memorySizeInGbs?: int32;

  @doc("The total memory available in GBs.")
  @visibility(Lifecycle.Read)
  maxMemoryInGbs?: int32;

  @doc("The local node storage to be allocated in GBs.")
  @visibility(Lifecycle.Read)
  dbNodeStorageSizeInGbs?: int32;

  @doc("The total local node storage available in GBs.")
  @visibility(Lifecycle.Read)
  maxDbNodeStorageSizeInGbs?: int32;

  @doc("The quantity of data in the database, in terabytes.")
  @visibility(Lifecycle.Read)
  dataStorageSizeInTbs?: float64;

  @doc("The total available DATA disk group size.")
  @visibility(Lifecycle.Read)
  maxDataStorageInTbs?: float64;

  @doc("The software version of the database servers (dom0) in the Exadata infrastructure.")
  @visibility(Lifecycle.Read)
  dbServerVersion?: string;

  @doc("The software version of the storage servers (cells) in the Exadata infrastructure.")
  @visibility(Lifecycle.Read)
  storageServerVersion?: string;

  @doc("The requested number of additional storage servers activated for the Exadata infrastructure.")
  @visibility(Lifecycle.Read)
  activatedStorageCount?: int32;

  @doc("The requested number of additional storage servers for the Exadata infrastructure.")
  @visibility(Lifecycle.Read)
  additionalStorageCount?: int32;

  @doc("The name for the Exadata infrastructure.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minLength(1)
  @maxLength(255)
  displayName: string;

  @doc("The OCID of the last maintenance run.")
  @visibility(Lifecycle.Read)
  lastMaintenanceRunId?: Ocid;

  @doc("The OCID of the next maintenance run.")
  @visibility(Lifecycle.Read)
  nextMaintenanceRunId?: Ocid;

  @doc("Monthly Db Server version")
  @visibility(Lifecycle.Read)
  monthlyDbServerVersion?: string;

  @doc("Monthly Storage Server version")
  @visibility(Lifecycle.Read)
  monthlyStorageServerVersion?: string;
}
