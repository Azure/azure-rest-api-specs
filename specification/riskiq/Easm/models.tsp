import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;
namespace Easm;

// Traits
@trait
model PageResultBodyFields<TResultFields, Context = TraitContext.List> {
  @traitContext(Context)
  responseFields: {
    @traitLocation(TraitLocation.Response)
    parameters: TResultFields;
  };
}

@trait
@traitAdded(Versions.v2024_03_01_preview)
model AssetsListQueryParametersTrait<Parameters, Contexts = unknown> {
  @traitContext(Contexts)
  queryParameters: {
    @traitLocation(TraitLocation.Parameters)
    parameters: Parameters;
  };
}

alias AssetsListTrait = {
  ...PageResultBodyFields<{
    @doc("The total number of items available in the full result set.")
    totalElements?: int64;

    @doc("The cursor mark to be used on the next request.  Not set if using paging.")
    mark?: string;
  }>;
  ...QueryParametersTrait<{
    ...FilterQueryParameter;
    ...OrderByParameter;
    ...SkipQueryParameter;
    ...MaxPageSizeQueryParameter;
    ...MarkParameter;
  }>;
  ...AssetsListQueryParametersTrait<{
    ...ResponseTypeParameter;
    ...ResponseIncludesParameter;
    ...RecentOnlyParameter;
  }>;
};
alias AssetsUpdateParameter = {
  ...RequiredFilterParameter;
};
alias DataConnectionsListTrait = {
  ...PageResultBodyFields<{
    @doc("The total number of items available in the full result set.")
    totalElements?: int64;
  }>;
  ...QueryParametersTrait<{
    ...SkipQueryParameter;
    ...MaxPageSizeQueryParameter;
  }>;
};
alias DiscoGroupsListRunsParameter = {
  ...FilterQueryParameter;
  ...SkipQueryParameter;
  ...MaxPageSizeQueryParameter;
  ...DiscoGroupNameParameter;
};
alias TasksListTrait = {
  ...PageResultBodyFields<{
    @doc("The total number of items available in the full result set.")
    totalElements?: int64;
  }>;
  ...QueryParametersTrait<{
    ...FilterQueryParameter;
    ...OrderByParameter;
    ...SkipQueryParameter;
    ...MaxPageSizeQueryParameter;
  }>;
};
alias DiscoGroupsListTrait = {
  ...PageResultBodyFields<{
    @doc("The total number of items available in the full result set.")
    totalElements?: int64;
  }>;
  ...QueryParametersTrait<{
    ...FilterQueryParameter;
    ...SkipQueryParameter;
    ...MaxPageSizeQueryParameter;
  }>;
};
alias DiscoTemplatesListTrait = {
  ...PageResultBodyFields<{
    @doc("The total number of items available in the full result set.")
    totalElements?: int64;
  }>;
  ...QueryParametersTrait<{
    ...FilterQueryParameter;
    ...SkipQueryParameter;
    ...MaxPageSizeQueryParameter;
  }>;
};
alias SavedFiltersListTrait = {
  ...PageResultBodyFields<{
    @doc("The total number of items available in the full result set.")
    totalElements?: int64;
  }>;
  ...QueryParametersTrait<{
    ...FilterQueryParameter;
    ...SkipQueryParameter;
    ...MaxPageSizeQueryParameter;
  }>;
};

alias ObservationsParameters = {
  ...QueryParametersTrait<{
    ...FilterQueryParameter;
    ...OrderByParameter;
    ...SkipQueryParameter;
    ...MaxPageSizeQueryParameter;
  }>;
};

alias AssetsExportTrait = {
  ...QueryParametersTrait<{
    ...FilterQueryParameter;
    ...OrderByParameter;
  }>;
};
alias ObservationsTrait = {
  ...QueryParametersTrait<{
    ...FilterQueryParameter;
    ...OrderByParameter;
    ...SkipQueryParameter;
    ...MaxPageSizeQueryParameter;
  }>;
};

alias DeltaDetailsTrait = {
  ...QueryParametersTrait<{
    ...SkipQueryParameter;
    ...MaxPageSizeQueryParameter;
  }>;
};

alias CisaCveListTrait = {
  ...PageResultBodyFields<{
    @doc("The total number of items available in the full result set.")
    totalElements?: int64;
  }>;
};

// Models
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("AlexaDetails", "java")
model AlexaInfo {
  alexaRank?: int64;
  category?: string;
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  recent?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model AsAsset extends InventoryAsset {
  asn?: int64;
  asNames?: ObservedString[];
  orgNames?: ObservedString[];
  orgIds?: ObservedString[];
  countries?: ObservedString[];
  registries?: ObservedString[];
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  registrarCreatedAt?: ObservedLong[];
  registrarUpdatedAt?: ObservedLong[];
  registrantContacts?: ObservedString[];
  adminContacts?: ObservedString[];
  technicalContacts?: ObservedString[];
  registrarNames?: ObservedString[];
  registrantNames?: ObservedString[];
  adminNames?: ObservedString[];
  technicalNames?: ObservedString[];
  adminOrgs?: ObservedString[];
  technicalOrgs?: ObservedString[];
  registrantPhones?: ObservedString[];
  adminPhones?: ObservedString[];
  technicalPhones?: ObservedString[];
  detailedFromWhoisAt?: utcDateTime;
}

@doc("The page of assets that match the provided metric.")
@pagedResult
model AssetPageResult {
  @doc("The total number of items available in the full result set.")
  totalElements?: int64;

  @doc("The cursor mark to be used on the next request.  Not set if using paging.")
  mark?: string;

  @doc("The link to access the next page of results.  Not set if at the end of the result set.")
  @nextLink
  nextLink?: string;

  @doc("The items in the current page of results.")
  @items
  value?: AssetResource[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The items in the current page of results.")
@discriminator("kind")
@resource("assets")
model AssetResource {
  /** Discriminator property for AssetResource. */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  kind: string;

  @doc("The system generated unique id for the resource.")
  @key("assetId")
  @visibility("read")
  id: string;

  @doc("The caller provided unique name for the resource.")
  name?: string;

  @doc("The name that can be used for display purposes.")
  displayName?: string;

  @doc("Global UUID for the asset.")
  uuid?: uuid;

  @doc("The date this asset was first added to this workspace.")
  createdDate?: utcDateTime;

  @doc("The date this asset was last updated for this workspace.")
  updatedDate?: utcDateTime;

  state?: AssetState;

  @doc("An optional customer provided identifier for this asset.")
  externalId?: string;

  @doc("Customer labels assigned to this asset.")
  labels?: string[];

  @doc("An indicator of whether this asset represents a wildcard rollup of assets on this domain.")
  wildcard?: boolean;

  @doc("The name of the DiscoGroup that brought added this asset to the workspace.")
  discoGroupName?: string;

  @doc("The history of how this asset was pulled into the workspace through the discovery process.")
  auditTrail?: AuditTrailItem[];

  reason?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model AssetSecurityPolicy {
  policyName?: string;
  isAffected?: boolean;
  description?: string;
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  recent?: boolean;
  sources?: Source[];
}

@doc("The collection of asset summaries.")
model AssetSummaryResult {
  @doc("The name of the summary response.  Depending on the request time this will either be the asset filter, risk category, or risk metric.")
  displayName?: string;

  @doc("The description of the summary response.  Filters don't have a description.")
  description?: string;

  @doc("The last time risk categories or risk metrics were captured. Set to the current time for asset filter requests, which always pull the live asset data.")
  updatedAt?: utcDateTime;

  @doc("If the request is for a metric category, this will contain the requested unique category name.")
  metricCategory?: string;

  @doc("If the request is for a metric, this will contain the requested unique metric name.")
  metric?: string;

  @doc("If the request is for an asset filter, this will contain the corresponding filter.")
  filter?: string;

  @doc("An optional label used to filter requests results.")
  labelName?: string;

  @doc("The count of assets matching the request parameters.")
  count?: int64;

  @doc("The link to the corresponding asset details.")
  link?: string;

  @doc("The corresponding child entities.  For metric categories this will contain metrics.  For filters with groupBy and segmentBy this will contain facets.")
  children?: AssetSummaryResult[];
}

@doc("A request body used to update an asset.")
@clientName("AssetUpdatePayload", "csharp")
model AssetUpdateData {
  @doc("The state to update the asset to.")
  state?: AssetUpdateState;

  @doc("A string which can be used to identify the asset in external systems.")
  externalId?: string;

  @doc("Any Labels to update the asset with.")
  labels?: Record<boolean>;

  @doc("A list of asset types to cascade the updates to.")
  transfers?: AssetUpdateTransfers;
}

@doc("A request body used to export an asset.")
@Versioning.added(Versions.v2024_03_01_preview)
model AssetsExportRequest {
  @doc("The name of the file to export.")
  fileName: string;

  @doc("The columns to export.")
  columns: string[];
}

@doc("A request body used to retrieve a list of deltas.")
@Versioning.added(Versions.v2024_03_01_preview)
model DeltaDetailsRequest {
  @doc("The type of delta detail to retrieve.")
  deltaDetailType: DeltaDetailType;

  @doc("The number of days prior to retrieve deltas for.")
  priorDays?: int32;

  @doc("The type of asset")
  kind: GlobalAssetType;

  @doc("expected format to be: yyyy-MM-dd")
  date?: string;
}

@doc("A request body used to retrieve a delta summary.")
@Versioning.added(Versions.v2024_03_01_preview)
model DeltaSummaryRequest {
  @doc("The number of days prior to retrieve deltas for.")
  priorDays?: int32;

  @doc("expected format to be: yyyy-MM-dd")
  date?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("AttributeDetails", "csharp")
model Attribute {
  attributeType?: string;
  attributeValue?: string;
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  recent?: boolean;
}

@doc("The history of how this asset was pulled into the workspace through the discovery process.")
model AuditTrailItem {
  @doc("The system generated unique id for the resource.")
  id?: string;

  @doc("The caller provided unique name for the resource.")
  name?: string;

  @doc("The name that can be used for display purposes.")
  displayName?: string;

  @doc("The kind of asset.")
  kind?: AuditTrailItemKind;

  @doc("An explanation of why this audit trail node was discovered from the previous node.")
  reason?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model AzureDataExplorerDataConnectionProperties
  extends DataConnectionProperties {
  @doc("The azure data explorer cluster name")
  clusterName?: string;

  @doc("The azure data explorer region")
  region?: string;

  @doc("The azure data explorer database name")
  databaseName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict"
@clientName("BannerDetails", "csharp")
model Banner {
  port?: int32;

  @clientName("bannerName", "csharp")
  banner?: string;

  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  scanType?: string;
  bannerMetadata?: string;
  recent?: boolean;
  sha256?: string;
  sources?: Source[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model Cvss3Summary {
  version?: string;
  vectorString?: string;
  attackVector?: string;
  attackComplexity?: string;
  privilegesRequired?: string;
  userInteraction?: string;
  scope?: string;
  confidentialityImpact?: string;
  integrityImpact?: string;
  availabilityImpact?: string;
  baseScore?: float32;
  baseSeverity?: string;
  exploitCodeMaturity?: string;
  remediationLevel?: string;
  reportConfidence?: string;
  exploitabilityScore?: float32;
  impactScore?: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ContactAsset extends InventoryAsset {
  email?: string;
  names?: ObservedString[];
  organizations?: ObservedString[];
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("CookieDetails", "csharp")
model Cookie {
  cookieName?: string;
  cookieDomain?: string;
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  recent?: boolean;
  cookieExpiryDate?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("CveDetails", "csharp")
model Cve {
  name?: string;
  cweId?: string;
  cvssScore?: float32;
  cvss3Summary?: Cvss3Summary;
}

@doc("The properties required to establish connection to a particular service")
model DataConnectionProperties {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@discriminator("kind")
@clientName("DataConnectionPayload", "csharp")
model DataConnectionData {
  /** Discriminator property for DataConnectionData. */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  kind: string;

  @doc("The name of data connection")
  name?: string;

  @doc("The type of data the data connection will transfer.")
  content?: DataConnectionContent;

  @doc("The rate at which the data connection will receive updates.")
  frequency?: DataConnectionFrequency;

  @doc("The day to update the data connection on. (1-7 for weekly, 1-31 for monthly)")
  frequencyOffset?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@discriminator("kind")
@resource("dataConnections")
model DataConnection {
  /** Discriminator property for DataConnection. */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  kind: string;

  @doc("The system generated unique id for the resource.")
  id?: string;

  @doc("The caller provided unique name for the resource.")
  @key("dataConnectionName")
  @visibility("read")
  name: string;

  @doc("The name that can be used for display purposes.")
  displayName?: string;

  @doc("The type of data the data connection will transfer")
  content?: DataConnectionContent;

  @doc("The date the data connection was created.")
  @visibility("read")
  createdDate?: utcDateTime;

  @doc("The rate at which the data connection will receive updates.")
  frequency?: DataConnectionFrequency;

  @doc("The day to update the data connection on.")
  frequencyOffset?: int32;

  @doc("The date the data connection was last updated.")
  @visibility("read")
  updatedDate?: utcDateTime;

  @doc("The date the data connection was last updated by user.")
  @visibility("read")
  userUpdatedAt?: utcDateTime;

  @doc("An indicator of whether the data connection is active.")
  active?: boolean;

  @doc("A message that specifies details about data connection if inactive.")
  @visibility("read")
  inactiveMessage?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model DependentResource {
  md5?: string;
  responseBodySize?: int64;
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  firstSeenCrawlGuid?: string;
  firstSeenPageGuid?: string;
  firstSeenResourceGuid?: string;
  lastSeenCrawlGuid?: string;
  lastSeenPageGuid?: string;
  lastSeenResourceGuid?: string;
  responseBodyMinhash?: int32[];
  contentType?: string;
  sha256?: string;
  sha384?: string;
  sha512?: string;
  url?: url;
  cached?: boolean;
  sriChecks?: SubResourceIntegrityCheck[];
  host?: string;
  lastObservedViolation?: utcDateTime;
  lastObservedValidation?: utcDateTime;
  lastObservedActualSriHash?: string;
  lastObservedExpectedSriHash?: string;
}

@doc("A request body used to create a discovery group.")
@clientName("DiscoveryGroupPayload", "csharp")
model DiscoGroupData {
  @doc("The name for a disco group.")
  name?: string;

  @doc("The description for a disco group.")
  description?: string;

  @doc("The tier for the disco group which will affect the algorithm used for the disco runs in this group.")
  tier?: string;

  @doc("The frequency at which the disco group is supposed to be rerun in milliseconds.")
  frequencyMilliseconds?: int64;

  @doc("The list of seeds used for the disco group runs.")
  seeds?: DiscoSource[];

  @doc("The list of names used for the disco group runs.")
  names?: string[];

  @doc("The list of excludes used for the disco group runs, aka assets to exclude from the discovery algorithm.")
  excludes?: DiscoSource[];

  @doc("The unique identifier for the disco template used for the disco group creation.")
  templateId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@resource("discoGroups")
@clientName("DiscoveryGroup", "csharp")
model DiscoGroup {
  @doc("The system generated unique id for the resource.")
  id?: string;

  @doc("The caller provided unique name for the resource.")
  @key("groupName")
  @visibility("read")
  name: string;

  @doc("The name that can be used for display purposes.")
  displayName?: string;

  @doc("The description for a disco group.")
  description?: string;

  @doc("The tier for the disco group which will affect the algorithm used for the disco runs in this group.")
  tier?: string;

  @doc("The frequency at which the disco group is supposed to be rerun in milliseconds.")
  frequencyMilliseconds?: int64;

  @doc("The list of seeds used for the disco group runs.")
  seeds?: DiscoSource[];

  @doc("The list of names used for the disco group runs.")
  names?: string[];

  @doc("The list of excludes used for the disco group runs, aka assets to exclude from the discovery algorithm.")
  excludes?: DiscoSource[];

  @doc("The latest run of this disco group with some limited information, null if the group has never been run.")
  latestRun?: DiscoRunResult;

  @doc("The date for the disco group was created.")
  createdDate?: utcDateTime;

  @doc("The unique identifier for the disco template used for the disco group creation.")
  templateId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@pagedResult
@clientName("DiscoveryRunPageResult", "csharp")
model DiscoRunPageResult {
  @doc("The total number of items available in the full result set.")
  totalElements?: int64;

  @doc("The link to access the next page of results.  Not set if at the end of the result set.")
  @nextLink
  nextLink?: string;

  @doc("The items in the current page of results.")
  @items
  value?: DiscoRunResult[];
}

@doc("The latest run of this disco group with some limited information, null if the group has never been run.")
@clientName("DiscoveryRunResult", "csharp")
model DiscoRunResult {
  @doc("The date for when the disco run was created in the system.")
  submittedDate?: utcDateTime;

  @doc("The date for when the disco run was actually started by the system.")
  startedDate?: utcDateTime;

  @doc("The date for when the disco run was completed by the system.")
  completedDate?: utcDateTime;

  @doc("The tier which will affect the algorithm used for the disco run.")
  tier?: string;

  @doc("The State of the disco run.")
  state?: DiscoRunState;

  @doc("The total count of assets that were found this disco run.")
  totalAssetsFoundCount?: int64;

  @doc("The list of seeds used for the disco run.")
  seeds?: DiscoSource[];

  @doc("The list of excludes used for the disco run, aka assets to exclude from the discovery algorithm.")
  excludes?: DiscoSource[];

  @doc("The list of names used for the disco run.")
  names?: string[];
}

@doc("Source entity used to drive discovery.")
@clientName("DiscoverySource", "csharp")
model DiscoSource {
  @doc("The kind of disco source.")
  kind?: DiscoSourceKind;

  @doc("The name for the disco source.")
  name?: string;
}

@doc("The items in the current page of results.")
@clientName("DiscoveryTemplate", "csharp")
@resource("discoTemplates")
model DiscoTemplate {
  @doc("The system generated unique id for the resource.")
  @key("templateId")
  @visibility("read")
  id: string;

  @doc("The caller provided unique name for the resource.")
  name?: string;

  @doc("The name that can be used for display purposes.")
  displayName?: string;

  @doc("The name of the industry.")
  industry?: string;

  @doc("The name of the region.")
  region?: string;

  @doc("The country code.")
  countryCode?: string;

  @doc("The state code.")
  stateCode?: string;

  @doc("The name of the city.")
  city?: string;

  @doc("The list of disco template seeds.")
  seeds?: DiscoSource[];

  @doc("The list of disco template names.")
  names?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model DomainAsset {
  domain?: string;
  whoisId?: int64;
  registrarIanaIds?: ObservedInteger[];
  registrantContacts?: ObservedString[];
  registrantOrgs?: ObservedString[];
  adminContacts?: ObservedString[];
  technicalContacts?: ObservedString[];
  alexaInfos?: AlexaInfo[];
  nameServers?: ObservedString[];
  mailServers?: ObservedString[];
  whoisServers?: ObservedString[];
  domainStatuses?: ObservedString[];
  registrarCreatedAt?: ObservedLong[];
  registrarUpdatedAt?: ObservedLong[];
  registrarExpiresAt?: ObservedLong[];
  soaRecords?: SoaRecord[];
  detailedFromWhoisAt?: utcDateTime;
  registrarNames?: ObservedString[];
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  parkedDomain?: ObservedBoolean[];
  registrantNames?: ObservedString[];
  adminNames?: ObservedString[];
  technicalNames?: ObservedString[];
  adminOrgs?: ObservedString[];
  technicalOrgs?: ObservedString[];
  registrantPhones?: ObservedString[];
  adminPhones?: ObservedString[];
  technicalPhones?: ObservedString[];
}

@doc("This is the top-level error object whose code matches the x-ms-error-code response header.")
model ErrorDetail {
  @doc("This is one of a server-defined set of error codes.")
  code: string;

  @doc("This is a human-readable representation of the error.")
  message: string;

  @doc("This is the error target.")
  target?: string;

  @doc("This is an array of details about specific errors that led to this reported error.")
  details?: ErrorDetail[];

  @doc("This is an object containing more specific information than the current object about the error.")
  innererror?: InnerError;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model GuidPair {
  pageGuid?: string;
  crawlStateGuid?: string;
  loadDate?: utcDateTime;
  recent?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model HostAsset extends InventoryAsset {
  host?: string;
  domain?: string;
  ipAddresses?: ObservedString[];
  webComponents?: WebComponent[];
  headers?: ObservedHeader[];
  attributes?: Attribute[];
  cookies?: Cookie[];
  sslCerts?: SslCertAsset[];
  parentHosts?: ObservedString[];
  childHosts?: ObservedString[];
  hostCore?: HostCore;
  services?: Service[];
  cnames?: ObservedString[];
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  resourceUrls?: ResourceUrl[];
  scanMetadata?: ScanMetadata[];
  asns?: ObservedLong[];
  ipBlocks?: IpBlock[];
  responseBodies?: ObservedString[];
  domainAsset?: DomainAsset;
  nsRecord?: ObservedBoolean[];
  mxRecord?: ObservedBoolean[];
  webserver?: ObservedBoolean[];
  location?: ObservedLocation[];
  nxdomain?: ObservedBoolean[];
  sslServerConfig?: SslServerConfig[];
  isWildcard?: ObservedBoolean[];
  banners?: Banner[];
  ipv4?: ObservedBoolean[];
  ipv6?: ObservedBoolean[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model HostCore {
  host?: string;
  domain?: string;
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  blacklistCauseFirstSeen?: utcDateTime;
  blacklistCauseLastSeen?: utcDateTime;
  blacklistCauseCount?: int64;
  blacklistResourceFirstSeen?: utcDateTime;
  blacklistResourceLastSeen?: utcDateTime;
  blacklistResourceCount?: int64;
  blacklistSequenceFirstSeen?: utcDateTime;
  blacklistSequenceLastSeen?: utcDateTime;
  blacklistSequenceCount?: int64;
  phishCauseCount?: int64;
  malwareCauseCount?: int64;
  spamCauseCount?: int64;
  scamCauseCount?: int64;
  phishResourceCount?: int64;
  malwareResourceCount?: int64;
  spamResourceCount?: int64;
  scamResourceCount?: int64;
  phishSequenceCount?: int64;
  malwareSequenceCount?: int64;
  spamSequenceCount?: int64;
  scamSequenceCount?: int64;
  alexaRank?: int32;
  hostReputationScore?: int32;
  hostPhishReputationScore?: int32;
  hostMalwareReputationScore?: int32;
  hostSpamReputationScore?: int32;
  hostScamReputationScore?: int32;
  domainReputationScore?: int32;
  domainPhishReputationScore?: int32;
  domainMalwareReputationScore?: int32;
  domainSpamReputationScore?: int32;
  domainScamReputationScore?: int32;
  uuid?: string;
}

@doc("This is an object containing more specific information than the current object about the error.")
model InnerError {
  @doc("This is a more specific error code than was provided by the containing error.")
  code?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  @doc("This is an additional field representing the value that caused the error to help with debugging.")
  value?: unknown;
}

@doc("A inventory base model created for swagger documentation purpose")
model InventoryAsset {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model IpAddressAsset extends InventoryAsset {
  ipAddress?: string;
  asns?: ObservedLong[];
  reputations?: Reputation[];
  webComponents?: WebComponent[];
  netRanges?: ObservedString[];
  headers?: ObservedHeader[];
  attributes?: Attribute[];
  cookies?: Cookie[];
  sslCerts?: SslCertAsset[];
  services?: Service[];
  ipBlocks?: IpBlock[];
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  banners?: Banner[];
  scanMetadata?: ScanMetadata[];
  nsRecord?: ObservedBoolean[];
  mxRecord?: ObservedBoolean[];
  location?: ObservedLocation[];
  hosts?: ObservedString[];
  nxdomain?: ObservedBoolean[];
  sslServerConfig?: SslServerConfig[];
  ipv4?: boolean;
  ipv6?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict"
model IpBlock {
  @clientName("ipBlockName", "csharp")
  ipBlock?: string;

  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  recent?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model IpBlockAsset extends InventoryAsset {
  ipBlock?: string;
  asns?: ObservedLong[];
  bgpPrefixes?: ObservedString[];
  netNames?: ObservedString[];
  registrantContacts?: ObservedString[];
  registrantOrgs?: ObservedString[];
  adminContacts?: ObservedString[];
  technicalContacts?: ObservedString[];
  registrarCreatedAt?: ObservedLong[];
  registrarUpdatedAt?: ObservedLong[];
  netRanges?: ObservedString[];
  startIp?: string;
  endIp?: string;
  reputations?: Reputation[];
  detailedFromWhoisAt?: utcDateTime;
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  location?: ObservedLocation[];
  registrarExpiresAt?: ObservedLong[];
  registrantNames?: ObservedString[];
  adminNames?: ObservedString[];
  technicalNames?: ObservedString[];
  adminOrgs?: ObservedString[];
  technicalOrgs?: ObservedString[];
  registrantPhones?: ObservedString[];
  adminPhones?: ObservedString[];
  technicalPhones?: ObservedString[];
  ipv4?: boolean;
  ipv6?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("ObservedLocationDetails", "csharp")
model Location {
  countryCode?: string;
  countryName?: string;
  region?: string;
  regionName?: string;
  city?: string;
  areaCode?: int32;
  postalCode?: string;
  latitude?: float32;
  longitude?: float32;
  dmaCode?: int32;
  metroCodeId?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model LogAnalyticsDataConnectionProperties extends DataConnectionProperties {
  @doc("log analytics api key")
  apiKey?: string;

  @doc("log analytics workspace id")
  workspaceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ObservedBoolean extends ObservedValue {
  value?: boolean;
  sources?: Source[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ObservedHeader extends ObservedValue {
  headerName?: string;
  headerValue?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ObservedInteger extends ObservedValue {
  value?: int32;
  sources?: Source[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ObservedIntegers extends ObservedValue {
  values?: int32[];
  sources?: Source[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ObservedLocation extends ObservedValue {
  value?: Location;
  sources?: Source[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ObservedLong extends ObservedValue {
  value?: int64;
  sources?: Source[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ObservedPortState extends ObservedValue {
  value?: ObservedPortStateValue;
  port?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ObservedString extends ObservedValue {
  value?: string;
  sources?: Source[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model PageAsset extends InventoryAsset {
  url?: url;
  httpMethod?: string;
  service?: string;
  ipAddresses?: ObservedString[];
  successful?: ObservedBoolean[];
  httpResponseCodes?: ObservedInteger[];
  httpResponseMessages?: ObservedString[];
  responseTimes?: ObservedLong[];
  frames?: ObservedBoolean[];
  windows?: ObservedBoolean[];
  nonHtmlFrames?: ObservedBoolean[];
  undirectedContent?: ObservedBoolean[];
  contentTypes?: ObservedString[];
  contentLengths?: ObservedLong[];
  windowNames?: ObservedString[];
  charsets?: ObservedString[];
  titles?: ObservedString[];
  languages?: ObservedString[];
  responseHeaders?: ObservedHeader[];
  cookies?: Cookie[];
  webComponents?: WebComponent[];
  attributes?: Attribute[];
  assetSecurityPolicies?: AssetSecurityPolicy[];
  responseBodyMinhashSignatures?: ObservedIntegers[];
  fullDomMinhashSignatures?: ObservedIntegers[];
  responseBodyHashSignatures?: ObservedString[];
  errors?: ObservedString[];
  sslCerts?: SslCertAsset[];
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  cause?: PageCause;
  referrer?: string;
  redirectUrls?: ObservedString[];
  redirectType?: PageAssetRedirectType;
  finalUrls?: ObservedString[];
  finalResponseCodes?: ObservedInteger[];
  parkedPage?: ObservedBoolean[];
  resourceUrls?: ResourceUrl[];
  guids?: GuidPair[];
  finalIpAddresses?: ObservedString[];
  asns?: ObservedLong[];
  ipBlocks?: IpBlock[];
  finalAsns?: ObservedLong[];
  finalIpBlocks?: IpBlock[];
  responseBodies?: ObservedString[];
  domainAsset?: DomainAsset;
  rootUrl?: ObservedBoolean;
  isRootUrl?: boolean;
  location?: ObservedLocation[];
  services?: Service[];
  siteStatus?: string;
  cnames?: ObservedString[];
  cdns?: ObservedString[];
  host?: string;
  domain?: string;
  sslServerConfig?: SslServerConfig[];
  gdprAssetSecurityPolicies?: AssetSecurityPolicy[];
  ipv4?: ObservedBoolean[];
  ipv6?: ObservedBoolean[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model PageCause {
  cause?: string;
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  causeElementXPath?: string;
  location?: string;
  possibleMatches?: int32;
  loopDetected?: boolean;
  version?: int32;
  domChangeIndex?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict"
@clientName("PortDetails", "csharp")
model Port {
  @clientName("portName", "csharp")
  port?: int32;

  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
}

@doc("A request body used for an asset report snapshot export.")
@clientName("ReportAssetSnapshotExportPayload", "csharp")
model ReportAssetSnapshotExportRequest {
  @doc("The metric to retrieve a snapshot for.")
  metric?: string;

  @doc("The filename of the exported file.")
  fileName?: string;

  @doc("The columns to include in the export")
  columns?: string[];
}

@doc("A request body used to retrieve an asset report snapshot.")
@clientName("ReportAssetSnapshotPayload", "csharp")
model ReportAssetSnapshotRequest {
  @doc("The metric to retrieve a snapshot for.")
  metric?: string;

  @doc("The name of the label to retrieve a snapshot for.")
  labelName?: string;

  @doc("The number of assets per page.")
  size?: int32;

  @doc("The page to retrieve.")
  page?: int32;
}

@doc("A snapshot of assets captured daily for the provided metric.  Asset details only contain primary properties.  Detailed asset data can be retrieved from the asset endpoints.")
model ReportAssetSnapshotResult {
  @doc("The name of the metric.")
  displayName?: string;

  @doc("The unique metric name.")
  metric?: string;

  @doc("The customer label that was filtered on, if one was provided.")
  labelName?: string;

  @doc("The last time this asset data was updated on this metric.")
  updatedAt?: utcDateTime;

  @doc("A description of what the metric represents.")
  description?: string;

  @doc("The page of assets that match the provided metric.")
  assets?: AssetPageResult;
}

@doc("A request body used to retrieve summary asset information. One and only one collection of summary identifiers must be provided: filters, metrics, or metricCategories.")
@clientName("ReportAssetSummaryPayload", "csharp")
model ReportAssetSummaryRequest {
  @doc("Categories to retrieve risk reporting data for.")
  metricCategories?: string[];

  @doc("Metrics to retrieve risk reporting data for.")
  metrics?: string[];

  @doc("Query filters to apply to the asset summary.")
  filters?: string[];

  @doc("A parameter to group the assets by (first level facet field), only used when the chosen summary identifier is filters.")
  groupBy?: string;

  @doc("A parameter to segment the assets by (second level facet field), only used when the chosen summary identifier is filters.")
  segmentBy?: string;

  @doc("Currently unused.")
  labelName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ReportAssetSummaryResult {
  @doc("The collection of asset summaries.")
  assetSummaries?: AssetSummaryResult[];
}

@doc("The breakdown of billable asset counts for each asset type.")
model ReportBillableAssetBreakdown {
  @doc("The kind of billable asset.")
  kind?: ReportBillableAssetBreakdownKind;

  @doc("The number of assets of this type.")
  count?: int64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ReportBillableAssetSnapshotResult {
  @doc("The date these assets were billed on.")
  date?: plainDate;

  @doc("The total number of billable assets for this date.")
  total?: int64;

  @doc("The breakdown of billable asset counts for each asset type.")
  assetBreakdown?: ReportBillableAssetBreakdown[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ReportBillableAssetSummaryResult {
  assetSummaries?: ReportBillableAssetSnapshotResult[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("ReputationDetails", "csharp")
model Reputation {
  listName?: string;
  threatType?: string;
  trusted?: boolean;
  cidr?: string;
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  listUpdatedAt?: utcDateTime;
  recent?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("ResourceUri", "csharp")
model ResourceUrl {
  url?: url;
  resources?: DependentResource[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  recent?: boolean;
}

@doc("A request body used to create a saved filter.")
@clientName("SavedFilterPayload", "csharp")
model SavedFilterData {
  @doc("An expression on the resource type that selects the resources to be returned.")
  filter: string;

  @doc("A human readable description of the saved filter.")
  description: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@resource("savedFilters")
model SavedFilter {
  @doc("The system generated unique id for the resource.")
  id?: string;

  @doc("The caller provided unique name for the resource.")
  @key("filterName")
  @visibility("read")
  name: string;

  @doc("The name that can be used for display purposes.")
  displayName?: string;

  filter?: string;
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ScanMetadata {
  port?: int32;
  bannerMetadata?: string;
  startScan?: utcDateTime;
  endScan?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("AssetService", "csharp")
model Service {
  scheme?: string;
  port?: int32;
  webComponents?: WebComponent[];
  sslCerts?: SslCertAsset[];
  exceptions?: ObservedString[];
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  recent?: boolean;
  portStates?: ObservedPortState[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model SoaRecord {
  nameServer?: string;
  email?: string;
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  serialNumber?: int64;
  recent?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict"
@clientName("SourceDetails", "csharp")
model Source {
  @clientName("sourceName", "csharp")
  source?: string;

  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  reason?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model SslCertAsset extends InventoryAsset {
  sha1?: string;
  subjectCommonNames?: string[];
  organizations?: string[];
  organizationalUnits?: string[];
  issuerCommonNames?: string[];
  sigAlgName?: string;
  invalidAfter?: utcDateTime;
  serialNumber?: string;
  subjectAlternativeNames?: string[];
  issuerAlternativeNames?: string[];
  sources?: Source[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  invalidBefore?: utcDateTime;
  keySize?: int32;
  keyAlgorithm?: string;
  subjectLocality?: string[];
  subjectState?: string[];
  subjectCountry?: string[];
  issuerLocality?: string[];
  issuerState?: string[];
  issuerCountry?: string[];
  subjectOrganizations?: string[];
  subjectOrganizationalUnits?: string[];
  issuerOrganizations?: string[];
  issuerOrganizationalUnits?: string[];
  version?: int32;
  certificateAuthority?: boolean;
  selfSigned?: boolean;
  sigAlgOid?: string;
  recent?: boolean;
  validationType?: SslCertAssetValidationType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model SslServerConfig {
  tlsVersions?: string[];
  cipherSuites?: string[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  sources?: Source[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model SubResourceIntegrityCheck {
  violation?: boolean;
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  causePageUrl?: string;
  crawlGuid?: string;
  pageGuid?: string;
  resourceGuid?: string;
  expectedHash?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@resource("tasks")
@clientName("TaskResource", "csharp")
model Task {
  @doc("The unique identifier of the task.")
  @key("taskId")
  @visibility("read")
  id: string;

  @doc("The time the task started.")
  startedAt?: utcDateTime;

  @doc("The time the task completed.")
  completedAt?: utcDateTime;

  @doc("The last time the status of the task was updated.")
  lastPolledAt?: utcDateTime;

  @doc("The state the task is in.")
  state?: TaskState;

  @doc("The phase the task is in.")
  phase?: TaskPhase;

  @doc("The reason the task was moved into its current state, if the task wasn't completed.")
  reason?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
  @doc("Attributes unique to the task.  This differs by task type.")
  metadata?: Record<unknown>;
}

@doc("Validate result for validate action endpoints")
model ValidateResult {
  @doc("This is the top-level error object whose code matches the x-ms-error-code response header.")
  error?: ErrorDetail;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model WebComponent {
  name?: string;
  type?: string;
  version?: string;
  ruleId?: string[];
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  cve?: Cve[];
  endOfLife?: int64;
  recent?: boolean;
  ports?: Port[];
  sources?: Source[];
  service?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("Template model for observed values")
model ObservedValue {
  firstSeen?: utcDateTime;
  lastSeen?: utcDateTime;
  count?: int64;
  recent?: boolean;
}

@doc("Result for each of the delta detail response")
@Versioning.added(Versions.v2024_03_01_preview)
model DeltaResult {
  @doc("Shows the asset kind")
  kind: GlobalAssetType;

  @doc("Shows the asset name")
  name: string;

  @doc("Shows the date when the asset was originally created")
  createdAt: utcDateTime;

  @doc("Shows the date when the asset was last updated, usually the date the we trying to pull up the results for")
  updatedAt: utcDateTime;

  @doc("Shows the inventory state")
  state: GlobalInventoryState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@Versioning.added(Versions.v2024_03_01_preview)
@pagedResult
model DeltaPageResult {
  @doc("The total number of items available in the full result set.")
  totalElements?: int64;

  @doc("The link to access the next page of results.  Not set if at the end of the result set.")
  @nextLink
  nextLink?: string;

  @doc("The items in the current page of results.")
  @items
  value?: DeltaResult[];
}

@doc("Define response body for getting delta summary")
@Versioning.added(Versions.v2024_03_01_preview)
model DeltaSummaryResult {
  @doc("Contains added, removed, and difference values for the whole range either 7 or 30 days")
  summary: DeltaRangeResult;

  @doc("Contains added, removed, count, and difference values for each day")
  daily: DeltaDateResult[];
}

@doc("Contains added, removed, and difference values for the whole range either 7 or 30 days")
@Versioning.added(Versions.v2024_03_01_preview)
model DeltaRangeResult {
  @doc("The range of dates requested")
  range: int64;

  @doc("The total amount of assets removed over a date range")
  removed: int64;

  @doc("The total amount of assets added over a date range")
  added: int64;

  @doc("The total amount of assets changed removed over a date range")
  difference: int64;

  @doc("A list of summary changes per asset kind")
  kindSummaries: DeltaTypeResponse[];
}

@doc("The type of Delta response for each asset kind")
@Versioning.added(Versions.v2024_03_01_preview)
model DeltaTypeResponse {
  @doc("The kind of asset")
  kind: GlobalAssetType;

  @doc("The amount of assets removed for one asset kind")
  removed: int64;

  @doc("The amount of assets added for one asset kind")
  added: int64;

  @doc("The amount of assets changed for one asset kind")
  difference: int64;
}

@doc("Date information for the delta response")
@Versioning.added(Versions.v2024_03_01_preview)
model DeltaDateResult {
  @doc("The date that is being requested")
  date: utcDateTime;

  @doc("A list of summary counts per day")
  deltas: DailyDeltaTypeResponse[];
}

@doc("Delta response for each day")
@Versioning.added(Versions.v2024_03_01_preview)
model DailyDeltaTypeResponse extends DeltaTypeResponse {
  @doc("The current number of assets for one asset kind")
  count: int64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("A list of asset types to cascade the updates to.")
union AssetUpdateTransfers {
  string,
  "as",
  "contact",
  "domain",
  "host",
  "ipAddress",
  "ipBlock",
  "page",
  "sslCert",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The kind of billable asset.")
union ReportBillableAssetBreakdownKind {
  string,
  "domain",
  "host",
  "ipAddress",
}

@doc("A list of global inventory states.")
@Versioning.added(Versions.v2024_03_01_preview)
union GlobalInventoryState {
  string,

  @doc("candidate")
  "candidate",

  @doc("candidate investigate")
  "candidateInvestigate",

  @doc("confirmed")
  "confirmed",

  @doc("associated")
  "associated",

  @doc("associated partner")
  "associatedPartner",

  @doc("associated third party")
  "associatedThirdParty",

  @doc("archived")
  "archived",

  @doc("dismissed")
  "dismissed",

  @doc("auto confirmed")
  "autoconfirmed",
}

@doc("A list of asset response type")
@Versioning.added(Versions.v2024_03_01_preview)
union AssetResponseType {
  string,

  @doc("Return only the asset id.")
  "id",

  @doc("Return the standard set of asset fields.")
  "standard",

  @doc("Return the full set of asset fields.")
  "full",

  @doc("Return a reduced set of fields.")
  "reduced",
}

@doc("A list of delta detail type")
@Versioning.added(Versions.v2024_03_01_preview)
union DeltaDetailType {
  string,

  @doc("added")
  "added",

  @doc("removed")
  "removed",
}

@doc("A list of global asset type")
@Versioning.added(Versions.v2024_03_01_preview)
union GlobalAssetType {
  string,

  @doc("page")
  "page",

  @doc("resource")
  "resource",

  @doc("mail server")
  "mailServer",

  @doc("name server")
  "nameServer",

  @doc("host")
  "host",

  @doc("domain")
  "domain",

  @doc("ip address")
  "ipAddress",

  @doc("ip block")
  "ipBlock",

  @doc("autonomous system number")
  "as",

  @doc("contact")
  "contact",

  @doc("ssl certificate")
  "sslCert",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The state the task is in.")
@clientName("TaskResourceState", "csharp")
union TaskState {
  string,
  "pending",
  "running",
  "paused",
  "complete",
  "incomplete",
  "failed",
  "warning",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The phase the task is in.")
@clientName("TaskResourcePhase", "csharp")
union TaskPhase {
  string,
  "running",
  "polling",
  "complete",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The kind of data connection.")
union DataConnectionKind {
  string,
  "logAnalytics",
  "azureDataExplorer",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The rate at which the data connection will receive updates.")
union DataConnectionFrequency {
  string,
  "daily",
  "weekly",
  "monthly",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The kind of asset.")
union AssetKind {
  string,
  "as",
  "contact",
  "domain",
  "host",
  "ipAddress",
  "ipBlock",
  "page",
  "sslCert",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The State of the disco run.")
union DiscoRunState {
  string,
  "pending",
  "running",
  "completed",
  "failed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The type of data the data connection will transfer")
union DataConnectionContent {
  string,
  "assets",
  "attackSurfaceInsights",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The kind of disco source.")
@clientName("DiscoverySourceKind", "csharp")
union DiscoSourceKind {
  string,
  "as",
  "attribute",
  "contact",
  "domain",
  "host",
  "ipBlock",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("state of observed port")
union ObservedPortStateValue {
  string,
  "open",
  "closed",
  "filtered",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The state to update the asset to.")
union AssetUpdateState {
  string,
  "candidate",
  "confirmed",
  "dismissed",
  "candidateInvestigate",
  "associatedPartner",
  "associatedThirdparty",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The state of assets")
union AssetState {
  string,
  AssetUpdateState,
  "archived",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The kind of asset.")
union AuditTrailItemKind {
  string,
  "as",
  "contact",
  "domain",
  "host",
  "ipAddress",
  "ipBlock",
  "page",
  "sslCert",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The redirect type of a page")
union PageAssetRedirectType {
  string,
  "httpHeader",
  "metaRefresh",
  "javascript",
  "final",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@doc("The validation type of a Ssl certificate")
union SslCertAssetValidationType {
  string,
  "domainValidation",
  "organizationValidation",
  "extendedValidation",
}

@doc("A list of observation types")
@Versioning.added(Versions.v2024_03_01_preview)
union ObservationType {
  string,

  @doc("common vulnerabilities and exposures")
  "cve",

  @doc("insight")
  "insight",
}

@doc("A list of observation priorities")
@Versioning.added(Versions.v2024_03_01_preview)
union ObservationPriority {
  string,

  @doc("high")
  "high",

  @doc("medium")
  "medium",

  @doc("low")
  "low",

  @doc("none")
  "none",
}

@doc("The result response for the observation")
@Versioning.added(Versions.v2024_03_01_preview)
model ObservationResult {
  @doc("The name of the observation.")
  name: string;

  @doc("The list of applicable types.")
  types: ObservationType[];

  @doc("The priority of the observation.")
  priority: ObservationPriority;

  @doc("The CVSS v2 score.")
  cvssScoreV2: float64;

  @doc("The CVSS v3 score.")
  cvssScoreV3: float64;
}

@doc("The page result response for the observation")
@Versioning.added(Versions.v2024_03_01_preview)
model ObservationPageResult {
  @doc("The total number of elements.")
  totalElements: int64;

  @doc("The summary of observation counts by priority.")
  prioritySummary: Record<int32>;

  @doc("The list of observation results.")
  value: ObservationResult[];
}

@doc("A list of asset chain sources")
@Versioning.added(Versions.v2024_03_01_preview)
union AssetChainSource {
  string,

  @doc("discovery group")
  "DISCO_GROUP",

  @doc("asset")
  "ASSET",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("LogAnalyticsDataConnectionPayload", "csharp")
model LogAnalyticsDataConnectionData extends DataConnectionData {
  @doc("The kind of DataConnectionData ")
  kind: "logAnalytics";

  @doc("properties")
  properties: LogAnalyticsDataConnectionProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
@clientName("AzureDataExplorerDataConnectionPayload", "csharp")
model AzureDataExplorerDataConnectionData extends DataConnectionData {
  @doc("The kind of DataConnectionData")
  kind: "azureDataExplorer";

  @doc("properties")
  properties: AzureDataExplorerDataConnectionProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model AsAssetResource extends AssetResource {
  @doc("The kind of AssetResource")
  kind: "as";

  @doc("asset")
  asset: AsAsset;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model ContactAssetResource extends AssetResource {
  @doc("The kind of AssetResource")
  kind: "contact";

  @doc("asset")
  asset: ContactAsset;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model DomainAssetResource extends AssetResource {
  @doc("The kind of AssetResource")
  kind: "domain";

  @doc("asset")
  asset: DomainAsset;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model HostAssetResource extends AssetResource {
  @doc("The kind of AssetResource")
  kind: "host";

  @doc("asset")
  asset: HostAsset;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model IpAddressAssetResource extends AssetResource {
  @doc("The kind of AssetResource")
  kind: "ipAddress";

  @doc("asset")
  asset: IpAddressAsset;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model IpBlockAssetResource extends AssetResource {
  @doc("The kind of AssetResource")
  kind: "ipBlock";

  @doc("asset")
  asset: IpBlockAsset;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model PageAssetResource extends AssetResource {
  @doc("The kind of AssetResource")
  kind: "page";

  @doc("asset")
  asset: PageAsset;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model SslCertAssetResource extends AssetResource {
  @doc("The kind of AssetResource")
  kind: "sslCert";

  @doc("asset")
  asset: SslCertAsset;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model LogAnalyticsDataConnection extends DataConnection {
  @doc("The kind of DataConnection")
  kind: "logAnalytics";

  @doc("properties")
  properties: LogAnalyticsDataConnectionProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation will be added next preview version"
model AzureDataExplorerDataConnection extends DataConnection {
  @doc("The kind of DataConnection")
  kind: "azureDataExplorer";

  @doc("properties")
  properties: AzureDataExplorerDataConnectionProperties;
}

@doc("The unique identifier for the discovery group.")
@clientName("DiscoveryGroupNameParameter", "csharp")
model DiscoGroupNameParameter {
  @doc("The unique identifier for the discovery group.")
  @path("groupName")
  groupName: string;
}

@doc("A list of expressions that specify the order of the returned resources.")
model OrderByParameter {
  @doc("A list of expressions that specify the order of the returned resources.")
  @query("orderby")
  orderby?: string;
}

@doc("Specify this value instead of 'skip' to use cursor-based searching. Initial value is '*' and subsequent values are returned in the response.")
model MarkParameter {
  @doc("Specify this value instead of 'skip' to use cursor-based searching. Initial value is '*' and subsequent values are returned in the response.")
  @query("mark")
  mark?: string;
}

@doc("Specify the response type.")
@Versioning.added(Versions.v2024_03_01_preview)
model ResponseTypeParameter {
  @doc("Specify the response type. The possible values are: ID, STANDARD, FULL, REDUCED")
  @query("responseType")
  responseType?: AssetResponseType;
}

@doc("The prameter of responseIncludes")
@Versioning.added(Versions.v2024_03_01_preview)
model ResponseIncludesParameter {
  @query({
    format: "csv",
  })
  @doc("The properties to include in the response.")
  responseIncludes?: string[];
}

@doc("The prameter of responseIncludes")
@Versioning.added(Versions.v2024_03_01_preview)
model RecentOnlyParameter {
  @query("recentOnly")
  @doc("If it's recent only.")
  recentOnly?: boolean;
}

@doc("An expression on the resource type that selects the resources to be returned.")
model RequiredFilterParameter {
  @doc("An expression on the resource type that selects the resources to be returned.")
  @query("filter")
  filter: string;
}

@resource("cisaCves")
@doc("cisa cve in a given workspace.")
@Versioning.added(Versions.v2024_03_01_preview)
model CisaCveResult {
  @key("cveId")
  @visibility("read")
  @doc("The CVE ID of the vulnerability in the format CVE-YYYY-NNNN, note that the number portion can have more than 4 digits.")
  cveId: string;

  @doc("The vendor or project name for the vulnerability.")
  vendorProject: string;

  @doc("The vulnerability product")
  product: string;

  @doc("The name of the vulnerability")
  vulnerabilityName: string;

  @doc("A short description of the vulnerability")
  shortDescription: string;

  @doc("The required action to address the vulnerability")
  requiredAction: string;

  @doc("Any additional notes about the vulnerability")
  notes: string;

  @doc("The date the vulnerability was added to the catalog in the format YYYY-MM-DD")
  dateAdded: utcDateTime;

  @doc("The date the required action is due in the format YYYY-MM-DD")
  dueDate: utcDateTime;

  @doc("The date the vulnerability was updated")
  updatedAt: utcDateTime;

  @doc("The number of assets affected by the vulnerability")
  count: int64;
}

@doc("AssetChainRequest containing information needed for the retrieval of the asset chain summary.")
@Versioning.added(Versions.v2024_03_01_preview)
model AssetChainRequest {
  @doc("Asset chain source.")
  assetChainSource: AssetChainSource;

  @doc("A collection of asset chain source ids.")
  sourceIds: string[];
}

@doc("Response for the asset chain summary.")
@Versioning.added(Versions.v2024_03_01_preview)
model AssetChainSummaryResult {
  @doc("A list of asset chain summaries per asset kind")
  affectedAssetsSummary: AssetChainKindSummaryResult[];

  @doc("A list of disco group summaries")
  affectedGroupsSummary: DiscoGroupSummaryResult[];

  @doc("The list of exceptions")
  errors?: ErrorResponse[];
}

@doc("A list of asset chain summaries per asset kind")
@Versioning.added(Versions.v2024_03_01_preview)
model AssetChainKindSummaryResult {
  @doc("The kind of asset")
  kind: AssetKind;

  @doc("The amount of assets affected for a given asset kind")
  affectedCount: int64;
}

@doc("A list of disco group summaries")
@Versioning.added(Versions.v2024_03_01_preview)
model DiscoGroupSummaryResult {
  @doc("The system generated unique id for the resource.")
  id: string;

  @doc("The caller provided unique name for the resource.")
  name: string;

  @doc("The name that can be used for display purposes.")
  displayName: string;
}

alias BodyParameter<
  T,
  TName extends valueof string = "body",
  TDoc extends valueof string = "Body parameter."
> = {
  @doc(TDoc)
  @friendlyName(TName)
  @bodyRoot
  body: T;
};
