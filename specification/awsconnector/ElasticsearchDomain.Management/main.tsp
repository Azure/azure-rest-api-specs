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

//---------------------------------------------- ElasticsearchDomains ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsElasticsearchDomainProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticsearchDomain")
model AwsElasticsearchDomainProperties {
  @doc("Gets and sets the property accessPolicies.")
  accessPolicies?: unknown;

  @doc("Gets and sets the property advancedOptions.")
  advancedOptions?: Record<string>;

  @doc("Gets and sets the property advancedSecurityOptions.")
  advancedSecurityOptions?: AdvancedSecurityOptionsInput;

  @doc("Gets and sets the property arn.")
  arn?: string;

  @doc("Gets and sets the property cognitoOptions.")
  cognitoOptions?: CognitoOptions;

  @doc("Gets and sets the property domainArn.")
  domainArn?: string;

  @doc("Gets and sets the property domainEndpoint.")
  domainEndpoint?: string;

  @doc("Gets and sets the property domainEndpointOptions.")
  domainEndpointOptions?: DomainEndpointOptions;

  @doc("Gets and sets the property domainName.")
  domainName?: string;

  @doc("Gets and sets the property ebsOptions.")
  ebsOptions?: EBSOptions;

  @doc("Gets and sets the property elasticsearchClusterConfig.")
  elasticsearchClusterConfig?: ElasticsearchClusterConfig;

  @doc("Gets and sets the property elasticsearchVersion.")
  elasticsearchVersion?: string;

  @doc("Gets and sets the property encryptionAtRestOptions.")
  encryptionAtRestOptions?: EncryptionAtRestOptions;

  @doc("Gets and sets the property id.")
  id?: string;

  @doc("Gets and sets the property logPublishingOptions.")
  logPublishingOptions?: Record<LogPublishingOption>;

  @doc("Gets and sets the property nodeToNodeEncryptionOptions.")
  nodeToNodeEncryptionOptions?: NodeToNodeEncryptionOptions;

  @doc("Gets and sets the property snapshotOptions.")
  snapshotOptions?: SnapshotOptions;

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property vpcOptions.")
  vpcOptions?: VPCOptions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AdvancedSecurityOptionsInput")
model AdvancedSecurityOptionsInput {
  @doc("Gets and sets the property anonymousAuthEnabled.")
  anonymousAuthEnabled?: boolean;

  @doc("Gets and sets the property enabled.")
  enabled?: boolean;

  @doc("Gets and sets the property internalUserDatabaseEnabled.")
  internalUserDatabaseEnabled?: boolean;

  @doc("Gets and sets the property masterUserOptions.")
  masterUserOptions?: MasterUserOptions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CognitoOptions")
model CognitoOptions {
  @doc("Gets and sets the property enabled.")
  enabled?: boolean;

  @doc("Gets and sets the property identityPoolId.")
  identityPoolId?: string;

  @doc("Gets and sets the property roleArn.")
  roleArn?: string;

  @doc("Gets and sets the property userPoolId.")
  userPoolId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DomainEndpointOptions")
model DomainEndpointOptions {
  @doc("Gets and sets the property customEndpoint.")
  customEndpoint?: string;

  @doc("Gets and sets the property customEndpointCertificateArn.")
  customEndpointCertificateArn?: string;

  @doc("Gets and sets the property customEndpointEnabled.")
  customEndpointEnabled?: boolean;

  @doc("Gets and sets the property enforceHTTPS.")
  enforceHTTPS?: boolean;

  @doc("Gets and sets the property tlsSecurityPolicy.")
  tlsSecurityPolicy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EBSOptions")
model EBSOptions {
  @doc("Gets and sets the property ebsEnabled.")
  ebsEnabled?: boolean;

  @doc("Gets and sets the property iops.")
  iops?: int32;

  @doc("Gets and sets the property volumeSize.")
  volumeSize?: int32;

  @doc("Gets and sets the property volumeType.")
  volumeType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticsearchClusterConfig")
model ElasticsearchClusterConfig {
  @doc("Gets and sets the property coldStorageOptions.")
  coldStorageOptions?: ColdStorageOptions;

  @doc("Gets and sets the property dedicatedMasterCount.")
  dedicatedMasterCount?: int32;

  @doc("Gets and sets the property dedicatedMasterEnabled.")
  dedicatedMasterEnabled?: boolean;

  @doc("Gets and sets the property dedicatedMasterType.")
  dedicatedMasterType?: string;

  @doc("Gets and sets the property instanceCount.")
  instanceCount?: int32;

  @doc("Gets and sets the property instanceType.")
  instanceType?: string;

  @doc("Gets and sets the property warmCount.")
  warmCount?: int32;

  @doc("Gets and sets the property warmEnabled.")
  warmEnabled?: boolean;

  @doc("Gets and sets the property warmType.")
  warmType?: string;

  @doc("Gets and sets the property zoneAwarenessConfig.")
  zoneAwarenessConfig?: ZoneAwarenessConfig;

  @doc("Gets and sets the property zoneAwarenessEnabled.")
  zoneAwarenessEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EncryptionAtRestOptions")
model EncryptionAtRestOptions {
  @doc("Gets and sets the property enabled.")
  enabled?: boolean;

  @doc("Gets and sets the property kmsKeyId.")
  kmsKeyId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogPublishingOption")
model LogPublishingOption {
  @doc("Gets and sets the property cloudWatchLogsLogGroupArn.")
  cloudWatchLogsLogGroupArn?: string;

  @doc("Gets and sets the property enabled.")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NodeToNodeEncryptionOptions")
model NodeToNodeEncryptionOptions {
  @doc("Gets and sets the property enabled.")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SnapshotOptions")
model SnapshotOptions {
  @doc("Gets and sets the property automatedSnapshotStartHour.")
  automatedSnapshotStartHour?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VPCOptions")
model VPCOptions {
  @doc("Gets and sets the property securityGroupIds.")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Gets and sets the property subnetIds.")
  @extension("x-ms-identifiers", [])
  subnetIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MasterUserOptions")
model MasterUserOptions {
  @doc("Gets and sets the property masterUserARN.")
  masterUserARN?: string;

  @doc("Gets and sets the property masterUserName.")
  masterUserName?: string;

  @doc("Gets and sets the property masterUserPassword.")
  masterUserPassword?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ColdStorageOptions")
model ColdStorageOptions {
  @doc("Gets and sets the property enabled.")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ZoneAwarenessConfig")
model ZoneAwarenessConfig {
  @doc("Gets and sets the property availabilityZoneCount.")
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
