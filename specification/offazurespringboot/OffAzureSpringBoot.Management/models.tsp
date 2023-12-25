import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.OffAzureSpringBoot;

interface Operations extends Azure.ResourceManager.Operations {}

enum ProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Accepted,
  Provisioning,
  Deleting,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

@doc("The springbootsites resource definition.")
model SpringbootsitesProperties {
  @doc("The master site ID from Azure Migrate.")
  masterSiteId?: string;

  @doc("The migrate project ID from Azure Migrate.")
  migrateProjectId?: string;

  @doc("The resource provisioning state.")
  provisioningState?: ProvisioningState;
}

@doc("The extended location definition.")
model SpringbootsitesModelExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}

@doc("The springbootservers resource definition.")
model SpringbootserversProperties {
  @doc("Target server port for remote login")
  port?: int32;

  @doc("Server is the target server name or ip address to discover of SpringBootServer.")
  server: string;

  @doc("The alternative FQDN or IP addresses to discover for this server")
  fqdnAndIpAddressList?: string[];

  @doc("The machine Id from ARM")
  machineArmId?: string;

  @doc("The total number of apps been discovered")
  totalApps?: int32;

  @doc("The total number of spring boot apps been discovered")
  springBootApps?: int32;

  @doc("The list of errors.")
  errors?: Error[];

  @doc("The resource provisioning state.")
  provisioningState?: ProvisioningState;
}

@doc("Defines the error.")
model Error {
  @doc("The error ID.")
  id?: int32;

  @doc("The error code.")
  code?: string;

  @doc("The summarized error message.")
  summaryMessage?: string;

  @doc("The account ID used to login.")
  runAsAccountId?: string;

  @doc("The detailed error message.")
  message?: string;

  @doc("The error possible causes.")
  possibleCauses?: string;

  @doc("The error recommended action")
  recommendedAction?: string;

  @doc("The error severity")
  severity?: string;

  @doc("Time when this error was last updated.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTimeStamp?: utcDateTime;
}

@doc("The springbootapps resource definition.")
model SpringbootappsProperties {
  @doc("The name of SpringBootApp.")
  appName?: string;

  @doc("The artifact name of SpringBootApp.")
  artifactName?: string;

  @doc("The application port.")
  appPort?: int32;

  @doc("The application type, whether it is a SpringBoot app.")
  appType?: string;

  @doc("The application configuration file list.")
  applicationConfigurations?: SpringbootappsPropertiesApplicationConfigurationsItem[];

  @doc("The application binding port list.")
  bindingPorts?: int32[];

  @doc("The jdk version in build.")
  buildJdkVersion?: string;

  @doc("The certificate file list.")
  certificates?: string[];

  @doc("The checksum of jar file.")
  checksum?: string;

  @doc("The dependency list.")
  dependencies?: string[];

  @doc("The environment variable list.")
  environments?: string[];

  @doc("The total instance count the app deployed.")
  instanceCount?: int32;

  @doc("The jar file location on the server.")
  jarFileLocation?: string;

  @doc("The jvm heap memory allocated.")
  jvmMemoryInMB?: int32;

  @doc("The jvm options.")
  jvmOptions?: string[];

  @doc("The other types of date collected.")
  miscs?: SpringbootappsPropertiesMiscsItem[];

  @doc("The breakdown info for app instances on all the servers")
  instances?: SpringbootappsPropertiesInstancesItem[];

  @doc("The jdk version installed on server")
  runtimeJdkVersion?: string;

  @doc("The server list the app installed")
  servers?: string[];

  @doc("The machine ARM id list the app belongs to.")
  machineArmIds?: string[];

  @doc("The site name.")
  siteName?: string;

  @doc("The spring boot version.")
  springBootVersion?: string;

  @doc("The static content location list.")
  staticContentLocations?: string[];

  @doc("The connection string list.")
  connectionStrings?: string[];

  @doc("Time when this springbootapps jar file was last modified.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Time when this springbootapps instance was last refreshed.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  @doc("The resource provisioning state.")
  provisioningState?: ProvisioningState;

  @doc("The list of errors.")
  errors?: Error[];
}

model SpringbootappsPropertiesApplicationConfigurationsItem {
  @doc("The application config file name.")
  key: string;

  @doc("The application config file content, only contains config keys.")
  value?: string;
}

model SpringbootappsPropertiesMiscsItem {
  @doc("The miscs. key.")
  key: string;

  @doc("The miscs. value.")
  value?: string;
}

model SpringbootappsPropertiesInstancesItem {
  @doc("The machine ARM resource Id of this app instance")
  machineArmId: string;

  @doc("The instance count of this app instance")
  instanceCount?: int32;

  @doc("The jvm heap memory allocated of this app instance")
  jvmMemoryInMB?: int32;
}

@doc("Summaries properties")
model SummariesProperties {
  @doc("The of number discovered spring boot servers.")
  discoveredServers?: int32;

  @doc("The of number discovered spring boot apps.")
  discoveredApps?: int32;

  @doc("The list of errors.")
  errors?: Error[];

  @doc("The resource provisioning state.")
  provisioningState?: ProvisioningState;
}

@doc("Error summary properties")
model ErrorSummariesProperties {
  @doc("The list of ErrorSummary.")
  discoveryScopeErrorSummaries?: ErrorSummaryModel[];

  @doc("The list of errors.")
  errors?: Error[];

  @doc("The resource provisioning state.")
  provisioningState?: ProvisioningState;
}

@doc("ErrorSummary model.")
model ErrorSummaryModel {
  @doc("The type of Object.")
  affectedResourceType?: string;

  @doc("The count.")
  affectedObjectsCount?: int32;
}

@doc("Object containing tags updates for patch operations.")
model SummariesResourcePatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The Summaries resource definition.")
  properties?: SummariesProperties;
}

@doc("Object containing tags updates for patch operations.")
model ErrorSummariesResourcePatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The ErrorSummaries resource definition.")
  properties?: ErrorSummariesProperties;
}
