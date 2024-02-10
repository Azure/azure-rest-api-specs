import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ConnectedCache;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("provisioning state of the resource")
enum ProvisioningState {
  ...ResourceProvisioningState,

  /** unknown  state of the provisioning state */
  Unknown,

  /** Accepted state of the provisioning state during the Async Operations */
  Accepted,

  /** Upgrading state of the provisioning state */
  Upgrading,

  /** Deleting state of the provisioning state */
  Deleting,
}

@doc("Operating System of the cache node")
enum OsType {
  /** cache node installs on windows operating system */
  Windows,

  /** cache node installs on Linux Operating system */
  Linux,
}

@doc("Cache node resource Bgp review state as integer")
enum BgpReviewStateEnum {
  /** bgp not configured */
  NotConfigured,

  /** bgp is in review state */
  InReview,

  /** bgp is in Approved state */
  Approved,

  /** bgp is setup need an attention for more troubleshoot */
  AttentionRequired,
}

@doc("Cache node configuration setup state")
enum ConfigurationState {
  /** connected cache setup configured */
  Configured,

  /** connected cache setup not configured */
  NotConfigured_Ip,
}

@doc("Proxy details enum")
enum ProxyRequired {
  /** Proxy is not required in setup */
  None,

  /** proxy is required in setup */
  Required,
}

@doc("Customer resource transit states")
enum CustomerTransitState {
  /** do not have transit */
  NoTransit,

  /** transit provider and have own subscribers */
  CombinedTransit,

  /** pure transit provider or network service provider */
  TransitOnly,
}

@doc("Update Cycle type")
enum CycleType {
  /** customer selection of preview update install mcc on their physical vm */
  Preview,

  /** customer selection of slow update to install mcc on their physical vm */
  Slow,

  /** customer selection of fast / auto update to install mcc on their physical vm */
  Fast,
}

@doc("Model representing Cache Node for ConnectedCache resource")
model CacheNodeOldResponse {
  @doc("The provisioned state of the resource")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("statusCode used to get code details of Mcc response object")
  statusCode?: string;

  @doc("statusText used to get status details in string format of Mcc response object")
  statusText?: string;

  @doc("statusDetails used to get inner details of Mcc response object")
  statusDetails?: string;

  @doc("status of the HTTP error code")
  @visibility("read")
  status?: string;

  @doc("The error details")
  error?: ErrorDetail;
}

@doc("Mcc PATCH operation properties.")
model ConnectedCachePatchResource {
  @doc("Resource tags.")
  @visibility("read", "update")
  tags?: Record<string>;
}

@doc("Model representing customer for connectedCache resource")
model CustomerProperty {
  @doc("The provisioned state of the resource")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Mcc customer resource (customer entity).")
  customer?: CustomerEntity;

  @doc("Mcc customer resource additional properties.")
  additionalCustomerProperties?: AdditionalCustomerProperties;

  @doc("Mcc response status code.")
  @visibility("read")
  statusCode?: string;

  @doc("Mcc response status text as string for retrieving status details.")
  @visibility("read")
  statusText?: string;

  @doc("Mcc response status details for retrieving response inner details.")
  @visibility("read")
  statusDetails?: string;

  @doc("HTTP error status code.")
  @visibility("read")
  status?: string;

  @doc("Mcc response error details.")
  @visibility("read")
  error?: ErrorDetail;
}

@doc("Model representing Customer resource for ConnectedCache resource")
model CustomerEntity {
  @doc("Customer resource Azure fully qualified resource Id.")
  fullyQualifiedResourceId?: string;

  @doc("Customer resource Guid Id.")
  @visibility("read")
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
  @visibility("read")
  createAsyncOperationId?: string;

  @doc("Customer resource deletion async operation Id.")
  @visibility("read")
  deleteAsyncOperationId?: string;

  @doc("Customer resource client tenant Id of subscription.")
  clientTenantId?: string;

  @doc("Customer resource sync attempts.")
  @visibility("read")
  synchWithAzureAttemptsCount?: int32;

  @doc("Customer resource last Azure sync timestamp.")
  @visibility("read")
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
  @visibility("create", "update")
  @secret
  verifySignupPhrase?: string;
}

@doc("Model representing customer for connected cache resource")
model AdditionalCustomerProperties {
  @doc("Customer resource last PeeringDB update timestamp.")
  @visibility("read")
  peeringDbLastUpdateTime?: utcDateTime;

  @doc("Customer resource cache efficiency.")
  @visibility("read")
  customerPropertiesOverviewCacheEfficiency?: float32;

  @doc("Customer resource average egress in Mbps.")
  @visibility("read")
  customerPropertiesOverviewAverageEgressMbps?: float32;

  @doc("Customer resource average cache miss throughput in Mbps.")
  @visibility("read")
  customerPropertiesOverviewAverageMissMbps?: float32;

  @doc("Customer resource maximum egress in Mbps.")
  @visibility("read")
  customerPropertiesOverviewEgressMbpsMax?: float32;

  @doc("Customer resource peak egress timestamp.")
  @visibility("read")
  customerPropertiesOverviewEgressMbpsMaxDateTime?: utcDateTime;

  @doc("Customer resource maximum cache miss throughput in Mbps.")
  @visibility("read")
  customerPropertiesOverviewMissMbpsMax?: float32;

  @doc("Customer resource peak cache miss throughput timestamp.")
  @visibility("read")
  customerPropertiesOverviewMissMbpsMaxDateTime?: utcDateTime;

  @doc("Customer resource total healthy cache nodes.")
  @visibility("read")
  customerPropertiesOverviewCacheNodesHealthyCount?: int32;

  @doc("Customer resource total unhealthy cache nodes.")
  @visibility("read")
  customerPropertiesOverviewCacheNodesUnhealthyCount?: int32;

  @doc("Customer resource signup status as boolean.")
  signupStatus?: boolean;

  @doc("Customer resource signup status as integer code.")
  signupStatusCode?: int32;

  @doc("Customer resource signup status as string text.")
  @visibility("read")
  signupStatusText?: string;

  @doc("Customer resource signup phase status code as integer.")
  @visibility("read")
  signupPhaseStatusCode?: int32;

  @doc("Customer resource signup phase status as string text.")
  @visibility("read")
  signupPhaseStatusText?: string;

  @doc("Customer resource last PeeringDB update timestamp.")
  @visibility("read")
  peeringDbLastUpdateDate?: utcDateTime;

  @doc("Customer resource owner organization name.")
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  status?: string;

  @doc("Mcc response error details.")
  error?: ErrorDetail;
}

@doc("Model representing Cache Node for ConnectedCache resource")
model CacheNodeEntity {
  @doc("Cache node resource Azure fully qualified resource Id.")
  fullyQualifiedResourceId?: string;

  @doc("Cache node resource customer resource GUID Id.")
  @visibility("read")
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
  @visibility("read")
  maxAllowableProbability?: float32;

  @doc("Cache node resource Azure XCid.")
  xCid?: string;

  @doc("Cache node resource flag for determining if managed by enterprise as boolean.")
  isEnterpriseManaged?: boolean;

  @doc("Cache node resource create async operation Id.")
  createAsyncOperationId?: string;

  @doc("Cache node resource deletion async operation Id.")
  deleteAsyncOperationId?: string;

  @doc("Cache node resource customer resource client tenant Id of subscription.")
  clientTenantId?: string;

  @doc("Cache node resource category.")
  category?: string;

  @doc("Cache node resource release version.")
  releaseVersion?: int32;

  @doc("Cache node resource last sync timestamp.")
  lastSyncWithAzureTimestamp?: utcDateTime;

  @doc("Cache node resource attempts to sync with Azure.")
  @visibility("read")
  synchWithAzureAttemptsCount?: int32;

  @doc("Cache node resource container configuration details.")
  containerConfigurations?: string;

  @doc("Cache node resource comma separated values of Cidrs.")
  cidrCsv?: string[];

  @doc("Cache node resource last Cidr Csv update timestamp")
  @visibility("read")
  cidrCsvLastUpdateTime?: utcDateTime;

  @doc("Cache node resource last Bgp Cidr Csv update timestamp")
  @visibility("read")
  bgpCidrCsvLastUpdateTime?: utcDateTime;

  @doc("Cache node resource last Bgp report timestamp.")
  @visibility("read")
  bgpLastReportedTime?: utcDateTime;

  @doc("Cache node resource Bgp review state string text in detail.")
  @visibility("read")
  bgpReviewStateText?: string;

  @doc("Cache node resource Bgp review state string text.")
  @visibility("read")
  bgpReviewState?: BgpReviewStateEnum;

  @doc("Cache node resource Bgp review feedback text.")
  @visibility("read")
  bgpReviewFeedback?: string;

  @doc("Cache node resource Bgp update count.")
  @visibility("read")
  bgpNumberOfTimesUpdated?: int32;

  @doc("Cache node resource Bgp record count.")
  @visibility("read")
  bgpNumberOfRecords?: int32;

  @doc("Cache node resource Bgp block count.")
  @visibility("read")
  bgpCidrBlocksCount?: int32;

  @doc("Cache node resource total addressable space defined by Bgp and Cidr Csv blocks.")
  @visibility("read")
  bgpAddressSpace?: int32;

  @doc("Cache node resource flag for determining if customer will be migrated.")
  shouldMigrate?: boolean;

  @doc("Cache node resource bytes truncated from Bgp output file.")
  @visibility("read")
  bgpFileBytesTruncated?: int32;

  @doc("Cache node resource current Cidr range precedence selection type.")
  cidrSelectionType?: int32;

  @doc("Cache node resource flag for indicating the cache node resource is frozen (not selectable, not editable in UI).")
  @visibility("read")
  isFrozen?: boolean;

  @doc("Cache node resource review process state as integer")
  @visibility("read")
  reviewState?: int32;

  @doc("Cache node resource review state text.")
  @visibility("read")
  reviewStateText?: string;

  @doc("Cache node resource review feedback text.")
  @visibility("read")
  reviewFeedback?: string;

  @doc("Cache node resource configuration state.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Cache node resource configuration state text.")
  @visibility("read")
  configurationStateText?: string;

  @doc("Cache node resource total addressable space defined by the Cidr Csv block.")
  addressSpace?: int32;

  @doc("Cache node resource Mcc container deployment worker connection count.")
  @visibility("read")
  workerConnections?: int32;

  @doc("Cache node resource last updated Mcc container deployment worker connection count timestamp.")
  @visibility("read")
  workerConnectionsLastUpdatedDateTime?: utcDateTime;

  @doc("Cache node resource Mcc container configuration details re-sync trigger.")
  @visibility("read")
  containerResyncTrigger?: int32;

  @doc("Cache node resource Mcc Container Id Uri.")
  @visibility("read")
  imageUri?: string;
}

@doc("Model representing cache node for connected cache resource")
model AdditionalCacheNodeProperties {
  @doc("issues list to return the issues as part of the additional cache node properties")
  cacheNodePropertiesDetailsIssuesList?: string[];

  @doc("Cache node resource aggregated status details.")
  @visibility("read")
  aggregatedStatusDetails?: string;

  @doc("Cache node resource aggregated status text.")
  @visibility("read")
  aggregatedStatusText?: string;

  @doc("Cache node resource aggregated status code.")
  @visibility("read")
  aggregatedStatusCode?: int32;

  @doc("Cache node resource Mcc product version.")
  @visibility("read")
  productVersion?: string;

  @doc("Cache node resource flag indicating if cache node has been physically installed or provisioned on their physical lab.")
  @visibility("read")
  isProvisioned?: boolean;

  @doc("Cache node resource detailed state text.")
  @visibility("read")
  cacheNodeStateDetailedText?: string;

  @doc("Cache node resource short state text.")
  @visibility("read")
  cacheNodeStateShortText?: string;

  @doc("Cache node resource state as integer.")
  @visibility("read")
  cacheNodeState?: int32;

  @doc("Cache node resource drive configurations.")
  driveConfiguration?: CacheNodeDriveConfiguration[];

  @doc("Cache node resource Bgp configuration.")
  bgpConfiguration?: BgpConfiguration;

  @doc("proxyUrl configuration of the cache node")
  proxyUrlConfiguration?: ProxyUrlConfiguration;

  @doc("Cache node resource Mcc proxy Url")
  proxyUrl?: string;

  @doc("Cache node resource requires a proxy")
  isProxyRequired?: ProxyRequired;

  @doc("Operating system of the cache node")
  osType?: OsType;

  @doc("Update Cycle Type")
  updateCycleType?: CycleType;

  @doc("Auto update or fast update version")
  autoUpdateVersion?: string;

  @doc("Update related information details")
  updateInfoDetails?: string;

  @doc("customer requested date time for mcc install of update cycle")
  updateRequestedDateTime?: utcDateTime;

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

@doc("Represents all Cidr details of the Bgp request for a specific cache node resource")
model MccCacheNodeBgpCidrDetails {
  ...Azure.ResourceManager.Foundations.TrackedResourceBase;

  @doc("Mcc cache node resource Bgp Cidr properties.")
  properties?: BgpCidrsConfiguration;
}

@doc("Mcc cache node Bgp Cidr details.")
model BgpCidrsConfiguration {
  @doc("Mcc cache node Bgp Cidr details.")
  @visibility("read")
  bgpCidrs?: string[];
}

@doc("Mcc cache node resource all install details.")
model MccCacheNodeInstallDetails {
  ...Azure.ResourceManager.Foundations.TrackedResourceBase;

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
  @visibility("read")
  @secret
  primaryAccountKey?: string;

  @doc("Mcc secondary account key. Internal to Mcc.")
  @visibility("read")
  @secret
  secondaryAccountKey?: string;

  @doc("Mcc Iot Central temporary device registration key, used once.")
  @visibility("read")
  @secret
  registrationKey?: string;
}
