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

//---------------------------------------------- ElasticsearchDomains ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Elasticsearch Domain",
    plural: "Elasticsearch Domains",
  },
  keywords: ["Microsoft.AwsConnector", "Elasticsearch", "Domain"],
})
@doc("A Microsoft.AwsConnector resource")
model ElasticsearchDomain is TrackedResource<ElasticsearchDomainProperties> {
  @doc("Name of ElasticsearchDomain")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticsearchDomains")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticsearchDomain")
model ElasticsearchDomainProperties {
  @doc("AWS Properties")
  awsProperties?: AwsElasticsearchDomainProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticsearchDomain")
model AwsElasticsearchDomainProperties {
  @doc("Property accessPolicies")
  accessPolicies?: unknown;

  @doc("Property advancedOptions")
  advancedOptions?: Record<string>;

  @doc("Property advancedSecurityOptions")
  advancedSecurityOptions?: AdvancedSecurityOptionsInput;

  @doc("Property arn")
  arn?: string;

  @doc("Property cognitoOptions")
  cognitoOptions?: CognitoOptions;

  @doc("Property domainArn")
  domainArn?: string;

  @doc("Property domainEndpoint")
  domainEndpoint?: string;

  @doc("Property domainEndpointOptions")
  domainEndpointOptions?: DomainEndpointOptions;

  @doc("Property domainName")
  domainName?: string;

  @doc("Property ebsOptions")
  ebsOptions?: EBSOptions;

  @doc("Property elasticsearchClusterConfig")
  elasticsearchClusterConfig?: ElasticsearchClusterConfig;

  @doc("Property elasticsearchVersion")
  elasticsearchVersion?: string;

  @doc("Property encryptionAtRestOptions")
  encryptionAtRestOptions?: EncryptionAtRestOptions;

  @doc("Property id")
  id?: string;

  @doc("Property logPublishingOptions")
  logPublishingOptions?: Record<LogPublishingOption>;

  @doc("Property nodeToNodeEncryptionOptions")
  nodeToNodeEncryptionOptions?: NodeToNodeEncryptionOptions;

  @doc("Property snapshotOptions")
  snapshotOptions?: SnapshotOptions;

  @doc("Property tags")
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
  @doc("Property anonymousAuthEnabled")
  anonymousAuthEnabled?: boolean;

  @doc("Property enabled")
  enabled?: boolean;

  @doc("Property internalUserDatabaseEnabled")
  internalUserDatabaseEnabled?: boolean;

  @doc("Property masterUserOptions")
  masterUserOptions?: MasterUserOptions;
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

  @doc("Property volumeSize")
  volumeSize?: int32;

  @doc("Property volumeType")
  volumeType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticsearchClusterConfig")
model ElasticsearchClusterConfig {
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
@doc("Definition of SnapshotOptions")
model SnapshotOptions {
  @doc("Property automatedSnapshotStartHour")
  automatedSnapshotStartHour?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticsearchDomains {
  get is ArmResourceRead<ElasticsearchDomain>;
  @doc("Create a ElasticsearchDomain. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticsearchDomain>;
  update is ArmCustomPatchAsync<
    ElasticsearchDomain,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticsearchDomain>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticsearchDomain>;
  listByResourceGroup is ArmResourceListByParent<ElasticsearchDomain>;
  listBySubscription is ArmListBySubscription<ElasticsearchDomain>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Elasticsearch::Domain
//--------------------------------------------------------------------------------------------
