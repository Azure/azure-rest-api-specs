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

//---------------------------------------------- S3Buckets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model S3Bucket is TrackedResource<S3BucketProperties> {
  @doc("Name of S3Bucket")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("s3Buckets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3Bucket")
model S3BucketProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsS3BucketProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsS3Bucket")
model AwsS3BucketProperties {
  @doc("Gets and sets the property accelerateConfiguration. Configuration for the transfer acceleration state.")
  accelerateConfiguration?: AccelerateConfiguration;

  @doc("Gets and sets the property accessControl. A canned access control list (ACL) that grants predefined permissions to the bucket.")
  accessControl?: AccessControl;

  @doc("Gets and sets the property analyticsConfigurations. The configuration and any analyses for the analytics filter of an Amazon S3 bucket.")
  @extension("x-ms-identifiers", [])
  analyticsConfigurations?: AnalyticsConfiguration[];

  @doc("Gets and sets the property arn. The Amazon Resource Name (ARN) of the specified bucket. the Amazon Resource Name (ARN) of the specified bucket.")
  arn?: string;

  @doc("Gets and sets the property bucketEncryption. Specifies default encryption for a bucket using server-side encryption with either Amazon S3-managed keys (SSE-S3) or AWS KMS-managed keys (SSE-KMS).")
  bucketEncryption?: BucketEncryption;

  @doc("Gets and sets the property bucketName. A name for the bucket. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the bucket name.")
  bucketName?: string;

  @doc("Gets and sets the property corsConfiguration. Rules that define cross-origin resource sharing of objects in this bucket.")
  corsConfiguration?: CorsConfiguration;

  @doc("Gets and sets the property domainName. The IPv4 DNS name of the specified bucket.")
  domainName?: string;

  @doc("Gets and sets the property dualStackDomainName. The IPv6 DNS name of the specified bucket. For more information about dual-stack endpoints, see [Using Amazon S3 Dual-Stack Endpoints](https://docs.aws.amazon.com/AmazonS3/latest/dev/dual-stack-endpoints.html).")
  dualStackDomainName?: string;

  @doc("Gets and sets the property intelligentTieringConfigurations. Specifies the S3 Intelligent-Tiering configuration for an Amazon S3 bucket.")
  @extension("x-ms-identifiers", [])
  intelligentTieringConfigurations?: IntelligentTieringConfiguration[];

  @doc("Gets and sets the property inventoryConfigurations. The inventory configuration for an Amazon S3 bucket.")
  @extension("x-ms-identifiers", [])
  inventoryConfigurations?: InventoryConfiguration[];

  @doc("Gets and sets the property lifecycleConfiguration. Rules that define how Amazon S3 manages objects during their lifetime.")
  lifecycleConfiguration?: LifecycleConfiguration;

  @doc("Gets and sets the property loggingConfiguration. Settings that define where logs are stored.")
  loggingConfiguration?: LoggingConfiguration;

  @doc("Gets and sets the property metricsConfigurations. Settings that define a metrics configuration for the CloudWatch request metrics from the bucket.")
  @extension("x-ms-identifiers", [])
  metricsConfigurations?: MetricsConfiguration[];

  @doc("Gets and sets the property notificationConfiguration. Configuration that defines how Amazon S3 handles bucket notifications. Describes the notification configuration for an Amazon S3 bucket.")
  notificationConfiguration?: NotificationConfiguration;

  @doc("Gets and sets the property objectLockConfiguration. Places an Object Lock configuration on the specified bucket.")
  objectLockConfiguration?: ObjectLockConfiguration;

  @doc("Gets and sets the property objectLockEnabled. Indicates whether this bucket has an Object Lock configuration enabled.")
  objectLockEnabled?: boolean;

  @doc("Gets and sets the property ownershipControls. Specifies the container element for object ownership rules.")
  ownershipControls?: OwnershipControls;

  @doc("Gets and sets the property publicAccessBlockConfiguration. Configuration that defines how Amazon S3 handles public access.")
  publicAccessBlockConfiguration?: PublicAccessBlockConfiguration;

  @doc("Gets and sets the property regionalDomainName. Returns the regional domain name of the specified bucket.")
  regionalDomainName?: string;

  @doc("Gets and sets the property replicationConfiguration. Configuration for replicating objects in an S3 bucket. A container for replication rules. You can add up to 1,000 rules. The maximum size of a replication configuration is 2 MB.")
  replicationConfiguration?: ReplicationConfiguration;

  @doc("Gets and sets the property tags. An arbitrary set of tags (key-value pairs) for this S3 bucket.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property versioningConfiguration. Describes the versioning state of an Amazon S3 bucket.")
  versioningConfiguration?: VersioningConfiguration;

  @doc("Gets and sets the property websiteConfiguration. Specifies website configuration parameters for an Amazon S3 bucket.")
  websiteConfiguration?: WebsiteConfiguration;

  @doc("Gets and sets the property websiteURL. The Amazon S3 website endpoint for the specified bucket.")
  websiteURL?: string;
}

@doc("AccessControl enum")
union AccessControl {
  @doc("AccessControl enum AuthenticatedRead")
  AuthenticatedRead: "AuthenticatedRead",

  @doc("AccessControl enum AwsExecRead")
  AwsExecRead: "AwsExecRead",

  @doc("AccessControl enum BucketOwnerFullControl")
  BucketOwnerFullControl: "BucketOwnerFullControl",

  @doc("AccessControl enum BucketOwnerRead")
  BucketOwnerRead: "BucketOwnerRead",

  @doc("AccessControl enum LogDeliveryWrite")
  LogDeliveryWrite: "LogDeliveryWrite",

  @doc("AccessControl enum Private")
  Private: "Private",

  @doc("AccessControl enum PublicRead")
  PublicRead: "PublicRead",

  @doc("AccessControl enum PublicReadWrite")
  PublicReadWrite: "PublicReadWrite",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AccelerateConfiguration")
model AccelerateConfiguration {
  @doc("Gets and sets the property accelerationStatus. Configures the transfer acceleration state for an Amazon S3 bucket.")
  accelerationStatus?: AccelerateConfigurationAccelerationStatus;
}

@doc("AccelerateConfigurationAccelerationStatus enum")
union AccelerateConfigurationAccelerationStatus {
  @doc("AccelerateConfigurationAccelerationStatus enum Enabled")
  Enabled: "Enabled",

  @doc("AccelerateConfigurationAccelerationStatus enum Suspended")
  Suspended: "Suspended",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AnalyticsConfiguration")
model AnalyticsConfiguration {
  @doc("Gets and sets the property id. The ID that identifies the analytics configuration.")
  id?: string;

  @doc("Gets and sets the property prefix. The prefix that an object must have to be included in the analytics results.")
  prefix?: string;

  @doc("Gets and sets the property storageClassAnalysis. Specifies data related to access patterns to be collected and made available to analyze the tradeoffs between different storage classes for an Amazon S3 bucket.")
  storageClassAnalysis?: StorageClassAnalysis;

  @doc("Gets and sets the property tagFilters.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BucketEncryption")
model BucketEncryption {
  @doc("Gets and sets the property serverSideEncryptionConfiguration. Specifies the default server-side-encryption configuration.")
  @extension("x-ms-identifiers", [])
  serverSideEncryptionConfiguration?: ServerSideEncryptionRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CorsConfiguration")
model CorsConfiguration {
  @doc("Gets and sets the property corsRules.")
  @extension("x-ms-identifiers", [])
  corsRules?: CorsRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IntelligentTieringConfiguration")
model IntelligentTieringConfiguration {
  @doc("Gets and sets the property id. The ID used to identify the S3 Intelligent-Tiering configuration.")
  id?: string;

  @doc("Gets and sets the property prefix. An object key name prefix that identifies the subset of objects to which the rule applies.")
  prefix?: string;

  @doc("Gets and sets the property status. Specifies the status of the configuration.")
  status?: IntelligentTieringConfigurationStatus;

  @doc("Gets and sets the property tagFilters. A container for a key-value pair.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];

  @doc("Gets and sets the property tierings. Specifies a list of S3 Intelligent-Tiering storage class tiers in the configuration. At least one tier must be defined in the list. At most, you can specify two tiers in the list, one for each available AccessTier: ARCHIVE_ACCESS and DEEP_ARCHIVE_ACCESS.")
  @extension("x-ms-identifiers", [])
  tierings?: Tiering[];
}

@doc("IntelligentTieringConfigurationStatus enum")
union IntelligentTieringConfigurationStatus {
  @doc("IntelligentTieringConfigurationStatus enum Disabled")
  Disabled: "Disabled",

  @doc("IntelligentTieringConfigurationStatus enum Enabled")
  Enabled: "Enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InventoryConfiguration")
model InventoryConfiguration {
  @doc("Gets and sets the property destination. Specifies information about where to publish analysis or configuration results for an Amazon S3 bucket and S3 Replication Time Control (S3 RTC).")
  destination?: Destination;

  @doc("Gets and sets the property enabled. Specifies whether the inventory is enabled or disabled.")
  enabled?: boolean;

  @doc("Gets and sets the property id. The ID used to identify the inventory configuration.")
  id?: string;

  @doc("Gets and sets the property includedObjectVersions. Object versions to include in the inventory list.")
  includedObjectVersions?: InventoryConfigurationIncludedObjectVersions;

  @doc("Gets and sets the property optionalFields. Contains the optional fields that are included in the inventory results.")
  @extension("x-ms-identifiers", [])
  optionalFields?: InventoryConfigurationOptionalFields[];

  @doc("Gets and sets the property prefix. The prefix that is prepended to all inventory results.")
  prefix?: string;

  @doc("Gets and sets the property scheduleFrequency. Specifies the schedule for generating inventory results.")
  scheduleFrequency?: InventoryConfigurationScheduleFrequency;
}

@doc("InventoryConfigurationIncludedObjectVersions enum")
union InventoryConfigurationIncludedObjectVersions {
  @doc("InventoryConfigurationIncludedObjectVersions enum All")
  All: "All",

  @doc("InventoryConfigurationIncludedObjectVersions enum Current")
  Current: "Current",

  string,
}

@doc("InventoryConfigurationScheduleFrequency enum")
union InventoryConfigurationScheduleFrequency {
  @doc("InventoryConfigurationScheduleFrequency enum Daily")
  Daily: "Daily",

  @doc("InventoryConfigurationScheduleFrequency enum Weekly")
  Weekly: "Weekly",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LifecycleConfiguration")
model LifecycleConfiguration {
  @doc("Gets and sets the property rules. A lifecycle rule for individual objects in an Amazon S3 bucket.")
  @extension("x-ms-identifiers", [])
  rules?: Rule[];
}

@doc("InventoryConfigurationOptionalFields enum")
union InventoryConfigurationOptionalFields {
  @doc("InventoryConfigurationOptionalFields enum BucketKeyStatus")
  BucketKeyStatus: "BucketKeyStatus",

  @doc("InventoryConfigurationOptionalFields enum ChecksumAlgorithm")
  ChecksumAlgorithm: "ChecksumAlgorithm",

  @doc("InventoryConfigurationOptionalFields enum ETag")
  ETag: "ETag",

  @doc("InventoryConfigurationOptionalFields enum EncryptionStatus")
  EncryptionStatus: "EncryptionStatus",

  @doc("InventoryConfigurationOptionalFields enum IntelligentTieringAccessTier")
  IntelligentTieringAccessTier: "IntelligentTieringAccessTier",

  @doc("InventoryConfigurationOptionalFields enum IsMultipartUploaded")
  IsMultipartUploaded: "IsMultipartUploaded",

  @doc("InventoryConfigurationOptionalFields enum LastModifiedDate")
  LastModifiedDate: "LastModifiedDate",

  @doc("InventoryConfigurationOptionalFields enum ObjectAccessControlList")
  ObjectAccessControlList: "ObjectAccessControlList",

  @doc("InventoryConfigurationOptionalFields enum ObjectLockLegalHoldStatus")
  ObjectLockLegalHoldStatus: "ObjectLockLegalHoldStatus",

  @doc("InventoryConfigurationOptionalFields enum ObjectLockMode")
  ObjectLockMode: "ObjectLockMode",

  @doc("InventoryConfigurationOptionalFields enum ObjectLockRetainUntilDate")
  ObjectLockRetainUntilDate: "ObjectLockRetainUntilDate",

  @doc("InventoryConfigurationOptionalFields enum ObjectOwner")
  ObjectOwner: "ObjectOwner",

  @doc("InventoryConfigurationOptionalFields enum ReplicationStatus")
  ReplicationStatus: "ReplicationStatus",

  @doc("InventoryConfigurationOptionalFields enum Size")
  Size: "Size",

  @doc("InventoryConfigurationOptionalFields enum StorageClass")
  StorageClass: "StorageClass",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoggingConfiguration")
model LoggingConfiguration {
  @doc("Gets and sets the property destinationBucketName. The name of an Amazon S3 bucket where Amazon S3 store server access log files. You can store log files in any bucket that you own. By default, logs are stored in the bucket where the LoggingConfiguration property is defined.")
  destinationBucketName?: string;

  @doc("Gets and sets the property logFilePrefix.")
  logFilePrefix?: string;

  @doc("Gets and sets the property targetObjectKeyFormat. Describes the key format for server access log file in the target bucket. You can choose between SimplePrefix and PartitionedPrefix.")
  targetObjectKeyFormat?: TargetObjectKeyFormat;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricsConfiguration")
model MetricsConfiguration {
  @doc("Gets and sets the property accessPointArn.")
  accessPointArn?: string;

  @doc("Gets and sets the property id.")
  id?: string;

  @doc("Gets and sets the property prefix.")
  prefix?: string;

  @doc("Gets and sets the property tagFilters.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NotificationConfiguration")
model NotificationConfiguration {
  @doc("Gets and sets the property eventBridgeConfiguration. Describes the Amazon EventBridge notification configuration for an Amazon S3 bucket.")
  eventBridgeConfiguration?: EventBridgeConfiguration;

  @doc("Gets and sets the property lambdaConfigurations.")
  @extension("x-ms-identifiers", [])
  lambdaConfigurations?: LambdaConfiguration[];

  @doc("Gets and sets the property queueConfigurations.")
  @extension("x-ms-identifiers", [])
  queueConfigurations?: QueueConfiguration[];

  @doc("Gets and sets the property topicConfigurations.")
  @extension("x-ms-identifiers", [])
  topicConfigurations?: TopicConfiguration[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ObjectLockConfiguration")
model ObjectLockConfiguration {
  @doc("Gets and sets the property objectLockEnabled.")
  objectLockEnabled?: string;

  @doc("Gets and sets the property rule. The Object Lock rule in place for the specified object.")
  rule?: ObjectLockRule;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OwnershipControls")
model OwnershipControls {
  @doc("Gets and sets the property rules.")
  @extension("x-ms-identifiers", [])
  rules?: OwnershipControlsRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PublicAccessBlockConfiguration")
model PublicAccessBlockConfiguration {
  @doc("Gets and sets the property blockPublicAcls. Specifies whether Amazon S3 should block public access control lists (ACLs) for this bucket and objects in this bucket. Setting this element to TRUE causes the following behavior:- PUT Bucket acl and PUT Object acl calls fail if the specified ACL is public. - PUT Object calls fail if the request includes a public ACL.Enabling this setting doesn't affect existing policies or ACLs.")
  blockPublicAcls?: boolean;

  @doc("Gets and sets the property blockPublicPolicy. Specifies whether Amazon S3 should block public bucket policies for this bucket. Setting this element to TRUE causes Amazon S3 to reject calls to PUT Bucket policy if the specified bucket policy allows public access.Enabling this setting doesn't affect existing bucket policies.")
  blockPublicPolicy?: boolean;

  @doc("Gets and sets the property ignorePublicAcls. Specifies whether Amazon S3 should ignore public ACLs for this bucket and objects in this bucket. Setting this element to TRUE causes Amazon S3 to ignore all public ACLs on this bucket and objects in this bucket.Enabling this setting doesn't affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set.")
  ignorePublicAcls?: boolean;

  @doc("Gets and sets the property restrictPublicBuckets. Specifies whether Amazon S3 should restrict public bucket policies for this bucket. Setting this element to TRUE restricts access to this bucket to only AWS services and authorized users within this account if the bucket has a public policy.Enabling this setting doesn't affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked.")
  restrictPublicBuckets?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationConfiguration")
model ReplicationConfiguration {
  @doc("Gets and sets the property role. The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that Amazon S3 assumes when replicating objects.")
  role?: string;

  @doc("Gets and sets the property rules. A container for one or more replication rules.")
  @extension("x-ms-identifiers", [])
  rules?: ReplicationRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VersioningConfiguration")
model VersioningConfiguration {
  @doc("Gets and sets the property status. The versioning state of the bucket.")
  status?: VersioningConfigurationStatus;
}

@doc("VersioningConfigurationStatus enum")
union VersioningConfigurationStatus {
  @doc("VersioningConfigurationStatus enum Enabled")
  Enabled: "Enabled",

  @doc("VersioningConfigurationStatus enum Suspended")
  Suspended: "Suspended",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WebsiteConfiguration")
model WebsiteConfiguration {
  @doc("Gets and sets the property errorDocument. The name of the error document for the website.")
  errorDocument?: string;

  @doc("Gets and sets the property indexDocument. The name of the index document for the website.")
  indexDocument?: string;

  @doc("Gets and sets the property redirectAllRequestsTo. Specifies the redirect behavior of all requests to a website endpoint of an Amazon S3 bucket.")
  redirectAllRequestsTo?: RedirectAllRequestsTo;

  @doc("Gets and sets the property routingRules.")
  @extension("x-ms-identifiers", [])
  routingRules?: RoutingRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StorageClassAnalysis")
model StorageClassAnalysis {
  @doc("Gets and sets the property dataExport. Specifies how data related to the storage class analysis for an Amazon S3 bucket should be exported.")
  dataExport?: DataExport;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TagFilter")
model TagFilter {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServerSideEncryptionRule")
model ServerSideEncryptionRule {
  @doc("Gets and sets the property bucketKeyEnabled. Specifies whether Amazon S3 should use an S3 Bucket Key with server-side encryption using KMS (SSE-KMS) for new objects in the bucket. Existing objects are not affected. Setting the BucketKeyEnabled element to true causes Amazon S3 to use an S3 Bucket Key. By default, S3 Bucket Key is not enabled.")
  bucketKeyEnabled?: boolean;

  @doc("Gets and sets the property serverSideEncryptionByDefault. Specifies the default server-side encryption to apply to new objects in the bucket. If a PUT Object request doesn't specify any server-side encryption, this default encryption will be applied.")
  serverSideEncryptionByDefault?: ServerSideEncryptionByDefault;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CorsRule")
model CorsRule {
  @doc("Gets and sets the property allowedHeaders. Headers that are specified in the Access-Control-Request-Headers header.")
  @extension("x-ms-identifiers", [])
  allowedHeaders?: string[];

  @doc("Gets and sets the property allowedMethods. An HTTP method that you allow the origin to execute.")
  @extension("x-ms-identifiers", [])
  allowedMethods?: CorsRuleAllowedMethods[];

  @doc("Gets and sets the property allowedOrigins. One or more origins you want customers to be able to access the bucket from.")
  @extension("x-ms-identifiers", [])
  allowedOrigins?: string[];

  @doc("Gets and sets the property exposedHeaders. One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).")
  @extension("x-ms-identifiers", [])
  exposedHeaders?: string[];

  @doc("Gets and sets the property id. A unique identifier for this rule.")
  id?: string;

  @doc("Gets and sets the property maxAge. The time in seconds that your browser is to cache the preflight response for the specified resource.")
  maxAge?: int32;
}

@doc("CorsRuleAllowedMethods enum")
union CorsRuleAllowedMethods {
  @doc("CorsRuleAllowedMethods enum DELETE")
  DELETE: "DELETE",

  @doc("CorsRuleAllowedMethods enum GET")
  GET: "GET",

  @doc("CorsRuleAllowedMethods enum HEAD")
  HEAD: "HEAD",

  @doc("CorsRuleAllowedMethods enum POST")
  POST: "POST",

  @doc("CorsRuleAllowedMethods enum PUT")
  PUT: "PUT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tiering")
model Tiering {
  @doc("Gets and sets the property accessTier. S3 Intelligent-Tiering access tier. See Storage class for automatically optimizing frequently and infrequently accessed objects for a list of access tiers in the S3 Intelligent-Tiering storage class.")
  accessTier?: TieringAccessTier;

  @doc("Gets and sets the property days. The number of consecutive days of no access after which an object will be eligible to be transitioned to the corresponding tier. The minimum number of days specified for Archive Access tier must be at least 90 days and Deep Archive Access tier must be at least 180 days. The maximum can be up to 2 years (730 days).")
  days?: int32;
}

@doc("TieringAccessTier enum")
union TieringAccessTier {
  @doc("TieringAccessTier enum ARCHIVE_ACCESS")
  ARCHIVE_ACCESS: "ARCHIVE_ACCESS",

  @doc("TieringAccessTier enum DEEP_ARCHIVE_ACCESS")
  DEEP_ARCHIVE_ACCESS: "DEEP_ARCHIVE_ACCESS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Destination")
model Destination {
  @doc("Gets and sets the property bucketAccountId. The account ID that owns the destination S3 bucket. ")
  bucketAccountId?: string;

  @doc("Gets and sets the property bucketArn. The Amazon Resource Name (ARN) of the bucket to which data is exported.")
  bucketArn?: string;

  @doc("Gets and sets the property format. Specifies the file format used when exporting data to Amazon S3.")
  format?: DestinationFormat;

  @doc("Gets and sets the property prefix. The prefix to use when exporting data. The prefix is prepended to all results.")
  prefix?: string;
}

@doc("DestinationFormat enum")
union DestinationFormat {
  @doc("DestinationFormat enum CSV")
  CSV: "CSV",

  @doc("DestinationFormat enum ORC")
  ORC: "ORC",

  @doc("DestinationFormat enum Parquet")
  Parquet: "Parquet",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Rule")
model Rule {
  @doc("Gets and sets the property abortIncompleteMultipartUpload. Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload.")
  abortIncompleteMultipartUpload?: AbortIncompleteMultipartUpload;

  @doc("Gets and sets the property expirationDate. The date value in ISO 8601 format. The timezone is always UTC. (YYYY-MM-DDThh:mm:ssZ)")
  expirationDate?: string;

  @doc("Gets and sets the property expirationInDays.")
  expirationInDays?: int32;

  @doc("Gets and sets the property expiredObjectDeleteMarker.")
  expiredObjectDeleteMarker?: boolean;

  @doc("Gets and sets the property id.")
  id?: string;

  @doc("Gets and sets the property noncurrentVersionExpiration. Container for the expiration rule that describes when noncurrent objects are expired. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 expire noncurrent object versions at a specific period in the object's lifetime")
  noncurrentVersionExpiration?: NoncurrentVersionExpiration;

  @doc("Gets and sets the property noncurrentVersionExpirationInDays.")
  noncurrentVersionExpirationInDays?: int32;

  @doc("Gets and sets the property noncurrentVersionTransition. Container for the transition rule that describes when noncurrent objects transition to the STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER_IR, GLACIER, or DEEP_ARCHIVE storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to the STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER_IR, GLACIER, or DEEP_ARCHIVE storage class at a specific period in the object's lifetime.")
  noncurrentVersionTransition?: NoncurrentVersionTransition;

  @doc("Gets and sets the property noncurrentVersionTransitions.")
  @extension("x-ms-identifiers", [])
  noncurrentVersionTransitions?: NoncurrentVersionTransition[];

  @doc("Gets and sets the property objectSizeGreaterThan.")
  objectSizeGreaterThan?: string;

  @doc("Gets and sets the property objectSizeLessThan.")
  objectSizeLessThan?: string;

  @doc("Gets and sets the property prefix.")
  prefix?: string;

  @doc("Gets and sets the property status.")
  status?: RuleStatus;

  @doc("Gets and sets the property tagFilters.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];

  @doc("Gets and sets the property transition. You must specify at least one of 'TransitionDate' and 'TransitionInDays'")
  transition?: Transition;

  @doc("Gets and sets the property transitions.")
  @extension("x-ms-identifiers", [])
  transitions?: Transition[];
}

@doc("RuleStatus enum")
union RuleStatus {
  @doc("RuleStatus enum Disabled")
  Disabled: "Disabled",

  @doc("RuleStatus enum Enabled")
  Enabled: "Enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TargetObjectKeyFormat")
model TargetObjectKeyFormat {
  @doc("Gets and sets the property simplePrefix. This format defaults the prefix to the given log file prefix for delivering server access log file.")
  simplePrefix?: unknown;

  @doc("Gets and sets the property partitionedPrefix. This format appends a time based prefix to the given log file prefix for delivering server access log file.")
  partitionedPrefix?: PartitionedPrefix;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EventBridgeConfiguration")
model EventBridgeConfiguration {
  @doc("Gets and sets the property eventBridgeEnabled. Specifies whether to send notifications to Amazon EventBridge when events occur in an Amazon S3 bucket.")
  eventBridgeEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LambdaConfiguration")
model LambdaConfiguration {
  @doc("Gets and sets the property event. The Amazon S3 bucket event for which to invoke the AWS Lambda function.")
  event?: string;

  @doc("Gets and sets the property filter. The filtering rules that determine which objects invoke the AWS Lambda function. Specifies object key name filtering rules.")
  filter?: NotificationFilter;

  @doc("Gets and sets the property function. The Amazon Resource Name (ARN) of the AWS Lambda function that Amazon S3 invokes when the specified event type occurs.")
  function?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of QueueConfiguration")
model QueueConfiguration {
  @doc("Gets and sets the property event. The Amazon S3 bucket event about which you want to publish messages to Amazon SQS.")
  event?: string;

  @doc("Gets and sets the property filter. The filtering rules that determine which objects trigger notifications. Specifies object key name filtering rules.")
  filter?: NotificationFilter;

  @doc("Gets and sets the property queue. The Amazon Resource Name (ARN) of the Amazon SQS queue to which Amazon S3 publishes a message when it detects events of the specified type.")
  queue?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TopicConfiguration")
model TopicConfiguration {
  @doc("Gets and sets the property event. The Amazon S3 bucket event about which to send notifications.")
  event?: string;

  @doc("Gets and sets the property filter. The filtering rules that determine for which objects to send notifications. Specifies object key name filtering rules.")
  filter?: NotificationFilter;

  @doc("Gets and sets the property topic. The Amazon Resource Name (ARN) of the Amazon SNS topic to which Amazon S3 publishes a message when it detects events of the specified type.")
  topic?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ObjectLockRule")
model ObjectLockRule {
  @doc("Gets and sets the property defaultRetention. The default retention period that you want to apply to new objects placed in the specified bucket.")
  defaultRetention?: DefaultRetention;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OwnershipControlsRule")
model OwnershipControlsRule {
  @doc("Gets and sets the property objectOwnership. Specifies an object ownership rule.")
  objectOwnership?: OwnershipControlsRuleObjectOwnership;
}

@doc("OwnershipControlsRuleObjectOwnership enum")
union OwnershipControlsRuleObjectOwnership {
  @doc("OwnershipControlsRuleObjectOwnership enum BucketOwnerEnforced")
  BucketOwnerEnforced: "BucketOwnerEnforced",

  @doc("OwnershipControlsRuleObjectOwnership enum BucketOwnerPreferred")
  BucketOwnerPreferred: "BucketOwnerPreferred",

  @doc("OwnershipControlsRuleObjectOwnership enum ObjectWriter")
  ObjectWriter: "ObjectWriter",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationRule")
model ReplicationRule {
  @doc("Gets and sets the property deleteMarkerReplication.")
  deleteMarkerReplication?: DeleteMarkerReplication;

  @doc("Gets and sets the property destination. Specifies which Amazon S3 bucket to store replicated objects in and their storage class.")
  destination?: ReplicationDestination;

  @doc("Gets and sets the property filter.")
  filter?: ReplicationRuleFilter;

  @doc("Gets and sets the property id. A unique identifier for the rule.")
  id?: string;

  @doc("Gets and sets the property prefix. An object key name prefix that identifies the object or objects to which the rule applies.")
  prefix?: string;

  @doc("Gets and sets the property priority.")
  priority?: int32;

  @doc("Gets and sets the property sourceSelectionCriteria. A container that describes additional filters for identifying the source objects that you want to replicate.")
  sourceSelectionCriteria?: SourceSelectionCriteria;

  @doc("Gets and sets the property status. Specifies whether the rule is enabled.")
  status?: ReplicationRuleStatus;
}

@doc("ReplicationRuleStatus enum")
union ReplicationRuleStatus {
  @doc("ReplicationRuleStatus enum Disabled")
  Disabled: "Disabled",

  @doc("ReplicationRuleStatus enum Enabled")
  Enabled: "Enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedirectAllRequestsTo")
model RedirectAllRequestsTo {
  @doc("Gets and sets the property hostName. Name of the host where requests are redirected.")
  hostName?: string;

  @doc("Gets and sets the property protocol. Protocol to use when redirecting requests. The default is the protocol that is used in the original request.")
  protocol?: RedirectAllRequestsToProtocol;
}

@doc("RedirectAllRequestsToProtocol enum")
union RedirectAllRequestsToProtocol {
  @doc("RedirectAllRequestsToProtocol enum http")
  http: "http",

  @doc("RedirectAllRequestsToProtocol enum https")
  https: "https",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RoutingRule")
model RoutingRule {
  @doc("Gets and sets the property redirectRule. Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can specify a different error code to return. Specifies how requests are redirected. In the event of an error, you can specify a different error code to return.")
  redirectRule?: RedirectRule;

  @doc("Gets and sets the property routingRuleCondition. A container for describing a condition that must be met for the specified redirect to apply.You must specify at least one of HttpErrorCodeReturnedEquals and KeyPrefixEquals")
  routingRuleCondition?: RoutingRuleCondition;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DataExport")
model DataExport {
  @doc("Gets and sets the property destination. Specifies information about where to publish analysis or configuration results for an Amazon S3 bucket and S3 Replication Time Control (S3 RTC).")
  destination?: Destination;

  @doc("Gets and sets the property outputSchemaVersion. The version of the output schema to use when exporting data.")
  outputSchemaVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServerSideEncryptionByDefault")
model ServerSideEncryptionByDefault {
  @doc("Gets and sets the property kmsMasterKeyID. 'KMSMasterKeyID' can only be used when you set the value of SSEAlgorithm as aws:kms or aws:kms:dsse.")
  kmsMasterKeyID?: string;

  @doc("Gets and sets the property sseAlgorithm.")
  sseAlgorithm?: ServerSideEncryptionByDefaultSSEAlgorithm;
}

@doc("ServerSideEncryptionByDefaultSSEAlgorithm enum")
union ServerSideEncryptionByDefaultSSEAlgorithm {
  @doc("ServerSideEncryptionByDefaultSSEAlgorithm enum AES256")
  AES256: "AES256",

  @doc("ServerSideEncryptionByDefaultSSEAlgorithm enum aws:kms")
  AwsKms: "aws:kms",

  @doc("ServerSideEncryptionByDefaultSSEAlgorithm enum aws:kms:dsse")
  AwsKmsDsse: "aws:kms:dsse",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AbortIncompleteMultipartUpload")
model AbortIncompleteMultipartUpload {
  @doc("Gets and sets the property daysAfterInitiation. Specifies the number of days after which Amazon S3 aborts an incomplete multipart upload.")
  daysAfterInitiation?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NoncurrentVersionExpiration")
model NoncurrentVersionExpiration {
  @doc("Gets and sets the property newerNoncurrentVersions. Specified the number of newer noncurrent and current versions that must exists before performing the associated action")
  newerNoncurrentVersions?: int32;

  @doc("Gets and sets the property noncurrentDays. Specified the number of days an object is noncurrent before Amazon S3 can perform the associated action")
  noncurrentDays?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NoncurrentVersionTransition")
model NoncurrentVersionTransition {
  @doc("Gets and sets the property newerNoncurrentVersions. Specified the number of newer noncurrent and current versions that must exists before performing the associated action")
  newerNoncurrentVersions?: int32;

  @doc("Gets and sets the property storageClass. The class of storage used to store the object.")
  storageClass?: NoncurrentVersionTransitionStorageClass;

  @doc("Gets and sets the property transitionInDays. Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action.")
  transitionInDays?: int32;
}

@doc("NoncurrentVersionTransitionStorageClass enum")
union NoncurrentVersionTransitionStorageClass {
  @doc("NoncurrentVersionTransitionStorageClass enum DEEP_ARCHIVE")
  DEEP_ARCHIVE: "DEEP_ARCHIVE",

  @doc("NoncurrentVersionTransitionStorageClass enum GLACIER")
  GLACIER: "GLACIER",

  @doc("NoncurrentVersionTransitionStorageClass enum GLACIER_IR")
  GLACIER_IR: "GLACIER_IR",

  @doc("NoncurrentVersionTransitionStorageClass enum INTELLIGENT_TIERING")
  INTELLIGENT_TIERING: "INTELLIGENT_TIERING",

  @doc("NoncurrentVersionTransitionStorageClass enum ONEZONE_IA")
  ONEZONE_IA: "ONEZONE_IA",

  @doc("NoncurrentVersionTransitionStorageClass enum STANDARD_IA")
  STANDARD_IA: "STANDARD_IA",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Transition")
model Transition {
  @doc("Gets and sets the property storageClass.")
  storageClass?: TransitionStorageClass;

  @doc("Gets and sets the property transitionDate. The date value in ISO 8601 format. The timezone is always UTC. (YYYY-MM-DDThh:mm:ssZ)")
  transitionDate?: string;

  @doc("Gets and sets the property transitionInDays.")
  transitionInDays?: int32;
}

@doc("TransitionStorageClass enum")
union TransitionStorageClass {
  @doc("TransitionStorageClass enum DEEP_ARCHIVE")
  DEEP_ARCHIVE: "DEEP_ARCHIVE",

  @doc("TransitionStorageClass enum GLACIER")
  GLACIER: "GLACIER",

  @doc("TransitionStorageClass enum GLACIER_IR")
  GLACIER_IR: "GLACIER_IR",

  @doc("TransitionStorageClass enum INTELLIGENT_TIERING")
  INTELLIGENT_TIERING: "INTELLIGENT_TIERING",

  @doc("TransitionStorageClass enum ONEZONE_IA")
  ONEZONE_IA: "ONEZONE_IA",

  @doc("TransitionStorageClass enum STANDARD_IA")
  STANDARD_IA: "STANDARD_IA",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PartitionedPrefix")
model PartitionedPrefix {
  @doc("Gets and sets the property partitionDateSource. Date Source for creating a partitioned prefix. This can be event time or delivery time.")
  partitionDateSource?: PartitionedPrefixPartitionDateSource;
}

@doc("PartitionedPrefixPartitionDateSource enum")
union PartitionedPrefixPartitionDateSource {
  @doc("PartitionedPrefixPartitionDateSource enum DeliveryTime")
  DeliveryTime: "DeliveryTime",

  @doc("PartitionedPrefixPartitionDateSource enum EventTime")
  EventTime: "EventTime",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NotificationFilter")
model NotificationFilter {
  @doc("Gets and sets the property s3Key. A container for object key name prefix and suffix filtering rules.")
  s3Key?: S3KeyFilter;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DefaultRetention")
model DefaultRetention {
  @doc("Gets and sets the property days.")
  days?: int32;

  @doc("Gets and sets the property mode.")
  mode?: DefaultRetentionMode;

  @doc("Gets and sets the property years.")
  years?: int32;
}

@doc("DefaultRetentionMode enum")
union DefaultRetentionMode {
  @doc("DefaultRetentionMode enum COMPLIANCE")
  COMPLIANCE: "COMPLIANCE",

  @doc("DefaultRetentionMode enum GOVERNANCE")
  GOVERNANCE: "GOVERNANCE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeleteMarkerReplication")
model DeleteMarkerReplication {
  @doc("Gets and sets the property status.")
  status?: DeleteMarkerReplicationStatus;
}

@doc("DeleteMarkerReplicationStatus enum")
union DeleteMarkerReplicationStatus {
  @doc("DeleteMarkerReplicationStatus enum Disabled")
  Disabled: "Disabled",

  @doc("DeleteMarkerReplicationStatus enum Enabled")
  Enabled: "Enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationDestination")
model ReplicationDestination {
  @doc("Gets and sets the property accessControlTranslation. Specify this only in a cross-account scenario (where source and destination bucket owners are not the same), and you want to change replica ownership to the AWS account that owns the destination bucket. If this is not specified in the replication configuration, the replicas are owned by same AWS account that owns the source object.")
  accessControlTranslation?: AccessControlTranslation;

  @doc("Gets and sets the property account.")
  account?: string;

  @doc("Gets and sets the property bucket.")
  bucket?: string;

  @doc("Gets and sets the property encryptionConfiguration. Specifies encryption-related information for an Amazon S3 bucket that is a destination for replicated objects.")
  encryptionConfiguration?: EncryptionConfiguration;

  @doc("Gets and sets the property metrics.")
  metrics?: Metrics;

  @doc("Gets and sets the property replicationTime.")
  replicationTime?: ReplicationTime;

  @doc("Gets and sets the property storageClass. The storage class to use when replicating objects, such as S3 Standard or reduced redundancy.")
  storageClass?: ReplicationDestinationStorageClass;
}

@doc("ReplicationDestinationStorageClass enum")
union ReplicationDestinationStorageClass {
  @doc("ReplicationDestinationStorageClass enum DEEP_ARCHIVE")
  DEEP_ARCHIVE: "DEEP_ARCHIVE",

  @doc("ReplicationDestinationStorageClass enum GLACIER")
  GLACIER: "GLACIER",

  @doc("ReplicationDestinationStorageClass enum GLACIER_IR")
  GLACIER_IR: "GLACIER_IR",

  @doc("ReplicationDestinationStorageClass enum INTELLIGENT_TIERING")
  INTELLIGENT_TIERING: "INTELLIGENT_TIERING",

  @doc("ReplicationDestinationStorageClass enum ONEZONE_IA")
  ONEZONE_IA: "ONEZONE_IA",

  @doc("ReplicationDestinationStorageClass enum REDUCED_REDUNDANCY")
  REDUCED_REDUNDANCY: "REDUCED_REDUNDANCY",

  @doc("ReplicationDestinationStorageClass enum STANDARD")
  STANDARD: "STANDARD",

  @doc("ReplicationDestinationStorageClass enum STANDARD_IA")
  STANDARD_IA: "STANDARD_IA",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationRuleFilter")
model ReplicationRuleFilter {
  @doc("Gets and sets the property and.")
  and?: ReplicationRuleAndOperator;

  @doc("Gets and sets the property prefix.")
  prefix?: string;

  @doc("Gets and sets the property tagFilter. Tags to use to identify a subset of objects for an Amazon S3 bucket.")
  tagFilter?: TagFilter;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SourceSelectionCriteria")
model SourceSelectionCriteria {
  @doc("Gets and sets the property replicaModifications. A filter that you can specify for selection for modifications on replicas.")
  replicaModifications?: ReplicaModifications;

  @doc("Gets and sets the property sseKmsEncryptedObjects. A container for filter information for the selection of Amazon S3 objects encrypted with AWS KMS. A container for filter information for the selection of S3 objects encrypted with AWS KMS.")
  sseKmsEncryptedObjects?: SseKmsEncryptedObjects;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedirectRule")
model RedirectRule {
  @doc("Gets and sets the property hostName. The host name to use in the redirect request.")
  hostName?: string;

  @doc("Gets and sets the property httpRedirectCode. The HTTP redirect code to use on the response. Not required if one of the siblings is present.")
  httpRedirectCode?: string;

  @doc("Gets and sets the property protocol. Protocol to use when redirecting requests. The default is the protocol that is used in the original request.")
  protocol?: RedirectRuleProtocol;

  @doc("Gets and sets the property replaceKeyPrefixWith. The object key prefix to use in the redirect request.")
  replaceKeyPrefixWith?: string;

  @doc("Gets and sets the property replaceKeyWith. The specific object key to use in the redirect request.d")
  replaceKeyWith?: string;
}

@doc("RedirectRuleProtocol enum")
union RedirectRuleProtocol {
  @doc("RedirectRuleProtocol enum http")
  http: "http",

  @doc("RedirectRuleProtocol enum https")
  https: "https",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RoutingRuleCondition")
model RoutingRuleCondition {
  @doc("Gets and sets the property httpErrorCodeReturnedEquals. The HTTP error code when the redirect is applied. ")
  httpErrorCodeReturnedEquals?: string;

  @doc("Gets and sets the property keyPrefixEquals. The object key name prefix when the redirect is applied.")
  keyPrefixEquals?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3KeyFilter")
model S3KeyFilter {
  @doc("Gets and sets the property rules.")
  @extension("x-ms-identifiers", [])
  rules?: FilterRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AccessControlTranslation")
model AccessControlTranslation {
  @doc("Gets and sets the property owner.")
  owner?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EncryptionConfiguration")
model EncryptionConfiguration {
  @doc("Gets and sets the property replicaKmsKeyID. Specifies the ID (Key ARN or Alias ARN) of the customer managed customer master key (CMK) stored in AWS Key Management Service (KMS) for the destination bucket.")
  replicaKmsKeyID?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Metrics")
model Metrics {
  @doc("Gets and sets the property eventThreshold.")
  eventThreshold?: ReplicationTimeValue;

  @doc("Gets and sets the property status.")
  status?: MetricsStatus;
}

@doc("MetricsStatus enum")
union MetricsStatus {
  @doc("MetricsStatus enum Disabled")
  Disabled: "Disabled",

  @doc("MetricsStatus enum Enabled")
  Enabled: "Enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationTime")
model ReplicationTime {
  @doc("Gets and sets the property status.")
  status?: ReplicationTimeStatus;

  @doc("Gets and sets the property time.")
  time?: ReplicationTimeValue;
}

@doc("ReplicationTimeStatus enum")
union ReplicationTimeStatus {
  @doc("ReplicationTimeStatus enum Disabled")
  Disabled: "Disabled",

  @doc("ReplicationTimeStatus enum Enabled")
  Enabled: "Enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationRuleAndOperator")
model ReplicationRuleAndOperator {
  @doc("Gets and sets the property prefix.")
  prefix?: string;

  @doc("Gets and sets the property tagFilters.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicaModifications")
model ReplicaModifications {
  @doc("Gets and sets the property status. Specifies whether Amazon S3 replicates modifications on replicas.")
  status?: ReplicaModificationsStatus;
}

@doc("ReplicaModificationsStatus enum")
union ReplicaModificationsStatus {
  @doc("ReplicaModificationsStatus enum Disabled")
  Disabled: "Disabled",

  @doc("ReplicaModificationsStatus enum Enabled")
  Enabled: "Enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SseKmsEncryptedObjects")
model SseKmsEncryptedObjects {
  @doc("Gets and sets the property status. Specifies whether Amazon S3 replicates objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service.")
  status?: SseKmsEncryptedObjectsStatus;
}

@doc("SseKmsEncryptedObjectsStatus enum")
union SseKmsEncryptedObjectsStatus {
  @doc("SseKmsEncryptedObjectsStatus enum Disabled")
  Disabled: "Disabled",

  @doc("SseKmsEncryptedObjectsStatus enum Enabled")
  Enabled: "Enabled",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FilterRule")
model FilterRule {
  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationTimeValue")
model ReplicationTimeValue {
  @doc("Gets and sets the property minutes.")
  minutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface S3Buckets {
  get is ArmResourceRead<S3Bucket>;
  @doc("Create a S3Bucket. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<S3Bucket>;
  update is ArmCustomPatchAsync<
    S3Bucket,
    Azure.ResourceManager.Foundations.TagsUpdateModel<S3Bucket>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<S3Bucket>;
  listByResourceGroup is ArmResourceListByParent<S3Bucket>;
  listBySubscription is ArmListBySubscription<S3Bucket>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::S3::Bucket
//--------------------------------------------------------------------------------------------
