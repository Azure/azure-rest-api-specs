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

//---------------------------------------------- SageMakerDeviceSummaries ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Sage Maker Device Summary",
    plural: "Sage Maker Device Summaries",
  },
  keywords: ["Microsoft.AwsConnector", "Sage", "Maker", "Device", "Summary"],
})
@doc("A Microsoft.AwsConnector resource")
model SageMakerDeviceSummary
  is TrackedResource<SageMakerDeviceSummaryProperties> {
  @doc("Name of SageMakerDeviceSummary")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("sageMakerDeviceSummaries")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SageMakerDeviceSummary")
model SageMakerDeviceSummaryProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSageMakerDeviceSummaryProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSageMakerDeviceSummary")
model AwsSageMakerDeviceSummaryProperties {
  @doc("<p>Edge Manager agent version.</p>")
  agentVersion?: string;

  @doc("<p>A description of the device.</p>")
  description?: string;

  @doc("<p>Amazon Resource Name (ARN) of the device.</p>")
  deviceArn?: string;

  @doc("<p>The name of the fleet the device belongs to.</p>")
  deviceFleetName?: string;

  @doc("<p>The unique identifier of the device.</p>")
  deviceName?: string;

  @doc("<p>The Amazon Web Services Internet of Things (IoT) object thing name associated with the device..</p>")
  iotThingName?: string;

  @doc("<p>The last heartbeat received from the device.</p>")
  latestHeartbeat?: utcDateTime;

  @doc("<p>Models on the device.</p>")
  @extension("x-ms-identifiers", [])
  models?: EdgeModelSummary[];

  @doc("<p>The timestamp of the last registration or de-reregistration.</p>")
  registrationTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EdgeModelSummary")
model EdgeModelSummary {
  @doc("<p>The name of the model.</p>")
  modelName?: string;

  @doc("<p>The version model.</p>")
  modelVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SageMakerDeviceSummaries {
  get is ArmResourceRead<SageMakerDeviceSummary>;
  @doc("Create a SageMakerDeviceSummary. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SageMakerDeviceSummary>;
  update is ArmCustomPatchAsync<
    SageMakerDeviceSummary,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SageMakerDeviceSummary>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SageMakerDeviceSummary>;
  listByResourceGroup is ArmResourceListByParent<SageMakerDeviceSummary>;
  listBySubscription is ArmListBySubscription<SageMakerDeviceSummary>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\sagemaker\sagemaker-2017-07-24.normal.json
// AWS Shape: DeviceSummary
//
// Related information for backend service:
// AWS Servcie : SageMaker
// Product Version : 3.7.798.0
// SDK Version : 3.7.319.4
//--------------------------------------------------------------------------------------------
