import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

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
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- OpenSearchServiceDomains ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model OpenSearchServiceDomain
  is TrackedResource<OpenSearchServiceDomainProperties> {
  @doc("Name of OpenSearchServiceDomain")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("openSearchServiceDomains")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenSearchServiceDomain")
model OpenSearchServiceDomainProperties {
  @doc("Awsproperties")
  awsProperties?: AwsOpenSearchServiceDomainProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsOpenSearchServiceDomain")
model AwsOpenSearchServiceDomainProperties {
  @doc("Accesspolicies")
  accessPolicies?: unknown;

  @doc("Advancedoptions")
  advancedOptions?: Record<string>;

  @doc("Advancedsecurityoptions")
  advancedSecurityOptions?: AdvancedSecurityOptionsInput;

  @doc("Arn")
  arn?: string;

  @doc("Clusterconfig")
  clusterConfig?: ClusterConfig;

  @doc("Cognitooptions")
  cognitoOptions?: CognitoOptions;

  @doc("Domainarn")
  domainArn?: string;

  @doc("Domainendpoint")
  domainEndpoint?: string;

  @doc("Domainendpointoptions")
  domainEndpointOptions?: DomainEndpointOptions;

  @doc("Domainendpointv2")
  domainEndpointV2?: string;

  @doc("Domainendpoints")
  domainEndpoints?: unknown;

  @doc("Domainname")
  domainName?: string;

  @doc("Ebsoptions")
  ebsOptions?: EBSOptions;

  @doc("Encryptionatrestoptions")
  encryptionAtRestOptions?: EncryptionAtRestOptions;

  @doc("Engineversion")
  engineVersion?: string;

  @doc("Ipaddresstype")
  ipAddressType?: string;

  @doc("Id")
  id?: string;

  @doc("Logpublishingoptions")
  logPublishingOptions?: Record<LogPublishingOption>;

  @doc("Nodetonodeencryptionoptions")
  nodeToNodeEncryptionOptions?: NodeToNodeEncryptionOptions;

  @doc("Offpeakwindowoptions")
  offPeakWindowOptions?: OffPeakWindowOptions;

  @doc("Servicesoftwareoptions")
  serviceSoftwareOptions?: ServiceSoftwareOptions;

  @doc("Snapshotoptions")
  snapshotOptions?: SnapshotOptions;

  @doc("Softwareupdateoptions")
  softwareUpdateOptions?: SoftwareUpdateOptions;

  @doc(" An arbitrary set of tags (key-value pairs) for this Domain.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Vpcoptions")
  vpcOptions?: VPCOptions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AdvancedSecurityOptionsInput")
model AdvancedSecurityOptionsInput {
  @doc("Anonymousauthdisabledate")
  anonymousAuthDisableDate?: string;

  @doc("Anonymousauthenabled")
  anonymousAuthEnabled?: boolean;

  @doc("Enabled")
  enabled?: boolean;

  @doc("Internaluserdatabaseenabled")
  internalUserDatabaseEnabled?: boolean;

  @doc("Masteruseroptions")
  masterUserOptions?: MasterUserOptions;

  @doc("Samloptions")
  samlOptions?: SAMLOptions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterConfig")
model ClusterConfig {
  @doc("Coldstorageoptions")
  coldStorageOptions?: ColdStorageOptions;

  @doc("Dedicatedmastercount")
  dedicatedMasterCount?: int32;

  @doc("Dedicatedmasterenabled")
  dedicatedMasterEnabled?: boolean;

  @doc("Dedicatedmastertype")
  dedicatedMasterType?: string;

  @doc("Instancecount")
  instanceCount?: int32;

  @doc("Instancetype")
  instanceType?: string;

  @doc("Multiazwithstandbyenabled")
  multiAZWithStandbyEnabled?: boolean;

  @doc("Warmcount")
  warmCount?: int32;

  @doc("Warmenabled")
  warmEnabled?: boolean;

  @doc("Warmtype")
  warmType?: string;

  @doc("Zoneawarenessconfig")
  zoneAwarenessConfig?: ZoneAwarenessConfig;

  @doc("Zoneawarenessenabled")
  zoneAwarenessEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CognitoOptions")
model CognitoOptions {
  @doc("Enabled")
  enabled?: boolean;

  @doc("Identitypoolid")
  identityPoolId?: string;

  @doc("Rolearn")
  roleArn?: string;

  @doc("Userpoolid")
  userPoolId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DomainEndpointOptions")
model DomainEndpointOptions {
  @doc("Customendpoint")
  customEndpoint?: string;

  @doc("Customendpointcertificatearn")
  customEndpointCertificateArn?: string;

  @doc("Customendpointenabled")
  customEndpointEnabled?: boolean;

  @doc("Enforcehttps")
  enforceHTTPS?: boolean;

  @doc("Tlssecuritypolicy")
  tlsSecurityPolicy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EBSOptions")
model EBSOptions {
  @doc("Ebsenabled")
  ebsEnabled?: boolean;

  @doc("Iops")
  iops?: int32;

  @doc("Throughput")
  throughput?: int32;

  @doc("Volumesize")
  volumeSize?: int32;

  @doc("Volumetype")
  volumeType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EncryptionAtRestOptions")
model EncryptionAtRestOptions {
  @doc("Enabled")
  enabled?: boolean;

  @doc("Kmskeyid")
  kmsKeyId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogPublishingOption")
model LogPublishingOption {
  @doc("Cloudwatchlogsloggrouparn")
  cloudWatchLogsLogGroupArn?: string;

  @doc("Enabled")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NodeToNodeEncryptionOptions")
model NodeToNodeEncryptionOptions {
  @doc("Enabled")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OffPeakWindowOptions")
model OffPeakWindowOptions {
  @doc("Enabled")
  enabled?: boolean;

  @doc("Offpeakwindow")
  offPeakWindow?: OffPeakWindow;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceSoftwareOptions")
model ServiceSoftwareOptions {
  @doc("Automatedupdatedate")
  automatedUpdateDate?: string;

  @doc("Cancellable")
  cancellable?: boolean;

  @doc("Currentversion")
  currentVersion?: string;

  @doc("Description")
  description?: string;

  @doc("Newversion")
  newVersion?: string;

  @doc("Optionaldeployment")
  optionalDeployment?: boolean;

  @doc("Updateavailable")
  updateAvailable?: boolean;

  @doc("Updatestatus")
  updateStatus?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SnapshotOptions")
model SnapshotOptions {
  @doc("Automatedsnapshotstarthour")
  automatedSnapshotStartHour?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SoftwareUpdateOptions")
model SoftwareUpdateOptions {
  @doc("Autosoftwareupdateenabled")
  autoSoftwareUpdateEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc(" The value of the tag.")
  key?: string;

  @doc(" The key of the tag.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VPCOptions")
model VPCOptions {
  @doc("Securitygroupids")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Subnetids")
  @extension("x-ms-identifiers", [])
  subnetIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MasterUserOptions")
model MasterUserOptions {
  @doc("Masteruserarn")
  masterUserARN?: string;

  @doc("Masterusername")
  masterUserName?: string;

  @doc("Masteruserpassword")
  masterUserPassword?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SAMLOptions")
model SAMLOptions {
  @doc("Enabled")
  enabled?: boolean;

  @doc("Idp")
  idp?: Idp;

  @doc("Masterbackendrole")
  masterBackendRole?: string;

  @doc("Masterusername")
  masterUserName?: string;

  @doc("Roleskey")
  rolesKey?: string;

  @doc("Sessiontimeoutminutes")
  sessionTimeoutMinutes?: int32;

  @doc("Subjectkey")
  subjectKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ColdStorageOptions")
model ColdStorageOptions {
  @doc("Enabled")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ZoneAwarenessConfig")
model ZoneAwarenessConfig {
  @doc("Availabilityzonecount")
  availabilityZoneCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OffPeakWindow")
model OffPeakWindow {
  @doc("Windowstarttime")
  windowStartTime?: WindowStartTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Idp")
model Idp {
  @doc("Entityid")
  entityId?: string;

  @doc("Metadatacontent")
  metadataContent?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WindowStartTime")
model WindowStartTime {
  @doc("Hours")
  hours?: int32;

  @doc("Minutes")
  minutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface OpenSearchServiceDomains {
  get is ArmResourceRead<OpenSearchServiceDomain>;
  @doc("Create a OpenSearchServiceDomain. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OpenSearchServiceDomain>;
  update is ArmCustomPatchAsync<
    OpenSearchServiceDomain,
    Azure.ResourceManager.Foundations.TagsUpdateModel<OpenSearchServiceDomain>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OpenSearchServiceDomain>;
  listByResourceGroup is ArmResourceListByParent<OpenSearchServiceDomain>;
  listBySubscription is ArmListBySubscription<OpenSearchServiceDomain>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::OpenSearchService::Domain
//--------------------------------------------------------------------------------------------
