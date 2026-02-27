import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@doc("Properties of a HorizonDb cluster")
model HorizonDbClusterProperties {
  @doc("The administrator login name")
  @minLength(1)
  @maxLength(63)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  administratorLogin: string;

  @doc("The administrator login password")
  @secret
  @minLength(8)
  @maxLength(128)
  administratorLoginPassword?: string;

  @doc("The version of the Orion Db")
  version?: string;

  @doc("The mode to create a new HorizonDb cluster")
  createMode?: CreateModeCluster;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Restore point creation time (ISO8601 format), specifying the time to restore from")
  pointInTimeUTC?: utcDateTime;

  @doc("The source HorizonDb cluster resource identifier for read replica or point in time restore scenarios")
  sourceOrionDbResourceId?: string;

  @doc("The pool name for restore or replica operations")
  poolName?: string;

  @doc("Number of replicas")
  @minValue(0)
  @maxValue(20)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  replicaCount?: int32;

  @doc("Number of vCores")
  @minValue(1)
  @maxValue(96)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  vCores?: int32;

  @doc("The availability zone of the Orion Db")
  availabilityZone?: string;

  @doc("The processor type for the Orion Db cluster")
  processorType?: string;

  @doc("The network related info")
  network?: Network;

  @doc("The high availability related info")
  highAvailability?: HighAvailability;

  @doc("The maintenance window related info")
  maintenanceWindow?: MaintenanceWindowOptions;

  @doc("Current state of the cluster")
  @visibility(Lifecycle.Read)
  state?: State;

  @doc("The fully qualified domain name of the cluster")
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  @doc("The fully qualified domain name used for readonly endpoint for the cluster")
  @visibility(Lifecycle.Read)
  readonlyEndpoint?: string;

  @doc("The earliest restore point time (ISO8601 format) for the cluster")
  @visibility(Lifecycle.Read)
  earliestRestoreDate?: utcDateTime;

  @doc("The provisioning state of the cluster")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The zone placement policy")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  zonePlacementPolicy?: string;
}

@doc("Properties of a HorizonDb cluster for update operations")
model HorizonDbClusterPropertiesForUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @secret
  @minLength(8)
  @maxLength(128)
  @doc("The administrator login password")
  administratorLoginPassword?: string;

  @doc("Number of vCores")
  @minValue(1)
  @maxValue(96)
  vCores?: int32;
}

@doc("Properties of a HorizonDb pool")
model HorizonDbPoolProperties {
  @doc("The SKU for the OrionDb pool")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  sku?: string;

  @doc("The location of the OrionDb pool")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  @doc("Current state of the pool")
  @visibility(Lifecycle.Read)
  state?: State;

  @doc("Number of replicas in the pool")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  replicaCount?: int32;

  @doc("The administrator login for the pool")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  administratorLogin?: string;

  @doc("The administrator login password for the pool")
  @secret
  @visibility(Lifecycle.Update)
  administratorLoginPassword?: string;

  @doc("The version of the OrionDb pool")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  version?: string;

  @doc("The tags for the OrionDb pool")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  tags?: string;

  @doc("The create mode for the pool")
  @visibility(Lifecycle.Update)
  createMode?: CreateModePool;

  @doc("The provisioning state of the pool")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Network properties")
model Network {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicNetworkAccess is a configuration flag, not sensitive data"
  @doc("The flag indicating whether public ip is requested")
  @visibility(Lifecycle.Read)
  publicNetworkAccess?: string;

  @doc("The customer provided delegated subnet full ARM resource ID")
  delegatedSubnetResourceId?: string;

  @doc("The customer provided private DNS zone full ARM resource ID")
  privateDnsZoneArmResourceId?: string;
}

@doc("High availability properties")
model HighAvailability {
  @doc("The HA mode for the server")
  mode?: HighAvailabilityMode;

  @doc("The user visible HA state of the server")
  @visibility(Lifecycle.Read)
  state?: string;

  @doc("The availability zone of the standby server")
  @visibility(Lifecycle.Read)
  standbyAvailabilityZone?: string;

  @doc("The fully qualified domain name of the standby server")
  @visibility(Lifecycle.Read)
  fullyQualifiedStandbyDomainName?: string;
}
@doc("Modes of high availability supported for this compute.")
union HighAvailabilityMode {
  string,

  /** High availability is disabled */
  Disabled: "Disabled",

  /** Zone redundant high availability */
  ZoneRedundant: "ZoneRedundant",

  /** Same zone high availability */
  SameZone: "SameZone",
}

@doc("Maintenance window properties")
model MaintenanceWindowOptions {
  @doc("Indicates whether the window is customer or system default")
  customWindow?: string;

  @doc("The day of the week for the maintenance to occur (0-6, where 0 is Sunday)")
  @minValue(0)
  @maxValue(6)
  dayOfWeek?: int32;

  @doc("The hour to start the maintenance (0-23)")
  @minValue(0)
  @maxValue(23)
  startHour?: int32;

  @doc("The minute to start the maintenance (0-59)")
  @minValue(0)
  @maxValue(59)
  startMinute?: int32;
}

@doc("Properties of a HorizonDb pool for update operations")
model HorizonDbPoolPropertiesForUpdate {
  @doc("Number of replicas in the pool")
  @minValue(0)
  @maxValue(20)
  replicaCount?: int32;
}

@doc("Represents a HorizonDb pool resource for update operations")
model HorizonDbPoolForPatch {
  @doc("The properties of the pool for update")
  properties?: HorizonDbPoolPropertiesForUpdate;
}

@doc("Properties of a HorizonDb replica")
model HorizonDbReplicaProperties {
  /**
   * Role of the replica
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  role?: ReplicaRole;

  @doc("Current status of the replica")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  status?: State;

  @doc("The fully qualified domain name of the replica")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  fullyQualifiedDomainName?: string;

  @doc("The provisioning state of the replica")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of a HorizonDb replica for update operations")
model HorizonDbReplicaPropertiesForUpdate {
  @doc("Role of the replica")
  role?: ReplicaRole;
}

@doc("Represents a HorizonDb replica resource for update operations")
model HorizonDbReplicaForPatch {
  @doc("The properties of the replica for update")
  properties?: HorizonDbReplicaPropertiesForUpdate;
}

@doc("Properties of a HorizonDb firewall rule")
model HorizonDbFirewallRuleProperties {
  @doc("The start IP address of the firewall rule")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  startIpAddress: string;

  @doc("The end IP address of the firewall rule")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  endIpAddress: string;

  @doc("The description of the OrionDb firewall rule")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  description?: string;

  @doc("The provisioning state of the firewall rule")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of a HorizonDb firewall rule for update operations")
model HorizonDbFirewallRulePropertiesForUpdate {
  @doc("The start IP address of the firewall rule")
  startIpAddress?: string;

  @doc("The end IP address of the firewall rule")
  endIpAddress?: string;

  @doc("The description of the firewall rule")
  description?: string;
}

@doc("Represents a HorizonDb firewall rule resource for update operations")
model HorizonDbFirewallRuleForPatch {
  @doc("The properties of the firewall rule for update")
  properties?: HorizonDbFirewallRulePropertiesForUpdate;
}

@doc("The mode to create a new HorizonDb cluster")
union CreateModeCluster {
  string,

  /** Create a new cluster */
  Create: "Create",

  /** Update an existing cluster */
  Update: "Update",

  /** Create cluster from point-in-time restore */
  PointInTimeRestore: "PointInTimeRestore",

  /** Create cluster from geo restore */
  GeoRestore: "GeoRestore",

  /** Revive a dropped cluster */
  ReviveDropped: "ReviveDropped",
}

@doc("The mode to create a new HorizonDb cluster")
union CreateModePool {
  string,

  /** Create a new pool */
  Create: "Create",

  /** Update an existing pool */
  Update: "Update",
}

@doc("Current states")
union State {
  string,

  /** Is ready and operational */
  Ready: "Ready",

  /** Is being dropped/deleted */
  Dropping: "Dropping",

  /** Is disabled */
  Disabled: "Disabled",

  /** Is starting up */
  Starting: "Starting",

  /** Is stopping */
  Stopping: "Stopping",

  /** Is stopped */
  Stopped: "Stopped",

  /** Is being updated */
  Updating: "Updating",

  /** Is healthy */
  Healthy: "Healthy",
}

@doc("Role of the replica")
union ReplicaRole {
  string,

  /** Read-only replica */
  Read: "Read",

  /** Read/write replica */
  ReadWrite: "Read/Write",
}

@doc("The provisioning state")
union ProvisioningState {
  string,

  /** Provisioning completed successfully */
  Succeeded: "Succeeded",

  /** Provisioning failed */
  Failed: "Failed",

  /** Provisioning was canceled */
  Canceled: "Canceled",

  /** Provisioning is in progress */
  InProgress: "InProgress",

  /** Provisioning is in progress */
  Provisioning: "Provisioning",
}
