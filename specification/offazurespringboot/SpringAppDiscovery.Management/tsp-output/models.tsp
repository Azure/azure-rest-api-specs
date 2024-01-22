import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.OffAzureSpringBoot;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The resource provisioning state.
 */
enum ProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Accepted,
  Provisioning,
  Deleting,
}

/**
 * The springbootsites resource definition.
 */
model SpringbootsitesProperties {
  /**
   * The master site ID from Azure Migrate.
   */
  masterSiteId?: string;

  /**
   * The migrate project ID from Azure Migrate.
   */
  migrateProjectId?: string;

  /**
   * The resource provisioning state.
   */
  provisioningState?: ProvisioningState;
}

/**
 * The extended location definition.
 */
model SpringbootsitesModelExtendedLocation {
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
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

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
 * The springbootsites resource patch definition.
 */
model SpringbootsitesPatch extends TrackedResource {
  /**
   * The springbootsites resource definition.
   */
  properties?: SpringbootsitesProperties;
}

/**
 * The springbootservers resource definition.
 */
model SpringbootserversProperties {
  /**
   * Target server port for remote login
   */
  port?: int32;

  /**
   * Server is the target server name or ip address to discover of SpringBootServer.
   */
  server: string;

  /**
   * The alternative FQDN or IP addresses to discover for this server
   */
  fqdnAndIpAddressList?: string[];

  /**
   * The machine Id from ARM
   */
  machineArmId?: string;

  /**
   * The total number of apps been discovered
   */
  totalApps?: int32;

  /**
   * The total number of spring boot apps been discovered
   */
  springBootApps?: int32;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * The resource provisioning state.
   */
  provisioningState?: ProvisioningState;
}

/**
 * Defines the error.
 */
model Error {
  /**
   * The error ID.
   */
  id?: int64;

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
   * The error possible causes.
   */
  possibleCauses?: string;

  /**
   * The error recommended action
   */
  recommendedAction?: string;

  /**
   * The error severity
   */
  severity?: string;

  /**
   * Time when this error was last updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTimeStamp?: utcDateTime;
}

/**
 * The springbootservers resource patch definition.
 */
model SpringbootserversPatch extends ProxyResource {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The springbootsites resource definition.
   */
  properties?: SpringbootserversProperties;
}

/**
 * The springbootapps resource definition.
 */
model SpringbootappsProperties {
  /**
   * The name of SpringBootApp.
   */
  appName?: string;

  /**
   * The artifact name of SpringBootApp.
   */
  artifactName?: string;

  /**
   * The application port.
   */
  appPort?: int32;

  /**
   * The application type, whether it is a SpringBoot app.
   */
  appType?: string;

  /**
   * The application configuration file list.
   */
  applicationConfigurations?: SpringbootappsPropertiesApplicationConfigurationsItem[];

  /**
   * The application binding port list.
   */
  bindingPorts?: int32[];

  /**
   * The jdk version in build.
   */
  buildJdkVersion?: string;

  /**
   * The certificate file list.
   */
  certificates?: string[];

  /**
   * The checksum of jar file.
   */
  checksum?: string;

  /**
   * The dependency list.
   */
  dependencies?: string[];

  /**
   * The environment variable list.
   */
  environments?: string[];

  /**
   * The total instance count the app deployed.
   */
  instanceCount?: int32;

  /**
   * The jar file location on the server.
   */
  jarFileLocation?: string;

  /**
   * The jvm heap memory allocated.
   */
  jvmMemoryInMB?: int32;

  /**
   * The jvm options.
   */
  jvmOptions?: string[];

  /**
   * The other types of date collected.
   */
  miscs?: SpringbootappsPropertiesMiscsItem[];

  /**
   * The breakdown info for app instances on all the servers
   */
  instances?: SpringbootappsPropertiesInstancesItem[];

  /**
   * The jdk version installed on server
   */
  runtimeJdkVersion?: string;

  /**
   * The server list the app installed
   */
  servers?: string[];

  /**
   * The machine ARM id list the app belongs to.
   */
  machineArmIds?: string[];

  /**
   * The site name.
   */
  siteName?: string;

  /**
   * The spring boot version.
   */
  springBootVersion?: string;

  /**
   * The static content location list.
   */
  staticContentLocations?: string[];

  /**
   * The connection string list.
   */
  connectionStrings?: string[];

  /**
   * Time when this springbootapps jar file was last modified.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Time when this springbootapps instance was last refreshed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The resource provisioning state.
   */
  provisioningState?: ProvisioningState;

  /**
   * The list of errors.
   */
  errors?: Error[];
}

model SpringbootappsPropertiesApplicationConfigurationsItem {
  /**
   * The application config file name.
   */
  key: string;

  /**
   * The application config file content, only contains config keys.
   */
  value?: string;
}

model SpringbootappsPropertiesMiscsItem {
  /**
   * The miscs. key.
   */
  key: string;

  /**
   * The miscs. value.
   */
  value?: string;
}

model SpringbootappsPropertiesInstancesItem {
  /**
   * The machine ARM resource Id of this app instance
   */
  machineArmId: string;

  /**
   * The instance count of this app instance
   */
  instanceCount?: int32;

  /**
   * The jvm heap memory allocated of this app instance
   */
  jvmMemoryInMB?: int32;
}

/**
 * The springbootapps resource patch definition.
 */
model SpringbootappsPatch extends ProxyResource {
  /**
   * The springbootapps resource definition.
   */
  properties?: SpringbootappsProperties;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Summaries properties
 */
model SummariesProperties {
  /**
   * The of number discovered spring boot servers.
   */
  discoveredServers?: int64;

  /**
   * The of number discovered spring boot apps.
   */
  discoveredApps?: int64;

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * The resource provisioning state.
   */
  provisioningState?: ProvisioningState;
}

/**
 * Error summary properties
 */
model ErrorSummariesProperties {
  /**
   * The list of ErrorSummary.
   */
  discoveryScopeErrorSummaries?: ErrorSummaryModel[];

  /**
   * The list of errors.
   */
  errors?: Error[];

  /**
   * The resource provisioning state.
   */
  provisioningState?: ProvisioningState;
}

/**
 * ErrorSummary model.
 */
model ErrorSummaryModel {
  /**
   * The type of Object.
   */
  affectedResourceType?: string;

  /**
   * The count.
   */
  affectedObjectsCount?: int64;
}

/**
 * Object containing tags updates for patch operations.
 */
model SummariesResourcePatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The Summaries resource definition.
   */
  properties?: SummariesProperties;
}

/**
 * Object containing tags updates for patch operations.
 */
model ErrorSummariesResourcePatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The ErrorSummaries resource definition.
   */
  properties?: ErrorSummariesProperties;
}
