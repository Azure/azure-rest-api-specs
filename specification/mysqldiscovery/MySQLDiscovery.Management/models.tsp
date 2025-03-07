import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MySQLDiscovery;

/**
 * Gets or sets the provisioning state.
 */
union ProvisioningState {
  string,

  /**
   * Unknown Provising State
   */
  Unknown: "Unknown",

  /**
   * Succeeded Provising State
   */
  Succeeded: "Succeeded",

  /**
   * Failed Provising State
   */
  Failed: "Failed",

  /**
   * Canceled Provising State
   */
  Canceled: "Canceled",

  /**
   * Creating Provising State
   */
  Creating: "Creating",

  /**
   * Deleting Provising State
   */
  Deleting: "Deleting",

  /**
   * Updating Provising State
   */
  Updating: "Updating",
}

/**
 * Mysql version support status.
 */
union SupportStatus {
  string,

  /**
   * OutOfSupport status
   */
  OutOfSupport: "OutOfSupport",

  /**
   * Extended status
   */
  Extended: "Extended",

  /**
   * Mainstream status
   */
  Mainstream: "Mainstream",
}

/**
 * Mysql server edition.
 */
union Edition {
  string,

  /**
   * Community edition
   */
  Community: "Community",

  /**
   * Enterprise edition
   */
  Enterprise: "Enterprise",
}

/**
 * List of Sites.
 */
model MySQLSiteList is Azure.Core.Page<MySQLSite>;

/**
 * MySQL Site properties
 */
model MySQLSiteProperties {
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
   * Gets or sets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
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
  @visibility("read")
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Object containing tags updates for patch operations.
 */
model MySQLSitesResourcePatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The MySQLSites resource definition.
   */
  properties?: MySQLSiteProperties;
}

/**
 * List of Servers.
 */
model MySQLServerList is Azure.Core.Page<MySQLServer>;

/**
 * MySQL Server properties
 */
model MySQLServerProperties {
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
   * MySQL Server port number
   */
  portNumber: string;

  /**
   * The mysql server version.
   */
  mysqlVersion?: string;

  /**
   * The number of database.
   */
  numberOfDatabase?: int64;

  /**
   * mysql version support status.
   */
  supportStatus?: SupportStatus;

  /**
   * mysql server edition.
   */
  edition?: Edition;

  /**
   * Time when mysql version support end.
   */
  supportEndIn?: plainDate;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * Gets or sets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Resource labels.
   */
  labels?: Record<string>;
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
 * Object containing tags updates for patch operations.
 */
model MySQLServerResourcePatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The MySQLServer resource definition.
   */
  properties?: MySQLServerProperties;
}

/**
 * List of ErrorSummaries.
 */
model ErrorSummaryList is Azure.Core.Page<ErrorSummary>;

/**
 * Error summaries properties
 */
model ErrorSummariesProperties {
  /**
   * The number of affected objects.
   */
  affectedObjectsCount?: int64;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * Gets or sets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * List of Summaries.
 */
model SummaryList is Azure.Core.Page<Summary>;

/**
 * Summaries properties
 */
model SummariesProperties {
  /**
   * The number of discovered server.
   */
  discoveredServers?: int64;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * Gets or sets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}
