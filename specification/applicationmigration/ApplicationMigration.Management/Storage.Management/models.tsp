import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ApplicationMigration;

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
/**
 * Model to represent a co-located share.
 */
model ColocatedShare {
  /**
   * The co-located Share id.
   */
  shareId: string;
}

/**
 * List of Sites.
 */
model StorageSiteList is Azure.Core.Page<StorageSite>;

/**
 * Storage Site properties
 */
model StorageSiteProperties is AzureResourceProperties {
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
}

/**
 * Object containing tags updates for patch operations.
 */
model StorageSitesResourcePatch {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;

  /**
   * The StorageSites resource definition.
   */
  properties?: StorageSiteProperties;
}

/**
 * List of FilesShares.
 */
model FileShareList is Azure.Core.Page<FileShare>;

/**
 * FileShare properties
 */
model FileShareProperties is AzureResourceProperties {
  /**
   * The Share ID.
   */
  shareId: string;

  /**
   * The Server name.
   */
  serverName: string;

  /**
   * discovery Machine Ids
   */
  machineArmIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/serverSites/machines";
    },
    {
      type: "Microsoft.OffAzure/vmwareSites/machines";
    },
    {
      type: "Microsoft.OffAzure/hyperVSites/machines";
    }
  ]>[];

  /**
   * The file share name.
   */
  fileShareName?: string;

  /**
   * The Protocol Type for the file share.
   */
  protocolType?: ProtocolType;

  /**
   * The Protocol Version
   */
  protocolVersion?: string[];

  /**
   * FileShare Estimated Volume Size in GB.
   */
  fileShareEstimatedVolSizeInGb?: float64;

  /**
   * FileShare Estimated Size in GB.
   */
  fileShareEstimatedSizeInGb?: float64;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * The number of errors.
   */
  errorCount?: int64;

  /**
   * The volume name.
   */
  volume?: string;

  /**
   * The volume ID.
   */
  volumeId?: string;

  // /**
  //  * The list of collations in the database.
  //  */
  // @OpenAPI.extension(
  //   "x-ms-identifiers",
  //   #["name", "locale", "collationProvider", "isDeterministic"]
  // )
  // collations?: Collation[];

  /**
   * Co-located shares on the same volume.
   */
  @identifiers(#["shareId"])
  colocatedShares?: ColocatedShare[];

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;
}

/**
 * FileShare Server properties
 */
model FileShareResourcePatchProperties {
  /**
   * FileShare resource patch properties object.
   */
  properties?: FileShareResourcePatch;
}

/**
 * FileShare properties
 */
model FileShareResourcePatch {
  /**
   * The Share ID.
   */
  shareId?: string;

  /**
   * The Server name.
   */
  serverName?: string;

  /**
   * discovery Machine Ids
   */
  machineArmIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/serverSites/machines";
    },
    {
      type: "Microsoft.OffAzure/vmwareSites/machines";
    },
    {
      type: "Microsoft.OffAzure/hyperVSites/machines";
    }
  ]>[];

  /**
   * The file share name.
   */
  fileShareName?: string;

  /**
   * The Protocol Type for the file share.
   */
  protocolType?: ProtocolType;

  /**
   * The Protocol Version
   */
  protocolVersion?: string[];

  /**
   * FileShare Estimated Volume Size in GB.
   */
  fileShareEstimatedVolSizeInGb?: float64;

  /**
   * FileShare Estimated Size in GB.
   */
  fileShareEstimatedSizeInGb?: float64;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * The number of errors.
   */
  errorCount?: int64;

  // /**
  //  * The list of collations in the database.
  //  */
  // @OpenAPI.extension(
  //   "x-ms-identifiers",
  //   #["name", "locale", "collationProvider", "isDeterministic"]
  // )
  // collations?: Collation[];

  /**
   * The volume name.
   */
  volume?: string;

  /**
   * The volume ID.
   */
  volumeId?: string;

  /**
   * Co-located shares on the same volume.
   */
  @identifiers(#["shareId"])
  colocatedShares?: ColocatedShare[];

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;
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
   * Name of the fabric site.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricSiteName: string;
}

/**
 * Class for agent spn properties.
 */
model AgentSpnProperties {
  /**
   * Tenant Id for the service principal with which the on-premise management/data plane components would communicate with Azure services.
   */
  tenantId?: string;

  /**
   * Application/client Id for the service principal with which the on-premise management/data plane components would communicate with Azure services.
   */
  applicationId?: string;

  /**
   * Object Id of the service principal with which the on-premise management/data plane components would communicate with Azure services.
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
 * The protocol Type for the file share.
 */
union ProtocolType {
  string,

  @doc("Unknown protocol type.")
  Unknown: "Unknown",

  @doc("Server Message Block Protocol.")
  SMB: "SMB",

  @doc("Network File System Protocol.")
  NFS: "NFS",
}

@doc("The Site Tags patch resource definition.")
model SiteTagsPatch {
  ...ArmTagsProperty;
}
