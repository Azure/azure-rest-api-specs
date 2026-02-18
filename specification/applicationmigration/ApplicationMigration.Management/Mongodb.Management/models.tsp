import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ApplicationMigration;

@doc("Definition of Server Parameter")
model ServerParameter {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

@doc("Base tracked resource type for PATCH updates.")
model TagsUpdate {
  ...ArmTagsProperty;
}

/**
 * Represents the Provisioning State of a resource.
 * Gets or sets the provisioning state.
 */
@doc("The status of the current operation.")
union ProvisioningState {
  string,

  @doc("Unknown provisioning state.")
  Unknown: "Unknown",

  @doc("Succeeded provisioning state.")
  Succeeded: "Succeeded",

  @doc("Failed provisioning state.")
  Failed: "Failed",

  @doc("Canceled provisioning state.")
  Canceled: "Canceled",

  @doc("Creating provisioning state.")
  Creating: "Creating",

  @doc("Deleting provisioning state.")
  Deleting: "Deleting",

  @doc("Updating provisioning state.")
  Updating: "Updating",
}

@doc("Common properties for all azure tracked and proxy resources.")
model AzureResourceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Request body for Proxy site refresh action.")
model ProxySiteRefreshBody {
  @doc("Gets or sets the appliance name of the agent in the site.")
  applianceName?: string;
}

/**
 * Represents an Enum with boolean values.
 */
union BoolValue {
  @doc("Represents an unknown value.")
  Unknown: "Unknown",

  @doc("Represents a true boolean value.")
  True: "True",

  @doc("Represents a false boolean value.")
  False: "False",

  string,
}

/**
 * Represents the TLS version.
 */
union TlsVersion {
  string,

  /**
   * UNKNOWN TLS version.
   */
  UNKNOWN: "UNKNOWN",

  /**
   * TLS version 1.0.
   * #deprecated This version is deprecated
   */
  #deprecated "This version is deprecated"
  Tls1_0: "Tls1_0",

  /**
   * TLS version 1.1.
   * #deprecated This version is deprecated
   */
  #deprecated "This version is deprecated"
  Tls1_1: "Tls1_1",

  /**
   * TLS version 1.2.
   */
  Tls1_2: "Tls1_2",

  /**
   * TLS version 1.3.
   */
  Tls1_3: "Tls1_3",
}

/**
 * Represents the Support status of the Mongo instance.
 */
union SupportStatus {
  string,

  /**
   * Unknown Support Status
   */
  Unknown: "Unknown",

  /**
   * OutOfSupport support status.
   */
  OutOfSupport: "OutOfSupport",

  /**
   * Extended support status.
   */
  Extended: "Extended",

  /**
   * Mainstream support status.
   */
  Mainstream: "Mainstream",
}

/**
 * Represents the Edition of the Mongo instance.
 */
union Edition {
  string,

  /**
   * Unknown edition.
   */
  Unknown: "Unknown",

  /**
   * Community edition.
   */
  Community: "Community",

  /**
   * Enterprise edition.
   */
  Enterprise: "Enterprise",
}

/**
 * The extended location for off-azure resources.
 */
model ExtendedLocation {
  /**
   * The extended location type.
   */
  type?: string;

  /**
   * The extended location name.
   */
  name?: string;
}

/**
 * List of MongoAgents.
 */
model MongoAgentList is Azure.Core.Page<MongoAgent>;

/**
 * Agent properties
 */
model AgentProperties is AzureResourceProperties {
  /**
   * Service principal identity details used by agent for communication to the service.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  servicePrincipalIdentityDetails: AgentSpnProperties;

  /**
   * Name of the appliance on which agent is running.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  migrateApplianceName: string;

  /**
   * Health details of the agent.
   */
  healthDetails?: AgentHealthProperties;

  /**
   * Name of the appliance on which agent is running.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricSiteName: string;
}

/**
 * Class for agent spn properties.
 */
model AgentSpnProperties {
  /**
   * Tenant Id for the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  tenantId?: string;

  /**
   * Application/client Id for the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  applicationId?: string;

  /**
   * Object Id of the service principal with which the on-premise management/data plane components would communicate with our Azure services.
   */
  objectId?: string;
}

/**
 * Class for agent health properties.
 */
model AgentHealthProperties {
  /**
   * Version of the agent.
   */
  version?: string;

  /**
   * Last heartbeat time of the agent in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastHeartBeatUtc?: utcDateTime;
}

/**
 * Object containing tags updates for patch operations.
 */
model AgentResourcePatch {
  /**
   * The Agent properties resource definition.
   */
  properties?: AgentResourcePatchProperties;
}

/**
 * Agent resource patch properties
 */
model AgentResourcePatchProperties {
  /**
   * Health details of the agent.
   */
  healthDetails?: AgentHealthProperties;
}

@doc("The Site Tags patch resource definition.")
model SiteTagsPatch {
  ...TagsUpdate;
}

/**
 * Represents a Mongo Hostmachine (With SKU Fields)
 */
model MongoHostMachineProperties {
  /**
   * The machine vCore count.
   */
  vCores: int64;

  /**
   * The allocated RAM in Machine.
   */
  allocatedMemoryInMb: int64;

  /**
   *  The storage on the machine
   */
  storageInMb: int64;

  /**
   *  IOPS
   */
  maxIops?: int64;

  /**
   * The network node host name for mongo.
   */
  csName?: string;

  /**
   * The operating system type for mongo.
   */
  osType?: string;

  /**
   * The operating system name for mongo.
   */
  osName?: string;

  /**
   * The operating system version for mongo.
   */
  osVersion?: string;

  /**
   * The operating system edition for mongo.
   */
  osEdition?: string;

  /**
   * The operating system architecture for mongo.
   */
  osArch?: string;

  /**
   * The processor name for mongo.
   */
  procName?: string;

  /**
   * The processor architecture for mongo.
   */
  procArch?: string;

  /**
   * The processor max clock speed.
   */
  procMaxClockSpeedMhz?: string;

  /**
   * The sockets count.
   */
  sockets?: int64;
}

/**
 * List of MongoSites.
 */
model MongoSiteList is Azure.Core.Page<MongoSite>;

/**
 * Mongo Site properties
 */
model MongoSiteProperties is AzureResourceProperties {
  /**
   * The mapped master Site Id.
   */
  masterSiteId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/masterSites";
    }
  ]>;

  /**
   * The mapped migrate project Id.
   */
  migrateProjectId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects";
    }
  ]>;

  /**
   * The extended location.
   */
  extendedLocation?: ExtendedLocation;
}

/**
 * List of MongoInstances.
 */
model MongoInstanceList is Azure.Core.Page<MongoInstance>;

/**
 * Mongo Instance properties
 */
model MongoInstanceProperties is AzureResourceProperties {
  /**
   * The Server IP/host name.
   */
  hostName: string;

  /**
   * The Server IP/host name.
   */
  hostIp?: string[];

  /**
   * discovery Machine Ids
   */
  machineArmIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/serverSites/machines";
    }
  ]>[];

  /**
   * The host machine properties.
   */
  hostMachineProperties?: MongoHostMachineProperties;

  /**
   * Mongo Server port number
   */
  portNumber: int32;

  /**
   * The mongo server version.
   */
  version?: string;

  /**
   * The home directory of mongo installation.
   */
  home?: string;

  /**
   * The mongo server region.
   */
  region?: string;

  /**
   * The number of databases.
   */
  numberOfDatabases?: int64;

  /**
   * mongo version support status.
   */
  supportStatus?: SupportStatus;

  /**
   * Mongo instance edition.
   */
  edition?: Edition;

  /**
   * Time when mongo instance version support end.
   */
  endOfSupportDate?: plainDate;

  /**
   * The list of critical errors.
   */
  @identifiers(#[])
  criticalErrors?: CollectionExceptionInfo[];

  /**
   * The number of critical errors.
   */
  criticalErrorCount: int64;

  /**
   * The list of warnings.
   */
  @identifiers(#[])
  warnings?: CollectionExceptionInfo[];

  /**
   * The number of warnings.
   */
  warningsCount: int64;

  /**
   * The list of informational messages.
   */
  @identifiers(#[])
  informationalMessages?: CollectionExceptionInfo[];

  /**
   * The number of informational messages.
   */
  informationalMessagesCount: int64;

  /**
   * Gets or sets storage size of Mongo instance.
   */
  storageSizeInMb?: float32;

  /**
   * The maximum number of connections allowed in the instance
   */
  maxConnections?: int64;

  /**
   * Indicates whether the system supports SSL connections.
   */
  supportsSsl?: BoolValue;

  /**
   * Indicates whether the system supports IPv6 connections.
   */
  supportsIpv6Connections?: BoolValue;

  /**
   * Indicates whether the system supports IPv4 connections.
   */
  supportsIpv4Connections?: BoolValue;

  /**
   * The number of compute IOPS (Input/Output Operations Per Second) collected.
   */
  computeIops?: int64;

  /**
   * The number of storage IOPS (Input/Output Operations Per Second) collected.
   */
  storageIops?: int64;

  /**
   * Specifies the replica set name for the MongoDB instance.
   */
  replicaSetName?: string;

  /**
   * Indicates whether the MongoDB instance is part of a sharded cluster.
   */
  isSharded?: BoolValue;

  /**
   * Specifies the authentication mechanism used by MongoDB.
   */
  authenticationMechanism?: string;

  /**
   * List of enabled MongoDB features.
   */
  enabledFeatures?: string[];

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;
}

/**
 * Mongo Instance properties
 */
model MongoInstanceResourcePatchProperties {
  /**
   * The instance resource patch properties.
   */
  properties?: MongoInstanceResourcePatch;
}

/**
 * Mongo Instance resource patch properties
 */
model MongoInstanceResourcePatch is AzureResourceProperties {
  /**
   * The Server IP/host name.
   */
  hostName?: string;

  /**
   * Mongo Server port number
   */
  portNumber?: int32;

  /**
   * The mongo server version.
   */
  version?: string;
}

/**
 * List of MongoDatabases.
 */
model MongoDatabaseList is Azure.Core.Page<MongoDatabase>;

/**
 * Mongo Database properties
 */
model MongoDatabaseProperties is AzureResourceProperties {
  /**
   * The database name.
   */
  databaseDisplayName: string;

  /**
   * discovered Mongo Instance Ids
   */
  mongoInstanceArmIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApplicationMigration/mongoSites/mongoInstances";
    }
  ]>[];

  /**
   * The size of the database in MB.
   */
  sizeInMb?: float32;

  /**
   * The number of collections in the database.
   */
  numberOfCollections?: int64;

  /**
   * The number of indexes in the database.
   */
  numberOfIndexes?: int64;

  /**
   * The number of documents in the database.
   */
  numberOfDocuments?: int64;

  /**
   * The average document size in bytes.
   */
  averageDocumentSizeInBytes?: float32;

  /**
   * The database creation timestamp.
   */
  createdAt?: utcDateTime;

  /**
   * The database last modified timestamp.
   */
  lastModifiedAt?: utcDateTime;

  /**
   * List of collection names in the database.
   */
  collections?: string[];

  /**
   * Indicates whether the database uses GridFS for file storage.
   */
  usesGridFs?: BoolValue;

  /**
   * The database storage engine.
   */
  storageEngine?: string;

  /**
   * The database sharding configuration.
   */
  shardingConfig?: string;

  /**
   * The list of critical errors.
   */
  @identifiers(#[])
  criticalErrors?: CollectionExceptionInfo[];

  /**
   * The number of critical errors.
   */
  criticalErrorCount: int64;

  /**
   * The list of warnings.
   */
  @identifiers(#[])
  warnings?: CollectionExceptionInfo[];

  /**
   * The number of warnings.
   */
  warningsCount: int64;

  /**
   * The list of informational messages.
   */
  @identifiers(#[])
  informationalMessages?: CollectionExceptionInfo[];

  /**
   * The number of informational messages.
   */
  informationalMessagesCount: int64;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;
}

/**
 * Mongo Database properties
 */
model MongoDatabaseResourcePatch {
  /**
   * The database resource patch properties.
   */
  properties?: MongoDatabaseResourcePatchProperties;
}

/**
 * Mongo Database resource patch properties
 */
model MongoDatabaseResourcePatchProperties {
  /**
   * The database name.
   */
  databaseDisplayName?: string;

  /**
   * discovered Mongo Instance Ids
   */
  mongoInstanceArmIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApplicationMigration/mongoSites/mongoInstances";
    }
  ]>[];

  /**
   * The size of the database in MB.
   */
  sizeInMb?: float32;

  /**
   * The number of collections in the database.
   */
  numberOfCollections?: int64;
}

/**
 * List of MongoCollections.
 */
model MongoCollectionList is Azure.Core.Page<MongoCollection>;

/**
 * Mongo Collection Properties
 */
model MongoCollectionProperties is AzureResourceProperties {
  /**
   * The collection name.
   */
  collectionDisplayName: string;

  /**
   * discovered Mongo Database Ids
   */
  mongoDatabaseArmIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApplicationMigration/mongoSites/mongoDatabases";
    }
  ]>[];

  /**
   * The size of the collection in MB.
   */
  sizeInMb?: float32;

  /**
   * The number of indexes in the collection.
   */
  numberOfIndexes?: int64;

  /**
   * The number of documents in the collection.
   */
  numberOfDocuments?: int64;

  /**
   * The average document size in bytes for this collection
   */
  averageDocumentSizeInBytes?: float32;

  /**
   * The collection creation timestamp.
   */
  createdAt?: utcDateTime;

  /**
   * The collection last modified timestamp.
   */
  lastModifiedAt?: utcDateTime;

  /**
   * The list of critical errors.
   */
  @identifiers(#[])
  criticalErrors?: CollectionExceptionInfo[];

  /**
   * The number of critical errors.
   */
  criticalErrorCount: int64;

  /**
   * The list of warnings.
   */
  @identifiers(#[])
  warnings?: CollectionExceptionInfo[];

  /**
   * The number of warnings.
   */
  warningsCount: int64;

  /**
   * The list of informational messages.
   */
  @identifiers(#[])
  informationalMessages?: CollectionExceptionInfo[];

  /**
   * The number of informational messages.
   */
  informationalMessagesCount: int64;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;
}

/**
 * Mongo Collection properties
 */
model MongoCollectionResourcePatch {
  /**
   * The collection resource patch properties.
   */
  properties?: MongoCollectionResourcePatchProperties;
}

/**
 * Properties for PATCH operation on MongoCollection resource.
 */
model MongoCollectionResourcePatchProperties {
  /** The collection name. */
  collectionDisplayName?: string;

  /**
   * discovered Mongo Database Ids
   */
  mongoDatabaseArmIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApplicationMigration/mongoSites/mongoDatabases";
    }
  ]>[];

  /** The size of the collection in MB. */
  sizeInMb?: float32;

  /** The number of indexes in the collection. */
  numberOfIndexes?: int64;

  /** The number of documents in the collection. */
  numberOfDocuments?: int64;

  /** The average document size in bytes. */
  averageDocumentSizeInBytes?: float32;

  /** The collection creation timestamp. */
  createdAt?: utcDateTime;

  /** The collection last modified timestamp. */
  lastModifiedAt?: utcDateTime;
}

/**
 * MongoError, Warning or information
 */
model CollectionExceptionInfo {
  /**
   * Content of the message
   */
  errorMessage: string;
}
