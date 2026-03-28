import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@doc("Represents the HorizonDb cluster.")
model HorizonDbCluster
  is Azure.ResourceManager.TrackedResource<HorizonDbClusterProperties> {
  @doc("The name of the HorizonDb cluster.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("clusterName")
  @path
  @segment("clusters")
  name: string;
}

@doc("Represents the HorizonDb pool.")
@parentResource(HorizonDbCluster)
model HorizonDbPool
  is Azure.ResourceManager.ProxyResource<HorizonDbPoolProperties> {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The name of the HorizonDb pool.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("poolName")
  @path
  @segment("pools")
  name: string;
}

@doc("Represents the HorizonDb replica.")
@parentResource(HorizonDbPool)
model HorizonDbReplica
  is Azure.ResourceManager.ProxyResource<HorizonDbReplicaProperties> {
  @doc("The name of the HorizonDb replica.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("replicaName")
  @path
  @segment("replicas")
  name: string;
}

@doc("Represents the HorizonDb firewall rule.")
@parentResource(HorizonDbPool)
model HorizonDbFirewallRule
  is Azure.ResourceManager.ProxyResource<HorizonDbFirewallRuleProperties> {
  @doc("The name of the HorizonDb firewall rule.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(128)
  @key("firewallRuleName")
  @path
  @segment("firewallRules")
  name: string;
}

@doc("Represents the HorizonDb private link resource.")
@parentResource(HorizonDbCluster)
model HorizonDbPrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @pattern("^.*$")
  @minLength(1)
  @maxLength(128)
  @key("groupName")
  @path
  @segment("privateLinkResources")
  name: string;
}

@doc("Represents the HorizonDb parameter group.")
model HorizonDbParameterGroup
  is Azure.ResourceManager.TrackedResource<HorizonDbParameterGroupProperties> {
  @doc("The name of the HorizonDb parameter group.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("parameterGroupName")
  @path
  @segment("parameterGroups")
  name: string;
}

@doc("Properties of a HorizonDb cluster.")
model HorizonDbClusterProperties {
  @doc("The administrator login name.")
  @minLength(1)
  @maxLength(63)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  administratorLogin: string;

  @doc("The administrator login password.")
  @secret
  @minLength(8)
  @maxLength(128)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  administratorLoginPassword?: string;

  @doc("The version of the HorizonDb cluster.")
  version?: string;

  @doc("The mode to create a new HorizonDb cluster.")
  createMode?: CreateModeCluster;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "UTC is a well-established acronym for Coordinated Universal Time and should remain uppercase for clarity and consistency with Azure service conventions"
  @doc("Restore point creation time specifying the time to restore from.")
  pointInTimeUTC?: utcDateTime;

  @doc("The source cluster resource ID for restore or replica creation.")
  sourceClusterResourceId?: armResourceIdentifier;

  @doc("The pool name for restore or replica operations.")
  poolName?: string;

  @doc("Number of replicas.")
  @minValue(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  replicaCount?: int32;

  @doc("Number of vCores.")
  @minValue(1)
  @maxValue(96)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  vCores?: int32;

  @doc("The processor type for the HorizonDb cluster.")
  processorType?: string;

  @doc("The network related info.")
  network?: Network;

  @doc("Current state of the cluster.")
  @visibility(Lifecycle.Read)
  state?: State;

  @doc("The fully qualified domain name of the cluster.")
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  @doc("The fully qualified domain name used for readonly endpoint for the cluster.")
  @visibility(Lifecycle.Read)
  readonlyEndpoint?: string;

  @doc("The provisioning state of the cluster.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Defines how replicas are placed across availability zones.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  zonePlacementPolicy?: ZonePlacementPolicy;

  @doc("Defines connection to a parameter group.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  parameterGroup?: HorizonDbClusterParameterGroupConnectionProperties;
}

@doc("Properties of a HorizonDb cluster for update operations.")
model HorizonDbClusterPropertiesForPatchUpdate {
  @secret
  @minLength(8)
  @maxLength(128)
  @doc("The administrator login password.")
  @visibility(Lifecycle.Update)
  administratorLoginPassword?: string;

  @doc("Number of vCores.")
  @minValue(1)
  @maxValue(96)
  @visibility(Lifecycle.Update)
  vCores?: int32;

  @doc("Defines connection to a parameter group.")
  parameterGroup?: HorizonDbClusterParameterGroupConnectionProperties;
}

@doc("HorizonDb cluster for update operations.")
model HorizonDbClusterForPatchUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The properties that can be updated for a HorizonDb cluster.")
  properties?: HorizonDbClusterPropertiesForPatchUpdate;
}

@doc("Properties of a HorizonDb pool.")
model HorizonDbPoolProperties {
  @doc("The location of the HorizonDb pool.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: azureLocation;

  @doc("Current state of the pool.")
  @visibility(Lifecycle.Read)
  state?: State;

  @doc("Number of replicas in the pool.")
  @visibility(Lifecycle.Read)
  replicaCount?: int32;

  @doc("The version of the HorizonDb pool.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("The create mode for the pool.")
  @visibility(Lifecycle.Read)
  createMode?: CreateModePool;

  @doc("The provisioning state of the pool.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Network properties.")
model Network {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "publicNetworkAccess is a configuration flag, not sensitive data"
  @doc("The flag indicating whether public ip is requested.")
  @visibility(Lifecycle.Read)
  publicNetworkAccess?: PublicNetworkAccessState;
}

@doc("Properties of a HorizonDb replica.")
model HorizonDbReplicaProperties {
  @doc("Role of the replica.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  role?: ReplicaRole;

  @doc("Current status of the replica.")
  @visibility(Lifecycle.Read)
  status?: State;

  @doc("The fully qualified domain name of the replica.")
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  @doc("The availability zone of the replica.")
  availabilityZone?: string;

  @doc("The provisioning state of the replica.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of a HorizonDb replica for update operations.")
model HorizonDbReplicaPropertiesForPatchUpdate {
  @visibility(Lifecycle.Update)
  @doc("Role of the replica.")
  role?: ReplicaRole;
}

@doc("HorizonDb replica for update operations.")
model HorizonDbReplicaForPatchUpdate {
  @doc("Properties of a HorizonDb replica for update operations.")
  properties?: HorizonDbReplicaPropertiesForPatchUpdate;
}

@doc("Properties of a HorizonDb firewall rule.")
model HorizonDbFirewallRuleProperties {
  @doc("The start IP address of the firewall rule (IPv4).")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  startIpAddress: string;

  @doc("The end IP address of the firewall rule (IPv4).")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  endIpAddress: string;

  @doc("The description of the HorizonDb firewall rule.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  description?: string;

  @doc("The provisioning state of the firewall rule.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The mode to create a new HorizonDb cluster.")
union CreateModeCluster {
  string,

  /** Create a new cluster */
  Create: "Create",

  /** Update an existing cluster */
  Update: "Update",

  /** Create cluster from point-in-time restore */
  PointInTimeRestore: "PointInTimeRestore",
}

@doc("The mode to create a new HorizonDb cluster.")
union CreateModePool {
  string,

  /** Create a new pool */
  Create: "Create",

  /** Update an existing pool */
  Update: "Update",
}

@doc("The zone redundancy option for the cluster.")
union ZonePlacementPolicy {
  string,

  /** Enforce zonal redundancy */
  Strict: "Strict",

  /** Best-effort placement (default) */
  BestEffort: "BestEffort",
}

@doc("Current states.")
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

@doc("Indicates if public network access is enabled or not.")
union PublicNetworkAccessState {
  string,

  @doc("Public network access is enabled")
  Enabled: "Enabled",

  @doc("Public network access is disabled")
  Disabled: "Disabled",
}

@doc("Role of the replica.")
union ReplicaRole {
  string,

  /** Read-only replica */
  Read: "Read",

  /** ReadWrite replica */
  ReadWrite: "ReadWrite",
}

@doc("The provisioning state.")
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

@doc("Properties of a HorizonDb parameter group.")
model HorizonDbParameterGroupProperties {
  @doc("Parameters in the parameter group.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  parameters?: ParameterProperties[];

  @doc("Description of the parameter group.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  description?: string;

  @doc("PostgreSQL version for the parameter group.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  pgVersion?: int32;

  @doc("Current version of the parameter group.")
  @visibility(Lifecycle.Read)
  version?: int32;

  @doc("Indicates whether the parameters should be applied immediately.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  applyImmediately?: boolean;

  @doc("The provisioning state of the parameter group.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of a HorizonDb parameters.")
model ParameterProperties {
  @doc("The name of the parameter.")
  name?: string;

  @visibility(Lifecycle.Read)
  @doc("The description of the parameter.")
  description?: string;

  @doc("The value of the configuration.")
  value?: string;

  @visibility(Lifecycle.Read)
  @doc("The data type of the parameter.")
  dataType?: string;

  @visibility(Lifecycle.Read)
  @doc("The allowed values for the parameter.")
  allowedValues?: string;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter can be changed dynamically.")
  isDynamic?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter is a read-only parameter.")
  isReadOnly?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Link to parameter documentation.")
  documentationLink?: url;

  @visibility(Lifecycle.Read)
  @doc("The unit of measurement for the parameter.")
  unit?: string;
}

@doc("Properties of a HorizonDb parameter group for update operations.")
model HorizonDbParameterGroupPropertiesForPatchUpdate {
  @doc("Parameters in the parameter group.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Update)
  parameters?: ParameterProperties[];

  @doc("Description of the parameter group.")
  @visibility(Lifecycle.Update)
  description?: string;

  @doc("Indicates whether the parameters should be applied immediately.")
  @visibility(Lifecycle.Update)
  applyImmediately?: boolean;
}

@doc("HorizonDb parameter group for update operations.")
model HorizonDbParameterGroupForPatchUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The properties that can be updated for a HorizonDb parameter group.")
  properties?: HorizonDbParameterGroupPropertiesForPatchUpdate;
}

@doc("Connection information for HorizonDb parameter group.")
model HorizonDbParameterGroupConnectionProperties {
  @doc("The name of the connected resource.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The resource ID of the connected resource.")
  @visibility(Lifecycle.Read)
  id?: armResourceIdentifier;

  @doc("The type of the resource.")
  @visibility(Lifecycle.Read)
  type?: string;
}

@doc("Connection information for HorizonDb parameter group.")
model HorizonDbClusterParameterGroupConnectionProperties {
  @doc("The resource ID of the connected parameter group.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  id?: armResourceIdentifier;

  @doc("Indication of if parameter group is applied on HorizonDb resource.")
  @visibility(Lifecycle.Read)
  syncStatus?: string;

  @doc("Indicates whether the parameters should be applied immediately.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  applyImmediately?: boolean;
}
