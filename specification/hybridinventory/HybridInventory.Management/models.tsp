import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridInventory;

@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

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
 * Represents the presence of Oids in Tables under a DB.
 */
union HasTablesWithOids {
  @doc("The Database has tables with Oids.")
  True: "true",

  @doc("The Database does not have tables with Oids.")
  False: "false",

  string,
}

/**
 * Represents the presence of Oids in Tables under a DB.
 */
union HasCustomDataTypes {
  @doc("The Database has custom data types.")
  True: "true",

  @doc("The Database does not have custom data types.")
  False: "false",

  string,
}

/**
 * Represents the Support status of the PostgreSQL instance.
 */
union SupportStatus {
  string,

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
 * Represents the Edition of the PostgreSQL instance.
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
 * Represents the Collation Provider for PostgreSQL.
 */
union CollationProvider {
  string,

  /**
   * UNKNOWN collation provider.
   */
  UNKNOWN: "UNKNOWN",

  /**
   * DEFAULT collation provider.
   */
  DEFAULT: "DEFAULT",

  /**
   * LIBC collation provider.
   */
  LIBC: "LIBC",

  /**
   * ICU collation provider.
   */
  ICU: "ICU",
}

/**
 * Represents the supported character sets in PostgreSQL.
 */
union Encoding {
  string,

  /**
   * Big Five character set for Traditional Chinese.
   */
  BIG5: "BIG5",

  /**
   * Extended UNIX Code-CN (for Simplified Chinese).
   */
  EUC_CN: "EUC_CN",

  /**
   * Extended UNIX Code-JP (for Japanese).
   */
  EUC_JP: "EUC_JP",

  /**
   * Extended UNIX Code-JP supporting JIS X 0213.
   */
  EUC_JIS_2004: "EUC_JIS_2004",

  /**
   * Extended UNIX Code-KR (for Korean).
   */
  EUC_KR: "EUC_KR",

  /**
   * Extended UNIX Code-TW (for Traditional Chinese).
   */
  EUC_TW: "EUC_TW",

  /**
   * GB18030, the official character set of China.
   */
  GB18030: "GB18030",

  /**
   * GBK, an extension of GB2312 used in China.
   */
  GBK: "GBK",

  /**
   * ISO 8859-5, used for Cyrillic script.
   */
  ISO_8859_5: "ISO_8859_5",

  /**
   * ISO 8859-6, used for Arabic script.
   */
  ISO_8859_6: "ISO_8859_6",

  /**
   * ISO 8859-7, used for Greek script.
   */
  ISO_8859_7: "ISO_8859_7",

  /**
   * ISO 8859-8, used for Hebrew script.
   */
  ISO_8859_8: "ISO_8859_8",

  /**
   * JOHAB, a South Korean character encoding.
   */
  JOHAB: "JOHAB",

  /**
   * KOI8-R, used for Russian language.
   */
  KOI8R: "KOI8R",

  /**
   * KOI8-U, an extension of KOI8-R for Ukrainian.
   */
  KOI8U: "KOI8U",

  /**
   * ISO 8859-1, also known as Latin-1.
   */
  LATIN1: "LATIN1",

  /**
   * ISO 8859-2, also known as Latin-2, used for Central European languages.
   */
  LATIN2: "LATIN2",

  /**
   * ISO 8859-3, also known as Latin-3.
   */
  LATIN3: "LATIN3",

  /**
   * ISO 8859-4, also known as Latin-4.
   */
  LATIN4: "LATIN4",

  /**
   * ISO 8859-9, also known as Latin-5 (Turkish).
   */
  LATIN5: "LATIN5",

  /**
   * ISO 8859-10, also known as Latin-6.
   */
  LATIN6: "LATIN6",

  /**
   * ISO 8859-13, also known as Latin-7 (Baltic languages).
   */
  LATIN7: "LATIN7",

  /**
   * ISO 8859-14, also known as Latin-8 (Celtic languages).
   */
  LATIN8: "LATIN8",

  /**
   * ISO 8859-15, also known as Latin-9.
   */
  LATIN9: "LATIN9",

  /**
   * ISO 8859-16, also known as Latin-10.
   */
  LATIN10: "LATIN10",

  /**
   * Mule internal encoding (deprecated).
   */
  MULE_INTERNAL: "MULE_INTERNAL",

  /**
   * Shift JIS encoding for Japanese.
   */
  SJIS: "SJIS",

  /**
   * Shift JIS encoding with JIS X 0213 support.
   */
  SHIFT_JIS_2004: "SHIFT_JIS_2004",

  /**
   * SQL_ASCII encoding (no specific character encoding).
   */
  SQL_ASCII: "SQL_ASCII",

  /**
   * Unified Hangul Code for Korean.
   */
  UHC: "UHC",

  /**
   * UTF-8 encoding, the most widely used Unicode format.
   */
  UTF8: "UTF8",

  /**
   * Windows CP866, used for Russian language.
   */
  WIN866: "WIN866",

  /**
   * Windows CP874, used for Thai language.
   */
  WIN874: "WIN874",

  /**
   * Windows CP1250, used for Central European languages.
   */
  WIN1250: "WIN1250",

  /**
   * Windows CP1251, used for Cyrillic script.
   */
  WIN1251: "WIN1251",

  /**
   * Windows CP1252, used in Western Europe (similar to Latin-1).
   */
  WIN1252: "WIN1252",

  /**
   * Windows CP1253, used for Greek.
   */
  WIN1253: "WIN1253",

  /**
   * Windows CP1254, used for Turkish.
   */
  WIN1254: "WIN1254",

  /**
   * Windows CP1255, used for Hebrew.
   */
  WIN1255: "WIN1255",

  /**
   * Windows CP1256, used for Arabic.
   */
  WIN1256: "WIN1256",

  /**
   * Windows CP1257, used for Baltic languages.
   */
  WIN1257: "WIN1257",

  /**
   * Windows CP1258, used for Vietnamese.
   */
  WIN1258: "WIN1258",
}

/**
 * Represents the Language supported by PostgreSQL. https://wiki.postgresql.org/wiki/PL_Matrix.
 */
union Language {
  string,

  /**
   * UNKNOWN edition.
   */
  UNKNOWN: "UNKNOWN",

  /**
   * SQL edition.
   */
  SQL: "SQL",

  /**
   * PLPGSQL edition.
   */
  PLPGSQL: "PLPGSQL",

  /**
   * PLPERL edition.
   */
  PLPERL: "PLPERL",

  /**
   * PLDOTNET edition.
   */
  PLDOTNET: "PLDOTNET",

  /**
   * PLHASKELL edition.
   */
  PLHASKELL: "PLHASKELL",

  /**
   * PLLOLCODE edition.
   */
  PLLOLCODE: "PLLOLCODE",

  /**
   * PLPYTHON edition.
   */
  PLPYTHON: "PLPYTHON",

  /**
   * PLLUA edition.
   */
  PLLUA: "PLLUA",

  /**
   * PLR edition.
   */
  PLR: "PLR",

  /**
   * PLJAVA edition.
   */
  PLJAVA: "PLJAVA",

  /**
   * PLV8 edition.
   */
  PLV8: "PLV8",

  /**
   * PLTCL edition.
   */
  PLTCL: "PLTCL",

  /**
   * PLSH edition.
   */
  PLSH: "PLSH",

  /**
   * PLPHP edition.
   */
  PLPHP: "PLPHP",

  /**
   * PLRUBY edition.
   */
  PLRUBY: "PLRUBY",

  /**
   * PLJAVASCRIPT edition.
   */
  PLJAVASCRIPT: "PLJAVASCRIPT",

  /**
   * PLCOFFEE edition.
   */
  PLCOFFEE: "PLCOFFEE",

  /**
   * PLRUST edition.
   */
  PLRUST: "PLRUST",

  /**
   * PLSCHEME edition.
   */
  PLSCHEME: "PLSCHEME",

  /**
   * PLXSLT edition.
   */
  PLXSLT: "PLXSLT",

  /**
   * INTERNAL edition.
   */
  INTERNAL: "INTERNAL",

  /**
   * C edition.
   */
  C: "C",
}

/**
 * List of Sites.
 */
model PgsqlSiteList is Azure.Core.Page<PgsqlSite>;

/**
 * PGSQL Site properties
 */
model PgsqlSiteProperties is AzureResourceProperties {
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
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Object containing tags updates for patch operations.
 */
model PgsqlSitesResourcePatch {
  /**
   * Resource tags.
   */
  @Azure.ResourceManager.identifiers(#["key", "value"])
  tags?: Tag[];

  /**
   * The PGSQLSites resource definition.
   */
  properties?: PgsqlSiteProperties;
}

/**
 * List of Servers.
 */
model PgsqlInstanceList is Azure.Core.Page<PgsqlInstance>;

/**
 * PGSQL Server properties
 */
model PgsqlInstanceProperties is AzureResourceProperties {
  /**
   * The Server IP/host name.
   */
  hostName: string;

  /**
   * The Server IP/host name.
   */
  hostIp?: string[];

  /**
   * discovery Machine Id
   */
  machineId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/serverSites/machines";
    }
  ]>;

  /**
   * The host machine properties.
   */
  hostMachineProperties?: HostMachineProperties;

  /**
   * PGSQL Server port number
   */
  portNumber: int64;

  /**
   * The pgsql server version.
   */
  version?: string;

  /**
   * The number of database.
   */
  numberOfDatabase?: int64;

  /**
   * pgsql version support status.
   */
  supportStatus?: SupportStatus;

  /**
   * PGSQL instance edition.
   */
  edition?: Edition;

  /**
   * Time when pgsql instance version support end.
   */
  endOfSupportDate?: plainDate;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * The number of errors.
   */
  errorCount?: int64;

  /**
   * The list of collations in the database.
   */
  @identifiers(#["name", "locale", "collationProvider", "isDeterministic"])
  collations?: Collation[];

  /**
   * Dictionary of server parameters for the instance
   */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["key", "value"])
  serverParameters?: ServerParameter[];

  /**
   * List of tablespaces in the instance.
   */
  tableSpaces?: string[];

  /**
   * List of non-default tablespaces in the instance.
   */
  nonDefaultTableSpaces?: string[];

  /**
   * Gets or sets storage size of PGSQL instance.
   */
  storageSizeInMb?: float32;

  /**
   * The maximum number of connections allowed in the instance
   */
  maxConnections?: int64;

  /**
   * Resource tags
   */
  @Azure.ResourceManager.identifiers(#["key", "value"])
  tags?: Tag[];
}

/**
 * PGSQL Server properties
 */
model PgsqlInstanceResourcePatchProperties {
  /**
   * PGSQL Instance resource patch properties object.
   */
  properties?: PgsqlInstanceResourcePatch;
}

/**
 * PGSQL Server properties
 */
model PgsqlInstanceResourcePatch {
  /**
   * The Server IP/host name.
   */
  hostIp?: string[];

  /**
   * discovery Machine Id
   */
  machineId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/serverSites/machines";
    }
  ]>;

  /**
   * The host machine properties.
   */
  hostMachineProperties?: HostMachineProperties;

  /**
   * The pgsql server version.
   */
  version?: string;

  /**
   * The number of database.
   */
  numberOfDatabase?: int64;

  /**
   * pgsql version support status.
   */
  supportStatus?: SupportStatus;

  /**
   * PGSQL instance edition.
   */
  edition?: Edition;

  /**
   * Time when pgsql instance version support end.
   */
  endOfSupportDate?: plainDate;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * The number of errors.
   */
  errorCount?: int64;

  /**
   * The list of collations in the database.
   */
  @identifiers(#["name", "locale", "collationProvider", "isDeterministic"])
  collations?: Collation[];

  /**
   * List of tablespaces in the instance.
   */
  tableSpaces?: string[];

  /**
   * List of non-default tablespaces in the instance.
   */
  nonDefaultTableSpaces?: string[];

  /**
   * Gets or sets storage size of PGSQL instance.
   */
  storageSizeInMb?: float32;

  /**
   * The maximum number of connections allowed in the instance
   */
  maxConnections?: int64;

  /**
   * Resource tags
   */
  @Azure.ResourceManager.identifiers(#["key", "value"])
  tags?: Tag[];
}

/**
 * Defines the error.
 */
model Error {
  /**
   * The error ID.
   */
  id?: string;

  /**
   * The error code.
   */
  code?: string;

  /**
   * The summarized error message.
   */
  summaryMessage?: string;

  /**
   * The account ID used to login.
   */
  runAsAccountId?: string;

  /**
   * The detailed error message.
   */
  message?: string;

  /**
   * The error possible cause.
   */
  possibleCause?: string;

  /**
   * Gets description of the checkpoint.
   */
  recommendedAction?: string;

  /**
   * Gets description of the severity.
   */
  severity?: string;

  /**
   * Time when this error was last updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTimeStamp?: utcDateTime;
}

/**
 * Represents a Collation in PostgreSQL.
 */
model Collation {
  /**
   * The name of the collation.
   */
  name?: string;

  /**
   * The locale of the collation.
   */
  locale?: string;

  /**
   * The provider of the collation.
   */
  collationProvider?: CollationProvider;

  /**
   * A value indicating whether the collation is deterministic.
   */
  isDeterministic?: boolean;
}

// /**
//  * Object containing tags updates for patch operations.
//  */
// model PgsqlInstanceResourcePatch {
//   /**
//    * Resource tags.
//    */
//   @Azure.ResourceManager.identifiers(#["key", "value"])
//   tags?: Tag[];
// }

/**
 * List of Databases.
 */
model PgsqlDatabaseList is Azure.Core.Page<PgsqlDatabase>;

/**
 * PGSQL Database properties
 */
model PgsqlDatabaseProperties is AzureResourceProperties {
  /**
   * The database name.
   */
  databaseDisplayName?: string;

  /**
   * discovered PGSQL Instance Id
   */
  pgSqlInstanceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridInventory/PGSQLSites/PGSQLInstances";
    }
  ]>;

  /**
   * PGSQL database encoding.
   */
  encoding?: Encoding;

  /**
   * The list of collations in the database.
   */
  @identifiers(#["name", "locale", "collationProvider", "isDeterministic"])
  collations?: Collation[];

  /**
   * The list of extensions in the database.
   */
  @Azure.ResourceManager.identifiers(#["name", "version"])
  extensions?: Extension[];

  /**
   * List of languages in the database.
   */
  languages?: Language[];

  /**
   * Whether tables with oid's exists in the database.
   */
  hasTablesWithOids?: HasTablesWithOids;

  /**
   * Whether the database has custom data types.
   */
  hasCustomDataTypes?: HasCustomDataTypes;

  /**
   * The number of errors.
   */
  errorCount?: int64;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * Resource tags
   */
  @Azure.ResourceManager.identifiers(#["key", "value"])
  tags?: Tag[];
}

/**
 * PGSQL Database properties
 */
model PgsqlDatabaseResourcePatchProperties {
  /**
   * The database resource patch properties.
   */
  properties?: PgsqlDatabaseResourcePatch;
}

/**
 * PGSQL Database patch object
 */
model PgsqlDatabaseResourcePatch {
  /**
   * The database name.
   */
  databaseDisplayName?: string;

  /**
   * discovered PGSQL Instance Id
   */
  pgSqlInstanceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridInventory/PGSQLSites/PGSQLInstances";
    }
  ]>;

  /**
   * PGSQL database encoding.
   */
  encoding?: Encoding;

  /**
   * The list of collations in the database.
   */
  @identifiers(#["name", "locale", "collationProvider", "isDeterministic"])
  collations?: Collation[];

  /**
   * The list of extensions in the database.
   */
  @Azure.ResourceManager.identifiers(#["name", "version"])
  extensions?: Extension[];

  /**
   * List of languages in the database.
   */
  languages?: Language[];

  /**
   * Whether tables with oid's exists in the database.
   */
  hasTablesWithOids?: HasTablesWithOids;

  /**
   * Whether the database has custom data types.
   */
  hasCustomDataTypes?: HasCustomDataTypes;

  /**
   * The number of errors.
   */
  errorCount?: int64;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * Resource tags
   */
  @Azure.ResourceManager.identifiers(#["key", "value"])
  tags?: Tag[];
}

/**
 * Represents an Extension (e.g., PostGIS, pgcrypto).
 */
model Extension {
  /**
   * The name of the extension.
   */
  name?: string;

  /**
   * The version of the extension.
   */
  version?: string;
}

// /**
//  * Object containing tags updates for patch operations.
//  */
// model PgsqlDatabaseResourcePatch {
//   /**
//    * Resource tags
//    */
//   @Azure.ResourceManager.identifiers(#["key", "value"])
//   tags?: Tag[];
// }

/**
 * List of Agents.
 */
model AgentList is Azure.Core.Page<Agent>;

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
 * Represents a Collation in PostgreSQL.
 */
model HostMachineProperties {
  /**
   * The machine vCore count.
   */
  vCores?: int64;

  /**
   * The allocated RAM in Machine.
   */
  allocatedMemoryInMb?: int64;
}
