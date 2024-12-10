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

//---------------------------------------------- SqsQueues ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "SQS Queue",
    plural: "SQS Queues",
  },
  keywords: ["Microsoft.AwsConnector", "SQS", "Queue"],
})
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
  @doc("AWS Properties")
  awsProperties?: AwsSqsQueueProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSqsQueue")
model AwsSqsQueueProperties {
  @doc("Property arn")
  arn?: string;

  @doc("For first-in-first-out (FIFO) queues, specifies whether to enable content-based deduplication. During the deduplication interval, SQS treats messages that are sent with identical content as duplicates and delivers only one copy of the message. For more information, see the ``ContentBasedDeduplication`` attribute for the ``CreateQueue`` action in the *API Reference*.")
  contentBasedDeduplication?: boolean;

  @doc("For high throughput for FIFO queues, specifies whether message deduplication occurs at the message group or queue level. Valid values are ``messageGroup`` and ``queue``. To enable high throughput for a FIFO queue, set this attribute to ``messageGroup`` *and* set the ``FifoThroughputLimit`` attribute to ``perMessageGroupId``. If you set these attributes to anything other than these values, normal throughput is in effect and deduplication occurs as specified. For more information, see [High throughput for FIFO queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/high-throughput-fifo.html) and [Quotas related to messages](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/quotas-messages.html) in the *Developer Guide*.")
  deduplicationScope?: string;

  @doc("The time in seconds for which the delivery of all messages in the queue is delayed. You can specify an integer value of ``0`` to ``900`` (15 minutes). The default value is ``0``.")
  delaySeconds?: int32;

  @doc("If set to true, creates a FIFO queue. If you don't specify this property, SQS creates a standard queue. For more information, see [FIFO queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html) in the *Developer Guide*.")
  fifoQueue?: boolean;

  @doc("For high throughput for FIFO queues, specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are ``perQueue`` and ``perMessageGroupId``. To enable high throughput for a FIFO queue, set this attribute to ``perMessageGroupId`` *and* set the ``DeduplicationScope`` attribute to ``messageGroup``. If you set these attributes to anything other than these values, normal throughput is in effect and deduplication occurs as specified. For more information, see [High throughput for FIFO queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/high-throughput-fifo.html) and [Quotas related to messages](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/quotas-messages.html) in the *Developer Guide*.")
  fifoThroughputLimit?: string;

  @doc("The length of time in seconds for which SQS can reuse a data key to encrypt or decrypt messages before calling KMS again. The value must be an integer between 60 (1 minute) and 86,400 (24 hours). The default is 300 (5 minutes).  A shorter time period provides better security, but results in more calls to KMS, which might incur charges after Free Tier. For more information, see [Encryption at rest](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html#sqs-how-does-the-data-key-reuse-period-work) in the *Developer Guide*.")
  kmsDataKeyReusePeriodSeconds?: int32;

  @doc("The ID of an AWS Key Management Service (KMS) for SQS, or a custom KMS. To use the AWS managed KMS for SQS, specify a (default) alias ARN, alias name (e.g. ``alias/aws/sqs``), key ARN, or key ID. For more information, see the following:  +   [Encryption at rest](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html) in the *Developer Guide*   +   [CreateQueue](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_CreateQueue.html) in the *API Reference*   +   [Request Parameters](https://docs.aws.amazon.com/kms/latest/APIReference/API_DescribeKey.html#API_DescribeKey_RequestParameters) in the *Key Management Service API Reference*   +   The Key Management Service (KMS) section of the [Best Practices](https://docs.aws.amazon.com/https://d0.awsstatic.com/whitepapers/aws-kms-best-practices.pdf) whitepaper")
  kmsMasterKeyId?: string;

  @doc("The limit of how many bytes that a message can contain before SQS rejects it. You can specify an integer value from ``1,024`` bytes (1 KiB) to ``262,144`` bytes (256 KiB). The default value is ``262,144`` (256 KiB).")
  maximumMessageSize?: int32;

  @doc("The number of seconds that SQS retains a message. You can specify an integer value from ``60`` seconds (1 minute) to ``1,209,600`` seconds (14 days). The default value is ``345,600`` seconds (4 days).")
  messageRetentionPeriod?: int32;

  @doc("A name for the queue. To create a FIFO queue, the name of your FIFO queue must end with the ``.fifo`` suffix. For more information, see [FIFO queues](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html) in the *Developer Guide*. If you don't specify a name, CFN generates a unique physical ID and uses that ID for the queue name. For more information, see [Name type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-name.html) in the *User Guide*.   If you specify a name, you can't perform updates that require replacement of this resource. You can perform updates that require no or some interruption. If you must replace the resource, specify a new name.")
  queueName?: string;

  @doc("Property queueUrl")
  queueUrl?: string;

  @doc("Specifies the duration, in seconds, that the ReceiveMessage action call waits until a message is in the queue in order to include it in the response, rather than returning an empty response if a message isn't yet available. You can specify an integer from 1 to 20. Short polling is used as the default or when you specify 0 for this property. For more information, see [Consuming messages using long polling](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-short-and-long-polling.html#sqs-long-polling) in the *Developer Guide*.")
  receiveMessageWaitTimeSeconds?: int32;

  @doc("The string that includes the parameters for the permissions for the dead-letter queue redrive permission and which source queues can specify dead-letter queues as a JSON object. The parameters are as follows:  +  ``redrivePermission``: The permission type that defines which source queues can specify the current queue as the dead-letter queue. Valid values are:  +  ``allowAll``: (Default) Any source queues in this AWS account in the same Region can specify this queue as the dead-letter queue.  +  ``denyAll``: No source queues can specify this queue as the dead-letter queue.  +  ``byQueue``: Only queues specified by the ``sourceQueueArns`` parameter can specify this queue as the dead-letter queue.    +  ``sourceQueueArns``: The Amazon Resource Names (ARN)s of the source queues that can specify this queue as the dead-letter queue and redrive messages. You can specify this parameter only when the ``redrivePermission`` parameter is set to ``byQueue``. You can specify up to 10 source queue ARNs. To allow more than 10 source queues to specify dead-letter queues, set the ``redrivePermission`` parameter to ``allowAll``.")
  redriveAllowPolicy?: Record<unknown>;

  @doc("The string that includes the parameters for the dead-letter queue functionality of the source queue as a JSON object. The parameters are as follows:  +  ``deadLetterTargetArn``: The Amazon Resource Name (ARN) of the dead-letter queue to which SQS moves messages after the value of ``maxReceiveCount`` is exceeded.  +  ``maxReceiveCount``: The number of times a message is delivered to the source queue before being moved to the dead-letter queue. When the ``ReceiveCount`` for a message exceeds the ``maxReceiveCount`` for a queue, SQS moves the message to the dead-letter-queue.    The dead-letter queue of a FIFO queue must also be a FIFO queue. Similarly, the dead-letter queue of a standard queue must also be a standard queue.   *JSON*   ``{ 'deadLetterTargetArn' : String, 'maxReceiveCount' : Integer }``   *YAML*   ``deadLetterTargetArn : String``   ``maxReceiveCount : Integer``")
  redrivePolicy?: Record<unknown>;

  @doc("Enables server-side queue encryption using SQS owned encryption keys. Only one server-side encryption option is supported per queue (for example, [SSE-KMS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sse-existing-queue.html) or [SSE-SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sqs-sse-queue.html)). When ``SqsManagedSseEnabled`` is not defined, ``SSE-SQS`` encryption is enabled by default.")
  sqsManagedSseEnabled?: boolean;

  @doc("The tags that you attach to this queue. For more information, see [Resource tag](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-resource-tags.html) in the *User Guide*.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The length of time during which a message will be unavailable after a message is delivered from the queue. This blocks other components from receiving the same message and gives the initial component time to process and delete the message from the queue. Values must be from 0 to 43,200 seconds (12 hours). If you don't specify a value, AWS CloudFormation uses the default value of 30 seconds. For more information about SQS queue visibility timeouts, see [Visibility timeout](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html) in the *Developer Guide*.")
  visibilityTimeout?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SqsQueues {
  get is ArmResourceRead<SqsQueue>;
  @doc("Create a SqsQueue. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SqsQueue>;
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
