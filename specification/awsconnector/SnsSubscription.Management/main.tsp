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

//---------------------------------------------- SnsSubscriptions ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "SNS Subscription",
    plural: "SNS Subscriptions",
  },
  keywords: ["Microsoft.AwsConnector", "SNS", "Subscription"],
})
@doc("A Microsoft.AwsConnector resource")
model SnsSubscription is TrackedResource<SnsSubscriptionProperties> {
  @doc("Name of SnsSubscription")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("snsSubscriptions")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SnsSubscription")
model SnsSubscriptionProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSnsSubscriptionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSnsSubscription")
model AwsSnsSubscriptionProperties {
  @doc("<p>The subscription's endpoint (format depends on the protocol).</p>")
  endpoint?: string;

  @doc("<p>The subscription's owner.</p>")
  owner?: string;

  @doc("<p>The subscription's protocol.</p>")
  protocol?: string;

  @doc("<p>The subscription's ARN.</p>")
  subscriptionArn?: string;

  @doc("<p>The ARN of the subscription's topic.</p>")
  topicArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SnsSubscriptions {
  get is ArmResourceRead<SnsSubscription>;
  @doc("Create a SnsSubscription. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SnsSubscription>;
  update is ArmCustomPatchAsync<
    SnsSubscription,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SnsSubscription>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SnsSubscription>;
  listByResourceGroup is ArmResourceListByParent<SnsSubscription>;
  listBySubscription is ArmListBySubscription<SnsSubscription>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\sns\sns-2010-03-31.normal.json
// AWS Shape: Subscription
//
// Related information for backend service:
// AWS Servcie : SNS
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.31
//--------------------------------------------------------------------------------------------
