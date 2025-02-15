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

//---------------------------------------------- GuardDutyDetectors ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Guard Duty Detector",
    plural: "Guard Duty Detectors",
  },
  keywords: ["Microsoft.AwsConnector", "Guard", "Duty", "Detector"],
})
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
  @doc("AWS Properties")
  awsProperties?: AwsGuardDutyDetectorProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsGuardDutyDetector")
model AwsGuardDutyDetectorProperties {
  @doc("Property dataSources")
  dataSources?: CFNDataSourceConfigurations;

  @doc("Property enable")
  enable?: boolean;

  @doc("Property features")
  @extension("x-ms-identifiers", [])
  features?: CFNFeatureConfiguration[];

  @doc("Property findingPublishingFrequency")
  findingPublishingFrequency?: string;

  @doc("Property id")
  id?: string;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: TagItem[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNDataSourceConfigurations")
model CFNDataSourceConfigurations {
  @doc("Property kubernetes")
  kubernetes?: CFNKubernetesConfiguration;

  @doc("Property malwareProtection")
  malwareProtection?: CFNMalwareProtectionConfiguration;

  @doc("Property s3Logs")
  s3Logs?: CFNS3LogsConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNFeatureConfiguration")
model CFNFeatureConfiguration {
  @doc("Property additionalConfiguration")
  @extension("x-ms-identifiers", [])
  additionalConfiguration?: CFNFeatureAdditionalConfiguration[];

  @doc("Property name")
  name?: string;

  @doc("Property status")
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
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNKubernetesConfiguration")
model CFNKubernetesConfiguration {
  @doc("Property auditLogs")
  auditLogs?: CFNKubernetesAuditLogsConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNMalwareProtectionConfiguration")
model CFNMalwareProtectionConfiguration {
  @doc("Property scanEc2InstanceWithFindings")
  scanEc2InstanceWithFindings?: CFNScanEc2InstanceWithFindingsConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNS3LogsConfiguration")
model CFNS3LogsConfiguration {
  @doc("Property enable")
  enable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNFeatureAdditionalConfiguration")
model CFNFeatureAdditionalConfiguration {
  @doc("Property name")
  name?: string;

  @doc("Property status")
  status?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNKubernetesAuditLogsConfiguration")
model CFNKubernetesAuditLogsConfiguration {
  @doc("Property enable")
  enable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CFNScanEc2InstanceWithFindingsConfiguration")
model CFNScanEc2InstanceWithFindingsConfiguration {
  @doc("Property ebsVolumes")
  ebsVolumes?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface GuardDutyDetectors {
  get is ArmResourceRead<GuardDutyDetector>;
  @doc("Create a GuardDutyDetector. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<GuardDutyDetector>;
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
