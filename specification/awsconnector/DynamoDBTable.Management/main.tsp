import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
  version: "2024-08-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

//---------------------------------------------- DynamoDBTables ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
@doc("Definition of DynamoDBTable")
model DynamoDBTableProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsDynamoDBTableProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsDynamoDBTable")
model AwsDynamoDBTableProperties {
  @doc("Gets and sets the property arn.")
  arn?: string;

  @doc("Gets and sets the property attributeDefinitions.")
  @extension("x-ms-identifiers", [])
  attributeDefinitions?: AttributeDefinition[];

  @doc("Gets and sets the property billingMode.")
  billingMode?: string;

  @doc("Gets and sets the property contributorInsightsSpecification.")
  contributorInsightsSpecification?: ContributorInsightsSpecification;

  @doc("Gets and sets the property deletionProtectionEnabled.")
  deletionProtectionEnabled?: boolean;

  @doc("Gets and sets the property globalSecondaryIndexes.")
  @extension("x-ms-identifiers", [])
  globalSecondaryIndexes?: GlobalSecondaryIndex[];

  @doc("Gets and sets the property importSourceSpecification.")
  importSourceSpecification?: ImportSourceSpecification;

  @doc("Gets and sets the property keySchema.")
  @extension("x-ms-identifiers", [])
  keySchema?: KeySchema[];

  @doc("Gets and sets the property kinesisStreamSpecification.")
  kinesisStreamSpecification?: KinesisStreamSpecification;

  @doc("Gets and sets the property localSecondaryIndexes.")
  @extension("x-ms-identifiers", [])
  localSecondaryIndexes?: LocalSecondaryIndex[];

  @doc("Gets and sets the property pointInTimeRecoverySpecification.")
  pointInTimeRecoverySpecification?: PointInTimeRecoverySpecification;

  @doc("Gets and sets the property provisionedThroughput.")
  provisionedThroughput?: ProvisionedThroughput;

  @doc("Gets and sets the property sseSpecification.")
  sseSpecification?: SSESpecification;

  @doc("Gets and sets the property streamArn.")
  streamArn?: string;

  @doc("Gets and sets the property streamSpecification.")
  streamSpecification?: StreamSpecification;

  @doc("Gets and sets the property tableClass.")
  tableClass?: string;

  @doc("Gets and sets the property tableName.")
  tableName?: string;

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property timeToLiveSpecification.")
  timeToLiveSpecification?: TimeToLiveSpecification;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of AttributeDefinition")
model AttributeDefinition {
  @doc("Gets and sets the property attributeName.")
  attributeName?: string;

  @doc("Gets and sets the property attributeType.")
  attributeType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ContributorInsightsSpecification")
model ContributorInsightsSpecification {
  @doc("Gets and sets the property enabled.")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of GlobalSecondaryIndex")
model GlobalSecondaryIndex {
  @doc("Gets and sets the property contributorInsightsSpecification.")
  contributorInsightsSpecification?: ContributorInsightsSpecification;

  @doc("Gets and sets the property indexName.")
  indexName?: string;

  @doc("Gets and sets the property keySchema.")
  @extension("x-ms-identifiers", [])
  keySchema?: KeySchema[];

  @doc("Gets and sets the property `projection`.")
  `projection`?: Projection;

  @doc("Gets and sets the property provisionedThroughput.")
  provisionedThroughput?: ProvisionedThroughput;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ImportSourceSpecification")
model ImportSourceSpecification {
  @doc("Gets and sets the property inputCompressionType.")
  inputCompressionType?: string;

  @doc("Gets and sets the property inputFormat.")
  inputFormat?: string;

  @doc("Gets and sets the property inputFormatOptions.")
  inputFormatOptions?: InputFormatOptions;

  @doc("Gets and sets the property s3BucketSource.")
  s3BucketSource?: S3BucketSource;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of KeySchema")
model KeySchema {
  @doc("Gets and sets the property attributeName.")
  attributeName?: string;

  @doc("Gets and sets the property keyType.")
  keyType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of KinesisStreamSpecification")
model KinesisStreamSpecification {
  @doc("Gets and sets the property approximateCreationDateTimePrecision.")
  approximateCreationDateTimePrecision?: KinesisStreamSpecificationApproximateCreationDateTimePrecision;

  @doc("Gets and sets the property streamArn.")
  streamArn?: string;
}

@doc("KinesisStreamSpecificationApproximateCreationDateTimePrecision enum")
enum KinesisStreamSpecificationApproximateCreationDateTimePrecision {
  @doc("KinesisStreamSpecificationApproximateCreationDateTimePrecision enum MICROSECOND")
  MICROSECOND: "MICROSECOND",

  @doc("KinesisStreamSpecificationApproximateCreationDateTimePrecision enum MILLISECOND")
  MILLISECOND: "MILLISECOND",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of LocalSecondaryIndex")
model LocalSecondaryIndex {
  @doc("Gets and sets the property indexName.")
  indexName?: string;

  @doc("Gets and sets the property keySchema.")
  @extension("x-ms-identifiers", [])
  keySchema?: KeySchema[];

  @doc("Gets and sets the property `projection`.")
  `projection`?: Projection;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of PointInTimeRecoverySpecification")
model PointInTimeRecoverySpecification {
  @doc("Gets and sets the property pointInTimeRecoveryEnabled.")
  pointInTimeRecoveryEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ProvisionedThroughput")
model ProvisionedThroughput {
  @doc("Gets and sets the property readCapacityUnits.")
  readCapacityUnits?: int32;

  @doc("Gets and sets the property writeCapacityUnits.")
  writeCapacityUnits?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of SSESpecification")
model SSESpecification {
  @doc("Gets and sets the property kmsMasterKeyId.")
  kmsMasterKeyId?: string;

  @doc("Gets and sets the property sseEnabled.")
  sseEnabled?: boolean;

  @doc("Gets and sets the property sseType.")
  sseType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of StreamSpecification")
model StreamSpecification {
  @doc("Gets and sets the property streamViewType.")
  streamViewType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of TimeToLiveSpecification")
model TimeToLiveSpecification {
  @doc("Gets and sets the property attributeName.")
  attributeName?: string;

  @doc("Gets and sets the property enabled.")
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Projection")
model Projection {
  @doc("Gets and sets the property nonKeyAttributes.")
  @extension("x-ms-identifiers", [])
  nonKeyAttributes?: string[];

  @doc("Gets and sets the property projectionType.")
  projectionType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of InputFormatOptions")
model InputFormatOptions {
  @doc("Gets and sets the property csv.")
  csv?: Csv;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of S3BucketSource")
model S3BucketSource {
  @doc("Gets and sets the property s3Bucket.")
  s3Bucket?: string;

  @doc("Gets and sets the property s3BucketOwner.")
  s3BucketOwner?: string;

  @doc("Gets and sets the property s3KeyPrefix.")
  s3KeyPrefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Csv")
model Csv {
  @doc("Gets and sets the property delimiter.")
  delimiter?: string;

  @doc("Gets and sets the property headerList.")
  @extension("x-ms-identifiers", [])
  headerList?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface DynamoDBTables {
  get is ArmResourceRead<DynamoDBTable>;
  @doc("Create a DynamoDBTable. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DynamoDBTable>;
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
