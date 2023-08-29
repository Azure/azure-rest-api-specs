import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using OpenAPI;

@doc("inner error")
model InnerError {
  @doc("code string ")
  code: string;

  @projectedName("csharp", "innerErrorr")
  @doc("inner error")
  innererror: InnerError;
}

@doc("Class for site agent properties.")
model SiteAgentProperties {
  @doc("Gets the ID of the agent.")
  @visibility("read")
  id?: string;

  @doc("Gets the version of the agent.")
  @visibility("read")
  version?: string;

  @doc("Gets the last heartbeat time of the agent in UTC.")
  @visibility("read")
  lastHeartBeatUtc?: utcDateTime;

  @doc("Gets or sets the key vault URI.")
  keyVaultUri?: string;

  @doc("Gets or sets the key vault ARM Id.")
  keyVaultId?: string;
}

@doc("Health Error Details Source")
@knownValues(HealthErrorDetailsSource)
scalar MicrosoftAzureFDSWebRoleHealthErrorDetailsSource extends string;

@doc("HealthError Details Source")
enum HealthErrorDetailsSource {
  RefreshFabricLayout,
  RefreshFabricLayoutGuest,
  RefreshFabricLayoutDependencyMap,
}

@doc("Data related to a machine's WebApps discovery.")
model WebAppDiscovery {
  @doc("Gets or sets number of successfully discovered web servers..")
  totalWebServerCount: int64;

  @doc("Gets or sets number of successfully discovered web applications.")
  totalWebApplicationCount: int64;

  @doc("Gets or sets status of partner discovery.")
  discoveryScopeStatus: DiscoveryScopeStatus;
}

@doc("Data related to a machine's Oracle discovery.")
model OracleDiscovery {
  @doc("Gets or sets number of successfully discovered instances.")
  totalInstanceCount: int64;

  @doc("Gets or sets number of successfully discovered databases.")
  totalDatabaseCount: int64;

  @doc("Gets or sets status of partner discovery.")
  discoveryScopeStatus: DiscoveryScopeStatus;
}

@doc("Data related to a machine's spring boot discovery.")
model SpringBootDiscovery {
  @doc("Gets or sets number of successfully discovered instances.")
  totalInstanceCount: int64;

  @doc("Gets or sets number of successfully discovered applications.")
  totalApplicationCount: int64;

  @doc("Gets or sets status of partner discovery.")
  discoveryScopeStatus: DiscoveryScopeStatus;
}

// @doc("hyperv cluster")
// model HypervCluster {
//   @doc("Gets or sets the type of the operating system.")
//   osType?: string;
// @doc("hyperv cluster")
// model HypervCluster {
//   @doc("Gets or sets the type of the operating system.")
//   osType?: string;

//   @doc("Gets or sets the Name of the operating system.")
//   osName?: string;
//   @doc("Gets or sets the Name of the operating system.")
//   osName?: string;

//   @doc("Gets or sets the Version of the operating system.")
//   osVersion?: string;
//   @doc("Gets or sets the Version of the operating system.")
//   osVersion?: string;

//   @doc("Gets or sets the Architecture of the operating system.")
//   osArchitecture?: string;
// }
@doc("DependencyMap DiscoveryScope Status")
enum DependencyMapDiscoveryScopeStatus {
  "DiscoverySucceededAtleastOnce",
  "DiscoveryFailed",
  "RunAsAccountNotAssociated",
  "DiscoveryNotStarted",
  "DiscoveryInProgress",
  "Disabled",
  "DiscoveryPartiallySucceded",
  "DiscoverySucceeded",
}

// enum HealthErrorDetailsDiscoveryScope {
//   "AppsAndRoles",
//   "DependencyMap",
//   "StaticData",
//   "SQLServerConnectionInfo",
// }

@doc("Gets discovery scope for which             error is encountered.")
@knownValues(HealthErrorDetailsDiscoveryScopeValues)
scalar HealthErrorDetailsDiscoveryScope extends string;

@doc("Gets discovery scope for which             error is encountered.")
enum HealthErrorDetailsDiscoveryScopeValues {
  "AppsAndRoles",
  "DependencyMap",
  "StaticData",
  "SQLServerConnectionInfo",
}

@doc("Error contract returned when some exception occurs in Rest API.")
model HealthErrorDetails {
  @doc("Gets the error message.")
  @visibility("read")
  message?: string;

  @doc("Gets the message parameters.")
  @visibility("read")
  messageParameters?: Record<string>;

  @doc("Gets the appliance name.")
  @visibility("read")
  applianceName?: string;

  @doc("Gets the error ID.")
  @visibility("read")
  id?: int64;

  @doc("Gets the error name.")
  @visibility("read")
  code?: string;

  @doc("Gets the possible causes of error.")
  @visibility("read")
  possibleCauses?: string;

  @doc("Gets the recommended action to resolve error.")
  @visibility("read")
  recommendedAction?: string;

  @doc("Gets the error severity.")
  @visibility("read")
  severity?: string;

  @doc("Gets the error summary message.")
  @visibility("read")
  summaryMessage?: string;

  @doc("Gets the error source.")
  @visibility("read")
  source?: HealthErrorDetailsSource;

  @doc("Gets the time stamp when the error was updated.")
  @visibility("read")
  updatedTimeStamp?: utcDateTime;

  @doc("Gets run as account id used while performing discovery             of entity.")
  @visibility("read")
  runAsAccountId?: string;

  @doc("Gets discovery scope for which             error is encountered.")
  @visibility("read")
  discoveryScope?: HealthErrorDetailsDiscoveryScope;
}

@doc("Contains data related dependency map discovery scope.")
model DependencyMapDiscovery {
  @doc("Gets discovery scope status.")
  @visibility("read")
  discoveryScopeStatus?: DependencyMapDiscoveryScopeStatus;

  @doc("Gets errors for discovery scope.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("""
Gets the run as account ID with which feature worked successfully.
           
It is discovered by the agent from the list of credentials.
""")
  @visibility("read")
  hydratedRunAsAccountId?: string;
}

@doc("Contains data related static data discovery scope.")
model StaticDiscovery {
  @doc("Gets discovery scope status.")
  @visibility("read")
  discoveryScopeStatus?: StaticDiscoveryScopeStatus;

  @doc("Gets errors for discovery scope.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("""
Gets the run as account ID with which feature worked successfully.
           
It is discovered by the agent from the list of credentials.
""")
  @visibility("read")
  hydratedRunAsAccountId?: string;
}
@doc("SQLDiscoveryScope Status")
enum SQLDiscoveryScopeStatus {
  "DiscoverySucceededAtleastOnce",
  "DiscoveryFailed",
  "RunAsAccountNotAssociated",
  "DiscoveryNotStarted",
  "DiscoveryInProgress",
  "Disabled",
  "DiscoveryPartiallySucceded",
  "DiscoverySucceeded",
}

@doc("SQLDiscovery SqlMetadataDiscoveryPipe")
enum SQLDiscoverySqlMetadataDiscoveryPipe {
  "Unknown",
  "VMware",
  "PowerShell",
  "SSH",
  "CIM",
  "Other",
}

@doc("Oracle DiscoveryScope Status")
enum OracleDiscoveryScopeStatus {
  "DiscoverySucceededAtleastOnce",
  "DiscoveryFailed",
  "RunAsAccountNotAssociated",
  "DiscoveryNotStarted",
  "DiscoveryInProgress",
  "Disabled",
  "DiscoveryPartiallySucceded",
  "DiscoverySucceeded",
}

@doc("Second level object returned as part of Machine REST resource.")
model OperatingSystem {
  @doc("Gets or sets the type of the operating system.")
  osType?: string;

  @doc("Gets or sets the Name of the operating system.")
  osName?: string;

  @doc("Gets or sets the Version of the operating system.")
  osVersion?: string;

  @doc("Gets or sets the Architecture of the operating system.")
  osArchitecture?: string;
}

@doc("Static DiscoveryScopeStatus")
enum StaticDiscoveryScopeStatus {
  "DiscoverySucceededAtleastOnce",
  "DiscoveryFailed",
  "RunAsAccountNotAssociated",
  "DiscoveryNotStarted",
  "DiscoveryInProgress",
  "Disabled",
  "DiscoveryPartiallySucceded",
  "DiscoverySucceeded",
}

@doc("Contains data related SQL discovery.")
model SqlDiscovery {
  @doc(" successfully Discovered ServerCount")
  successfullyDiscoveredServerCount?: int32;

  @doc("total Server Count")
  totalServerCount?: int32;

  @doc("sql Metadata Hydrated RunAsAccountId")
  sqlMetadataHydratedRunAsAccountId?: string;

  @doc("sql Metadata DiscoveryPipe")
  sqlMetadataDiscoveryPipe?: SQLDiscoverySqlMetadataDiscoveryPipe;

  @doc("discovery Scope Status")
  discoveryScopeStatus?: SQLDiscoveryScopeStatus;
}

@doc("Application Discovery Scope Status")
enum ApplicationDiscoveryScopeStatus {
  "DiscoverySucceededAtleastOnce",
  "DiscoveryFailed",
  "RunAsAccountNotAssociated",
  "DiscoveryNotStarted",
  "DiscoveryInProgress",
  "Disabled",
  "DiscoveryPartiallySucceded",
  "DiscoverySucceeded",
}

@doc("Contains data related application and roles discovery scope.")
model ApplicationDiscovery {
  @doc("Gets discovery scope status.")
  @visibility("read")
  discoveryScopeStatus?: ApplicationDiscoveryScopeStatus;

  @doc("Gets errors for discovery scope.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("""
Gets the run as account ID with which feature worked successfully.
           
It is discovered by the agent from the list of credentials.
""")
  @visibility("read")
  hydratedRunAsAccountId?: string;
}

@doc("Second level object.  Data related to a machine's operating system.             Serialized and stored as part of Machine Rest object. ")
model GuestOsDetails {
  @doc("Gets or sets the type of the operating system.")
  osType?: string;

  @doc("Gets or sets the Name of the operating system.")
  osName?: string;

  @doc("Gets or sets the Version of the operating system.")
  osVersion?: string;

  @doc("Gets or sets the Architecture of the operating system.")
  osArchitecture?: string;
}

@doc("DependencyMap Service Map extensions Dependency Map Request Filters")
model DependencyMapServiceMapextensionsDependencyMapRequestFilters {
  @doc("array of machine ids")
  machineIds?: string[];

  @doc("array of process Ids")
  processIds?: string[];
};

@doc("DependencyMap ServiceMap extensions SingleMachine DetailedMap Request")
model DependencyMapServiceMapextensionsSingleMachineDetailedMapRequest {
  @doc("id of machine")
  machineId?: string;

  @doc("start time")
  startTime?: utcDateTime;

  @doc("end time")
  endTime?: utcDateTime;

  @doc("optional filters")
  filters?: DependencyMapServiceMapextensionsDependencyMapRequestFilters;

}

@doc("DependencyMap ServiceMap extensions Client GroupMembers Request")
model DependencyMapServiceMapextensionsClientGroupMembersRequest {
  @doc("id of machine")
  machineId?: string;

  @doc("process group name ")
  processGroupName?: string;

  @doc("name of process")
  processName?: string;

  @doc("start time")
  startTime?: utcDateTime;

  @doc("end time")
  endTime?: utcDateTime;

  @doc("optional filters")
  filters?: DependencyMapServiceMapextensionsDependencyMapRequestFilters;

}

@doc("DependencyMap ServiceMap extensions ServerGroup Members Request")
model DependencyMapServiceMapextensionsServerGroupMembersRequest {
  @doc("port of server")
  serverPort?: int32;

  @doc("start time")
  startTime?: utcDateTime;

  @doc("end time")
  endTime?: utcDateTime;

  @doc("optional filters")
  filters?: DependencyMapServiceMapextensionsDependencyMapRequestFilters;

}

@doc("DependencyMap ServiceMapextensions Scope MapRequest")
model DependencyMapServiceMapextensionsScopeMapRequest {
  @doc("start time")
  startTime?: utcDateTime;

  @doc("end time")
  endTime?: utcDateTime;

  @doc("optional filters")
  filters?: DependencyMapServiceMapextensionsDependencyMapRequestFilters;
}

@doc("""
Defines class that represents input to enable or disable DMP on machine
      
      for cosmos entity operation.
""")
model UpdateMachineDepMapStatus {
  @doc("Gets or sets the machine collection.")
  @extension("x-ms-identifiers", [])
  machines?: UpdateMachineDepMapStatusDependencyMapMachineInput[];
}

@doc("Machine class.")
model UpdateMachineDepMapStatusDependencyMapMachineInput {
  @doc("Gets or sets the ARM id of the machine.")
  machineId?: string;

  @doc("""
Gets or sets a value indicating whether
            dependency mapping is to
be enabled or not.
""")
  isDependencyMapToBeEnabled?: boolean;
}

@doc("DependencyMap ServiceMap extensions ExportDependencies Request")
model DependencyMapServiceMapextensionsExportDependenciesRequest {
  @doc("start time")
  startTime?: utcDateTime;

  @doc("end time")
  endTime?: utcDateTime;
}

@doc("The body of export machine errors request.")
model VersionedV202001ExportMachineErrorsRequest {
  @doc("Gets or sets the properties.")
  //@extension("x-ms-client-flatten", true)
  properties?: VersionedV202001ExportMachineErrorsRequestExportMachineErrorsProperties;
}

@doc("The Properties class for export machine errors request body.")
model VersionedV202001ExportMachineErrorsRequestExportMachineErrorsProperties {
  @doc("Gets or sets the discovery scope.")
  discoveryScope?: VersionedV202001ExportMachineErrorsRequestExportMachineErrorsPropertiesDiscoveryScope;
}

@doc("ExportMachineErrorsProperties")
enum VersionedV202001ExportMachineErrorsRequestExportMachineErrorsPropertiesDiscoveryScopeKnownValues {
  "AppsAndRoles",
  "DependencyMap",
  "StaticData",
  "SQLServerConnectionInfo",
}

@knownValues(
  VersionedV202001ExportMachineErrorsRequestExportMachineErrorsPropertiesDiscoveryScopeKnownValues
)
@doc("Export Machine Errors Properties")
scalar VersionedV202001ExportMachineErrorsRequestExportMachineErrorsPropertiesDiscoveryScope
  extends string;

@doc("PrivateEndpointConnectionProperties")  
enum PrivateEndpointConnectionPropertiesV2ProvisioningStateKnownValues {
  "Accepted",
  "InProgress",
  "Succeeded",
  "Failed",
}

@knownValues(PrivateEndpointConnectionPropertiesV2ProvisioningStateKnownValues)
@doc(" PrivateEndpointConnection ProvisioningState")
scalar PrivateEndpointConnectionPropertiesV2ProvisioningState extends string;

@doc("PrivateLinkServiceConnectionState")
enum PrivateLinkServiceConnectionStateStatusKnownValues {
  "Approved",
  "Pending",
  "Rejected",
  "Disconnected",
}

@doc("PrivateLinkServiceConnectionState")
@knownValues(PrivateLinkServiceConnectionStateStatusKnownValues)
scalar PrivateLinkServiceConnectionStateStatus extends string;

@doc("Class for site properties.")
model MasterSiteProperties {
  @doc("Gets or sets the state of public network access.")
  publicNetworkAccess?: V202007MasterSitePropertiesPublicNetworkAccess;

  @doc("""
Gets or sets a value indicating whether multiple sites per site type are
allowed.
""")
  allowMultipleSites?: boolean;

  @doc("""
Gets or sets the sites that are a part of Master Site.
            The key
should contain the Site ARM name.
""")
  sites?: string[];

  @doc("Gets or sets a value for customer storage account ARM id.")
  customerStorageAccountArmId?: string;

  @doc("Gets the private endpoint connections.")
  @visibility("read")
  privateEndpointConnections?: PendpointConnection[];

  @doc("Gets the nested sites under Master Site.")
  @visibility("read")
  nestedSites?: string[];

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("REST model used to encapsulate the user visible state of a PrivateEndpoint.")
model PendpointConnection {
  @doc("Relative URL to get this Sites.")
  @visibility("read")
  id?: string;

  @doc("Gets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets the resource type.")
  @visibility("read")
  type?: string;

  @doc("Gets the tag for optimistic concurrency control.")
  @visibility("read")
  eTag?: string;

  @doc("Gets the properties of the object.")
  @visibility("read")
  //@extension("x-ms-client-flatten", true)
  properties?: PrivateEndpointConnectionPropertiesV2;
}

@doc("PrivateEndpointConnectionProperties V2")
model PrivateEndpointConnectionPropertiesV2 {
  @visibility("read")
  @doc("array of group ids")
  groupIds?: string[];

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("private endpoints")
  @visibility("read")
  privateEndpoint?: ResourceId;

  @doc("private endpoints connection state")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

@doc("PrivateEndpointModelsResourceId")
model ResourceId {
  @doc("id name")
  @visibility("read")
  id?: string;
}

@doc("Service Connection State")
model PrivateLinkServiceConnectionState {
  @doc("state status")
  status?: PrivateLinkServiceConnectionStateStatus;

  @doc("description string")
  description?: string;

  @doc("actions required")
  actionsRequired?: string;
}

@doc("PublicNetworkAccess")
enum V202007MasterSitePropertiesPublicNetworkAccess {
  "NotSpecified",
  "Enabled",
  "Disabled",
}

@doc("Private Endpoint Connection Proxy Request Body")
model MicrosoftAzureMigratePrivateEndpointBodyPrivateEndpointConnectionProxyRequestBody {
  
  @doc("Relative URL to get this resource.")
  @visibility("read")
  id?: string;

  @doc("Gets the name of the resource.")
  @visibility("read")
  name?: string;

  @doc("Gets the resource type.")
  @visibility("read")
  type?: string;

  @doc("private endpoint details")
  remotePrivateEndpoint?: PrivateEndpointDetails;
}

@doc("ARM async operation status response model.")
model IarmAsyncOperationStatus {
  @doc("""
  Gets the status of the operation. ARM expects the terminal status to be one
  of
              Succeeded/ Failed/ Canceled. All other values imply that the
  operation is still running.
  """)
  @visibility("read")
  status?: string;
}

@doc("priate endpoint details")
model PrivateEndpointDetails {
  @doc("idvalue")
  id?: string;

  @doc("PrivateLinkServiceConnection array")
  @extension("x-ms-identifiers", [])
  manualPrivateLinkServiceConnections?: PrivateLinkServiceConnection[];

  @doc("PrivateLinkServiceConnection array")
  @extension("x-ms-identifiers", [])
  privateLinkServiceConnections?: PrivateLinkServiceConnection[];
  @doc("PrivateLinkServiceProxy array")
  privateLinkServiceProxies?: PrivateLinkServiceProxy[];
  @doc("IpConfiguration array")
  connectionDetails?: IpConfiguration[];
}
@doc("private link service connection model")
model PrivateLinkServiceConnection {
  @doc("name value")
  name?: string;
  @doc("group ids")
  groupIds?: string[];
  @doc("request message")
  requestMessage?: string;
}

@doc("private link service proxy model")
model PrivateLinkServiceProxy {
  @doc("id value")
  id?: string;

  @extension("x-ms-identifiers", [])
  @doc("group connectivity information")
  groupConnectivityInformation?: GroupConnectivityInformation[];
  @doc("remote private endpoint connection")
  remotePrivateEndpointConnection?: ResourceId;
  @doc("remote private link service connection state")
  remotePrivateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

@doc("ip configuration model")
model IpConfiguration {
  @doc("id value")
  id?: string;
  @doc("private Ip Address")
  privateIpAddress?: string;
  @doc("link identifier")
  linkIdentifier?: string;
  @doc("group id")
  groupId?: string;
  @doc("member name")
  memberName?: string;
}

@doc("group connectivity information model")
model GroupConnectivityInformation {
  @doc("group id")
  groupId?: string;
  @doc("member name")
  memberName?: string;
  @doc("customer visible Fqdns array")
  customerVisibleFqdns?: string[];
  @doc("internal Fqdn")
  internalFqdn?: string;
  @doc("redirect Map Id")
  redirectMapId?: string;
  @doc("private link service Arm Region")
  privateLinkServiceArmRegion?: string;
}

@doc("private link resource properties model")
model PrivateLinkResourceProperties {
  @doc("required members")
  requiredMembers?: string[];
  @doc("required zone names")
  requiredZoneNames?: string[];
  @doc("group id")
  groupId?: string;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Discovery Scope.")
enum DiscoveryScopeStatus {
  "DiscoverySucceededAtleastOnce",
  "DiscoveryFailed",
  "RunAsAccountNotAssociated",
  "DiscoveryNotStarted",
  "DiscoveryInProgress",
  "Disabled",
  "DiscoveryPartiallySucceded",
  "DiscoverySucceeded",
}

@doc("Error contract returned when some exception occurs in Rest API.")
model ErrorDetails {
  @doc("Gets the error code.")
  @visibility("read")
  code?: string;

  @doc("Gets the error message.")
  @visibility("read")
  message?: string;

  @doc("Gets the possible causes of error.")
  @visibility("read")
  possibleCauses?: string;

  @doc("Gets the recommended action to resolve error.")
  @visibility("read")
  recommendedAction?: string;

  @doc("Gets the error severity.")
  @visibility("read")
  severity?: string;

  @doc("Gets a value indicating whether the error originated from a agent or not.")
  @visibility("read")
  isAgentReportedError?: boolean;

  @doc("Gets the agent error code.")
  @visibility("read")
  agentErrorCode?: string;

  @doc("Gets the error message from the agent.")
  @visibility("read")
  agentErrorMessage?: string;

  @doc("Gets possible causes for the agent error.")
  @visibility("read")
  agentErrorPossibleCauses?: string;

  @doc("Gets the recommended action for the agent error.")
  @visibility("read")
  agentErrorRecommendedAction?: string;
}
@doc("The list of Machine MetaData.")
model MachineMetadataList {
  @extension("x-ms-identifiers", [])
  @extension("x-ms-identifiers", [])
  @doc("The list of Machine MetaData.")
  value: MachineMetadata[];
}

@doc("The properties of Machine MetaData")
model MachineMetadata {
  @doc("arm id of the machine.")
  machineArmId: string;
  @doc("value representing state of dependency mapping (enabled/disabled).")
  dependencyMapping: string;

  @doc("machine tags")
  tags: Record<string>;
}

@doc("The status of the current operation.")
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
  InProgress,
}

@doc("Error contract returned when some exception occurs in Rest API.")
model SiteHealthErrorDetails {
  @doc("Gets the error message.")
  @visibility("read")
  message?: string;

  @doc("Gets the message parameters.")
  @visibility("read")
  messageParameters?: Record<string>;

  @doc("Gets the appliance name.")
  @visibility("read")
  applianceName?: string;

  @doc("Gets the error ID.")
  @visibility("read")
  id?: int32;

  @doc("Gets the error name.")
  @visibility("read")
  code?: string;

  @doc("Gets the possible causes of error.")
  @visibility("read")
  possibleCauses?: string;

  @doc("Gets the recommended action to resolve error.")
  @visibility("read")
  recommendedAction?: string;

  @doc("Gets the error severity.")
  @visibility("read")
  severity?: string;

  @doc("Gets the error summary message.")
  @visibility("read")
  summaryMessage?: string;

  @doc("Gets the error source.")
  @visibility("read")
  source?: HealthErrorDetailsSource;

  @doc("Gets the time stamp when the error was updated.")
  @visibility("read")
  updatedTimeStamp?: utcDateTime;

  @doc("Gets run as account id used while performing discovery             of entity.")
  @visibility("read")
  runAsAccountId?: string;

  @doc("Gets discovery scope for which             error is encountered.")
  @visibility("read")
  discoveryScope?: HealthErrorDetailsDiscoveryScope;
}

@doc("Collection of SiteHealthSummary.")
model SiteHealthSummaryCollection {
  @doc("Gets the list of SiteHealthSummary.")
  @visibility("read")
  @extension("x-ms-identifiers", ["applianceName"])
  value?: SiteHealthSummary[];

  @doc("Gets the value of next link.")
  @visibility("read")
  nextLink?: string;
}

@doc("LayoutUpdate Sources")
enum LayoutUpdateSources {
  "RefreshFabricLayout",
  "RefreshFabricLayoutGuest",
  "RefreshFabricLayoutDependencyMap",
}

@doc("The properties of ServerSiteResource.")
model SiteHealthSummary {
  @doc("Gets the appliance name.")
  @visibility("read")
  applianceName?: string;

  @doc("Gets the error message.")
  @visibility("read")
  errorMessage?: string;

  @doc("Gets the summary message.")
  @visibility("read")
  summaryMessage?: string;

  @doc("Gets the error Id.")
  @visibility("read")
  errorId?: int64;

  @doc("Gets the error code.")
  @visibility("read")
  errorCode?: string;

  @doc("Gets or sets the count of affected objects.")
  affectedObjectsCount?: int64;

  @doc("Gets or sets the hit count of the error.")
  hitCount?: int64;

  @doc("Gets the severity of error.")
  @visibility("read")
  severity?: string;

  @doc("Gets the remediation guidance.")
  @visibility("read")
  remediationGuidance?: string;

  @doc("Gets the affected resource type.")
  @visibility("read")
  affectedResourceType?: string;

  @doc("Gets or sets the affected resources.")
  affectedResources?: string[];

  @doc("Gets or sets sources of the exception.")
  fabricLayoutUpdateSources?: SiteHealthSummaryFabricLayoutUpdateSourcesItem[];
}

@doc("SiteHealthSummary FabricLayout UpdateSources")
enum SiteHealthSummaryFabricLayoutUpdateSourcesItemKnownValues {
  "RefreshFabricLayout",
  "RefreshFabricLayoutGuest",
  "RefreshFabricLayoutDependencyMap",
}

@doc("SiteHealthSummary FabricLayout UpdateSources")
scalar SiteHealthSummaryFabricLayoutUpdateSourcesItem extends string;

@doc("Class for site properties.")
model SiteSpnProperties {
  @doc("""
Gets or sets the tenant Id for the service principal with which the
on-premise
            management/data plane components would communicate with
our Azure services.
""")
  tenantId?: string;

  @doc("""
Gets or sets the application/client Id for the service principal with which
the
            on-premise management/data plane components would communicate
with our Azure 
            services.
""")
  applicationId?: string;

  @doc("""
Gets or sets the object Id of the service principal with which the on-premise

           management/data plane components would communicate with our Azure
services.
""")
  objectId?: string;

  @doc("Gets or sets the intended audience for the service principal.")
  audience?: string;

  @doc("""
Gets or sets the AAD Authority URL which was used to request the token for
the
            service principal.
""")
  aadAuthority?: string;

  @doc("Gets or sets the raw certificate data for building certificate expiry flows.")
  rawCertData?: string;
}

@doc("Hyper-V site usage.")
model SiteUsageResponse {
  @doc("Gets or sets the number of machines discovered in the site.")
  machineCount: int32;

  @doc("Gets or sets the number of run as accounts in the site.")
  runAsAccountCount: int32;

  @doc("Gets or sets the number of hosts part of the site.")
  hostCount: int32;

  @doc("Gets or sets the number of clusters part of the site.")
  clusterCount: int32;

  // @doc("The status of the last operation.")
  // provisioningState?: ProvisioningState;
  // @doc("The status of the last operation.")
  // provisioningState?: ProvisioningState;
}
@doc("Nonce Request REST Resource.")
model NonceRequest {
  @doc("Gets or sets the Appliance Name.")
  applianceName?: string;
}

@doc("ErrorSummaryRequest body")
model ErrorSummaryRequest {
  @doc("Gets or sets the Appliance Name.")
  applianceName?: string;
}

@doc("ExportSqlServerRequest body")
model ExportSqlServersRequest {
  @doc("Gets or sets the Appliance Name.")
  applianceName?: string;

  @doc("filter options.")
  filter?: string;
}

@doc("ExportWebAppsRequest body")
model ExportWebAppsRequest {
  @doc("filter options.")
  filter?: string;
}

@doc("ExportMachinesRequest body")
model ExportMachinesRequest {
  @doc("filter options.")
  filter?: string;
}

@doc("AgentManifestNonce REST Resource.")
model ApplianceNonce {
  @doc("Gets or sets the nested properties.")
  //@extension("x-ms-client-flatten", true)
  properties?: ApplianceNonceValueProperties;
}

@doc("Class for nonce properties.")
model ApplianceNonceValueProperties {
  @doc("Gets or sets the value of nonce appended with Master Site Id.")
  appendedNonce?: string;
}

@doc("SQL site web model.")
model SqlSite {
  @doc("ARM type name.")
  @visibility("read")
  type?: string;

  @doc("Gets the relative URL to get this Site.")
  @visibility("read")
  id?: string;

  @doc("Gets or sets the nested properties.")
  properties?: SqlSiteProperties;

  @doc("Gets or sets the name of the site.")
  name?: string;

  @doc("Gets or sets the eTag for concurrency control.")
  eTag?: string;

  @doc("Gets or sets the Azure location in which Sites is created.")
  @visibility("read", "create")
  location?: string;
}

@doc("Class for SQL site properties.")
model SqlSiteProperties {
  @doc("""
Gets or sets the appliance details used by service to communicate
           
to the appliance.
""")
  @extension("x-ms-identifiers", [])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  @doc("Gets or sets the discovery scenario.")
  discoveryScenario?: SqlSitePropertiesDiscoveryScenario;

  @doc("Gets the service endpoint.")
  @visibility("read")
  serviceEndpoint?: string;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("SqlSiteProperties DiscoveryScenario")
enum SqlSitePropertiesDiscoveryScenarioKnownValues {
  "Migrate",
  "DR",
}
@doc("SqlSiteProperties DiscoveryScenario")
scalar SqlSitePropertiesDiscoveryScenario extends string;

@doc("Class for site appliance properties.")
model SiteApplianceProperties {
  @doc(" Gets or sets the service principal identity details used by agent for  communication              to the service.  ")
  servicePrincipalIdentityDetails?: SiteSpnProperties;

  @doc("Gets or sets the on-premises agent details.")
  agentDetails?: SiteAgentProperties;

  @doc("Gets or sets the Appliance Name.")
  applianceName?: string;
}

@doc("SQL site usage.")
model SqlSiteUsage {
  @doc("Gets or sets the number of servers discovered in the site.")
  serverCount?: int32;

  @doc("Gets or sets the number of databases discovered in the site.")
  databaseCount?: int32;

  @doc("Gets or sets the number of run as accounts in the site.")
  runAsAccountCount?: int32;
}

@doc("SQL site refresh.")
model SqlSiteRefreshBody {
  @doc("Gets or sets the appliance name of the agent in the site.")
  applianceName?: string;
}

@doc("Class for SQL Server availability group properties.")
model SqlAvailabilityGroupProperties {
  @doc("Gets or sets the SQL Availability Group Name.")
  availabilityGroupName?: string;

  @doc("Gets or sets the type of availability group.             Currently there are two types of AGs Traditional and Distributed. ")
  availabilityGroupType?: SqlAvailabilityGroupPropertiesAvailabilityGroupType;

  @doc("Gets or sets a value indicating whether AG is multi subnet or not.")
  isMultiSubNet?: boolean;

  @doc("Gets or sets the Cluster name where AG is hosted.")
  clusterName?: string;

  @doc("Gets the list of availability replica properties which together forms this availability group.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  availabilityReplicas?: SqlAvailabilityGroupSqlAvailabilityReplicaProperties[];

  @doc("""
Gets the parent availability replica overview if any.
            This would be
set with details of parent AG and AR for cases where this availability group is
a part of a distributed AG.
            Currently, we do not populate this
since discovery and linking of DAG(Distributed Availability Group) is not
implemented.
""")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  parentReplicaOverviewList?: SqlAvailabilityReplicaOverview[];

  @doc("""
Gets or sets a value indicating whether this Availability group is part of a
distributed AG.
""")
  isPartOfDistributedAvailabilityGroup?: boolean;

  @doc("Gets or sets a value indicating whether the entity is deleted.")
  isDeleted?: boolean;

  @doc("Gets or sets the marking machine creation.")
  createdTimestamp?: string;

  @doc("Gets or sets the timestamp marking last updated on the machine.")
  updatedTimestamp?: string;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("AvailabilityGroupType")
enum SqlAvailabilityGroupPropertiesAvailabilityGroupType {
  "Unknown",
  "Traditional",
  "Distributed",
}

@doc("SqlAvailabilityGroup AvailabilityGroupType")
scalar SqlAvailabilityGroupSqlAvailabilityGroupPropertiesAvailabilityGroupType
  extends string;

@doc("Class for SQL Server availability replica properties.")
model SqlAvailabilityGroupSqlAvailabilityReplicaProperties {
  @doc("Gets or sets the SQL Availability Replica Name.")
  availabilityReplicaName?: string;

  @doc("Gets or sets the SQL Availability Replica Id.")
  availabilityReplicaId?: string;

  @doc("Gets or sets the replica type of the availability group.")
  replicaType?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaType;

  @doc("Gets or sets the state of the availability replica.")
  replicaState?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaState;

  @doc("Gets or sets the synchronization status of the replica.")
  replicaSyncStatus?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSyncStatus;

  @doc("Gets or sets the commit mode of the replica.")
  replicaCommitMode?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaCommitMode;

  @doc("Gets or sets the read mode of the replica.")
  replicaReadMode?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaReadMode;

  @doc("Gets or sets the seed mode of the replica.")
  replicaSeedMode?: SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSeedMode;

  @doc("""
Gets or sets the Availability Replica object if Replica is of type database.
This is null in case Replica is
            of type AG. This is to be populated
in case of normal AG.
""")
  sqlDatabaseReplicaInfo?: SqlAvailabilityGroupSqlDatabaseReplicaInfo;

  @doc("""
Gets or sets the Availability Replica object if Replica is of type AG. This is
null in case Replica is
            of type database. This is to be populated
in case AG is of type DAG.
""")
  sqlAvailabilityGroupReplicaInfo?: SqlAvailabilityGroupReplicaInfo;
}

@doc("ReplicaType")
enum SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaTypeKnownValues {
  "Unknown",
  "DatabaseReplica",
  "AvailabilityGroupReplica",
}

@doc("SqlAvailabilityGroup ReplicaType")
scalar SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaType
  extends string;

@doc("ReplicaState")
enum SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaStateKnownValues {
  "Unknown",
  "Primary",
  "Secondary",
}
@doc("ReplicaState")
scalar SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaState
  extends string;

@doc("ReplicaSyncStatus")  
enum SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSyncStatusKnownValues {
  "Unknown",
  "Synchronized",
  "Unsynchronized",
}
@doc("ReplicaSyncStatus")  
scalar SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSyncStatus
  extends string;

@doc("ReplicaCommitMode")  
enum SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaCommitModeKnownValues {
  "Unknown",
  "Synchronous",
  "Asynchronous",
}

@doc("ReplicaCommitMode")  
scalar SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaCommitMode
  extends string;

@doc("ReplicaReadMode")
enum SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaReadModeKnownValues {
  "Unknown",
  "None",
  "ReadOnly",
  "ReadWrite",
}

@doc("SqlAvailabilityGroup ReplicaReadMode")
scalar SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaReadMode
  extends string;

@doc("ReplicaSeedMode")
enum SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSeedModeKnownValues {
  "Unknown",
  "Manual",
  "Automatic",
}
@doc("ReplicaSeedMode")
scalar SqlAvailabilityGroupSqlAvailabilityReplicaPropertiesReplicaSeedMode
  extends string;

@doc("""
        Class which represents the SQL availability replica properties of type
        databases.
        """)
model SqlAvailabilityGroupSqlDatabaseReplicaInfo {
  @doc("Gets or sets the host name of the availability replica.")
  hostName?: string;

  @doc("Gets or sets the SQL Server name of the availability replica.")
  sqlServerName?: string;

  @doc("Gets or sets the SQL Server name of the availability replica.")
  sqlServerArmId?: string;
}

@doc("Class which represents the SQL availability replica properties of type AG.")
model SqlAvailabilityGroupReplicaInfo {
  @doc("Gets or sets the name of the cluster on which this replica is hosted.")
  clusterName?: string;

  @doc("Gets or sets the name of the availability replica.")
  availabilityGroupName?: string;

  @doc("Gets or sets the AG ARM ID which are part of this Replica.")
  availabilityGroupArmId?: string;
}

@doc("Web model for SQL replica overview.")
model SqlAvailabilityReplicaOverview {
  @doc("Gets or sets the state of the availability replica.")
  replicaState?: SqlAvailabilityReplicaOverviewReplicaState;

  @doc("""
Gets or sets the SQL Availability Replica Id within the Availability Group this
database is a part of.
""")
  availabilityReplicaId?: string;

  @doc("""
Gets or sets the Availability Group Id in which this database participates if
any. It would be set if the database has
{Microsoft.Azure.FDS.CosmosDB.SqlDatabaseEntity.IsDatabaseHighlyAvailable} has
a value \"true\".
""")
  availabilityGroupArmId?: string;

  @doc("Gets or sets the SQL Availability group name.")
  availabilityGroupName?: string;
}

@doc("Overview Replica State")
enum SqlAvailabilityReplicaOverviewReplicaStateKnownValues {
  "Unknown",
  "Primary",
  "Secondary",
}

@doc("SqlAvailabilityReplica State")
scalar SqlAvailabilityReplicaOverviewReplicaState extends string;

@doc("Class for Web app site properties.")
model WebAppSiteProperties {
  @doc("""
Gets or sets the appliance details used by service to communicate
           
to the appliance.
""")
  @extension("x-ms-identifiers", [])
  siteAppliancePropertiesCollection?: SiteApplianceProperties[];

  @doc("Gets or sets the discovery scenario.")
  discoveryScenario?: WebAppSitePropertiesDiscoveryScenario;

  @doc("Gets the service endpoint.")
  @visibility("read")
  serviceEndpoint?: string;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Discovery Scenario")
enum WebAppSitePropertiesDiscoveryScenarioKnownValues {
  "Migrate",
  "DR",
}

@doc("WebAppSite DiscoveryScenario")
scalar WebAppSitePropertiesDiscoveryScenario extends string;

@doc("Web app site usage.")
model WebAppSiteUsage {
  @doc("Gets or sets the number of web servers discovered in the site.")
  webServerCount?: int32;

  @doc("Gets or sets the number of web applications discovered in the site.")
  webApplicationCount?: int32;

  @doc("Gets or sets the number of run as accounts in the site.")
  runAsAccountCount?: int32;
}

@doc("Request body for Proxy site refresh action.")
model ProxySiteRefreshBody {
  @doc("Gets or sets the appliance name of the agent in the site.")
  applianceName?: string;
}

@doc("Class for web application properties.")
model IisWebApplicationProperties {
  @doc("Gets the list of application units for the web site.")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  applications?: IisApplicationUnit[];

  @extension("x-ms-identifiers", [])
  @doc("Gets the list of application units for the web site.")
  @visibility("read")
  virtualApplications?: IisVirtualApplicationUnit[];

  @doc("Gets the web server id.")
  @visibility("read")
  webServerId?: string;

  @doc("Gets the web server name.")
  @visibility("read")
  webServerName?: string;

  @doc("Gets the virtual path of the application.")
  @visibility("read")
  virtualPath?: string;

  @doc("Gets the physical path of the application.")
  @visibility("read")
  physicalPath?: string;

  @extension("x-ms-identifiers", [])
  @doc("Gets the front end bindings for the application.")
  @visibility("read")
  bindings?: FrontEndBinding[];

  @extension("x-ms-identifiers", [])
  @doc("Gets the Error details.")
  @visibility("read")
  frameworks?: WebApplicationFramework[];

  @extension("x-ms-identifiers", [])
  @doc("Gets the configuration.")
  @visibility("read")
  configurations?: WebApplicationConfigurationUnit[];

  @extension("x-ms-identifiers", [])
  @doc("Gets the directories.")
  @visibility("read")
  directories?: WebApplicationDirectoryUnit[];

  @doc("Gets the display name.")
  @visibility("read")
  displayName?: string;

  
  @doc("Gets or sets tags on the resource.")
  tags?: Record<Object>;

  @doc("Gets a value indicating whether application is deleted.")
  @visibility("read")
  isDeleted?: boolean;

  @doc("Gets the timestamp marking creation of the entity.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Gets the timestamp marking last update operation.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Gets the server type.")
  @visibility("read")
  serverType?: string;

  @doc("Gets the Error details.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("Gets the appliance names.")
  @visibility("read")
  applianceNames?: string[];

  @doc("Gets a value indicating whether the WebApp has errors or not.")
  @visibility("read")
  hasErrors?: boolean;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("""
Second-level object for identification of application units in a web site
hosted on IIS.
""")
model IisApplicationUnit {
  @doc("Gets or sets the path of the directory.")
  applicationPoolName?: string;

  @doc("Gets or sets the managed pipeline mode.")
  managedPipelineMode?: string;

  @doc("Gets or sets the runtime version.")
  runtimeVersion?: string;

  @doc("""
Gets or sets a value indicating whether 32 bit applications are allowed to run
on 64 bit.
""")
  enable32BitApiOnWin64?: boolean;

  @doc("Gets or sets the path of the directory.")
  path?: DirectoryPath;

  @extension("x-ms-identifiers", [])
  @doc("Gets or sets the list of directories.")
  directories?: DirectoryPath[];
}

@doc("Second level entity for virtual directories.")
model DirectoryPath {
  @doc("Gets or sets the virtual path for the directory.")
  virtual?: string;

  @doc("Gets or sets the physical path of the directory on the web server.")
  physical?: string;
}

@doc("""
Second-level object for identification of virtual applications in a web site
hosted on IIS.
""")
model IisVirtualApplicationUnit {
  @doc("Gets a value indicating whether the application corresponds to a directory.")
  @visibility("read")
  isVirtualDirectory?: boolean;

  @doc("Gets or sets the path of the directory.")
  path?: DirectoryPath;

  @extension("x-ms-identifiers", [])
  @doc("Gets or sets the list of directories.")
  directories?: DirectoryPath[];
}

@doc("Frontend bindings for a web application.")
model FrontEndBinding {
  @doc("Gets or sets the Binding protocol.")
  protocol?: string;

  @doc("Gets or sets the Host name.")
  hostName?: string;

  @doc("Gets or sets the Port number.")
  port?: string;

  @doc("Gets or sets the IP Address.")
  ipAddress?: string;
}
@doc("Framework specific data for a web application.")
model WebApplicationFramework {
  @doc("Gets or sets Name of the framework.")
  name?: string;

  @doc("Gets or sets Version of the framework.")
  version?: string;
}

@doc("Web Application configuration unit.")
model WebApplicationConfigurationUnit {
  @doc("Gets or sets the configuration name.")
  name?: string;

  @doc("Gets or sets the configuration file path.")
  filePath?: string;

  @doc("Gets or sets the configuration local file path.")
  localFilePath?: string;

  @doc("Gets or sets the configuration target file path.")
  targetFilePath?: string;

  @doc("Gets or sets the configuration section in the file.")
  section?: string;

  @doc("Gets or sets the configuration type.")
  type?: string;

  @doc("""
Gets or sets a value indicating whether the configuration is edited or not by
the user.
""")
  isDeploymentTimeEditable?: boolean;

  @doc("Gets or sets the identifier for the configuration.")
  identifier?: string;
}

@doc("Web Application directory unit.")
model WebApplicationDirectoryUnit {
  @doc("Gets or sets the unique id corresponding to the application directory.")
  id?: string;

  @doc("""
Gets or sets a value indicating whether the directory object is editable.
     
      True when the directory is added as an optional directory, false when
discovery is done
            manually.
""")
  isEditable?: boolean;

  @doc("Gets or sets the paths of the directory on the source machine.")
  sourcePaths?: string[];

  @doc("Gets or sets the local scratch path at which the directories has been copied.")
  localScratchPath?: string;

  @doc("Gets or sets the mount path of the application directory.")
  mountPath?: string;

  @doc("Gets or sets the size of the directory on the source machine.")
  sourceSize?: string;
}

@doc("Class for web server properties.")
model IisWebServerProperties {
  @doc("Gets the configuration location.")
  @visibility("read")
  configurationLocation?: string;

  @doc("Gets the configuration location.")
  @visibility("read")
  version?: string;

  @doc("Gets the list of machines.")
  @visibility("read")
  machineIds?: string[];

  @doc("Gets the list of web applications.")
  @visibility("read")
  webApplications?: string[];

  @doc("Gets the display name.")
  @visibility("read")
  displayName?: string;

  @doc("Gets the server FQDN.")
  @visibility("read")
  serverFqdn?: string;

  @doc("Gets the run as account id.")
  @visibility("read")
  runAsAccountId?: string;

  @doc("Gets a value indicating whether application is deleted.")
  @visibility("read")
  isDeleted?: boolean;

  @doc("Gets the timestamp marking creation of the entity.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Gets the timestamp marking last update operation.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Gets the server type.")
  @visibility("read")
  serverType?: string;

  @doc("Gets the Error details.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("Gets the appliance names.")
  @visibility("read")
  applianceNames?: string[];

  @doc("Gets a value indicating whether the WebApp has errors or not.")
  @visibility("read")
  hasErrors?: boolean;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Class for web application properties.")
model TomcatWebApplicationProperties {
  @doc("Gets the web server id.")
  @visibility("read")
  webServerId?: string;

  @doc("Gets the web server name.")
  @visibility("read")
  webServerName?: string;

  @doc("Gets the virtual path of the application.")
  @visibility("read")
  virtualPath?: string;

  @doc("Gets the physical path of the application.")
  @visibility("read")
  physicalPath?: string;

  @doc("Gets the front end bindings for the application.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  bindings?: FrontEndBinding[];

  @doc("Gets the Error details.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  frameworks?: WebApplicationFramework[];

  @doc("Gets the configuration.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  configurations?: WebApplicationConfigurationUnit[];

  @doc("Gets the directories.")
  @visibility("read")
  directories?: WebApplicationDirectoryUnit[];

  @doc("Gets the display name.")
  @visibility("read")
  displayName?: string;

  @doc("Gets tags that can be used with ODATA.")
  @visibility("read")
  tags?: Record<Object>;

  @doc("Gets a value indicating whether application is deleted.")
  @visibility("read")
  isDeleted?: boolean;

  @doc("Gets the timestamp marking creation of the entity.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Gets the timestamp marking last update operation.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Gets the server type.")
  @visibility("read")
  serverType?: string;

  @doc("Gets the Error details.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("Gets the appliance names.")
  @visibility("read")
  applianceNames?: string[];

  @doc("Gets a value indicating whether the WebApp has errors or not.")
  @visibility("read")
  hasErrors?: boolean;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Class for web server properties.")
model TomcatWebServerProperties {
  @doc("Gets or sets the services defined in the server.")
  @extension("x-ms-identifiers", [])
  services?: TomcatServiceUnit[];

  @doc("Gets the configuration location.")
  @visibility("read")
  configurationLocation?: string;

  @doc("Gets the configuration location.")
  @visibility("read")
  version?: string;

  @doc("Gets the list of machines.")
  @visibility("read")
  machineIds?: string[];

  @doc("Gets the list of web applications.")
  @visibility("read")
  webApplications?: string[];

  @doc("Gets the display name.")
  @visibility("read")
  displayName?: string;

  @doc("Gets the server FQDN.")
  @visibility("read")
  serverFqdn?: string;

  @doc("Gets the run as account id.")
  @visibility("read")
  runAsAccountId?: string;

  @doc("Gets a value indicating whether application is deleted.")
  @visibility("read")
  isDeleted?: boolean;

  @doc("Gets the timestamp marking creation of the entity.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Gets the timestamp marking last update operation.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Gets the server type.")
  @visibility("read")
  serverType?: string;

  @doc("Gets the Error details.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("Gets the appliance names.")
  @visibility("read")
  applianceNames?: string[];

  @doc("Gets a value indicating whether the WebApp has errors or not.")
  @visibility("read")
  hasErrors?: boolean;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Tomcat service data.")
model TomcatServiceUnit {
  @doc("Gets or sets the name of the service.")
  name?: string;

  @extension("x-ms-identifiers", [])
  @doc("Gets or sets the connectors defined for the service component.")
  connectors?: ConnectorUnit[];

  @doc("Gets or sets the engine defined for the service component.")
  engine?: TomcatEngineUnit;
}

@doc("The connectors of the web server.")
model ConnectorUnit {
  @extension("x-ms-identifiers", [])
  @doc("Gets or sets the bindings for the connector.")
  bindings?: FrontEndBinding[];
}

@doc("Tomcat engine data.")
model TomcatEngineUnit {
  @doc("Gets or sets the name of the engine.")
  name?: string;

  @doc("Gets or sets the hosts defined for the engine.")
  @extension("x-ms-identifiers", [])
  hosts?: TomcatHostUnit[];
}

@doc("Tomcat host data.")
model TomcatHostUnit {
  @doc("Gets or sets the name of the host.")
  name?: string;

  @doc("Gets or sets the app base path for the host.")
  appBasePath?: string;

  @doc("Gets or sets the app base value configured for the host.")
  appBase?: string;
}

@doc("Discovery site data source properties class.")
model DiscoverySiteDataSourceProperties {
  @doc("Gets or sets the discovery site Id.")
  discoverySiteId?: string;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Class for web extended machine properties.")
model WebAppExtendedMachineProperties {
  @doc("Gets a value indicating whether application is deleted.")
  @visibility("read")
  isDeleted?: boolean;

  @doc("Gets the timestamp marking creation of the entity.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Gets the timestamp marking last update operation.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Gets the Error details.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("Gets the hydrated host name.")
  @visibility("read")
  hostName?: string;

  @doc("Gets the Name of the extended machine.")
  @visibility("read")
  machineDisplayName?: string;

  @doc("Gets the machine ARM id.")
  @visibility("read")
  machineId?: string;

  @doc("Gets the run as account ID of the machine used for web app discovery.")
  @visibility("read")
  runAsAccountId?: string;

  @doc("Gets the agent hydrated run as account.")
  @visibility("read")
  hydratedRunAsAccountId?: string;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Class for web application properties.")
model WebRoleV202011PreviewWebApplicationProperties {
  @doc("Gets the web server id.")
  @visibility("read")
  webServerId?: string;

  @doc("Gets the web server name.")
  @visibility("read")
  webServerName?: string;

  @doc("Gets the virtual path of the application.")
  @visibility("read")
  virtualPath?: string;

  @doc("Gets the physical path of the application.")
  @visibility("read")
  physicalPath?: string;

  @doc("Gets the front end bindings for the application.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  bindings?: FrontEndBinding[];

  @doc("Gets the Error details.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  frameworks?: WebApplicationFramework[];

  @doc("Gets the configuration.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  configurations?: WebApplicationConfigurationUnit[];

  @doc("Gets the directories.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  directories?: WebApplicationDirectoryUnit[];

  @doc("Gets the display name.")
  @visibility("read")
  displayName?: string;

  @doc("Gets tags that can be used with ODATA.")
  @visibility("read")
  tags?: Record<Object>;

  @doc("Gets a value indicating whether application is deleted.")
  @visibility("read")
  isDeleted?: boolean;

  @doc("Gets the timestamp marking creation of the entity.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Gets the timestamp marking last update operation.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Gets the server type.")
  @visibility("read")
  serverType?: string;

  @doc("Gets the Error details.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("Gets the appliance names.")
  @visibility("read")
  applianceNames?: string[];

  @doc("Gets a value indicating whether the WebApp has errors or not.")
  @visibility("read")
  hasErrors?: boolean;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Class for run as account properties.")
model RunAsAccountProperties {
  @doc("Display name of the run as account.")
  @visibility("read")
  displayName?: string;

  @doc("Gets the credential type of the run as account.")
  @visibility("read")
  credentialType?: string;

  @doc("Timestamp marking run as account creation.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Timestamp marking last updated on the run as account.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Gets the appliance name of the run as account.")
  @visibility("read")
  applianceName?: string;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Class for web server properties.")
model WebServerProperties {
  @doc("Gets the configuration location.")
  @visibility("read")
  configurationLocation?: string;

  @doc("Gets the configuration location.")
  @visibility("read")
  version?: string;

  @doc("Gets the list of machines.")
  @visibility("read")
  machineIds?: string[];

  @doc("Gets the list of web applications.")
  @visibility("read")
  webApplications?: string[];

  @doc("Gets the display name.")
  @visibility("read")
  displayName?: string;

  @doc("Gets the server FQDN.")
  @visibility("read")
  serverFqdn?: string;

  @doc("Gets the run as account id.")
  @visibility("read")
  runAsAccountId?: string;

  @doc("Gets a value indicating whether application is deleted.")
  @visibility("read")
  isDeleted?: boolean;

  @doc("Gets the timestamp marking creation of the entity.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Gets the timestamp marking last update operation.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Gets the server type.")
  @visibility("read")
  serverType?: string;

  @doc("Gets the Error details.")
  @visibility("read")
  errors?: HealthErrorDetails[];

  @doc("Gets the appliance names.")
  @visibility("read")
  applianceNames?: string[];

  @doc("Gets a value indicating whether the WebApp has errors or not.")
  @visibility("read")
  hasErrors?: boolean;

  @doc("provisioning state enum")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
@doc("Collection of web app properties.")
model WebAppPropertiesCollection {
  @doc("Gets or sets the list of web app properties.")
  @extension("x-ms-identifiers", [])
  webApps?: WebAppProperties[];
}
@doc("Class representing web app properties web model.")
model WebAppProperties {
  @doc("Gets or sets the arm id of the web app.")
  webAppArmId?: string;

  @doc("Gets or sets Tags.")
  tags?: Record<Object>;
}

@doc("Processor Information.")
model ProcessorInfo {
  @doc("Gets or sets the name\\model of a processor.")
  name?: string;

  @doc("Gets or sets the number of sockets.")
  numberOfSockets?: int32;

  @doc("Gets or sets the total number of cores in a socket.")
  numberOfCoresPerSocket?: int32;
}

@doc("HyperV VM software inventory REST resource.")
model HypervVmSoftwareInventory {
  @doc("Gets the relative URL to get this VMWare machine.")
  @visibility("read")
  id?: string;

  @doc("Handled by resource provider.")
  @visibility("read")
  type?: string;

  @doc("Gets the Name of the machine.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets software inventory properties.")
  //@extension("x-ms-client-flatten", true)
  properties?: MachineSoftwareInventoryProperties;
}

@doc("Class for machine software inventory properties.")
model MachineSoftwareInventoryProperties {
  @doc("Apps And Roles of the machine entity.")
  @visibility("read")
  appsAndRoles?: AppsAndRoles;
}

@doc("AppsAndRoles in the guest virtual machine.")
model AppsAndRoles {
  @doc("Gets or sets Applications of the AppsAndRoles.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  applications?: Application[];

  @doc("Gets or sets WebApplications of the AppsAndRoles.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  webApplications?: WebApplicationAppsAndRolesModel[];

  @doc("Gets or sets Features of the AppsAndRoles.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  features?: Feature[];

  @doc("Gets or sets SQLServers of the AppsAndRoles.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  sqlServers?: SqlServerApplication[];

  @doc("Gets or sets SharePointServers of the AppsAndRoles.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  sharePointServers?: SharePointServer[];

  @doc("Gets or sets SystemCenters of the AppsAndRoles.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  systemCenters?: SystemCenter[];

  @doc("Gets or sets BizTalkServers of the AppsAndRoles.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  bizTalkServers?: BizTalkServer[];

  @doc("Gets or sets ExchangeServers of the AppsAndRoles.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  exchangeServers?: ExchangeServer[];

  @doc("Gets or sets OtherDatabaseServers of the AppsAndRoles.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  otherDatabases?: OtherDatabase[];
}

@doc("SystemCenter in the guest virtual machine.")
model SystemCenter {
  @doc("Gets or sets ProductName of the SystemCenter.")
  @visibility("read")
  productName?: string;

  @doc("Gets or sets Status of the SystemCenter.")
  @visibility("read")
  status?: string;

  @doc("Gets or sets Version of the SystemCenter.")
  @visibility("read")
  version?: string;
}

@doc("BizTalkServer in the guest virtual machine.")
model BizTalkServer {
  @doc("Gets or sets ProductName of the BizTalkServer.")
  @visibility("read")
  productName?: string;

  @doc("Gets or sets Status of the BizTalkServer.")
  @visibility("read")
  status?: string;
}

@doc("ExchangeServer in the guest virtual machine.")
model ExchangeServer {
  @doc("Gets or sets ProductName of the ExchangeServer.")
  @visibility("read")
  productName?: string;

  @doc("Gets or sets Edition of the ExchangeServer.")
  @visibility("read")
  edition?: string;

  @doc("Gets or sets Roles of the ExchangeServer.")
  @visibility("read")
  roles?: string;

  @doc("Gets or sets ServicePack of the ExchangeServer.")
  @visibility("read")
  servicePack?: string;

  @doc("Gets or sets Version of the ExchangeServer.")
  @visibility("read")
  version?: string;
}

@doc("SharePointServer in the guest virtual machine.")
model SharePointServer {
  @doc("Gets or sets ProductName of the SharePointServer.")
  @visibility("read")
  productName?: string;

  @doc("Gets or sets a value indicating whether the SharePointServer is Enterprise.")
  @visibility("read")
  isEnterprise?: boolean;

  @doc("Gets or sets Status of the SharePointServer.")
  @visibility("read")
  status?: string;

  @doc("Gets or sets Version of the SharePointServer.")
  @visibility("read")
  version?: string;
}

@doc("WebApplication in the guest virtual machine.")
model WebApplicationAppsAndRolesModel {
  @doc("Gets or sets Name of the WebApplication.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets Status of the WebApplication.")
  @visibility("read")
  status?: string;

  @doc("Gets or sets Platform of the WebApplication.")
  @visibility("read")
  platform?: string;

  @doc("Gets or sets GroupName of the WebApplication.")
  @visibility("read")
  groupName?: string;

  @doc("Gets or sets WebServer of the WebApplication.")
  @visibility("read")
  webServer?: string;

  @doc("Gets or sets ApplicationPool of the WebApplication.")
  @visibility("read")
  applicationPool?: string;
}

@doc("SQLServer in the guest virtual machine.")
model SqlServerApplication {
  @doc("Gets or sets Name of the SQLServer.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets Edition of the SQLServer.")
  @visibility("read")
  edition?: string;

  @doc("Gets or sets ServicePack of the SQLServer.")
  @visibility("read")
  servicePack?: string;

  @doc("Gets or sets Version of the SQLServer.")
  @visibility("read")
  version?: string;

  @doc("Gets or sets Clustered of the SQLServer.")
  @visibility("read")
  clustered?: string;

  @doc("Gets or sets ClusterName of the SQLServer.")
  @visibility("read")
  clusterName?: string;

  @doc("Gets or sets the DNS host name of SQLServer.")
  @visibility("read")
  dnsHostName?: string;

  @doc("Gets or sets the port of the SQLServer.")
  @visibility("read")
  port?: string;

  @doc("Gets or sets the comma separated IPs of the SQLServer.")
  @visibility("read")
  commaSeparatedIps?: string;

  @doc("Gets the status.")
  @visibility("read")
  status?: string;

  @doc("Gets or sets the value which reflects if Named Pipe is enabled or not.")
  @visibility("read")
  isNamedPipeEnabled?: boolean;

@doc("Gets or sets the value which reflects if Named Pipe is enabled or not.")
  @visibility("read")
  isTcpIpEnabled?: boolean;

  @doc("Gets the status.")
  @visibility("read")
  namedPipeName?: string;
}

@doc("OtherDatabase in the guest virtual machine.")
model OtherDatabase {
  @doc("Gets or sets DatabaseType of the OtherDatabase.")
  @visibility("read")
  databaseType?: string;

  @doc("Gets or sets Instance of the OtherDatabase.")
  @visibility("read")
  instance?: string;

  @doc("Gets or sets Version of the OtherDatabase.")
  @visibility("read")
  version?: string;
}
