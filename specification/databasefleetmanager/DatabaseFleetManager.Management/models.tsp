import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DatabaseFleetManager;

/**
 * The provisioning state of the resource.
 */
union AzureProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,

  /** Resource is provisioning. */
  Provisioning: "Provisioning",

  /** Request on the resource has been accepted. */
  Accepted: "Accepted",
}

/**
 * Principal type of the authorized principal.
 */
union PrincipalType {
  string,

  /** Application principal type. */
  Application: "Application",

  /** User principal type. */
  User: "User",
}

/**
 * Resource type of the destination tier override.
 */
union ResourceType {
  string,

  /** Database resource type. */
  Database: "Database",

  /** Elastic pool resource type. */
  Pool: "Pool",
}

/**
 * Status of zone redundancy in a tier.
 */
union ZoneRedundancy {
  string,

  /** Zone redundancy enabled. */
  Enabled: "Enabled",

  /** Zone redundancy disabled. */
  Disabled: "Disabled",
}

/**
 * Create mode. Available options: Default - Create a database. Copy - Copy the source database (source database name must be specified) PointInTimeRestore - Create a database by restoring source database from a point in time (source database name and restore from time must be specified)
 */
union DatabaseCreateMode {
  string,

  /** Create a database. */
  Default: "Default",

  /** Copy the source database (source database name must be specified). */
  Copy: "Copy",

  /** Create a database by restoring source database from a point in time (source database name and restore from time must be specified). */
  PointInTimeRestore: "PointInTimeRestore",
}

/**
 * Identity type of the main principal.
 */
union IdentityType {
  string,

  /** No identity. */
  None: "None",

  /** User assigned identity. */
  UserAssigned: "UserAssigned",
}

/**
 * A database change tier definition.
 */
model DatabaseChangeTierDefinition {
  /**
   * A target tier name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  targetTierName?: string;
}

/**
 * Fleet database properties.
 */
model FleetDatabaseProperties {
  /**
   * Resource identifier for the underlying database resource.
   */
  @visibility(Lifecycle.Read)
  originalDatabaseId?: string;

  /**
   * Database state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AzureProvisioningState;

  /**
   * Create mode. Available options: Default - Create a database. Copy - Copy the source database (source database name must be specified) PointInTimeRestore - Create a database by restoring source database from a point in time (source database name and restore from time must be specified)
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  createMode?: DatabaseCreateMode;

  /**
   * Name of the tier this database belongs to.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tierName?: string;

  /**
   * Connection string to connect to the database with.
   */
  @visibility(Lifecycle.Read)
  connectionString?: string;

  /**
   * If true, database is recoverable.
   */
  @visibility(Lifecycle.Read)
  recoverable?: boolean;

  /**
   * Restore from time when CreateMode is PointInTimeRestore.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restoreFromTime?: utcDateTime;

  /**
   * Earliest restore time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreTime?: utcDateTime;

  /**
   * Latest restore time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  latestRestoreTime?: utcDateTime;

  /**
   * Backup retention in days.
   */
  @visibility(Lifecycle.Read)
  backupRetentionDays?: int32;

  /**
   * Maximum database size in Gb.
   */
  @visibility(Lifecycle.Read)
  databaseSizeGbMax?: int32;

  /**
   * Source database name used when CreateMode is Copy or PointInTimeRestore.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceDatabaseName?: string;

  /**
   * Additional database properties to be applied as the underlying database resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Model properties or operation parameters should not be of type Record. ARM requires Resource provider teams to define types explicitly."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  resourceTags?: Record<string>;

  /**
   * Identity property.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  identity?: Identity;

  /**
   * Transparent Data Encryption properties
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  transparentDataEncryption?: TransparentDataEncryption;

  /**
   * Database collation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  collation?: string;
}

/**
 * Database Identity.
 */
model Identity {
  /**
   * Identity type of the main principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  identityType?: IdentityType;

  /**
   * User identity ids
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @OpenAPI.extension("x-ms-identifiers", #[])
  userAssignedIdentities?: DatabaseIdentity[];

  /**
   * The federated client id for the SQL Database. It is used for cross tenant CMK scenario.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  federatedClientId?: uuid;
}

/**
 * Database Identity properties.
 */
model DatabaseIdentity {
  /**
   * Resource Id of the database identity.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /**
   * Principal Id of the database identity.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  principalId?: uuid;

  /**
   * Client Id of the database identity.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  clientId?: uuid;
}

/**
 * Transparent Data Encryption properties.
 */
model TransparentDataEncryption {
  /**
   * Customer Managed Key (CMK) Uri.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keyUri?: url;

  /**
   * Additional Keys
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keys?: string[];

  /**
   * Enable key auto rotation
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  enableAutoRotation?: boolean;
}

/**
 * A database rename definition.
 */
model DatabaseRenameDefinition {
  /**
   * New database name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  newName?: string;
}

/**
 * A Firewall rule properties.
 */
model FirewallRuleProperties {
  /**
   * Start IP address.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  startIpAddress?: string;

  /**
   * End IP address.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endIpAddress?: string;

  /**
   * Provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AzureProvisioningState;
}

/**
 * An update to a Database Fleet.
 */
model FleetUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The Database Fleet properties.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  properties?: FleetProperties;
}

/**
 * The Database Fleet properties.
 */
model FleetProperties {
  /**
   * Fleet description.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string;

  /**
   * Provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AzureProvisioningState;
}

/**
 * A destination tier override.
 */
model DestinationTierOverride {
  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceType: ResourceType;

  /**
   * Destination tier name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tierName: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceName: string;
}

/**
 * A main principal.
 */
model MainPrincipal {
  /**
   * Login name of the main principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  login?: string;

  /**
   * Application Id of the main principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  applicationId?: uuid;

  /**
   * Object Id of the main principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  objectId?: uuid;

  /**
   * Tenant Id of the main principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tenantId?: uuid;

  /**
   * Principal type of the main principal.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  principalType?: PrincipalType;
}

/**
 * A Fleetspace properties.
 */
model FleetspaceProperties {
  /**
   * Fleetspace state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AzureProvisioningState;

  /**
   * Maximum number of vCores database fleet manager is allowed to provision in the fleetspace.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  capacityMax?: int32;

  /**
   * Main Microsoft Entra ID principal that has admin access to all databases in the fleetspace.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mainPrincipal?: MainPrincipal;
}

/**
 * Server registration definition.
 */
model RegisterServerDefinition {
  /**
   * Destination tier name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tierName?: string;

  /**
   * Source subscription id.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceSubscriptionId?: string;

  /**
   * Source resource group name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceResourceGroupName?: string;

  /**
   * Source SQL Server name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceServerName?: string;

  /**
   * Destination tier overrides.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
  destinationTierOverrides?: DestinationTierOverride[];
}

/**
 * A Fleet tier properties.
 */
model FleetTierProperties {
  /**
   * If true, tier is disabled.
   */
  @visibility(Lifecycle.Read)
  disabled?: boolean;

  /**
   * If true, serverless resources are provisioned in the tier.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serverless?: boolean;

  /**
   * If true, databases are pooled.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  pooled?: boolean;

  /**
   * Service tier of provisioned resources. Supported values: GeneralPurpose, Hyperscale.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceTier?: string;

  /**
   * Family of provisioned resources, for example Gen5.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  family?: string;

  /**
   * Capacity of provisioned resources in the tier, in units matching the specified service tier, for example vCore for GeneralPurpose.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  capacity?: int32;

  /**
   * Maximum number of databases per pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  poolNumOfDatabasesMax?: int32;

  /**
   * Number of high availability replicas for databases in this tier.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  highAvailabilityReplicaCount?: int32;

  /**
   * Enable zone redundancy for all databases in this tier.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  zoneRedundancy?: ZoneRedundancy;

  /**
   * Minimum allocated capacity per database, in units matching the specified service tier.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  databaseCapacityMin?: float64;

  /**
   * Maximum allocated capacity per database, in units matching the specified service tier.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  databaseCapacityMax?: float64;

  /**
   * Maximum database size in Gb.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  databaseSizeGbMax?: int32;

  /**
   * Provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AzureProvisioningState;
}

/**
 * A database filter parameters.
 */
model FleetDatabaseFilterParameters {
  /**
   * Filter on database tier name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tierName?: string;
}
