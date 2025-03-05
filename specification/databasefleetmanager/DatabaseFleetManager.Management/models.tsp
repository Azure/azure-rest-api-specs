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
  @visibility("read", "create")
  targetTierName?: string;
}

/**
 * Fleet database properties.
 */
model FleetDatabaseProperties {
  /**
   * Resource identifier for the underlying database resource.
   */
  @visibility("read")
  originalDatabaseId?: string;

  /**
   * Database state.
   */
  @visibility("read")
  provisioningState?: AzureProvisioningState;

  /**
   * Create mode. Available options: Default - Create a database. Copy - Copy the source database (source database name must be specified) PointInTimeRestore - Create a database by restoring source database from a point in time (source database name and restore from time must be specified)
   */
  @visibility("read", "create")
  createMode?: DatabaseCreateMode;

  /**
   * Name of the tier this database belongs to.
   */
  @visibility("read", "create")
  tierName?: string;

  /**
   * Connection string to connect to the database with.
   */
  @visibility("read")
  connectionString?: string;

  /**
   * If true, database is recoverable.
   */
  @visibility("read")
  recoverable?: boolean;

  /**
   * Restore from time when CreateMode is PointInTimeRestore.
   */
  @visibility("read", "create")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restoreFromTime?: utcDateTime;

  /**
   * Earliest restore time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreTime?: utcDateTime;

  /**
   * Latest restore time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  latestRestoreTime?: utcDateTime;

  /**
   * Backup retention in days.
   */
  @visibility("read")
  backupRetentionDays?: int32;

  /**
   * Maximum database size in Gb.
   */
  @visibility("read")
  databaseSizeGbMax?: int32;

  /**
   * Source database name used when CreateMode is Copy or PointInTimeRestore.
   */
  @visibility("read", "create")
  sourceDatabaseName?: string;

  /**
   * Additional database properties to be applied as the underlying database resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Model properties or operation parameters should not be of type Record. ARM requires Resource provider teams to define types explicitly."
  @visibility("read", "create", "update")
  resourceTags?: Record<string>;

  /**
   * Identity property.
   */
  @visibility("read", "create", "update")
  identity?: Identity;

  /**
   * Transparent Data Encryption properties
   */
  @visibility("read", "create", "update")
  transparentDataEncryption?: TransparentDataEncryption;

  /**
   * Database collation.
   */
  @visibility("read", "create")
  collation?: string;
}

/**
 * Database Identity.
 */
model Identity {
  /**
   * Identity type of the main principal.
   */
  @visibility("read", "create", "update")
  identityType?: IdentityType;

  /**
   * User identity ids
   */
  @visibility("read", "create", "update")
  @OpenAPI.extension("x-ms-identifiers", [])
  userAssignedIdentities?: DatabaseIdentity[];

  /**
   * The federated client id for the SQL Database. It is used for cross tenant CMK scenario.
   */
  @visibility("read", "create", "update")
  federatedClientId?: uuid;
}

/**
 * Database Identity properties.
 */
model DatabaseIdentity {
  /**
   * Resource Id of the database identity.
   */
  @visibility("read", "create", "update")
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /**
   * Principal Id of the database identity.
   */
  @visibility("read", "create", "update")
  principalId?: uuid;

  /**
   * Client Id of the database identity.
   */
  @visibility("read", "create", "update")
  clientId?: uuid;
}

/**
 * Transparent Data Encryption properties.
 */
model TransparentDataEncryption {
  /**
   * Customer Managed Key (CMK) Uri.
   */
  @visibility("read", "create", "update")
  keyUri?: url;

  /**
   * Additional Keys
   */
  @visibility("read", "create", "update")
  keys?: string[];

  /**
   * Enable key auto rotation
   */
  @visibility("read", "create", "update")
  enableAutoRotation?: boolean;
}

/**
 * A database rename definition.
 */
model DatabaseRenameDefinition {
  /**
   * New database name.
   */
  @visibility("read", "create")
  newName?: string;
}

/**
 * A Firewall rule properties.
 */
model FirewallRuleProperties {
  /**
   * Start IP address.
   */
  @visibility("read", "create")
  startIpAddress?: string;

  /**
   * End IP address.
   */
  @visibility("read", "create")
  endIpAddress?: string;

  /**
   * Provisioning state.
   */
  @visibility("read")
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
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * The Database Fleet properties.
   */
  @visibility("read", "create", "update")
  properties?: FleetProperties;
}

/**
 * The Database Fleet properties.
 */
model FleetProperties {
  /**
   * Fleet description.
   */
  @visibility("read", "create")
  description?: string;

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: AzureProvisioningState;
}

/**
 * A destination tier override.
 */
model DestinationTierOverride {
  /**
   * Resource type.
   */
  @visibility("read", "create")
  resourceType: ResourceType;

  /**
   * Destination tier name.
   */
  @visibility("read", "create")
  tierName: string;

  /**
   * Resource name.
   */
  @visibility("read", "create")
  resourceName: string;
}

/**
 * A main principal.
 */
model MainPrincipal {
  /**
   * Login name of the main principal.
   */
  @visibility("read", "create")
  login?: string;

  /**
   * Application Id of the main principal.
   */
  @visibility("read", "create")
  applicationId?: uuid;

  /**
   * Object Id of the main principal.
   */
  @visibility("read", "create")
  objectId?: uuid;

  /**
   * Tenant Id of the main principal.
   */
  @visibility("read", "create")
  tenantId?: uuid;

  /**
   * Principal type of the main principal.
   */
  @visibility("read", "create")
  principalType?: PrincipalType;
}

/**
 * A Fleetspace properties.
 */
model FleetspaceProperties {
  /**
   * Fleetspace state.
   */
  @visibility("read")
  provisioningState?: AzureProvisioningState;

  /**
   * Maximum number of vCores database fleet manager is allowed to provision in the fleetspace.
   */
  @visibility("read", "create", "update")
  capacityMax?: int32;

  /**
   * Main Microsoft Entra ID principal that has admin access to all databases in the fleetspace.
   */
  @visibility("read", "create")
  mainPrincipal?: MainPrincipal;
}

/**
 * Server registration definition.
 */
model RegisterServerDefinition {
  /**
   * Destination tier name.
   */
  @visibility("read", "create")
  tierName?: string;

  /**
   * Source subscription id.
   */
  @visibility("read", "create")
  sourceSubscriptionId?: string;

  /**
   * Source resource group name.
   */
  @visibility("read", "create")
  sourceResourceGroupName?: string;

  /**
   * Source SQL Server name.
   */
  @visibility("read", "create")
  sourceServerName?: string;

  /**
   * Destination tier overrides.
   */
  @visibility("read", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  destinationTierOverrides?: DestinationTierOverride[];
}

/**
 * A Fleet tier properties.
 */
model FleetTierProperties {
  /**
   * If true, tier is disabled.
   */
  @visibility("read")
  disabled?: boolean;

  /**
   * If true, serverless resources are provisioned in the tier.
   */
  @visibility("read", "create")
  serverless?: boolean;

  /**
   * If true, databases are pooled.
   */
  @visibility("read", "create")
  pooled?: boolean;

  /**
   * Service tier of provisioned resources. Supported values: GeneralPurpose, Hyperscale.
   */
  @visibility("read", "create")
  serviceTier?: string;

  /**
   * Family of provisioned resources, for example Gen5.
   */
  @visibility("read", "create")
  family?: string;

  /**
   * Capacity of provisioned resources in the tier, in units matching the specified service tier, for example vCore for GeneralPurpose.
   */
  @visibility("read", "create")
  capacity?: int32;

  /**
   * Maximum number of databases per pool.
   */
  @visibility("read", "create", "update")
  poolNumOfDatabasesMax?: int32;

  /**
   * Number of high availability replicas for databases in this tier.
   */
  @visibility("read", "create")
  highAvailabilityReplicaCount?: int32;

  /**
   * Enable zone redundancy for all databases in this tier.
   */
  @visibility("read", "create")
  zoneRedundancy?: ZoneRedundancy;

  /**
   * Minimum allocated capacity per database, in units matching the specified service tier.
   */
  @visibility("read", "create")
  databaseCapacityMin?: float64;

  /**
   * Maximum allocated capacity per database, in units matching the specified service tier.
   */
  @visibility("read", "create")
  databaseCapacityMax?: float64;

  /**
   * Maximum database size in Gb.
   */
  @visibility("read", "create")
  databaseSizeGbMax?: int32;

  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: AzureProvisioningState;
}

/**
 * A database filter parameters.
 */
model FleetDatabaseFilterParameters {
  /**
   * Filter on database tier name.
   */
  @visibility("read", "create")
  tierName?: string;
}
