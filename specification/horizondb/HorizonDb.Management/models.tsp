import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

/**
 * Properties of a HorizonDb cluster
 */
model HorizonDbClusterProperties {
  /**
   * The administrator login name
   */
  @minLength(1)
  @maxLength(63)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  administratorLogin: string;

  /**
   * The administrator login password
   */
  @secret
  @minLength(8)
  @maxLength(128)
  administratorLoginPassword?: string;

  /**
   * The version of the Orion Db
   */
  version?: string;

  /**
   * The mode to create a new HorizonDb cluster
   */
  createMode?: CreateModeCluster;

  /**
   * Restore point creation time (ISO8601 format), specifying the time to restore from
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pointInTimeUTC?: utcDateTime;

  /**
   * The source HorizonDb cluster resource identifier for read replica or point in time restore scenarios
   */
  sourceOrionDbResourceId?: string;

  /**
   * The pool name for restore or replica operations
   */
  poolName?: string;

  /**
   * Number of replicas
   */
  @minValue(0)
  @maxValue(20)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  replicaCount?: int32;

  /**
   * Number of vCores
   */
  @minValue(1)
  @maxValue(96)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  vCores?: int32;

  /**
   * The availability zone of the Orion Db
   */
  availabilityZone?: string;

  /**
   * The processor type for the Orion Db cluster
   */
  processorType?: string;

  /**
   * The network related info
   */
  network?: Network;

  /**
   * The high availability related info
   */
  highAvailability?: HighAvailability;

  /**
   * The maintenance window related info
   */
  maintenanceWindow?: MaintenanceWindowOptions;

  /**
   * Current state of the cluster
   */
  @visibility(Lifecycle.Read)
  state?: State;

  /**
   * The fully qualified domain name of the cluster
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  /**
   * The fully qualified domain name used for readonly endpoint for the cluster
   */
  @visibility(Lifecycle.Read)
  readonlyEndpoint?: string;

  /**
   * The earliest restore point time (ISO8601 format) for the cluster
   */
  @visibility(Lifecycle.Read)
  earliestRestoreDate?: utcDateTime;

  /**
   * The provisioning state of the cluster
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Properties of a HorizonDb cluster for update operations
 */
model HorizonDbClusterPropertiesForUpdate {
  /**
   * The administrator login password
   */
  @secret
  @minLength(8)
  @maxLength(128)
  administratorLoginPassword?: string;

  /**
   * Number of vCores
   */
  @minValue(1)
  @maxValue(96)
  vCores?: int32;
}

/**
 * Represents a HorizonDb cluster resource for update operations
 */
model HorizonDbClusterForUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The properties of the cluster for update
   */
  properties?: HorizonDbClusterPropertiesForUpdate;
}

/**
 * Properties of a HorizonDb pool
 */
model HorizonDbPoolProperties {
  /**
   * The SKU for the OrionDb pool
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  sku?: string;

  /**
   * The location of the OrionDb pool
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  /**
   * Current state of the pool
   */
  @doc("Current state of the pool")
  @visibility(Lifecycle.Read)
  state?: State;

  /**
   * Number of replicas in the pool
   */
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  replicaCount?: int32;

  /**
   * The administrator login for the pool
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  administratorLogin?: string;

  /**
   * The administrator login password for the pool
   */
  @secret
  @visibility(Lifecycle.Update)
  administratorLoginPassword?: string;

  /**
   * The version of the OrionDb pool
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  version?: string;

  /**
   * The tags for the OrionDb pool
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  tags?: string;

  /**
   * The create mode for the pool
   */
  @visibility(Lifecycle.Update)
  createMode?: CreateModePool;

  /**
   * The provisioning state of the pool
   */
  @doc("The provisioning state of the pool")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Network properties
 */
model Network {
  /**
   * The flag indicating whether public ip is requested for the server
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicNetworkAccess is a configuration flag, not sensitive data"
  @visibility(Lifecycle.Read)
  publicNetworkAccess?: string;

  /**
   * The customer provided delegated subnet full ARM resource ID
   */
  delegatedSubnetResourceId?: string;

  /**
   * The customer provided private DNS zone full ARM resource ID
   */
  privateDnsZoneArmResourceId?: string;
}

/**
 * High availability properties
 */
model HighAvailability {
  /**
   * The HA mode for the server
   */
  mode?: HighAvailabilityMode;

  /**
   * The user visible HA state of the server
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * The availability zone of the standby server
   */
  @visibility(Lifecycle.Read)
  standbyAvailabilityZone?: string;

  /**
   * The fully qualified domain name of the standby server
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedStandbyDomainName?: string;
}
/**
 * Modes of high availability supported for this compute.
 */
union HighAvailabilityMode {
  string,

  /** High availability is disabled */
  Disabled: "Disabled",

  /** Zone redundant high availability */
  ZoneRedundant: "ZoneRedundant",

  /** Same zone high availability */
  SameZone: "SameZone",
}

/**
 * Maintenance window properties
 */
model MaintenanceWindowOptions {
  /**
   * Indicates whether the window is customer or system default
   */
  customWindow?: string;

  /**
   * The day of the week for the maintenance to occur (0-6, where 0 is Sunday)
   */
  @minValue(0)
  @maxValue(6)
  dayOfWeek?: int32;

  /**
   * The hour to start the maintenance (0-23)
   */
  @minValue(0)
  @maxValue(23)
  startHour?: int32;

  /**
   * The minute to start the maintenance (0-59)
   */
  @minValue(0)
  @maxValue(59)
  startMinute?: int32;
}

/**
 * Properties of a HorizonDb pool for update operations
 */
model HorizonDbPoolPropertiesForUpdate {
  /**
   * Number of replicas in the pool
   */
  @minValue(0)
  @maxValue(20)
  replicaCount?: int32;
}

/**
 * Represents a HorizonDb pool resource for update operations
 */
model HorizonDbPoolForUpdate {
  /**
   * The properties of the pool for update
   */
  properties?: HorizonDbPoolPropertiesForUpdate;
}

/**
 * Properties of a HorizonDb replica
 */
model HorizonDbReplicaProperties {
  /**
   * Role of the replica
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  role?: ReplicaRole;

  /**
   * Current status of the replica
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  status?: State;

  /**
   * The fully qualified domain name of the replica
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  fullyQualifiedDomainName?: string;

  /**
   * The provisioning state of the replica
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Properties of a HorizonDb replica for update operations
 */
model HorizonDbReplicaPropertiesForUpdate {
  /**
   * Role of the replica
   */
  role?: ReplicaRole;
}

/**
 * Represents a HorizonDb replica resource for update operations
 */
model HorizonDbReplicaForUpdate {
  /**
   * The properties of the replica for update
   */
  properties?: HorizonDbReplicaPropertiesForUpdate;
}

/**
 * Properties of a HorizonDb firewall rule
 */
model HorizonDbFirewallRuleProperties {
  /**
   * The start IP address of the firewall rule
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  startIpAddress: string;

  /**
   * The end IP address of the firewall rule
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  endIpAddress: string;

  /**
   * The description of the OrionDb firewall rule
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  description?: string;

  /**
   * The provisioning state of the firewall rule
   */
  @doc("The provisioning state of the firewall rule")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The mode to create a new HorizonDb cluster
 */
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

/**
 * The mode to create a new HorizonDb cluster
 */
union CreateModePool {
  string,

  /** Create a new pool */
  Create: "Create",

  /** Update an existing pool */
  Update: "Update",
}

/**
 * Current states
 */
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

/**
 * Role of the replica
 */
union ReplicaRole {
  string,

  /** Read-only replica */
  Read: "Read",

  /** Read/write replica */
  ReadWrite: "Read/Write",
}

/**
 * The provisioning state
 */
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
