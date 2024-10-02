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
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- OpenSearchServiceDomains ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Open Search Service Domain",
    plural: "Open Search Service Domains",
  },
  keywords: ["Microsoft.AwsConnector", "Open", "Search", "Service", "Domain"],
})
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
  @doc("AWS Properties")
  awsProperties?: AwsOpenSearchServiceDomainProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsOpenSearchServiceDomain")
model AwsOpenSearchServiceDomainProperties {
  @doc("Property accessPolicies")
  accessPolicies?: unknown;

  @doc("Property advancedOptions")
  advancedOptions?: Record<string>;

  @doc("Property advancedSecurityOptions")
  advancedSecurityOptions?: AdvancedSecurityOptionsInput;

  @doc("Property arn")
  arn?: string;

  @doc("Property clusterConfig")
  clusterConfig?: ClusterConfig;

  @doc("Property cognitoOptions")
  cognitoOptions?: CognitoOptions;

  @doc("Property domainArn")
  domainArn?: string;

  @doc("Property domainEndpoint")
  domainEndpoint?: string;

  @doc("Property domainEndpointOptions")
  domainEndpointOptions?: DomainEndpointOptions;

  @doc("Property domainEndpointV2")
  domainEndpointV2?: string;

  @doc("Property domainEndpoints")
  domainEndpoints?: unknown;

  @doc("Property domainName")
  domainName?: string;

  @doc("Property ebsOptions")
  ebsOptions?: EBSOptions;

  @doc("Property encryptionAtRestOptions")
  encryptionAtRestOptions?: EncryptionAtRestOptions;

  @doc("Property engineVersion")
  engineVersion?: string;

  @doc("Property ipAddressType")
  ipAddressType?: string;

  @doc("Property id")
  id?: string;

  @doc("Property logPublishingOptions")
  logPublishingOptions?: Record<LogPublishingOption>;

  @doc("Property nodeToNodeEncryptionOptions")
  nodeToNodeEncryptionOptions?: NodeToNodeEncryptionOptions;

  @doc("Property offPeakWindowOptions")
  offPeakWindowOptions?: OffPeakWindowOptions;

  @doc("Property serviceSoftwareOptions")
  serviceSoftwareOptions?: ServiceSoftwareOptions;

  @doc("Property snapshotOptions")
  snapshotOptions?: SnapshotOptions;

  @doc("Property softwareUpdateOptions")
  softwareUpdateOptions?: SoftwareUpdateOptions;

  @doc("An arbitrary set of tags (key-value pairs) for this Domain.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property vpcOptions")
  vpcOptions?: VPCOptions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AdvancedSecurityOptionsInput")
model AdvancedSecurityOptionsInput {
  @doc("Property anonymousAuthDisableDate")
  anonymousAuthDisableDate?: string;

  @doc("Property anonymousAuthEnabled")
  anonymousAuthEnabled?: boolean;

  @doc("Property enabled")
  enabled?: boolean;

  @doc("Property internalUserDatabaseEnabled")
  internalUserDatabaseEnabled?: boolean;

  @doc("Property masterUserOptions")
  masterUserOptions?: MasterUserOptions;

  @doc("Property samlOptions")
  samlOptions?: SAMLOptions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterConfig")
model ClusterConfig {
  @doc("Property coldStorageOptions")
  coldStorageOptions?: ColdStorageOptions;

  @doc("Property dedicatedMasterCount")
  dedicatedMasterCount?: int32;

  @doc("Property dedicatedMasterEnabled")
  dedicatedMasterEnabled?: boolean;

  @doc("Property dedicatedMasterType")
  dedicatedMasterType?: string;

  @doc("Property instanceCount")
  instanceCount?: int32;

  @doc("Property instanceType")
  instanceType?: string;

  @doc("Property multiAZWithStandbyEnabled")
  multiAZWithStandbyEnabled?: boolean;

  @doc("Property warmCount")
  warmCount?: int32;

  @doc("Property warmEnabled")
  warmEnabled?: boolean;

  @doc("Property warmType")
  warmType?: string;

  @doc("Property zoneAwarenessConfig")
  zoneAwarenessConfig?: ZoneAwarenessConfig;

  @doc("Property zoneAwarenessEnabled")
  zoneAwarenessEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CognitoOptions")
model CognitoOptions {
  @doc("Property enabled")
  enabled?: boolean;

  @doc("Property identityPoolId")
  identityPoolId?: string;

  @doc("Property roleArn")
  roleArn?: string;

  @doc("Property userPoolId")
  userPoolId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DomainEndpointOptions")
model DomainEndpointOptions {
  @doc("Property customEndpoint")
  customEndpoint?: string;

  @doc("Property customEndpointCertificateArn")
  customEndpointCertificateArn?: string;

  @doc("Property customEndpointEnabled")
  customEndpointEnabled?: boolean;

  @doc("Property enforceHTTPS")
  enforceHTTPS?: boolean;

  @doc("Property tlsSecurityPolicy")
  tlsSecurityPolicy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EBSOptions")
model EBSOptions {
  @doc("Property ebsEnabled")
  ebsEnabled?: boolean;

  @doc("Property iops")
  iops?: int32;

  @doc("Property throughput")
  throughput?: int32;

  @doc("Property volumeSize")
  volumeSize?: int32;

  @doc("Property volumeType")
  volumeType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EncryptionAtRestOptions")
model EncryptionAtRestOptions {
  @doc("Property enabled")
  enabled?: boolean;

  @doc("Property kmsKeyId")
  kmsKeyId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogPublishingOption")
model LogPublishingOption {
  @doc("Property cloudWatchLogsLogGroupArn")
  cloudWatchLogsLogGroupArn?: string;

  @doc("Property enabled")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NodeToNodeEncryptionOptions")
model NodeToNodeEncryptionOptions {
  @doc("Property enabled")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OffPeakWindowOptions")
model OffPeakWindowOptions {
  @doc("Property enabled")
  enabled?: boolean;

  @doc("Property offPeakWindow")
  offPeakWindow?: OffPeakWindow;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceSoftwareOptions")
model ServiceSoftwareOptions {
  @doc("Property automatedUpdateDate")
  automatedUpdateDate?: string;

  @doc("Property cancellable")
  cancellable?: boolean;

  @doc("Property currentVersion")
  currentVersion?: string;

  @doc("Property description")
  description?: string;

  @doc("Property newVersion")
  newVersion?: string;

  @doc("Property optionalDeployment")
  optionalDeployment?: boolean;

  @doc("Property updateAvailable")
  updateAvailable?: boolean;

  @doc("Property updateStatus")
  updateStatus?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SnapshotOptions")
model SnapshotOptions {
  @doc("Property automatedSnapshotStartHour")
  automatedSnapshotStartHour?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SoftwareUpdateOptions")
model SoftwareUpdateOptions {
  @doc("Property autoSoftwareUpdateEnabled")
  autoSoftwareUpdateEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The value of the tag.")
  key?: string;

  @doc("The key of the tag.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VPCOptions")
model VPCOptions {
  @doc("Property securityGroupIds")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Property subnetIds")
  @extension("x-ms-identifiers", [])
  subnetIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MasterUserOptions")
model MasterUserOptions {
  @doc("Property masterUserARN")
  masterUserARN?: string;

  @doc("Property masterUserName")
  masterUserName?: string;

  @doc("Property masterUserPassword")
  masterUserPassword?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SAMLOptions")
model SAMLOptions {
  @doc("Property enabled")
  enabled?: boolean;

  @doc("Property idp")
  idp?: Idp;

  @doc("Property masterBackendRole")
  masterBackendRole?: string;

  @doc("Property masterUserName")
  masterUserName?: string;

  @doc("Property rolesKey")
  rolesKey?: string;

  @doc("Property sessionTimeoutMinutes")
  sessionTimeoutMinutes?: int32;

  @doc("Property subjectKey")
  subjectKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ColdStorageOptions")
model ColdStorageOptions {
  @doc("Property enabled")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ZoneAwarenessConfig")
model ZoneAwarenessConfig {
  @doc("Property availabilityZoneCount")
  availabilityZoneCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OffPeakWindow")
model OffPeakWindow {
  @doc("Property windowStartTime")
  windowStartTime?: WindowStartTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Idp")
model Idp {
  @doc("Property entityId")
  entityId?: string;

  @doc("Property metadataContent")
  metadataContent?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WindowStartTime")
model WindowStartTime {
  @doc("Property hours")
  hours?: int32;

  @doc("Property minutes")
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
