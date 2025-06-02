import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
namespace Microsoft.ConnectedCache;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("provisioning state of the resource")
union ProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,

  /** unknown  state of the provisioning state */
  Unknown: "Unknown",

  /** Accepted state of the provisioning state during the Async Operations */
  Accepted: "Accepted",

  /** Upgrading state of the provisioning state */
  Upgrading: "Upgrading",

  /** Deleting state of the provisioning state */
  Deleting: "Deleting",
}

@doc("Operating System of the cache node")
union OsType {
  string,

  /** cache node installs on windows operating system */
  Windows: "Windows",

  /** cache node installs on Linux Operating system */
  Linux: "Linux",

  /** cache node installs on Azure Eflow */
  Eflow: "Eflow",
}

@doc("Cache node resource Bgp review state as integer")
union BgpReviewStateEnum {
  string,

  /** bgp not configured */
  NotConfigured: "NotConfigured",

  /** bgp is in review state */
  InReview: "InReview",

  /** bgp is in Approved state */
  Approved: "Approved",

  /** bgp is setup need an attention for more troubleshoot */
  AttentionRequired: "AttentionRequired",
}

@doc("Cache node configuration setup state")
union ConfigurationState {
  string,

  /** connected cache setup configured */
  Configured: "Configured",

  /** connected cache setup not configured */
  NotConfigured_Ip: "NotConfigured_Ip",
}

@doc("Proxy details enum")
union ProxyRequired {
  string,

  /** Proxy is not required in setup */
  None: "None",

  /** proxy is required in setup */
  Required: "Required",
}

@doc("Customer resource transit states")
union CustomerTransitState {
  string,

  /** do not have transit */
  NoTransit: "NoTransit",

  /** transit provider and have own subscribers */
  CombinedTransit: "CombinedTransit",

  /** pure transit provider or network service provider */
  TransitOnly: "TransitOnly",
}

@doc("Auto update Ring type")
union autoUpdateRingType {
  string,

  /** customer selection of preview update install mcc on their physical vm */
  Preview: "Preview",

  /** customer selection of slow update to install mcc on their physical vm */
  Slow: "Slow",

  /** customer selection of fast / auto update to install mcc on their physical vm */
  Fast: "Fast",
}

@doc("Update Cycle type")
union CycleType {
  string,

  /** customer selection of preview update install mcc on their physical vm */
  Preview: "Preview",

  /** customer selection of slow update to install mcc on their physical vm */
  Slow: "Slow",

  /** customer selection of fast / auto update to install mcc on their physical vm */
  Fast: "Fast",
}

@added(Versions.v2024_11_30_preview)
@doc("Mcc issue type")
union MccIssueType {
  /** mcc issue Type drive not found */
  DriveNotFound: "DriveNotFound",

  /** mcc issue worker count is less */
  WorkerCountTooFew: "WorkerCountTooFew",

  /** mcc issue with drive permissions */
  DrivePermission: "DrivePermission",

  /** mcc issue drive size is too small */
  DriveTooSmall: "DriveTooSmall",

  /** mcc issue with drive i/o error */
  DriveInputOutputError: "DriveInputOutputError",

  /** all other issues */
  Other: "Other",

  string,
}

@removed(Versions.v2024_11_30_preview)
@doc("Model representing Cache Node for ConnectedCache resource")
model CacheNodeOldResponse {
  @doc("The provisioned state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("statusCode used to get code details of Mcc response object")
  statusCode?: string;

  @doc("statusText used to get status details in string format of Mcc response object")
  statusText?: string;

  @doc("statusDetails used to get inner details of Mcc response object")
  statusDetails?: string;

  @doc("status of the HTTP error code")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("The error details")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("Mcc PATCH operation properties.")
@Azure.ClientGenerator.Core.clientName("ConnectedCachePatchContent", "csharp")
model ConnectedCachePatchResource {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @doc("Resource tags.")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  tags?: Record<string>;
}

@doc("Model representing customer for connectedCache resource")
model CustomerProperty {
  @doc("The provisioned state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Mcc customer resource (customer entity).")
  customer?: CustomerEntity;

  @doc("Mcc customer resource additional properties.")
  additionalCustomerProperties?: AdditionalCustomerProperties;

  @doc("Mcc response status code.")
  @visibility(Lifecycle.Read)
  statusCode?: string;

  @doc("Mcc response status text as string for retrieving status details.")
  @visibility(Lifecycle.Read)
  statusText?: string;

  @doc("Mcc response status details for retrieving response inner details.")
  @visibility(Lifecycle.Read)
  statusDetails?: string;

  @doc("HTTP error status code.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Mcc response error details.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("Model representing Customer resource for ConnectedCache resource")
model CustomerEntity {
  @doc("Customer resource Azure fully qualified resource Id.")
  fullyQualifiedResourceId?: string;

  @doc("Customer resource Guid Id.")
  @visibility(Lifecycle.Read)
  customerId?: string;

  @doc("Customer resource name.")
  customerName?: string;

  @doc("Customer resource contact email.")
  contactEmail?: string;

  @doc("Customer resource contact phone.")
  contactPhone?: string;

  @doc("Customer resource contact full name.")
  contactName?: string;

  @doc("Customer resource entitlement flag as boolean.")
  isEntitled?: boolean;

  @doc("Customer resource Mcc release version.")
  releaseVersion?: int32;

  @doc("Customer resource create async operation Id.")
  @visibility(Lifecycle.Read)
  createAsyncOperationId?: string;

  @doc("Customer resource deletion async operation Id.")
  @visibility(Lifecycle.Read)
  deleteAsyncOperationId?: string;

  @doc("Customer resource client tenant Id of subscription.")
  clientTenantId?: string;

  @doc("Customer resource sync attempts.")
  @visibility(Lifecycle.Read)
  synchWithAzureAttemptsCount?: int32;

  @doc("Customer resource last Azure sync timestamp.")
  @visibility(Lifecycle.Read)
  lastSyncWithAzureTimestamp?: utcDateTime;

  @doc("Customer resource flag for enterprise management as boolean.")
  isEnterpriseManaged?: boolean;

  @doc("Customer resource flag for migration.")
  shouldMigrate?: boolean;

  @doc("Customer resource flag for resending signup code as boolean.")
  resendSignupCode?: boolean;

  @doc("Customer resource flag for requiring verification of signup code as boolean.")
  verifySignupCode?: boolean;

  @doc("Customer resource phrase for verifying signup.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  verifySignupPhrase?: string;
}

@doc("Model representing customer for connected cache resource")
model AdditionalCustomerProperties {
  @doc("Customer resource last PeeringDB update timestamp.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2024_11_30_preview)
  peeringDbLastUpdateTime?: utcDateTime;

  @doc("Customer resource cache efficiency.")
  @visibility(Lifecycle.Read)
  customerPropertiesOverviewCacheEfficiency?: float32;

  @doc("Customer resource average egress in Mbps.")
  @visibility(Lifecycle.Read)
  customerPropertiesOverviewAverageEgressMbps?: float32;

  @doc("Customer resource average cache miss throughput in Mbps.")
  @visibility(Lifecycle.Read)
  customerPropertiesOverviewAverageMissMbps?: float32;

  @doc("Customer resource maximum egress in Mbps.")
  @visibility(Lifecycle.Read)
  customerPropertiesOverviewEgressMbpsMax?: float32;

  @doc("Customer resource peak egress timestamp.")
  @visibility(Lifecycle.Read)
  customerPropertiesOverviewEgressMbpsMaxDateTime?: utcDateTime;

  @doc("Customer resource maximum cache miss throughput in Mbps.")
  @visibility(Lifecycle.Read)
  customerPropertiesOverviewMissMbpsMax?: float32;

  @doc("Customer resource peak cache miss throughput timestamp.")
  @visibility(Lifecycle.Read)
  customerPropertiesOverviewMissMbpsMaxDateTime?: utcDateTime;

  @doc("Customer resource total healthy cache nodes.")
  @visibility(Lifecycle.Read)
  customerPropertiesOverviewCacheNodesHealthyCount?: int32;

  @doc("Customer resource total unhealthy cache nodes.")
  @visibility(Lifecycle.Read)
  customerPropertiesOverviewCacheNodesUnhealthyCount?: int32;

  @doc("Customer resource signup status as boolean.")
  @visibility(Lifecycle.Read)
  signupStatus?: boolean;

  @doc("Customer resource signup status as integer code.")
  @visibility(Lifecycle.Read)
  signupStatusCode?: int32;

  @doc("Customer resource signup status as string text.")
  @visibility(Lifecycle.Read)
  signupStatusText?: string;

  @doc("Customer resource signup phase status code as integer.")
  @visibility(Lifecycle.Read)
  signupPhaseStatusCode?: int32;

  @doc("Customer resource signup phase status as string text.")
  @visibility(Lifecycle.Read)
  signupPhaseStatusText?: string;

  @doc("Customer resource last PeeringDB update timestamp.")
  @visibility(Lifecycle.Read)
  @Azure.ClientGenerator.Core.clientName(
    "peeringDbLastUpdateDateValue",
    "csharp"
  )
  peeringDbLastUpdateDate?: utcDateTime;

  @doc("Customer resource owner organization name.")
  @visibility(Lifecycle.Read)
  customerOrgName?: string;

  @doc("Customer resource contact email.")
  customerEmail?: string;

  @doc("Customer resource transit Asn (autonomous system number).")
  customerTransitAsn?: string;

  @doc("Customer resource transit state.")
  customerTransitState?: CustomerTransitState;

  @doc("Customer resource Asn (autonomous system number).")
  customerAsn?: string;

  @doc("Customer resource estimated Asn peering peak in Gbps.")
  @visibility(Lifecycle.Read)
  customerAsnEstimatedEgressPeekGbps?: float32;

  @doc("Customer resource entitlement Sku Id.")
  customerEntitlementSkuId?: string;

  @doc("Customer resource entitlement Sku Guid.")
  customerEntitlementSkuGuid?: string;

  @doc("Customer resource entitlement Sku name.")
  customerEntitlementSkuName?: string;

  @doc("Customer resource entitlement expiration date string.")
  customerEntitlementExpiration?: utcDateTime;

  @doc("Optional property #1 of Mcc response object.")
  optionalProperty1?: string;

  @doc("Optional property #2 of Mcc response object.")
  optionalProperty2?: string;

  @doc("Optional property #3 of Mcc response object.")
  optionalProperty3?: string;

  @doc("Optional property #4 of Mcc response object.")
  optionalProperty4?: string;

  @doc("Optional property #5 of Mcc response object.")
  optionalProperty5?: string;
}

@doc("Model representing an Mcc cache node connectedCache resource")
model CacheNodeProperty {
  @doc("The provisioned state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Mcc cache node resource (cache node entity).")
  cacheNode?: CacheNodeEntity;

  @doc("Mcc cache node resource additional properties.")
  additionalCacheNodeProperties?: AdditionalCacheNodeProperties;

  @doc("Mcc response status code.")
  statusCode?: string;

  @doc("Mcc response status text as string for retrieving status details.")
  statusText?: string;

  @doc("Mcc response status details for retrieving response inner details.")
  statusDetails?: string;

  @doc("HTTP error status code.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Mcc response error details.")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("Model representing Cache Node for ConnectedCache resource")
model CacheNodeEntity {
  @doc("Cache node resource Azure fully qualified resource Id.")
  fullyQualifiedResourceId?: string;

  @doc("Cache node resource customer resource GUID Id.")
  @visibility(Lifecycle.Read)
  customerId?: string;

  @doc("Cache node resource customer resource name.")
  customerName?: string;

  @doc("Cache node resource Ip address.")
  ipAddress?: string;

  @doc("Cache node resource customer index as string.")
  customerIndex?: string;

  @doc("Cache node resource identifier of the cache node")
  cacheNodeId?: string;

  @doc("Cache node resource name.")
  cacheNodeName?: string;

  @doc("Cache node resource customer resource Asn (autonomous system number)")
  customerAsn?: int32;

  @doc("Cache node resource flag for indicating if cache node is enabled.")
  isEnabled?: boolean;

  @doc("Cache node resource maximum allowed egress in Mbps.")
  maxAllowableEgressInMbps?: int32;

  @doc("Cache node resource maximum allowed probability of egress.")
  @visibility(Lifecycle.Read)
  maxAllowableProbability?: float32;

  @doc("Cache node resource Azure XCid.")
  @visibility(Lifecycle.Read)
  xCid?: string;

  @doc("Cache node resource flag for determining if managed by enterprise as boolean.")
  isEnterpriseManaged?: boolean;

  @doc("Cache node resource create async operation Id.")
  @visibility(Lifecycle.Read)
  createAsyncOperationId?: string;

  @doc("Cache node resource deletion async operation Id.")
  @visibility(Lifecycle.Read)
  deleteAsyncOperationId?: string;

  @doc("Cache node resource customer resource client tenant Id of subscription.")
  @visibility(Lifecycle.Read)
  clientTenantId?: string;

  @doc("Cache node resource category.")
  @visibility(Lifecycle.Read)
  category?: string;

  @doc("Cache node resource release version.")
  @visibility(Lifecycle.Read)
  releaseVersion?: int32;

  @doc("Cache node resource last sync timestamp.")
  @visibility(Lifecycle.Read)
  lastSyncWithAzureTimestamp?: utcDateTime;

  @doc("Cache node resource last backend updated timestamp.")
  @visibility(Lifecycle.Read)
  lastUpdatedTimestamp?: utcDateTime;

  @doc("Cache node resource attempts to sync with Azure.")
  @visibility(Lifecycle.Read)
  synchWithAzureAttemptsCount?: int32;

  @doc("Cache node resource container configuration details.")
  @visibility(Lifecycle.Read)
  containerConfigurations?: string;

  @doc("Cache node resource comma separated values of Cidrs.")
  cidrCsv?: string[];

  @doc("Cache node resource last Cidr Csv update timestamp")
  @visibility(Lifecycle.Read)
  cidrCsvLastUpdateTime?: utcDateTime;

  @doc("Cache node resource last Bgp Cidr Csv update timestamp")
  @visibility(Lifecycle.Read)
  bgpCidrCsvLastUpdateTime?: utcDateTime;

  @doc("Cache node resource last Bgp report timestamp.")
  @visibility(Lifecycle.Read)
  bgpLastReportedTime?: utcDateTime;

  @doc("Cache node resource Bgp review state string text in detail.")
  @visibility(Lifecycle.Read)
  bgpReviewStateText?: string;

  @doc("Cache node resource Bgp review state string text.")
  @visibility(Lifecycle.Read)
  bgpReviewState?: BgpReviewStateEnum;

  @doc("Cache node resource Bgp review feedback text.")
  @visibility(Lifecycle.Read)
  bgpReviewFeedback?: string;

  @doc("Cache node resource Bgp update count.")
  @visibility(Lifecycle.Read)
  bgpNumberOfTimesUpdated?: int32;

  @doc("Cache node resource Bgp record count.")
  @visibility(Lifecycle.Read)
  bgpNumberOfRecords?: int32;

  @doc("Cache node resource Bgp block count.")
  @visibility(Lifecycle.Read)
  bgpCidrBlocksCount?: int32;

  @doc("Cache node resource total addressable space defined by Bgp and Cidr Csv blocks.")
  @visibility(Lifecycle.Read)
  bgpAddressSpace?: int32;

  @doc("Cache node resource flag for determining if customer will be migrated.")
  shouldMigrate?: boolean;

  @doc("Cache node resource bytes truncated from Bgp output file.")
  @visibility(Lifecycle.Read)
  bgpFileBytesTruncated?: int32;

  @doc("Cache node resource current Cidr range precedence selection type.")
  cidrSelectionType?: int32;

  @doc("Cache node resource flag for indicating the cache node resource is frozen (not selectable, not editable in UI).")
  @visibility(Lifecycle.Read)
  isFrozen?: boolean;

  @doc("Cache node resource review process state as integer")
  @visibility(Lifecycle.Read)
  reviewState?: int32;

  @doc("Cache node resource review state text.")
  @visibility(Lifecycle.Read)
  reviewStateText?: string;

  @doc("Cache node resource review feedback text.")
  @visibility(Lifecycle.Read)
  reviewFeedback?: string;

  @doc("Cache node resource configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Cache node resource configuration state text.")
  @visibility(Lifecycle.Read)
  configurationStateText?: string;

  @doc("Cache node resource total addressable space defined by the Cidr Csv block.")
  @visibility(Lifecycle.Read)
  addressSpace?: int32;

  @doc("Cache node resource Mcc container deployment worker connection count.")
  @visibility(Lifecycle.Read)
  workerConnections?: int32;

  @doc("Cache node resource last updated Mcc container deployment worker connection count timestamp.")
  @visibility(Lifecycle.Read)
  workerConnectionsLastUpdatedDateTime?: utcDateTime;

  @doc("Cache node resource Mcc container configuration details re-sync trigger.")
  @visibility(Lifecycle.Read)
  containerResyncTrigger?: int32;

  @doc("Cache node resource Mcc Container Id Uri.")
  @visibility(Lifecycle.Read)
  imageUri?: string;

  @doc("FQDN(fully qualified domain name) value of the mcc cache node")
  fullyQualifiedDomainName?: string;

  @doc("Auto Update Ring Type which is slow or fast etc.")
  autoUpdateRingType?: autoUpdateRingType;

  @doc("Customer requested week of month for mcc install of auto update cycle. 0 is default no selection. 1-5 are valid weeks of month, 1 is first week, 2 is second week, etc.")
  @minValue(0)
  @maxValue(5)
  autoUpdateRequestedWeek?: int32;

  @doc("Customer requested day of week for mcc install of auto update cycle. 0 is default no selection. 1-7 are days of week, 1 is Sunday, 2 is Monday, etc.")
  @minValue(0)
  @maxValue(7)
  autoUpdateRequestedDay?: int32;

  @doc("Customer requested time of the day for mcc install of auto update cycle, should be hh:mm")
  @pattern("^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$")
  autoUpdateRequestedTime?: string;
}

@doc("Model representing cache node for connected cache resource")
model AdditionalCacheNodeProperties {
  @doc("issues list to return the issues as part of the additional cache node properties")
  cacheNodePropertiesDetailsIssuesList?: string[];

  @added(Versions.v2024_11_30_preview)
  @visibility(Lifecycle.Read)
  @doc("current cache node issue list.")
  issuesList?: string[];

  @added(Versions.v2024_11_30_preview)
  @doc("Number of cache node issues.")
  @visibility(Lifecycle.Read)
  issuesCount?: int32;

  @added(Versions.v2024_11_30_preview)
  @doc("cache node current tls certificate.")
  @visibility(Lifecycle.Read)
  currentTlsCertificate?: MccCacheNodeTlsCertificate;

  @added(Versions.v2024_11_30_preview)
  @doc("cache node last auto update information.")
  @visibility(Lifecycle.Read)
  lastAutoUpdateInfo?: MccCacheNodeAutoUpdateInfo;

  @doc("Cache node resource aggregated status details.")
  @visibility(Lifecycle.Read)
  aggregatedStatusDetails?: string;

  @doc("Cache node resource aggregated status text.")
  @visibility(Lifecycle.Read)
  aggregatedStatusText?: string;

  @doc("Cache node resource aggregated status code.")
  @visibility(Lifecycle.Read)
  aggregatedStatusCode?: int32;

  @doc("Cache node resource Mcc product version.")
  @visibility(Lifecycle.Read)
  productVersion?: string;

  @doc("Cache node resource flag indicating if cache node has been physically installed or provisioned on their physical lab.")
  @visibility(Lifecycle.Read)
  isProvisioned?: boolean;

  @doc("Cache node resource detailed state text.")
  @visibility(Lifecycle.Read)
  cacheNodeStateDetailedText?: string;

  @doc("Cache node resource short state text.")
  @visibility(Lifecycle.Read)
  cacheNodeStateShortText?: string;

  @doc("Cache node resource state as integer.")
  @visibility(Lifecycle.Read)
  cacheNodeState?: int32;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @doc("Cache node resource drive configurations.")
  driveConfiguration?: CacheNodeDriveConfiguration[];

  @doc("Cache node resource Bgp configuration.")
  bgpConfiguration?: BgpConfiguration;

  @doc("proxyUrl configuration of the cache node")
  proxyUrlConfiguration?: ProxyUrlConfiguration;

  @doc("Cache node resource Mcc proxy Url")
  @removed(Versions.v2024_11_30_preview)
  proxyUrl?: string;

  @doc("Cache node resource requires a proxy")
  isProxyRequired?: ProxyRequired;

  @doc("Operating system of the cache node")
  osType?: OsType;

  @doc("Update Cycle Type")
  @removed(Versions.v2024_11_30_preview)
  updateCycleType?: CycleType;

  @doc("Auto update or fast update version")
  autoUpdateVersion?: string;

  @doc("Update related information details")
  updateInfoDetails?: string;

  @doc("customer requested date time for mcc install of update cycle")
  updateRequestedDateTime?: utcDateTime;

  @doc("Auto update version that is the Next available version to update on mcc cache node")
  @visibility(Lifecycle.Read)
  autoUpdateNextAvailableVersion?: string;

  @doc("Auto update last applied date time of mcc install")
  @visibility(Lifecycle.Read)
  autoUpdateNextAvailableDateTime?: utcDateTime;

  @doc("Auto update version that is the applied to update on mcc cache node")
  @visibility(Lifecycle.Read)
  autoUpdateAppliedVersion?: string;

  @doc("Auto Update status details from the backend after applying the new version details")
  @visibility(Lifecycle.Read)
  autoUpdateLastAppliedDetails?: string;

  @doc("Last applied auto update state for mcc install of auto update cycle")
  @visibility(Lifecycle.Read)
  autoUpdateLastAppliedState?: string;

  @doc("Auto update last applied date time of mcc install")
  @visibility(Lifecycle.Read)
  autoUpdateLastAppliedDateTime?: utcDateTime;

  @doc("Auto update last triggered date time of mcc install")
  @visibility(Lifecycle.Read)
  autoUpdateLastTriggeredDateTime?: utcDateTime;

  @added(Versions.v2024_11_30_preview)
  @doc("Resource creation method of mcc cache node resource, cli or portal")
  @minValue(0)
  @maxValue(5)
  creationMethod?: int32;

  @added(Versions.v2024_11_30_preview)
  @doc("Cache node tls certificate status.")
  @visibility(Lifecycle.Read)
  tlsStatus?: string;

  @doc("Optional property #1 of Mcc response object")
  optionalProperty1?: string;

  @doc("Optional property #2 of Mcc response object")
  optionalProperty2?: string;

  @doc("Optional property #3 of Mcc response object")
  optionalProperty3?: string;

  @doc("Optional property #4 of Mcc response object")
  optionalProperty4?: string;

  @doc("Optional property #5 of Mcc response object")
  optionalProperty5?: string;
}

@doc("Drive configuration for cache node")
model CacheNodeDriveConfiguration {
  @doc("physical path location of the folder used for caching content")
  physicalPath?: string;

  @doc("physical size of the drive used for caching content")
  sizeInGb?: int32;

  @doc("corresponding nginx cache number. Valid cache numbers are 1 - 20")
  @minValue(1)
  @maxValue(20)
  cacheNumber?: int32;

  @doc("full binding for corresponding nginx cache drive")
  nginxMapping?: string;
}

@doc("Bgp configuration of cache node")
model BgpConfiguration {
  @doc("Asn to ip address mapping")
  asnToIpAddressMapping?: string;
}

@doc("ProxyUrl configuration of cache node")
model ProxyUrlConfiguration {
  @doc("Host Proxy Address configuration along with port number. This can be a proxy or ip address. ex: xx.xx.xx.xxxx:80 or host name http://exampleproxy.com:80")
  proxyUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "optional properties"
@doc("Represents all Cidr details of the Bgp request for a specific cache node resource")
model MccCacheNodeBgpCidrDetails
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Mcc cache node resource Bgp Cidr properties.")
  properties?: BgpCidrsConfiguration;
}

@doc("Mcc cache node Bgp Cidr details.")
model BgpCidrsConfiguration {
  @doc("Mcc cache node Bgp Cidr details.")
  @visibility(Lifecycle.Read)
  bgpCidrs?: string[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "optional properties"
@doc("Mcc cache node resource all install details.")
model MccCacheNodeInstallDetails
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Mcc cache node resource install script details.")
  properties?: CacheNodeInstallProperties;
}

@doc("Mcc cache node resource install script properties.")
model CacheNodeInstallProperties {
  @doc("Mcc customer resource Id.")
  customerId?: string;

  @doc("Mcc cache node resource Id.")
  cacheNodeId?: string;

  @doc("Mcc primary account key. Internal to Mcc.")
  @visibility(Lifecycle.Read)
  @secret
  primaryAccountKey?: string;

  @doc("Mcc secondary account key. Internal to Mcc.")
  @visibility(Lifecycle.Read)
  @secret
  secondaryAccountKey?: string;

  @doc("Mcc Iot Central temporary device registration key, used once.")
  @visibility(Lifecycle.Read)
  @secret
  registrationKey?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @visibility(Lifecycle.Read)
  @secret
  @added(Versions.v2024_11_30_preview)
  @doc("Mcc Tls certificate provisioning key.")
  tlsCertificateProvisioningKey?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @added(Versions.v2024_11_30_preview)
  @doc("Cache node resource drive configurations.")
  driveConfiguration?: CacheNodeDriveConfiguration[];

  @added(Versions.v2024_11_30_preview)
  @doc("proxyUrl configuration of the cache node")
  proxyUrlConfiguration?: ProxyUrlConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "optional properties"
@added(Versions.v2024_11_30_preview)
@doc("Mcc cache node resource auto update history.")
model MccCacheNodeAutoUpdateHistory
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Mcc cache node resource auto update history properties.")
  properties?: MccCacheNodeAutoUpdateHistoryProperties;
}

@added(Versions.v2024_11_30_preview)
@doc("Mcc cache node resource auto update history properties.")
model MccCacheNodeAutoUpdateHistoryProperties {
  @doc("Mcc customer resource Id.")
  @visibility(Lifecycle.Read)
  customerId?: string;

  @doc("Mcc cache node resource Id.")
  @visibility(Lifecycle.Read)
  cacheNodeId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Cache node resource auto update history information.")
  autoUpdateHistory?: MccCacheNodeAutoUpdateInfo[];
}

@added(Versions.v2024_11_30_preview)
@doc("Mcc cache node resource auto update properties.")
model MccCacheNodeAutoUpdateInfo {
  @doc("Auto update image uri before update.")
  @visibility(Lifecycle.Read)
  imageUriBeforeUpdate?: string;

  @doc("Auto update image uri targetted to update.")
  @visibility(Lifecycle.Read)
  imageUriTargeted?: string;

  @doc("Auto update image uri at Terminal.")
  @visibility(Lifecycle.Read)
  imageUriTerminal?: string;

  @doc("Auto update Ring Type.")
  @visibility(Lifecycle.Read)
  autoUpdateRingType?: int32;

  @doc("Auto update image uri after update.")
  @visibility(Lifecycle.Read)
  movedToTerminalStateDateTime?: utcDateTime;

  @doc("Auto update image uri before update.")
  @visibility(Lifecycle.Read)
  ruleRequestedWeek?: int32;

  @doc("Auto update image uri after update.")
  @visibility(Lifecycle.Read)
  ruleRequestedDay?: int32;

  @doc("Auto update entity created datetime.")
  @visibility(Lifecycle.Read)
  createdDateTimeUtc?: utcDateTime;

  @doc("Auto update entity last updated datetime.")
  @visibility(Lifecycle.Read)
  updatedRegistryDateTimeUtc?: utcDateTime;

  @doc("This text describing the purpose of the plan of auto update.")
  @visibility(Lifecycle.Read)
  planChangeLogText?: string;

  @doc("Auto update last applied status.")
  @visibility(Lifecycle.Read)
  autoUpdateLastAppliedStatus?: int32;

  @doc("Auto update last applied status text.")
  @visibility(Lifecycle.Read)
  autoUpdateLastAppliedStatusText?: string;

  @doc("Auto update last applied detailed status text.")
  @visibility(Lifecycle.Read)
  autoUpdateLastAppliedStatusDetailedText?: string;

  @doc("Auto update planId.")
  @visibility(Lifecycle.Read)
  planId?: int64;

  @doc("Auto update time to go live date time.")
  @visibility(Lifecycle.Read)
  timeToGoLiveDateTime?: string;

  @doc("Auto update rule requested minute.")
  @visibility(Lifecycle.Read)
  ruleRequestedMinute?: string;

  @doc("Auto update rule requested hour.")
  @visibility(Lifecycle.Read)
  ruleRequestedHour?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "optional properties"
@added(Versions.v2024_11_30_preview)
@doc("Mcc cache node resource issue history.")
model MccCacheNodeIssueHistory
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Mcc cache node resource issue history properties.")
  properties?: MccCacheNodeIssueHistoryProperties;
}

@added(Versions.v2024_11_30_preview)
@doc("Mcc cache node resource issue history properties.")
model MccCacheNodeIssueHistoryProperties {
  @doc("Mcc customer resource Id.")
  @visibility(Lifecycle.Read)
  customerId?: string;

  @doc("Mcc cache node resource Id.")
  @visibility(Lifecycle.Read)
  cacheNodeId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Cache node resource issue details history.")
  mccIssueHistory?: MccIssue[];
}

@added(Versions.v2024_11_30_preview)
@doc("Mcc cache node resource issue properties.")
model MccIssue {
  @doc("Mcc cache node issue type.")
  @visibility(Lifecycle.Read)
  mccIssueType?: string;

  @doc("Mcc cache node issues toastString.")
  @visibility(Lifecycle.Read)
  toastString?: string;

  @doc("Mcc cache node issue detail string.")
  @visibility(Lifecycle.Read)
  detailString?: string;

  @doc("Mcc cache node issue related help link.")
  @visibility(Lifecycle.Read)
  helpLink?: string;

  @doc("Mcc cache node issue start date.")
  @visibility(Lifecycle.Read)
  issueStartDate?: utcDateTime;

  @doc("Mcc cache node issue end date.")
  @visibility(Lifecycle.Read)
  issueEndDate?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "optional properties"
@added(Versions.v2024_11_30_preview)
@doc("Mcc cache node resource Tls certificate history details.")
model MccCacheNodeTlsCertificateHistory
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Mcc cache node resource Tls certificate details.")
  properties?: MccCacheNodeTlsCertificateProperties;
}

@added(Versions.v2024_11_30_preview)
@doc("Mcc cache node resource auto update properties.")
model MccCacheNodeTlsCertificateProperties {
  @doc("Mcc customer resource Id.")
  @visibility(Lifecycle.Read)
  customerId?: string;

  @doc("Mcc cache node resource Id.")
  @visibility(Lifecycle.Read)
  cacheNodeId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Cache node resource tls certificate history details.")
  tlsCertificateHistory?: MccCacheNodeTlsCertificate[];
}

@added(Versions.v2024_11_30_preview)
@doc("Mcc cache node resource Tls certificate details.")
model MccCacheNodeTlsCertificate {
  @doc("Mcc cache node Tls certificate status.")
  @visibility(Lifecycle.Read)
  actionRequired?: string;

  @doc("Mcc cache node Tls certificate file name.")
  @visibility(Lifecycle.Read)
  certificateFileName?: string;

  @doc("Mcc cache node Tls certificate thumbprint.")
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  @doc("Mcc cache node Tls certificate expiry date.")
  @visibility(Lifecycle.Read)
  expiryDate?: utcDateTime;

  @doc("Mcc cache node Tls certificate not before date.")
  @visibility(Lifecycle.Read)
  notBeforeDate?: utcDateTime;

  @doc("Mcc cache node Tls certificate subject name.")
  @visibility(Lifecycle.Read)
  subject?: string;

  @doc("Mcc cache node Tls certificate subject alternate name.")
  @visibility(Lifecycle.Read)
  subjectAltName?: string;
}
