import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- OpenSearchDomainStatuses ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Open Search Domain Status",
    plural: "Open Search Domain Statuses",
  },
  keywords: ["Microsoft.AwsConnector", "Open", "Search", "Domain", "Status"],
})
@doc("A Microsoft.AwsConnector resource")
model OpenSearchDomainStatus
  is TrackedResource<OpenSearchDomainStatusProperties> {
  @doc("Name of OpenSearchDomainStatus")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("openSearchDomainStatuses")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenSearchDomainStatus")
model OpenSearchDomainStatusProperties {
  @doc("AWS Properties")
  awsProperties?: AwsOpenSearchDomainStatusProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsOpenSearchDomainStatus")
model AwsOpenSearchDomainStatusProperties {
  @doc("<p>The Amazon Resource Name (ARN) of the domain. For more information, see <a href='https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html'>IAM identifiers </a> in the <i>AWS Identity and Access Management User Guide</i>.</p>")
  arn?: string;

  @doc("<p>Identity and Access Management (IAM) policy document specifying the access policies for the domain.</p>")
  accessPolicies?: string;

  @doc("<p>Key-value pairs that specify advanced configuration options.</p>")
  advancedOptions?: Record<string>;

  @doc("<p>Settings for fine-grained access control.</p>")
  advancedSecurityOptions?: AdvancedSecurityOptions;

  @doc("<p>Auto-Tune settings for the domain.</p>")
  autoTuneOptions?: AutoTuneOptionsOutput;

  @doc("<p>Information about a configuration change happening on the domain.</p>")
  changeProgressDetails?: ChangeProgressDetails;

  @doc("<p>Container for the cluster configuration of the domain.</p>")
  clusterConfig?: ClusterConfig;

  @doc("<p>Key-value pairs to configure Amazon Cognito authentication for OpenSearch Dashboards.</p>")
  cognitoOptions?: CognitoOptions;

  @doc("<p>Creation status of an OpenSearch Service domain. True if domain creation is complete. False if domain creation is still in progress.</p>")
  created?: boolean;

  @doc("<p>Deletion status of an OpenSearch Service domain. True if domain deletion is complete. False if domain deletion is still in progress. Once deletion is complete, the status of the domain is no longer returned.</p>")
  deleted?: boolean;

  @doc("<p>Additional options for the domain endpoint, such as whether to require HTTPS for all traffic.</p>")
  domainEndpointOptions?: DomainEndpointOptions;

  @doc("<p>Unique identifier for the domain.</p>")
  domainId?: string;

  @doc("<p>Name of the domain. Domain names are unique across all domains owned by the same account within an Amazon Web Services Region.</p>")
  domainName?: string;

  @doc("<p>The status of any changes that are currently in progress for the domain.</p>")
  domainProcessingStatus?: DomainProcessingStatusTypeEnumValue;

  @doc("<p>Container for EBS-based storage settings for the domain.</p>")
  ebsOptions?: EBSOptions;

  @doc("<p>Encryption at rest settings for the domain.</p>")
  encryptionAtRestOptions?: EncryptionAtRestOptions;

  @doc("<p>Domain-specific endpoint used to submit index, search, and data upload requests to the domain.</p>")
  endpoint?: string;

  @doc("<p>If <code>IPAddressType</code> to set to <code>dualstack</code>, a version 2 domain endpoint is provisioned. This endpoint functions like a normal endpoint, except that it works with both IPv4 and IPv6 IP addresses. Normal endpoints work only with IPv4 IP addresses. </p>")
  endpointV2?: string;

  @doc("<p>The key-value pair that exists if the OpenSearch Service domain uses VPC endpoints. Example <code>key, value</code>: <code>'vpc','vpc-endpoint-h2dsd34efgyghrtguk5gt6j2foh4.us-east-1.es.amazonaws.com'</code>.</p>")
  endpoints?: Record<string>;

  @doc("<p>Version of OpenSearch or Elasticsearch that the domain is running, in the format <code>Elasticsearch_X.Y</code> or <code>OpenSearch_X.Y</code>.</p>")
  engineVersion?: string;

  @doc("<p>The type of IP addresses supported by the endpoint for the domain.</p>")
  ipAddressType?: IPAddressTypeEnumValue;

  @doc("<p>Log publishing options for the domain.</p>")
  logPublishingOptions?: Record<LogPublishingOption>;

  @doc("<p>Information about the domain properties that are currently being modified.</p>")
  @extension("x-ms-identifiers", [])
  modifyingProperties?: ModifyingProperties[];

  @doc("<p>Whether node-to-node encryption is enabled or disabled.</p>")
  nodeToNodeEncryptionOptions?: NodeToNodeEncryptionOptions;

  @doc("<p>Options that specify a custom 10-hour window during which OpenSearch Service can perform configuration changes on the domain.</p>")
  offPeakWindowOptions?: OffPeakWindowOptions;

  @doc("<p>The status of the domain configuration. True if OpenSearch Service is processing configuration changes. False if the configuration is active.</p>")
  processing?: boolean;

  @doc("<p>The current status of the domain's service software.</p>")
  serviceSoftwareOptions?: ServiceSoftwareOptions;

  @doc("<p>DEPRECATED. Container for parameters required to configure automated snapshots of domain indexes.</p>")
  snapshotOptions?: SnapshotOptions;

  @doc("<p>Service software update options for the domain.</p>")
  softwareUpdateOptions?: SoftwareUpdateOptions;

  @doc("<p>The status of a domain version upgrade to a new version of OpenSearch or Elasticsearch. True if OpenSearch Service is in the process of a version upgrade. False if the configuration is active.</p>")
  upgradeProcessing?: boolean;

  @doc("<p>The VPC configuration for the domain.</p>")
  vpcOptions?: VPCDerivedInfo;
}

@doc("DomainProcessingStatusType enum")
union DomainProcessingStatusType {
  @doc("DomainProcessingStatusType enum Active")
  Active: "Active",

  @doc("DomainProcessingStatusType enum Creating")
  Creating: "Creating",

  @doc("DomainProcessingStatusType enum Deleting")
  Deleting: "Deleting",

  @doc("DomainProcessingStatusType enum Isolated")
  Isolated: "Isolated",

  @doc("DomainProcessingStatusType enum Modifying")
  Modifying: "Modifying",

  @doc("DomainProcessingStatusType enum UpdatingServiceSoftware")
  UpdatingServiceSoftware: "UpdatingServiceSoftware",

  @doc("DomainProcessingStatusType enum UpgradingEngineVersion")
  UpgradingEngineVersion: "UpgradingEngineVersion",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DomainProcessingStatusTypeEnumValue")
model DomainProcessingStatusTypeEnumValue {
  @doc("Property value")
  value?: DomainProcessingStatusType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AdvancedSecurityOptions")
model AdvancedSecurityOptions {
  @doc("<p>Date and time when the migration period will be disabled. Only necessary when <a href='https://docs.aws.amazon.com/opensearch-service/latest/developerguide/fgac.html#fgac-enabling-existing'>enabling fine-grained access control on an existing domain</a>.</p>")
  anonymousAuthDisableDate?: utcDateTime;

  @doc("<p>True if a 30-day migration period is enabled, during which administrators can create role mappings. Only necessary when <a href='https://docs.aws.amazon.com/opensearch-service/latest/developerguide/fgac.html#fgac-enabling-existing'>enabling fine-grained access control on an existing domain</a>.</p>")
  anonymousAuthEnabled?: boolean;

  @doc("<p>True if fine-grained access control is enabled.</p>")
  enabled?: boolean;

  @doc("<p>True if the internal user database is enabled.</p>")
  internalUserDatabaseEnabled?: boolean;

  @doc("<p>Container for information about the SAML configuration for OpenSearch Dashboards.</p>")
  samlOptions?: SAMLOptionsOutput;
}

@doc("IPAddressType enum")
union IPAddressType {
  @doc("IPAddressType enum dualstack")
  Dualstack: "dualstack",

  @doc("IPAddressType enum ipv4")
  Ipv4: "ipv4",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IPAddressTypeEnumValue")
model IPAddressTypeEnumValue {
  @doc("Property value")
  value?: IPAddressType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AutoTuneOptionsOutput")
model AutoTuneOptionsOutput {
  @doc("<p>Any errors that occurred while enabling or disabling Auto-Tune.</p>")
  errorMessage?: string;

  @doc("<p>The current state of Auto-Tune on the domain.</p>")
  state?: AutoTuneStateEnumValue;

  @doc("<p>Whether the domain's off-peak window will be used to deploy Auto-Tune changes rather than a maintenance schedule.</p>")
  useOffPeakWindow?: boolean;
}

@doc("AutoTuneState enum")
union AutoTuneState {
  @doc("AutoTuneState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("AutoTuneState enum DISABLED_AND_ROLLBACK_COMPLETE")
  DISABLED_AND_ROLLBACK_COMPLETE: "DISABLED_AND_ROLLBACK_COMPLETE",

  @doc("AutoTuneState enum DISABLED_AND_ROLLBACK_ERROR")
  DISABLED_AND_ROLLBACK_ERROR: "DISABLED_AND_ROLLBACK_ERROR",

  @doc("AutoTuneState enum DISABLED_AND_ROLLBACK_IN_PROGRESS")
  DISABLED_AND_ROLLBACK_IN_PROGRESS: "DISABLED_AND_ROLLBACK_IN_PROGRESS",

  @doc("AutoTuneState enum DISABLED_AND_ROLLBACK_SCHEDULED")
  DISABLED_AND_ROLLBACK_SCHEDULED: "DISABLED_AND_ROLLBACK_SCHEDULED",

  @doc("AutoTuneState enum DISABLE_IN_PROGRESS")
  DISABLE_IN_PROGRESS: "DISABLE_IN_PROGRESS",

  @doc("AutoTuneState enum ENABLED")
  ENABLED: "ENABLED",

  @doc("AutoTuneState enum ENABLE_IN_PROGRESS")
  ENABLE_IN_PROGRESS: "ENABLE_IN_PROGRESS",

  @doc("AutoTuneState enum ERROR")
  ERROR: "ERROR",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AutoTuneStateEnumValue")
model AutoTuneStateEnumValue {
  @doc("Property value")
  value?: AutoTuneState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ChangeProgressDetails")
model ChangeProgressDetails {
  @doc("<p>The ID of the configuration change.</p>")
  changeId?: string;

  @doc("<p>The current status of the configuration change.</p>")
  configChangeStatus?: ConfigChangeStatusEnumValue;

  @doc("<p>The IAM principal who initiated the configuration change.</p>")
  initiatedBy?: InitiatedByEnumValue;

  @doc("<p>The last time that the configuration change was updated.</p>")
  lastUpdatedTime?: utcDateTime;

  @doc("<p>A message corresponding to the status of the configuration change.</p>")
  message?: string;

  @doc("<p>The time that the configuration change was initiated, in Universal Coordinated Time (UTC).</p>")
  startTime?: utcDateTime;
}

@doc("ConfigChangeStatus enum")
union ConfigChangeStatus {
  @doc("ConfigChangeStatus enum ApplyingChanges")
  ApplyingChanges: "ApplyingChanges",

  @doc("ConfigChangeStatus enum Cancelled")
  Cancelled: "Cancelled",

  @doc("ConfigChangeStatus enum Completed")
  Completed: "Completed",

  @doc("ConfigChangeStatus enum Initializing")
  Initializing: "Initializing",

  @doc("ConfigChangeStatus enum Pending")
  Pending: "Pending",

  @doc("ConfigChangeStatus enum PendingUserInput")
  PendingUserInput: "PendingUserInput",

  @doc("ConfigChangeStatus enum Validating")
  Validating: "Validating",

  @doc("ConfigChangeStatus enum ValidationFailed")
  ValidationFailed: "ValidationFailed",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfigChangeStatusEnumValue")
model ConfigChangeStatusEnumValue {
  @doc("Property value")
  value?: ConfigChangeStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterConfig")
model ClusterConfig {
  @doc("<p>Container for cold storage configuration options.</p>")
  coldStorageOptions?: ColdStorageOptions;

  @doc("<p>Number of dedicated master nodes in the cluster. This number must be greater than 2 and not 4, otherwise you receive a validation exception.</p>")
  dedicatedMasterCount?: int32;

  @doc("<p>Indicates whether dedicated master nodes are enabled for the cluster.<code>True</code> if the cluster will use a dedicated master node.<code>False</code> if the cluster will not.</p>")
  dedicatedMasterEnabled?: boolean;

  @doc("<p>OpenSearch Service instance type of the dedicated master nodes in the cluster.</p>")
  dedicatedMasterType?: OpenSearchPartitionInstanceTypeEnumValue;

  @doc("<p>Number of data nodes in the cluster. This number must be greater than 1, otherwise you receive a validation exception.</p>")
  instanceCount?: int32;

  @doc("<p>Instance type of data nodes in the cluster.</p>")
  instanceType?: OpenSearchPartitionInstanceTypeEnumValue;

  @doc("<p>A boolean that indicates whether a multi-AZ domain is turned on with a standby AZ. For more information, see <a href='https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-multiaz.html'>Configuring a multi-AZ domain in Amazon OpenSearch Service</a>. </p>")
  multiAZWithStandbyEnabled?: boolean;

  @doc("<p>The number of warm nodes in the cluster.</p>")
  warmCount?: int32;

  @doc("<p>Whether to enable warm storage for the cluster.</p>")
  warmEnabled?: boolean;

  @doc("<p>The instance type for the cluster's warm nodes.</p>")
  warmType?: OpenSearchWarmPartitionInstanceTypeEnumValue;

  @doc("<p>Container for zone awareness configuration options. Only required if <code>ZoneAwarenessEnabled</code> is <code>true</code>.</p>")
  zoneAwarenessConfig?: ZoneAwarenessConfig;

  @doc("<p>Indicates whether multiple Availability Zones are enabled. For more information, see <a href='https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-multiaz.html'>Configuring a multi-AZ domain in Amazon OpenSearch Service</a>.</p>")
  zoneAwarenessEnabled?: boolean;
}

@doc("InitiatedBy enum")
union InitiatedBy {
  @doc("InitiatedBy enum CUSTOMER")
  CUSTOMER: "CUSTOMER",

  @doc("InitiatedBy enum SERVICE")
  SERVICE: "SERVICE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InitiatedByEnumValue")
model InitiatedByEnumValue {
  @doc("Property value")
  value?: InitiatedBy;
}

@doc("OpenSearchWarmPartitionInstanceType enum")
union OpenSearchWarmPartitionInstanceType {
  @doc("OpenSearchWarmPartitionInstanceType enum ultrawarm1.large.search")
  Ultrawarm1LargeSearch: "ultrawarm1.large.search",

  @doc("OpenSearchWarmPartitionInstanceType enum ultrawarm1.medium.search")
  Ultrawarm1MediumSearch: "ultrawarm1.medium.search",

  @doc("OpenSearchWarmPartitionInstanceType enum ultrawarm1.xlarge.search")
  Ultrawarm1XlargeSearch: "ultrawarm1.xlarge.search",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenSearchWarmPartitionInstanceTypeEnumValue")
model OpenSearchWarmPartitionInstanceTypeEnumValue {
  @doc("Property value")
  value?: OpenSearchWarmPartitionInstanceType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CognitoOptions")
model CognitoOptions {
  @doc("<p>Whether to enable or disable Amazon Cognito authentication for OpenSearch Dashboards.</p>")
  enabled?: boolean;

  @doc("<p>The Amazon Cognito identity pool ID that you want OpenSearch Service to use for OpenSearch Dashboards authentication.</p>")
  identityPoolId?: string;

  @doc("<p>The <code>AmazonOpenSearchServiceCognitoAccess</code> role that allows OpenSearch Service to configure your user pool and identity pool.</p>")
  roleArn?: string;

  @doc("<p>The Amazon Cognito user pool ID that you want OpenSearch Service to use for OpenSearch Dashboards authentication.</p>")
  userPoolId?: string;
}

@doc("OpenSearchPartitionInstanceType enum")
union OpenSearchPartitionInstanceType {
  @doc("OpenSearchPartitionInstanceType enum c4.2xlarge.search")
  C42xlargeSearch: "c4.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c4.4xlarge.search")
  C44xlargeSearch: "c4.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c4.8xlarge.search")
  C48xlargeSearch: "c4.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c4.large.search")
  C4LargeSearch: "c4.large.search",

  @doc("OpenSearchPartitionInstanceType enum c4.xlarge.search")
  C4XlargeSearch: "c4.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c5.18xlarge.search")
  C518xlargeSearch: "c5.18xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c5.2xlarge.search")
  C52xlargeSearch: "c5.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c5.4xlarge.search")
  C54xlargeSearch: "c5.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c5.9xlarge.search")
  C59xlargeSearch: "c5.9xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c5.large.search")
  C5LargeSearch: "c5.large.search",

  @doc("OpenSearchPartitionInstanceType enum c5.xlarge.search")
  C5XlargeSearch: "c5.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c6g.12xlarge.search")
  C6g12xlargeSearch: "c6g.12xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c6g.2xlarge.search")
  C6g2xlargeSearch: "c6g.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c6g.4xlarge.search")
  C6g4xlargeSearch: "c6g.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c6g.8xlarge.search")
  C6g8xlargeSearch: "c6g.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum c6g.large.search")
  C6gLargeSearch: "c6g.large.search",

  @doc("OpenSearchPartitionInstanceType enum c6g.xlarge.search")
  C6gXlargeSearch: "c6g.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum d2.2xlarge.search")
  D22xlargeSearch: "d2.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum d2.4xlarge.search")
  D24xlargeSearch: "d2.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum d2.8xlarge.search")
  D28xlargeSearch: "d2.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum d2.xlarge.search")
  D2XlargeSearch: "d2.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum i2.2xlarge.search")
  I22xlargeSearch: "i2.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum i2.xlarge.search")
  I2XlargeSearch: "i2.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum i3.16xlarge.search")
  I316xlargeSearch: "i3.16xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum i3.2xlarge.search")
  I32xlargeSearch: "i3.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum i3.4xlarge.search")
  I34xlargeSearch: "i3.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum i3.8xlarge.search")
  I38xlargeSearch: "i3.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum i3.large.search")
  I3LargeSearch: "i3.large.search",

  @doc("OpenSearchPartitionInstanceType enum i3.xlarge.search")
  I3XlargeSearch: "i3.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m3.2xlarge.search")
  M32xlargeSearch: "m3.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m3.large.search")
  M3LargeSearch: "m3.large.search",

  @doc("OpenSearchPartitionInstanceType enum m3.medium.search")
  M3MediumSearch: "m3.medium.search",

  @doc("OpenSearchPartitionInstanceType enum m3.xlarge.search")
  M3XlargeSearch: "m3.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m4.10xlarge.search")
  M410xlargeSearch: "m4.10xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m4.2xlarge.search")
  M42xlargeSearch: "m4.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m4.4xlarge.search")
  M44xlargeSearch: "m4.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m4.large.search")
  M4LargeSearch: "m4.large.search",

  @doc("OpenSearchPartitionInstanceType enum m4.xlarge.search")
  M4XlargeSearch: "m4.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m5.12xlarge.search")
  M512xlargeSearch: "m5.12xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m5.24xlarge.search")
  M524xlargeSearch: "m5.24xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m5.2xlarge.search")
  M52xlargeSearch: "m5.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m5.4xlarge.search")
  M54xlargeSearch: "m5.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m5.large.search")
  M5LargeSearch: "m5.large.search",

  @doc("OpenSearchPartitionInstanceType enum m5.xlarge.search")
  M5XlargeSearch: "m5.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m6g.12xlarge.search")
  M6g12xlargeSearch: "m6g.12xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m6g.2xlarge.search")
  M6g2xlargeSearch: "m6g.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m6g.4xlarge.search")
  M6g4xlargeSearch: "m6g.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m6g.8xlarge.search")
  M6g8xlargeSearch: "m6g.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum m6g.large.search")
  M6gLargeSearch: "m6g.large.search",

  @doc("OpenSearchPartitionInstanceType enum m6g.xlarge.search")
  M6gXlargeSearch: "m6g.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum or1.12xlarge.search")
  Or112xlargeSearch: "or1.12xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum or1.16xlarge.search")
  Or116xlargeSearch: "or1.16xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum or1.2xlarge.search")
  Or12xlargeSearch: "or1.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum or1.4xlarge.search")
  Or14xlargeSearch: "or1.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum or1.8xlarge.search")
  Or18xlargeSearch: "or1.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum or1.large.search")
  Or1LargeSearch: "or1.large.search",

  @doc("OpenSearchPartitionInstanceType enum or1.medium.search")
  Or1MediumSearch: "or1.medium.search",

  @doc("OpenSearchPartitionInstanceType enum or1.xlarge.search")
  Or1XlargeSearch: "or1.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r3.2xlarge.search")
  R32xlargeSearch: "r3.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r3.4xlarge.search")
  R34xlargeSearch: "r3.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r3.8xlarge.search")
  R38xlargeSearch: "r3.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r3.large.search")
  R3LargeSearch: "r3.large.search",

  @doc("OpenSearchPartitionInstanceType enum r3.xlarge.search")
  R3XlargeSearch: "r3.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r4.16xlarge.search")
  R416xlargeSearch: "r4.16xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r4.2xlarge.search")
  R42xlargeSearch: "r4.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r4.4xlarge.search")
  R44xlargeSearch: "r4.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r4.8xlarge.search")
  R48xlargeSearch: "r4.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r4.large.search")
  R4LargeSearch: "r4.large.search",

  @doc("OpenSearchPartitionInstanceType enum r4.xlarge.search")
  R4XlargeSearch: "r4.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r5.12xlarge.search")
  R512xlargeSearch: "r5.12xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r5.24xlarge.search")
  R524xlargeSearch: "r5.24xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r5.2xlarge.search")
  R52xlargeSearch: "r5.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r5.4xlarge.search")
  R54xlargeSearch: "r5.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r5.large.search")
  R5LargeSearch: "r5.large.search",

  @doc("OpenSearchPartitionInstanceType enum r5.xlarge.search")
  R5XlargeSearch: "r5.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6g.12xlarge.search")
  R6g12xlargeSearch: "r6g.12xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6g.2xlarge.search")
  R6g2xlargeSearch: "r6g.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6g.4xlarge.search")
  R6g4xlargeSearch: "r6g.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6g.8xlarge.search")
  R6g8xlargeSearch: "r6g.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6g.large.search")
  R6gLargeSearch: "r6g.large.search",

  @doc("OpenSearchPartitionInstanceType enum r6g.xlarge.search")
  R6gXlargeSearch: "r6g.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6gd.12xlarge.search")
  R6gd12xlargeSearch: "r6gd.12xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6gd.16xlarge.search")
  R6gd16xlargeSearch: "r6gd.16xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6gd.2xlarge.search")
  R6gd2xlargeSearch: "r6gd.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6gd.4xlarge.search")
  R6gd4xlargeSearch: "r6gd.4xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6gd.8xlarge.search")
  R6gd8xlargeSearch: "r6gd.8xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum r6gd.large.search")
  R6gdLargeSearch: "r6gd.large.search",

  @doc("OpenSearchPartitionInstanceType enum r6gd.xlarge.search")
  R6gdXlargeSearch: "r6gd.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum t2.medium.search")
  T2MediumSearch: "t2.medium.search",

  @doc("OpenSearchPartitionInstanceType enum t2.micro.search")
  T2MicroSearch: "t2.micro.search",

  @doc("OpenSearchPartitionInstanceType enum t2.small.search")
  T2SmallSearch: "t2.small.search",

  @doc("OpenSearchPartitionInstanceType enum t3.2xlarge.search")
  T32xlargeSearch: "t3.2xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum t3.large.search")
  T3LargeSearch: "t3.large.search",

  @doc("OpenSearchPartitionInstanceType enum t3.medium.search")
  T3MediumSearch: "t3.medium.search",

  @doc("OpenSearchPartitionInstanceType enum t3.micro.search")
  T3MicroSearch: "t3.micro.search",

  @doc("OpenSearchPartitionInstanceType enum t3.nano.search")
  T3NanoSearch: "t3.nano.search",

  @doc("OpenSearchPartitionInstanceType enum t3.small.search")
  T3SmallSearch: "t3.small.search",

  @doc("OpenSearchPartitionInstanceType enum t3.xlarge.search")
  T3XlargeSearch: "t3.xlarge.search",

  @doc("OpenSearchPartitionInstanceType enum t4g.medium.search")
  T4gMediumSearch: "t4g.medium.search",

  @doc("OpenSearchPartitionInstanceType enum t4g.small.search")
  T4gSmallSearch: "t4g.small.search",

  @doc("OpenSearchPartitionInstanceType enum ultrawarm1.large.search")
  Ultrawarm1LargeSearch: "ultrawarm1.large.search",

  @doc("OpenSearchPartitionInstanceType enum ultrawarm1.medium.search")
  Ultrawarm1MediumSearch: "ultrawarm1.medium.search",

  @doc("OpenSearchPartitionInstanceType enum ultrawarm1.xlarge.search")
  Ultrawarm1XlargeSearch: "ultrawarm1.xlarge.search",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenSearchPartitionInstanceTypeEnumValue")
model OpenSearchPartitionInstanceTypeEnumValue {
  @doc("Property value")
  value?: OpenSearchPartitionInstanceType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DomainEndpointOptions")
model DomainEndpointOptions {
  @doc("<p>The fully qualified URL for the custom endpoint.</p>")
  customEndpoint?: string;

  @doc("<p>The ARN for your security certificate, managed in Amazon Web Services Certificate Manager (ACM).</p>")
  customEndpointCertificateArn?: string;

  @doc("<p>Whether to enable a custom endpoint for the domain.</p>")
  customEndpointEnabled?: boolean;

  @doc("<p>True to require that all traffic to the domain arrive over HTTPS.</p>")
  enforceHTTPS?: boolean;

  @doc("<p>Specify the TLS security policy to apply to the HTTPS endpoint of the domain. The policy can be one of the following values:</p> <ul> <li> <p> <b>Policy-Min-TLS-1-0-2019-07:</b> TLS security policy that supports TLS version 1.0 to TLS version 1.2</p> </li> <li> <p> <b>Policy-Min-TLS-1-2-2019-07:</b> TLS security policy that supports only TLS version 1.2</p> </li> <li> <p> <b>Policy-Min-TLS-1-2-PFS-2023-10:</b> TLS security policy that supports TLS version 1.2 to TLS version 1.3 with perfect forward secrecy cipher suites</p> </li> </ul>")
  tlsSecurityPolicy?: TLSSecurityPolicyEnumValue;
}

@doc("TLSSecurityPolicy enum")
union TLSSecurityPolicy {
  @doc("TLSSecurityPolicy enum Policy-Min-TLS-1-0-2019-07")
  PolicyMinTLS10201907: "Policy-Min-TLS-1-0-2019-07",

  @doc("TLSSecurityPolicy enum Policy-Min-TLS-1-2-2019-07")
  PolicyMinTLS12201907: "Policy-Min-TLS-1-2-2019-07",

  @doc("TLSSecurityPolicy enum Policy-Min-TLS-1-2-PFS-2023-10")
  PolicyMinTLS12PFS202310: "Policy-Min-TLS-1-2-PFS-2023-10",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TLSSecurityPolicyEnumValue")
model TLSSecurityPolicyEnumValue {
  @doc("Property value")
  value?: TLSSecurityPolicy;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EBSOptions")
model EBSOptions {
  @doc("<p>Indicates whether EBS volumes are attached to data nodes in an OpenSearch Service domain.</p>")
  ebsEnabled?: boolean;

  @doc("<p>Specifies the baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the <code>gp3</code> and provisioned IOPS EBS volume types.</p>")
  iops?: int32;

  @doc("<p>Specifies the throughput (in MiB/s) of the EBS volumes attached to data nodes. Applicable only for the <code>gp3</code> volume type.</p>")
  throughput?: int32;

  @doc("<p>Specifies the size (in GiB) of EBS volumes attached to data nodes.</p>")
  volumeSize?: int32;

  @doc("<p>Specifies the type of EBS volumes attached to data nodes.</p>")
  volumeType?: VolumeTypeEnumValue;
}

@doc("VolumeType enum")
union VolumeType {
  @doc("VolumeType enum gp2")
  Gp2: "gp2",

  @doc("VolumeType enum gp3")
  Gp3: "gp3",

  @doc("VolumeType enum io1")
  Io1: "io1",

  @doc("VolumeType enum standard")
  Standard: "standard",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VolumeTypeEnumValue")
model VolumeTypeEnumValue {
  @doc("Property value")
  value?: VolumeType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EncryptionAtRestOptions")
model EncryptionAtRestOptions {
  @doc("<p>True to enable encryption at rest.</p>")
  enabled?: boolean;

  @doc("<p>The KMS key ID. Takes the form <code>1a2a3a4-1a2a-3a4a-5a6a-1a2a3a4a5a6a</code>.</p>")
  kmsKeyId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogPublishingOption")
model LogPublishingOption {
  @doc("<p>The Amazon Resource Name (ARN) of the CloudWatch Logs group to publish logs to.</p>")
  cloudWatchLogsLogGroupArn?: string;

  @doc("<p>Whether the log should be published.</p>")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ModifyingProperties")
model ModifyingProperties {
  @doc("<p>The current value of the domain property that is being modified.</p>")
  activeValue?: string;

  @doc("<p>The name of the property that is currently being modified.</p>")
  name?: string;

  @doc("<p>The value that the property that is currently being modified will eventually have.</p>")
  pendingValue?: string;

  @doc("<p>The type of value that is currently being modified. Properties can have two types:</p> <ul> <li> <p> <code>PLAIN_TEXT</code>: Contain direct values such as '1', 'True', or 'c5.large.search'.</p> </li> <li> <p> <code>STRINGIFIED_JSON</code>: Contain content in JSON format, such as {'Enabled':'True'}'.</p> </li> </ul>")
  valueType?: PropertyValueTypeEnumValue;
}

@doc("PropertyValueType enum")
union PropertyValueType {
  @doc("PropertyValueType enum PLAIN_TEXT")
  PLAIN_TEXT: "PLAIN_TEXT",

  @doc("PropertyValueType enum STRINGIFIED_JSON")
  STRINGIFIED_JSON: "STRINGIFIED_JSON",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PropertyValueTypeEnumValue")
model PropertyValueTypeEnumValue {
  @doc("Property value")
  value?: PropertyValueType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NodeToNodeEncryptionOptions")
model NodeToNodeEncryptionOptions {
  @doc("<p>True to enable node-to-node encryption.</p>")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OffPeakWindowOptions")
model OffPeakWindowOptions {
  @doc("<p>Whether to enable an off-peak window.</p> <p>This option is only available when modifying a domain created prior to February 16, 2023, not when creating a new domain. All domains created after this date have the off-peak window enabled by default. You can't disable the off-peak window after it's enabled for a domain.</p>")
  enabled?: boolean;

  @doc("<p>Off-peak window settings for the domain.</p>")
  offPeakWindow?: OffPeakWindow;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceSoftwareOptions")
model ServiceSoftwareOptions {
  @doc("<p>The timestamp, in Epoch time, until which you can manually request a service software update. After this date, we automatically update your service software.</p>")
  automatedUpdateDate?: utcDateTime;

  @doc("<p> True if you're able to cancel your service software version update. False if you can't cancel your service software update.</p>")
  cancellable?: boolean;

  @doc("<p>The current service software version present on the domain.</p>")
  currentVersion?: string;

  @doc("<p>A description of the service software update status.</p>")
  description?: string;

  @doc("<p>The new service software version, if one is available.</p>")
  newVersion?: string;

  @doc("<p>True if a service software is never automatically updated. False if a service software is automatically updated after the automated update date.</p>")
  optionalDeployment?: boolean;

  @doc("<p>True if you're able to update your service software version. False if you can't update your service software version.</p>")
  updateAvailable?: boolean;

  @doc("<p>The status of your service software update.</p>")
  updateStatus?: DeploymentStatusEnumValue;
}

@doc("DeploymentStatus enum")
union DeploymentStatus {
  @doc("DeploymentStatus enum COMPLETED")
  COMPLETED: "COMPLETED",

  @doc("DeploymentStatus enum ELIGIBLE")
  ELIGIBLE: "ELIGIBLE",

  @doc("DeploymentStatus enum IN_PROGRESS")
  IN_PROGRESS: "IN_PROGRESS",

  @doc("DeploymentStatus enum NOT_ELIGIBLE")
  NOT_ELIGIBLE: "NOT_ELIGIBLE",

  @doc("DeploymentStatus enum PENDING_UPDATE")
  PENDING_UPDATE: "PENDING_UPDATE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentStatusEnumValue")
model DeploymentStatusEnumValue {
  @doc("Property value")
  value?: DeploymentStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SnapshotOptions")
model SnapshotOptions {
  @doc("<p>The time, in UTC format, when OpenSearch Service takes a daily automated snapshot of the specified domain. Default is <code>0</code> hours.</p>")
  automatedSnapshotStartHour?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SoftwareUpdateOptions")
model SoftwareUpdateOptions {
  @doc("<p>Whether automatic service software updates are enabled for the domain.</p>")
  autoSoftwareUpdateEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VPCDerivedInfo")
model VPCDerivedInfo {
  @doc("<p>The list of Availability Zones associated with the VPC subnets.</p>")
  @extension("x-ms-identifiers", [])
  availabilityZones?: string[];

  @doc("<p>The list of security group IDs associated with the VPC endpoints for the domain.</p>")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("<p>A list of subnet IDs associated with the VPC endpoints for the domain.</p>")
  @extension("x-ms-identifiers", [])
  subnetIds?: string[];

  @doc("<p>The ID for your VPC. Amazon VPC generates this value when you create a VPC.</p>")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SAMLOptionsOutput")
model SAMLOptionsOutput {
  @doc("<p>True if SAML is enabled.</p>")
  enabled?: boolean;

  @doc("<p>Describes the SAML identity provider's information.</p>")
  idp?: SAMLIdp;

  @doc("<p>The key used for matching the SAML roles attribute.</p>")
  rolesKey?: string;

  @doc("<p>The duration, in minutes, after which a user session becomes inactive.</p>")
  sessionTimeoutMinutes?: int32;

  @doc("<p>The key used for matching the SAML subject attribute.</p>")
  subjectKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ColdStorageOptions")
model ColdStorageOptions {
  @doc("<p>Whether to enable or disable cold storage on the domain. You must enable UltraWarm storage to enable cold storage.</p>")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ZoneAwarenessConfig")
model ZoneAwarenessConfig {
  @doc("<p>If you enabled multiple Availability Zones, this value is the number of zones that you want the domain to use. Valid values are <code>2</code> and <code>3</code>. If your domain is provisioned within a VPC, this value be equal to number of subnets.</p>")
  availabilityZoneCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OffPeakWindow")
model OffPeakWindow {
  @doc("<p>A custom start time for the off-peak window, in Coordinated Universal Time (UTC). The window length will always be 10 hours, so you can't specify an end time. For example, if you specify 11:00 P.M. UTC as a start time, the end time will automatically be set to 9:00 A.M.</p>")
  windowStartTime?: WindowStartTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SAMLIdp")
model SAMLIdp {
  @doc("<p>The unique entity ID of the application in the SAML identity provider.</p>")
  entityId?: string;

  @doc("<p>The metadata of the SAML application, in XML format.</p>")
  metadataContent?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WindowStartTime")
model WindowStartTime {
  @doc("<p>The start hour of the window in Coordinated Universal Time (UTC), using 24-hour time. For example, <code>17</code> refers to 5:00 P.M. UTC.</p>")
  hours?: int64;

  @doc("<p>The start minute of the window, in UTC.</p>")
  minutes?: int64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface OpenSearchDomainStatuses {
  get is ArmResourceRead<OpenSearchDomainStatus>;
  @doc("Create a OpenSearchDomainStatus. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<OpenSearchDomainStatus>;
  update is ArmCustomPatchAsync<
    OpenSearchDomainStatus,
    Azure.ResourceManager.Foundations.TagsUpdateModel<OpenSearchDomainStatus>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OpenSearchDomainStatus>;
  listByResourceGroup is ArmResourceListByParent<OpenSearchDomainStatus>;
  listBySubscription is ArmListBySubscription<OpenSearchDomainStatus>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\OpenSearch\opensearch-2021-01-01.normal.json
// AWS Shape: DomainStatus
//
// Related information for backend service:
// AWS Servcie : OpenSearch
// Product Version : 3.7.798.0
// SDK Version : undefined
//--------------------------------------------------------------------------------------------
