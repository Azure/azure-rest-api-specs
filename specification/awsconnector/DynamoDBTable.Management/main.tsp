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

//---------------------------------------------- DynamoDBTables ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Dynamo DB Table",
    plural: "Dynamo DB Tables",
  },
  keywords: ["Microsoft.AwsConnector", "Dynamo", "DB", "Table"],
})
@doc("A Microsoft.AwsConnector resource")
model DynamoDBTable is TrackedResource<DynamoDBTableProperties> {
  @doc("Name of DynamoDBTable")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("dynamoDBTables")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DynamoDBTable")
model DynamoDBTableProperties {
  @doc("AWS Properties")
  awsProperties?: AwsDynamoDBTableProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsDynamoDBTable")
model AwsDynamoDBTableProperties {
  @doc("Property arn")
  arn?: string;

  @doc("A list of attributes that describe the key schema for the table and indexes. This property is required to create a DDB table. Update requires: [Some interruptions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-update-behaviors.html#update-some-interrupt). Replacement if you edit an existing AttributeDefinition.")
  @extension("x-ms-identifiers", [])
  attributeDefinitions?: AttributeDefinition[];

  @doc("Specify how you are charged for read and write throughput and how you manage capacity. Valid values include:  +   ``PROVISIONED`` - We recommend using ``PROVISIONED`` for predictable workloads. ``PROVISIONED`` sets the billing mode to [Provisioned Mode](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.ReadWriteCapacityMode.html#HowItWorks.ProvisionedThroughput.Manual).  +   ``PAY_PER_REQUEST`` - We recommend using ``PAY_PER_REQUEST`` for unpredictable workloads. ``PAY_PER_REQUEST`` sets the billing mode to [On-Demand Mode](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.ReadWriteCapacityMode.html#HowItWorks.OnDemand).   If not specified, the default is ``PROVISIONED``.")
  billingMode?: string;

  @doc("The settings used to enable or disable CloudWatch Contributor Insights for the specified table. The settings used to enable or disable CloudWatch Contributor Insights.")
  contributorInsightsSpecification?: ContributorInsightsSpecification;

  @doc("Determines if a table is protected from deletion. When enabled, the table cannot be deleted by any user or process. This setting is disabled by default. For more information, see [Using deletion protection](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.Basics.html#WorkingWithTables.Basics.DeletionProtection) in the *Developer Guide*.")
  deletionProtectionEnabled?: boolean;

  @doc("Global secondary indexes to be created on the table. You can create up to 20 global secondary indexes.  If you update a table to include a new global secondary index, CFNlong initiates the index creation and then proceeds with the stack update. CFNlong doesn't wait for the index to complete creation because the backfilling phase can take a long time, depending on the size of the table. You can't use the index or update the table until the index's status is ``ACTIVE``. You can track its status by using the DynamoDB [DescribeTable](https://docs.aws.amazon.com/cli/latest/reference/dynamodb/describe-table.html) command. If you add or delete an index during an update, we recommend that you don't update any other resources. If your stack fails to update and is rolled back while adding a new index, you must manually delete the index.  Updates are not supported. The following are exceptions:  +  If you update either the contributor insights specification or the provisioned throughput values of global secondary indexes, you can update the table without interruption.  +  You can delete or add one global secondary index without interruption. If you do both in the same update (for example, by changing the index's logical ID), the update fails.")
  @extension("x-ms-identifiers", [])
  globalSecondaryIndexes?: GlobalSecondaryIndex[];

  @doc("Specifies the properties of data being imported from the S3 bucket source to the table.  If you specify the ``ImportSourceSpecification`` property, and also specify either the ``StreamSpecification``, the ``TableClass`` property, or the ``DeletionProtectionEnabled`` property, the IAM entity creating/updating stack must have ``UpdateTable`` permission. Specifies the properties of data being imported from the S3 bucket source to the table.")
  importSourceSpecification?: ImportSourceSpecification;

  @doc("Specifies the attributes that make up the primary key for the table. The attributes in the ``KeySchema`` property must also be defined in the ``AttributeDefinitions`` property.")
  @extension("x-ms-identifiers", [])
  keySchema?: KeySchema[];

  @doc("The Kinesis Data Streams configuration for the specified table. The Kinesis Data Streams configuration for the specified table.")
  kinesisStreamSpecification?: KinesisStreamSpecification;

  @doc("Local secondary indexes to be created on the table. You can create up to 5 local secondary indexes. Each index is scoped to a given hash key value. The size of each hash key can be up to 10 gigabytes.")
  @extension("x-ms-identifiers", [])
  localSecondaryIndexes?: LocalSecondaryIndex[];

  @doc("The settings used to enable point in time recovery. The settings used to enable point in time recovery.")
  pointInTimeRecoverySpecification?: PointInTimeRecoverySpecification;

  @doc("Throughput for the specified table, which consists of values for ``ReadCapacityUnits`` and ``WriteCapacityUnits``. For more information about the contents of a provisioned throughput structure, see [Amazon DynamoDB Table ProvisionedThroughput](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ProvisionedThroughput.html).  If you set ``BillingMode`` as ``PROVISIONED``, you must specify this property. If you set ``BillingMode`` as ``PAY_PER_REQUEST``, you cannot specify this property. Throughput for the specified table, which consists of values for ``ReadCapacityUnits`` and ``WriteCapacityUnits``. For more information about the contents of a provisioned throughput structure, see [Table ProvisionedThroughput](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ProvisionedThroughput.html).")
  provisionedThroughput?: ProvisionedThroughput;

  @doc("A resource-based policy document that contains permissions to add to the specified table. In a CFNshort template, you can provide the policy in JSON or YAML format because CFNshort converts YAML to JSON before submitting it to DDB. For more information about resource-based policies, see [Using resource-based policies for](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/access-control-resource-based.html) and [Resource-based policy examples](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-examples.html). When you attach a resource-based policy while creating a table, the policy creation is *strongly consistent*. For information about the considerations that you should keep in mind while attaching a resource-based policy, see [Resource-based policy considerations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-considerations.html). Creates or updates a resource-based policy document that contains the permissions for DDB resources, such as a table, its indexes, and stream. Resource-based policies let you define access permissions by specifying who has access to each resource, and the actions they are allowed to perform on each resource. In a CFNshort template, you can provide the policy in JSON or YAML format because CFNshort converts YAML to JSON before submitting it to DDB. For more information about resource-based policies, see [Using resource-based policies for](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/access-control-resource-based.html) and [Resource-based policy examples](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-examples.html). While defining resource-based policies in your CFNshort templates, the following considerations apply:  +  The maximum size supported for a resource-based policy document in JSON format is 20 KB. DDB counts whitespaces when calculating the size of a policy against this limit.   +  Resource-based policies don't support [drift detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html#). If you update a policy outside of the CFNshort stack template, you'll need to update the CFNshort stack with the changes.  +  Resource-based policies don't support out-of-band changes. If you add, update, or delete a policy outside of the CFNshort template, the change won't be overwritten if there are no changes to the policy within the template. For example, say that your template contains a resource-based policy, which you later update outside of the template. If you don't make any changes to the policy in the template, the updated policy in DDB won’t be synced with the policy in the template. Conversely, say that your template doesn’t contain a resource-based policy, but you add a policy outside of the template. This policy won’t be removed from DDB as long as you don’t add it to the template. When you add a policy to the template and update the stack, the existing policy in DDB will be updated to match the one defined in the template.   For a full list of all considerations, see [Resource-based policy considerations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-considerations.html).")
  resourcePolicy?: ResourcePolicy;

  @doc("Specifies the settings to enable server-side encryption. Represents the settings used to enable server-side encryption.")
  sseSpecification?: SSESpecification;

  @doc("Property streamArn")
  streamArn?: string;

  @doc("The settings for the DDB table stream, which capture changes to items stored in the table. Represents the DynamoDB Streams configuration for a table in DynamoDB.")
  streamSpecification?: StreamSpecification;

  @doc("The table class of the new table. Valid values are ``STANDARD`` and ``STANDARD_INFREQUENT_ACCESS``.")
  tableClass?: string;

  @doc("A name for the table. If you don't specify a name, CFNlong generates a unique physical ID and uses that ID for the table name. For more information, see [Name Type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-name.html).  If you specify a name, you cannot perform updates that require replacement of this resource. You can perform updates that require no or some interruption. If you must replace the resource, specify a new name.")
  tableName?: string;

  @doc("An array of key-value pairs to apply to this resource. For more information, see [Tag](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-resource-tags.html).")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Specifies the Time to Live (TTL) settings for the table.  For detailed information about the limits in DynamoDB, see [Limits in Amazon DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) in the Amazon DynamoDB Developer Guide. Represents the settings used to enable or disable Time to Live (TTL) for the specified table.")
  timeToLiveSpecification?: TimeToLiveSpecification;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AttributeDefinition")
model AttributeDefinition {
  @doc("A name for the attribute.")
  attributeName?: string;

  @doc("The data type for the attribute, where:  +   ``S`` - the attribute is of type String  +   ``N`` - the attribute is of type Number  +   ``B`` - the attribute is of type Binary")
  attributeType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContributorInsightsSpecification")
model ContributorInsightsSpecification {
  @doc("Indicates whether CloudWatch Contributor Insights are to be enabled (true) or disabled (false).")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GlobalSecondaryIndex")
model GlobalSecondaryIndex {
  @doc("The settings used to enable or disable CloudWatch Contributor Insights for the specified global secondary index. The settings used to enable or disable CloudWatch Contributor Insights.")
  contributorInsightsSpecification?: ContributorInsightsSpecification;

  @doc("The name of the global secondary index. The name must be unique among all other indexes on this table.")
  indexName?: string;

  @doc("The complete key schema for a global secondary index, which consists of one or more pairs of attribute names and key types:  +   ``HASH`` - partition key  +   ``RANGE`` - sort key    The partition key of an item is also known as its *hash attribute*. The term 'hash attribute' derives from DynamoDB's usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values. The sort key of an item is also known as its *range attribute*. The term 'range attribute' derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.")
  @extension("x-ms-identifiers", [])
  keySchema?: KeySchema[];

  @doc("Represents attributes that are copied (projected) from the table into the global secondary index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. Represents attributes that are copied (projected) from the table into an index. These are in addition to the primary key attributes and index key attributes, which are automatically projected.")
  `projection`?: Projection;

  @doc("Represents the provisioned throughput settings for the specified global secondary index. For current minimum and maximum provisioned throughput values, see [Service, Account, and Table Quotas](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) in the *Amazon DynamoDB Developer Guide*. Throughput for the specified table, which consists of values for ``ReadCapacityUnits`` and ``WriteCapacityUnits``. For more information about the contents of a provisioned throughput structure, see [Table ProvisionedThroughput](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ProvisionedThroughput.html).")
  provisionedThroughput?: ProvisionedThroughput;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImportSourceSpecification")
model ImportSourceSpecification {
  @doc("Type of compression to be used on the input coming from the imported table.")
  inputCompressionType?: string;

  @doc("The format of the source data. Valid values for ``ImportFormat`` are ``CSV``, ``DYNAMODB_JSON`` or ``ION``.")
  inputFormat?: string;

  @doc("Additional properties that specify how the input is formatted, The format options for the data that was imported into the target table. There is one value, CsvOption.")
  inputFormatOptions?: InputFormatOptions;

  @doc("The S3 bucket that provides the source for the import. The S3 bucket that is being imported from.")
  s3BucketSource?: S3BucketSource;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KeySchema")
model KeySchema {
  @doc("The name of a key attribute.")
  attributeName?: string;

  @doc("The role that this key attribute will assume:  +   ``HASH`` - partition key  +   ``RANGE`` - sort key    The partition key of an item is also known as its *hash attribute*. The term 'hash attribute' derives from DynamoDB's usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values. The sort key of an item is also known as its *range attribute*. The term 'range attribute' derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.")
  keyType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KinesisStreamSpecification")
model KinesisStreamSpecification {
  @doc("The precision for the time and date that the stream was created.")
  approximateCreationDateTimePrecision?: KinesisStreamSpecificationApproximateCreationDateTimePrecision;

  @doc("The ARN for a specific Kinesis data stream. Length Constraints: Minimum length of 37. Maximum length of 1024.")
  streamArn?: string;
}

@doc("KinesisStreamSpecificationApproximateCreationDateTimePrecision enum")
union KinesisStreamSpecificationApproximateCreationDateTimePrecision {
  @doc("KinesisStreamSpecificationApproximateCreationDateTimePrecision enum MICROSECOND")
  MICROSECOND: "MICROSECOND",

  @doc("KinesisStreamSpecificationApproximateCreationDateTimePrecision enum MILLISECOND")
  MILLISECOND: "MILLISECOND",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LocalSecondaryIndex")
model LocalSecondaryIndex {
  @doc("The name of the local secondary index. The name must be unique among all other indexes on this table.")
  indexName?: string;

  @doc("The complete key schema for the local secondary index, consisting of one or more pairs of attribute names and key types:  +   ``HASH`` - partition key  +   ``RANGE`` - sort key    The partition key of an item is also known as its *hash attribute*. The term 'hash attribute' derives from DynamoDB's usage of an internal hash function to evenly distribute data items across partitions, based on their partition key values. The sort key of an item is also known as its *range attribute*. The term 'range attribute' derives from the way DynamoDB stores items with the same partition key physically close together, in sorted order by the sort key value.")
  @extension("x-ms-identifiers", [])
  keySchema?: KeySchema[];

  @doc("Represents attributes that are copied (projected) from the table into the local secondary index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. Represents attributes that are copied (projected) from the table into an index. These are in addition to the primary key attributes and index key attributes, which are automatically projected.")
  `projection`?: Projection;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PointInTimeRecoverySpecification")
model PointInTimeRecoverySpecification {
  @doc("Indicates whether point in time recovery is enabled (true) or disabled (false) on the table.")
  pointInTimeRecoveryEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProvisionedThroughput")
model ProvisionedThroughput {
  @doc("The maximum number of strongly consistent reads consumed per second before DynamoDB returns a ``ThrottlingException``. For more information, see [Specifying Read and Write Requirements](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughput.html) in the *Amazon DynamoDB Developer Guide*. If read/write capacity mode is ``PAY_PER_REQUEST`` the value is set to 0.")
  readCapacityUnits?: int32;

  @doc("The maximum number of writes consumed per second before DynamoDB returns a ``ThrottlingException``. For more information, see [Specifying Read and Write Requirements](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughput.html) in the *Amazon DynamoDB Developer Guide*. If read/write capacity mode is ``PAY_PER_REQUEST`` the value is set to 0.")
  writeCapacityUnits?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourcePolicy")
model ResourcePolicy {
  @doc("A resource-based policy document that contains permissions to add to the specified DDB table, index, or both. In a CFNshort template, you can provide the policy in JSON or YAML format because CFNshort converts YAML to JSON before submitting it to DDB. For more information about resource-based policies, see [Using resource-based policies for](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/access-control-resource-based.html) and [Resource-based policy examples](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-examples.html).")
  policyDocument?: unknown;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SSESpecification")
model SSESpecification {
  @doc("The KMS key that should be used for the KMS encryption. To specify a key, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. Note that you should only provide this parameter if the key is different from the default DynamoDB key ``alias/aws/dynamodb``.")
  kmsMasterKeyId?: string;

  @doc("Indicates whether server-side encryption is done using an AWS managed key or an AWS owned key. If enabled (true), server-side encryption type is set to ``KMS`` and an AWS managed key is used (KMS charges apply). If disabled (false) or not specified, server-side encryption is set to AWS owned key.")
  sseEnabled?: boolean;

  @doc("Server-side encryption type. The only supported value is:  +   ``KMS`` - Server-side encryption that uses KMSlong. The key is stored in your account and is managed by KMS (KMS charges apply).")
  sseType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StreamSpecification")
model StreamSpecification {
  @doc("Creates or updates a resource-based policy document that contains the permissions for DDB resources, such as a table's streams. Resource-based policies let you define access permissions by specifying who has access to each resource, and the actions they are allowed to perform on each resource. In a CFNshort template, you can provide the policy in JSON or YAML format because CFNshort converts YAML to JSON before submitting it to DDB. For more information about resource-based policies, see [Using resource-based policies for](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/access-control-resource-based.html) and [Resource-based policy examples](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-examples.html). Creates or updates a resource-based policy document that contains the permissions for DDB resources, such as a table, its indexes, and stream. Resource-based policies let you define access permissions by specifying who has access to each resource, and the actions they are allowed to perform on each resource. In a CFNshort template, you can provide the policy in JSON or YAML format because CFNshort converts YAML to JSON before submitting it to DDB. For more information about resource-based policies, see [Using resource-based policies for](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/access-control-resource-based.html) and [Resource-based policy examples](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-examples.html). While defining resource-based policies in your CFNshort templates, the following considerations apply:  +  The maximum size supported for a resource-based policy document in JSON format is 20 KB. DDB counts whitespaces when calculating the size of a policy against this limit.   +  Resource-based policies don't support [drift detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html#). If you update a policy outside of the CFNshort stack template, you'll need to update the CFNshort stack with the changes.  +  Resource-based policies don't support out-of-band changes. If you add, update, or delete a policy outside of the CFNshort template, the change won't be overwritten if there are no changes to the policy within the template. For example, say that your template contains a resource-based policy, which you later update outside of the template. If you don't make any changes to the policy in the template, the updated policy in DDB won’t be synced with the policy in the template. Conversely, say that your template doesn’t contain a resource-based policy, but you add a policy outside of the template. This policy won’t be removed from DDB as long as you don’t add it to the template. When you add a policy to the template and update the stack, the existing policy in DDB will be updated to match the one defined in the template.   For a full list of all considerations, see [Resource-based policy considerations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-considerations.html).")
  resourcePolicy?: ResourcePolicy;

  @doc("When an item in the table is modified, ``StreamViewType`` determines what information is written to the stream for this table. Valid values for ``StreamViewType`` are:  +   ``KEYS_ONLY`` - Only the key attributes of the modified item are written to the stream.  +   ``NEW_IMAGE`` - The entire item, as it appears after it was modified, is written to the stream.  +   ``OLD_IMAGE`` - The entire item, as it appeared before it was modified, is written to the stream.  +   ``NEW_AND_OLD_IMAGES`` - Both the new and the old item images of the item are written to the stream.")
  streamViewType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key of the tag. Tag keys are case sensitive. Each DynamoDB table can only have up to one tag with the same key. If you try to add an existing tag (same key), the existing tag value will be updated to the new value.")
  key?: string;

  @doc("The value of the tag. Tag values are case-sensitive and can be null.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TimeToLiveSpecification")
model TimeToLiveSpecification {
  @doc("The name of the TTL attribute used to store the expiration time for items in the table.   +  The ``AttributeName`` property is required when enabling the TTL, or when TTL is already enabled.  +  To update this property, you must first disable TTL and then enable TTL with the new attribute name.")
  attributeName?: string;

  @doc("Indicates whether TTL is to be enabled (true) or disabled (false) on the table.")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Projection")
model Projection {
  @doc("Represents the non-key attribute names which will be projected into the index. For local secondary indexes, the total count of ``NonKeyAttributes`` summed across all of the local secondary indexes, must not exceed 100. If you project the same attribute into two different indexes, this counts as two distinct attributes when determining the total.")
  @extension("x-ms-identifiers", [])
  nonKeyAttributes?: string[];

  @doc("The set of attributes that are projected into the index:  +   ``KEYS_ONLY`` - Only the index and primary keys are projected into the index.  +   ``INCLUDE`` - In addition to the attributes described in ``KEYS_ONLY``, the secondary index will include other non-key attributes that you specify.  +   ``ALL`` - All of the table attributes are projected into the index.   When using the DynamoDB console, ``ALL`` is selected by default.")
  projectionType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InputFormatOptions")
model InputFormatOptions {
  @doc("The options for imported source files in CSV format. The values are Delimiter and HeaderList. The options for imported source files in CSV format. The values are Delimiter and HeaderList.")
  csv?: Csv;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3BucketSource")
model S3BucketSource {
  @doc("The S3 bucket that is being imported from.")
  s3Bucket?: string;

  @doc("The account number of the S3 bucket that is being imported from. If the bucket is owned by the requester this is optional.")
  s3BucketOwner?: string;

  @doc("The key prefix shared by all S3 Objects that are being imported.")
  s3KeyPrefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Csv")
model Csv {
  @doc("The delimiter used for separating items in the CSV file being imported.")
  delimiter?: string;

  @doc("List of the headers used to specify a common header for all source CSV files being imported. If this field is specified then the first line of each CSV file is treated as data instead of the header. If this field is not specified the the first line of each CSV file is treated as the header.")
  @extension("x-ms-identifiers", [])
  headerList?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface DynamoDBTables {
  get is ArmResourceRead<DynamoDBTable>;
  @doc("Create a DynamoDBTable. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<DynamoDBTable>;
  update is ArmCustomPatchAsync<
    DynamoDBTable,
    Azure.ResourceManager.Foundations.TagsUpdateModel<DynamoDBTable>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DynamoDBTable>;
  listByResourceGroup is ArmResourceListByParent<DynamoDBTable>;
  listBySubscription is ArmListBySubscription<DynamoDBTable>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::DynamoDB::Table
//--------------------------------------------------------------------------------------------
