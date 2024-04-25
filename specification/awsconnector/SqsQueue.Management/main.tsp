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

//---------------------------------------------- SqsQueues ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model SqsQueue is TrackedResource<SqsQueueProperties> {
  @doc("Name of SqsQueue")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("sqsQueues")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SqsQueue")
model SqsQueueProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsSqsQueueProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSqsQueue")
model AwsSqsQueueProperties {
  @doc("Gets and sets the property arn. Amazon Resource Name (ARN) of the queue.")
  arn?: string;

  @doc("Gets and sets the property contentBasedDeduplication. For first-in-first-out (FIFO) queues, specifies whether to enable content-based deduplication. During the deduplication interval, Amazon SQS treats messages that are sent with identical content as duplicates and delivers only one copy of the message.")
  contentBasedDeduplication?: boolean;

  @doc("Gets and sets the property deduplicationScope. Specifies whether message deduplication occurs at the message group or queue level. Valid values are messageGroup and queue.")
  deduplicationScope?: string;

  @doc("Gets and sets the property delaySeconds. The time in seconds for which the delivery of all messages in the queue is delayed. You can specify an integer value of 0 to 900 (15 minutes). The default value is 0.")
  delaySeconds?: int32;

  @doc("Gets and sets the property fifoQueue. If set to true, creates a FIFO queue. If you don't specify this property, Amazon SQS creates a standard queue.")
  fifoQueue?: boolean;

  @doc("Gets and sets the property fifoThroughputLimit. Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are perQueue and perMessageGroupId. The perMessageGroupId value is allowed only when the value for DeduplicationScope is messageGroup.")
  fifoThroughputLimit?: string;

  @doc("Gets and sets the property kmsDataKeyReusePeriodSeconds. The length of time in seconds for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. The value must be an integer between 60 (1 minute) and 86,400 (24 hours). The default is 300 (5 minutes).")
  kmsDataKeyReusePeriodSeconds?: int32;

  @doc("Gets and sets the property kmsMasterKeyId. The ID of an AWS managed customer master key (CMK) for Amazon SQS or a custom CMK. To use the AWS managed CMK for Amazon SQS, specify the (default) alias alias/aws/sqs.")
  kmsMasterKeyId?: string;

  @doc("Gets and sets the property maximumMessageSize. The limit of how many bytes that a message can contain before Amazon SQS rejects it. You can specify an integer value from 1,024 bytes (1 KiB) to 262,144 bytes (256 KiB). The default value is 262,144 (256 KiB).")
  maximumMessageSize?: int32;

  @doc("Gets and sets the property messageRetentionPeriod. The number of seconds that Amazon SQS retains a message. You can specify an integer value from 60 seconds (1 minute) to 1,209,600 seconds (14 days). The default value is 345,600 seconds (4 days).")
  messageRetentionPeriod?: int32;

  @doc("Gets and sets the property queueName. A name for the queue. To create a FIFO queue, the name of your FIFO queue must end with the .fifo suffix.")
  queueName?: string;

  @doc("Gets and sets the property queueUrl. URL of the source queue.")
  queueUrl?: string;

  @doc("Gets and sets the property receiveMessageWaitTimeSeconds. Specifies the duration, in seconds, that the ReceiveMessage action call waits until a message is in the queue in order to include it in the response, rather than returning an empty response if a message isn't yet available. You can specify an integer from 1 to 20. Short polling is used as the default or when you specify 0 for this property.")
  receiveMessageWaitTimeSeconds?: int32;

  @doc("Gets and sets the property redriveAllowPolicy. The string that includes the parameters for the permissions for the dead-letter queue redrive permission and which source queues can specify dead-letter queues as a JSON object.")
  redriveAllowPolicy?: string;

  @doc("Gets and sets the property redrivePolicy. A string that includes the parameters for the dead-letter queue functionality (redrive policy) of the source queue.")
  redrivePolicy?: string;

  @doc("Gets and sets the property sqsManagedSseEnabled. Enables server-side queue encryption using SQS owned encryption keys. Only one server-side encryption option is supported per queue (e.g. SSE-KMS or SSE-SQS ).")
  sqsManagedSseEnabled?: boolean;

  @doc("Gets and sets the property tags. The tags that you attach to this queue.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property visibilityTimeout. The length of time during which a message will be unavailable after a message is delivered from the queue. This blocks other components from receiving the same message and gives the initial component time to process and delete the message from the queue. Values must be from 0 to 43,200 seconds (12 hours). If you don't specify a value, AWS CloudFormation uses the default value of 30 seconds.")
  visibilityTimeout?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SqsQueues {
  get is ArmResourceRead<SqsQueue>;
  @doc("Create a SqsQueue. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqsQueue>;
  update is ArmCustomPatchAsync<
    SqsQueue,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SqsQueue>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SqsQueue>;
  listByResourceGroup is ArmResourceListByParent<SqsQueue>;
  listBySubscription is ArmListBySubscription<SqsQueue>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::SQS::Queue
//--------------------------------------------------------------------------------------------
