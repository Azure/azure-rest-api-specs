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

//---------------------------------------------- ConfigServiceConfigurationRecorderStatuses ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Config  Service Configuration Recorder Status",
    plural: "Config  Service Configuration Recorder Statuses",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Config ",
    "Service",
    "Configuration",
    "Recorder",
    "Status"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model ConfigServiceConfigurationRecorderStatus
  is TrackedResource<ConfigServiceConfigurationRecorderStatusProperties> {
  @doc("Name of ConfigServiceConfigurationRecorderStatus")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("configServiceConfigurationRecorderStatuses")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfigServiceConfigurationRecorderStatus")
model ConfigServiceConfigurationRecorderStatusProperties {
  @doc("AWS Properties")
  awsProperties?: AwsConfigServiceConfigurationRecorderStatusProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsConfigServiceConfigurationRecorderStatus")
model AwsConfigServiceConfigurationRecorderStatusProperties {
  @doc("<p>The latest error code from when the recorder last failed.</p>")
  lastErrorCode?: string;

  @doc("<p>The latest error message from when the recorder last failed.</p>")
  lastErrorMessage?: string;

  @doc("<p>The time the recorder was last started.</p>")
  lastStartTime?: utcDateTime;

  @doc("<p>The status of the latest recording event processed by the recorder.</p>")
  lastStatus?: RecorderStatusEnumValue;

  @doc("<p>The time of the latest change in status of an recording event processed by the recorder.</p>")
  lastStatusChangeTime?: utcDateTime;

  @doc("<p>The time the recorder was last stopped.</p>")
  lastStopTime?: utcDateTime;

  @doc("<p>The name of the configuration recorder.</p>")
  name?: string;

  @doc("<p>Specifies whether or not the recorder is currently recording.</p>")
  recording?: boolean;
}

@doc("RecorderStatus enum")
union RecorderStatus {
  @doc("RecorderStatus enum Failure")
  Failure: "Failure",

  @doc("RecorderStatus enum Pending")
  Pending: "Pending",

  @doc("RecorderStatus enum Success")
  Success: "Success",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecorderStatusEnumValue")
model RecorderStatusEnumValue {
  @doc("Property value")
  value?: RecorderStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ConfigServiceConfigurationRecorderStatuses {
  get is ArmResourceRead<ConfigServiceConfigurationRecorderStatus>;
  @doc("Create a ConfigServiceConfigurationRecorderStatus. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ConfigServiceConfigurationRecorderStatus>;
  update is ArmCustomPatchAsync<
    ConfigServiceConfigurationRecorderStatus,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ConfigServiceConfigurationRecorderStatus>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ConfigServiceConfigurationRecorderStatus>;
  listByResourceGroup is ArmResourceListByParent<ConfigServiceConfigurationRecorderStatus>;
  listBySubscription is ArmListBySubscription<ConfigServiceConfigurationRecorderStatus>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\config\config-2014-11-12.normal.json
// AWS Shape: ConfigurationRecorderStatus
//
// Related information for backend service:
// AWS Servcie : Config Service
// Product Version : 3.7.798.0
// SDK Version : 3.7.302.55
//--------------------------------------------------------------------------------------------
