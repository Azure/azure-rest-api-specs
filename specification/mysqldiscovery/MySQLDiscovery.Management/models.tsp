import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MySqlDiscovery;

/**
 * Gets or sets the provisioning state.
 */
union ProvisioningState {
  string,
  Unknown: "Unknown",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
  Creating: "Creating",
  Deleting: "Deleting",
  Updating: "Updating",
}

/**
 * mysql version support status.
 */
union SupportStatus {
  string,
  OutOfSupport: "OutOfSupport",
  Extended: "Extended",
  Mainstream: "Mainstream",
}

/**
 * mysql server edition.
 */
union Edition {
  string,
  Community: "Community",
  Enterprise: "Enterprise",
}

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
 * List of Sites.
 */
model MySQLSiteList is Azure.Core.Page<MySQLSite>;

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
 * List of Servers.
 */
model MySQLServerList is Azure.Core.Page<MySQLServer>;

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
  provisioningState?: ProvisioningState;
}

/**
 * List of Summaries.
 */
model SummaryList is Azure.Core.Page<Summary>;

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
  provisioningState?: ProvisioningState;
}

/**
 * List of ErrorSummaries.
 */
model ErrorSummaryList is Azure.Core.Page<ErrorSummary>;

/**
 * Agent properties
 */
model AgentProperties {
  /**
   * Service principal identity details used by agent for communication to the service.
   */
  @visibility("read", "create")
  servicePrincipalIdentityDetails: AgentSpnProperties;

  /**
   * Name of the appliance on which agent is running.
   */
  @visibility("read", "create")
  migrateApplianceName: string;

  /**
   * Health details of the agent.
   */
  healthDetails?: AgentHealthProperties;

  /**
   * Gets or sets the provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
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

/**
 * List of Agents.
 */
model AgentList is Azure.Core.Page<Agent>;
