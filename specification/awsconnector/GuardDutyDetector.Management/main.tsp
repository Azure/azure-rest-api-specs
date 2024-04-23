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

//---------------------------------------------- GuardDutyDetectors ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model GuardDutyDetector is TrackedResource<GuardDutyDetectorProperties> {
  @doc("Name of GuardDutyDetector")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("guardDutyDetectors")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GuardDutyDetector")
model GuardDutyDetectorProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsGuardDutyDetectorProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsGuardDutyDetector")
model AwsGuardDutyDetectorProperties {
  @doc("Gets and sets the property dataSources.")
  dataSources?: CFNDataSourceConfigurations;

  @doc("Gets and sets the property enable.")
  enable?: boolean;

  @doc("Gets and sets the property features.")
  @extension("x-ms-identifiers", [])
  features?: CFNFeatureConfiguration[];

  @doc("Gets and sets the property findingPublishingFrequency.")
  findingPublishingFrequency?: string;

  @doc("Gets and sets the property id.")
  id?: string;

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: TagItem[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNDataSourceConfigurations")
model CFNDataSourceConfigurations {
  @doc("Gets and sets the property kubernetes.")
  kubernetes?: CFNKubernetesConfiguration;

  @doc("Gets and sets the property malwareProtection.")
  malwareProtection?: CFNMalwareProtectionConfiguration;

  @doc("Gets and sets the property s3Logs.")
  s3Logs?: CFNS3LogsConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNFeatureConfiguration")
model CFNFeatureConfiguration {
  @doc("Gets and sets the property additionalConfiguration.")
  @extension("x-ms-identifiers", [])
  additionalConfiguration?: CFNFeatureAdditionalConfiguration[];

  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property status.")
  status?: CFNFeatureConfigurationStatus;
}

@doc("CFNFeatureConfigurationStatus enum")
union CFNFeatureConfigurationStatus {
  @doc("CFNFeatureConfigurationStatus enum DISABLED")
  DISABLED: "DISABLED",

  @doc("CFNFeatureConfigurationStatus enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TagItem")
model TagItem {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNKubernetesConfiguration")
model CFNKubernetesConfiguration {
  @doc("Gets and sets the property auditLogs.")
  auditLogs?: CFNKubernetesAuditLogsConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNMalwareProtectionConfiguration")
model CFNMalwareProtectionConfiguration {
  @doc("Gets and sets the property scanEc2InstanceWithFindings.")
  scanEc2InstanceWithFindings?: CFNScanEc2InstanceWithFindingsConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNS3LogsConfiguration")
model CFNS3LogsConfiguration {
  @doc("Gets and sets the property enable.")
  enable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNFeatureAdditionalConfiguration")
model CFNFeatureAdditionalConfiguration {
  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property status.")
  status?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNKubernetesAuditLogsConfiguration")
model CFNKubernetesAuditLogsConfiguration {
  @doc("Gets and sets the property enable.")
  enable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNScanEc2InstanceWithFindingsConfiguration")
model CFNScanEc2InstanceWithFindingsConfiguration {
  @doc("Gets and sets the property ebsVolumes.")
  ebsVolumes?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface GuardDutyDetectors {
  get is ArmResourceRead<GuardDutyDetector>;
  @doc("Create a GuardDutyDetector. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GuardDutyDetector>;
  update is ArmCustomPatchAsync<
    GuardDutyDetector,
    Azure.ResourceManager.Foundations.TagsUpdateModel<GuardDutyDetector>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<GuardDutyDetector>;
  listByResourceGroup is ArmResourceListByParent<GuardDutyDetector>;
  listBySubscription is ArmListBySubscription<GuardDutyDetector>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::GuardDuty::Detector
//--------------------------------------------------------------------------------------------
