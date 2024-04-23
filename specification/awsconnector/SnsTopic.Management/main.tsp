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

//---------------------------------------------- SnsTopics ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model SnsTopic is TrackedResource<SnsTopicProperties> {
  @doc("Name of SnsTopic")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("snsTopics")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SnsTopic")
model SnsTopicProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsSnsTopicProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSnsTopic")
model AwsSnsTopicProperties {
  @doc("Gets and sets the property archivePolicy. The archive policy determines the number of days Amazon SNS retains messages. You can set a retention period from 1 to 365 days.")
  archivePolicy?: unknown;

  @doc("Gets and sets the property contentBasedDeduplication. Enables content-based deduplication for FIFO topics. By default, ContentBasedDeduplication is set to false. If you create a FIFO topic and this attribute is false, you must specify a value for the MessageDeduplicationId parameter for the Publish action.When you set ContentBasedDeduplication to true, Amazon SNS uses a SHA-256 hash to generate the MessageDeduplicationId using the body of the message (but not the attributes of the message).(Optional) To override the generated value, you can specify a value for the the MessageDeduplicationId parameter for the Publish action.")
  contentBasedDeduplication?: boolean;

  @doc("Gets and sets the property dataProtectionPolicy. The body of the policy document you want to use for this topic.You can only add one policy per topic.The policy must be in JSON string format.Length Constraints: Maximum length of 30720")
  dataProtectionPolicy?: unknown;

  @doc("Gets and sets the property deliveryStatusLogging. Delivery status logging configuration for supported protocols for an Amazon SNS topic.")
  @extension("x-ms-identifiers", [])
  deliveryStatusLogging?: LoggingConfig[];

  @doc("Gets and sets the property displayName. The display name to use for an Amazon SNS topic with SMS subscriptions.")
  displayName?: string;

  @doc("Gets and sets the property fifoTopic. Set to true to create a FIFO topic.")
  fifoTopic?: boolean;

  @doc("Gets and sets the property kmsMasterKeyId. The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK. For more information, see Key Terms. For more examples, see KeyId in the AWS Key Management Service API Reference.This property applies only to [server-side-encryption](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html).")
  kmsMasterKeyId?: string;

  @doc("Gets and sets the property signatureVersion. Version of the Amazon SNS signature used. If the SignatureVersion is 1, Signature is a Base64-encoded SHA1withRSA signature of the Message, MessageId, Type, Timestamp, and TopicArn values. If the SignatureVersion is 2, Signature is a Base64-encoded SHA256withRSA signature of the Message, MessageId, Type, Timestamp, and TopicArn values.")
  signatureVersion?: string;

  @doc("Gets and sets the property subscription. The SNS subscriptions (endpoints) for this topic.")
  @extension("x-ms-identifiers", [])
  subscription?: Subscription[];

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property topicArn.")
  topicArn?: string;

  @doc("Gets and sets the property topicName. The name of the topic you want to create. Topic names must include only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 256 characters long. FIFO topic names must end with .fifo.If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the topic name. For more information, see Name Type.")
  topicName?: string;

  @doc("Gets and sets the property tracingConfig. Tracing mode of an Amazon SNS topic. By default TracingConfig is set to PassThrough, and the topic passes through the tracing header it receives from an SNS publisher to its subscriptions. If set to Active, SNS will vend X-Ray segment data to topic owner account if the sampled flag in the tracing header is true. Only supported on standard topics.")
  tracingConfig?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoggingConfig")
model LoggingConfig {
  @doc("Gets and sets the property failureFeedbackRoleArn. The IAM role ARN to be used when logging failed message deliveries in Amazon CloudWatch")
  failureFeedbackRoleArn?: string;

  @doc("Gets and sets the property protocol. Indicates one of the supported protocols for the SNS topic")
  protocol?: LoggingConfigProtocol;

  @doc("Gets and sets the property successFeedbackRoleArn. The IAM role ARN to be used when logging successful message deliveries in Amazon CloudWatch")
  successFeedbackRoleArn?: string;

  @doc("Gets and sets the property successFeedbackSampleRate. The percentage of successful message deliveries to be logged in Amazon CloudWatch. Valid percentage values range from 0 to 100")
  successFeedbackSampleRate?: string;
}

@doc("LoggingConfigProtocol enum")
union LoggingConfigProtocol {
  @doc("LoggingConfigProtocol enum application")
  application: "application",

  @doc("LoggingConfigProtocol enum firehose")
  firehose: "firehose",

  @doc("LoggingConfigProtocol enum http/s")
  HttpS: "http/s",

  @doc("LoggingConfigProtocol enum lambda")
  lambda: "lambda",

  @doc("LoggingConfigProtocol enum sqs")
  sqs: "sqs",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Subscription")
model Subscription {
  @doc("Gets and sets the property endpoint.")
  endpoint?: string;

  @doc("Gets and sets the property protocol.")
  protocol?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, `_`, `.`, `/`, `=`, `+`, and `-`.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 characters in length.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SnsTopics {
  get is ArmResourceRead<SnsTopic>;
  @doc("Create a SnsTopic. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SnsTopic>;
  update is ArmCustomPatchAsync<
    SnsTopic,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SnsTopic>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SnsTopic>;
  listByResourceGroup is ArmResourceListByParent<SnsTopic>;
  listBySubscription is ArmListBySubscription<SnsTopic>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::SNS::Topic
//--------------------------------------------------------------------------------------------
