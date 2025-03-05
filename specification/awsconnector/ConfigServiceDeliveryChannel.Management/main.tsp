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

//---------------------------------------------- ConfigServiceDeliveryChannels ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Config  Service Delivery Channel",
    plural: "Config  Service Delivery Channels",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Config ",
    "Service",
    "Delivery",
    "Channel"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model ConfigServiceDeliveryChannel
  is TrackedResource<ConfigServiceDeliveryChannelProperties> {
  @doc("Name of ConfigServiceDeliveryChannel")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("configServiceDeliveryChannels")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfigServiceDeliveryChannel")
model ConfigServiceDeliveryChannelProperties {
  @doc("AWS Properties")
  awsProperties?: AwsConfigServiceDeliveryChannelProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsConfigServiceDeliveryChannel")
model AwsConfigServiceDeliveryChannelProperties {
  @doc("<p>The options for how often Config delivers configuration snapshots to the Amazon S3 bucket.</p>")
  configSnapshotDeliveryProperties?: ConfigSnapshotDeliveryProperties;

  @doc("<p>The name of the delivery channel. By default, Config assigns the name 'default' when creating the delivery channel. To change the delivery channel name, you must use the DeleteDeliveryChannel action to delete your current delivery channel, and then you must use the PutDeliveryChannel command to create a delivery channel that has the desired name.</p>")
  name?: string;

  @doc("<p>The name of the Amazon S3 bucket to which Config delivers configuration snapshots and configuration history files.</p> <p>If you specify a bucket that belongs to another Amazon Web Services account, that bucket must have policies that grant access permissions to Config. For more information, see <a href='https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-policy.html'>Permissions for the Amazon S3 Bucket</a> in the <i>Config Developer Guide</i>.</p>")
  s3BucketName?: string;

  @doc("<p>The prefix for the specified Amazon S3 bucket.</p>")
  s3KeyPrefix?: string;

  @doc("<p>The Amazon Resource Name (ARN) of the Key Management Service (KMS ) KMS key (KMS key) used to encrypt objects delivered by Config. Must belong to the same Region as the destination S3 bucket.</p>")
  s3KmsKeyArn?: string;

  @doc("<p>The Amazon Resource Name (ARN) of the Amazon SNS topic to which Config sends notifications about configuration changes.</p> <p>If you choose a topic from another account, the topic must have policies that grant access permissions to Config. For more information, see <a href='https://docs.aws.amazon.com/config/latest/developerguide/sns-topic-policy.html'>Permissions for the Amazon SNS Topic</a> in the <i>Config Developer Guide</i>.</p>")
  snsTopicARN?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfigSnapshotDeliveryProperties")
model ConfigSnapshotDeliveryProperties {
  @doc("<p>The frequency with which Config delivers configuration snapshots.</p>")
  deliveryFrequency?: MaximumExecutionFrequencyEnumValue;
}

@doc("MaximumExecutionFrequency enum")
union MaximumExecutionFrequency {
  @doc("MaximumExecutionFrequency enum One_Hour")
  One_Hour: "One_Hour",

  @doc("MaximumExecutionFrequency enum Six_Hours")
  Six_Hours: "Six_Hours",

  @doc("MaximumExecutionFrequency enum Three_Hours")
  Three_Hours: "Three_Hours",

  @doc("MaximumExecutionFrequency enum Twelve_Hours")
  Twelve_Hours: "Twelve_Hours",

  @doc("MaximumExecutionFrequency enum TwentyFour_Hours")
  TwentyFour_Hours: "TwentyFour_Hours",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MaximumExecutionFrequencyEnumValue")
model MaximumExecutionFrequencyEnumValue {
  @doc("Property value")
  value?: MaximumExecutionFrequency;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ConfigServiceDeliveryChannels {
  get is ArmResourceRead<ConfigServiceDeliveryChannel>;
  @doc("Create a ConfigServiceDeliveryChannel. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ConfigServiceDeliveryChannel>;
  update is ArmCustomPatchAsync<
    ConfigServiceDeliveryChannel,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ConfigServiceDeliveryChannel>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ConfigServiceDeliveryChannel>;
  listByResourceGroup is ArmResourceListByParent<ConfigServiceDeliveryChannel>;
  listBySubscription is ArmListBySubscription<ConfigServiceDeliveryChannel>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\config\config-2014-11-12.normal.json
// AWS Shape: DeliveryChannel
//
// Related information for backend service:
// AWS Servcie : Config Service
// Product Version : 3.7.798.0
// SDK Version : 3.7.302.55
//--------------------------------------------------------------------------------------------
