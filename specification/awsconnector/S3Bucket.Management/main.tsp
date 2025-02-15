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

//---------------------------------------------- S3Buckets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "S3 Bucket",
    plural: "S3 Buckets",
  },
  keywords: ["Microsoft.AwsConnector", "S3", "Bucket"],
})
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
  @doc("AWS Properties")
  awsProperties?: AwsS3BucketProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsS3Bucket")
model AwsS3BucketProperties {
  @doc("Configures the transfer acceleration state for an Amazon S3 bucket. For more information, see [Amazon S3 Transfer Acceleration](https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html) in the *Amazon S3 User Guide*. Configures the transfer acceleration state for an Amazon S3 bucket. For more information, see [Amazon S3 Transfer Acceleration](https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html) in the *Amazon S3 User Guide*.")
  accelerateConfiguration?: AccelerateConfiguration;

  @doc("This is a legacy property, and it is not recommended for most use cases. A majority of modern use cases in Amazon S3 no longer require the use of ACLs, and we recommend that you keep ACLs disabled. For more information, see [Controlling object ownership](https://docs.aws.amazon.com//AmazonS3/latest/userguide/about-object-ownership.html) in the *Amazon S3 User Guide*.  A canned access control list (ACL) that grants predefined permissions to the bucket. For more information about canned ACLs, see [Canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) in the *Amazon S3 User Guide*.  S3 buckets are created with ACLs disabled by default. Therefore, unless you explicitly set the [AWS::S3::OwnershipControls](https://docs.aws.amazon.com//AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket-ownershipcontrols.html) property to enable ACLs, your resource will fail to deploy with any value other than Private. Use cases requiring ACLs are uncommon.  The majority of access control configurations can be successfully and more easily achieved with bucket policies. For more information, see [AWS::S3::BucketPolicy](https://docs.aws.amazon.com//AWSCloudFormation/latest/UserGuide/aws-properties-s3-policy.html). For examples of common policy configurations, including S3 Server Access Logs buckets and more, see [Bucket policy examples](https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies.html) in the *Amazon S3 User Guide*.")
  accessControl?: AccessControl;

  @doc("Specifies the configuration and any analyses for the analytics filter of an Amazon S3 bucket.")
  @extension("x-ms-identifiers", [])
  analyticsConfigurations?: AnalyticsConfiguration[];

  @doc("the Amazon Resource Name (ARN) of the specified bucket.")
  arn?: string;

  @doc("Specifies default encryption for a bucket using server-side encryption with Amazon S3-managed keys (SSE-S3), AWS KMS-managed keys (SSE-KMS), or dual-layer server-side encryption with KMS-managed keys (DSSE-KMS). For information about the Amazon S3 default encryption feature, see [Amazon S3 Default Encryption for S3 Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html) in the *Amazon S3 User Guide*. Specifies default encryption for a bucket using server-side encryption with Amazon S3-managed keys (SSE-S3), AWS KMS-managed keys (SSE-KMS), or dual-layer server-side encryption with KMS-managed keys (DSSE-KMS). For information about the Amazon S3 default encryption feature, see [Amazon S3 Default Encryption for S3 Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html) in the *Amazon S3 User Guide*.")
  bucketEncryption?: BucketEncryption;

  @doc("A name for the bucket. If you don't specify a name, AWS CloudFormation generates a unique ID and uses that ID for the bucket name. The bucket name must contain only lowercase letters, numbers, periods (.), and dashes (-) and must follow [Amazon S3 bucket restrictions and limitations](https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html). For more information, see [Rules for naming Amazon S3 buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html#bucketnamingrules) in the *Amazon S3 User Guide*.   If you specify a name, you can't perform updates that require replacement of this resource. You can perform updates that require no or some interruption. If you need to replace the resource, specify a new name.")
  bucketName?: string;

  @doc("Describes the cross-origin access configuration for objects in an Amazon S3 bucket. For more information, see [Enabling Cross-Origin Resource Sharing](https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html) in the *Amazon S3 User Guide*. Describes the cross-origin access configuration for objects in an Amazon S3 bucket. For more information, see [Enabling Cross-Origin Resource Sharing](https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html) in the *Amazon S3 User Guide*.")
  corsConfiguration?: CorsConfiguration;

  @doc("Property domainName")
  domainName?: string;

  @doc("Property dualStackDomainName")
  dualStackDomainName?: string;

  @doc("Defines how Amazon S3 handles Intelligent-Tiering storage.")
  @extension("x-ms-identifiers", [])
  intelligentTieringConfigurations?: IntelligentTieringConfiguration[];

  @doc("Specifies the inventory configuration for an Amazon S3 bucket. For more information, see [GET Bucket inventory](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETInventoryConfig.html) in the *Amazon S3 API Reference*.")
  @extension("x-ms-identifiers", [])
  inventoryConfigurations?: InventoryConfiguration[];

  @doc("Specifies the lifecycle configuration for objects in an Amazon S3 bucket. For more information, see [Object Lifecycle Management](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html) in the *Amazon S3 User Guide*. Specifies the lifecycle configuration for objects in an Amazon S3 bucket. For more information, see [Object Lifecycle Management](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html) in the *Amazon S3 User Guide*.")
  lifecycleConfiguration?: LifecycleConfiguration;

  @doc("Settings that define where logs are stored. Describes where logs are stored and the prefix that Amazon S3 assigns to all log object keys for a bucket. For examples and more information, see [PUT Bucket logging](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTlogging.html) in the *Amazon S3 API Reference*.  To successfully complete the ``AWS::S3::Bucket LoggingConfiguration`` request, you must have ``s3:PutObject`` and ``s3:PutObjectAcl`` in your IAM permissions.")
  loggingConfiguration?: LoggingConfiguration;

  @doc("Specifies a metrics configuration for the CloudWatch request metrics (specified by the metrics configuration ID) from an Amazon S3 bucket. If you're updating an existing metrics configuration, note that this is a full replacement of the existing metrics configuration. If you don't include the elements you want to keep, they are erased. For more information, see [PutBucketMetricsConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTMetricConfiguration.html).")
  @extension("x-ms-identifiers", [])
  metricsConfigurations?: MetricsConfiguration[];

  @doc("Configuration that defines how Amazon S3 handles bucket notifications. Describes the notification configuration for an Amazon S3 bucket.  If you create the target resource and related permissions in the same template, you might have a circular dependency. For example, you might use the ``AWS::Lambda::Permission`` resource to grant the bucket permission to invoke an AWS Lambda function. However, AWS CloudFormation can't create the bucket until the bucket has permission to invoke the function (AWS CloudFormation checks whether the bucket can invoke the function). If you're using Refs to pass the bucket name, this leads to a circular dependency. To avoid this dependency, you can create all resources without specifying the notification configuration. Then, update the stack with a notification configuration. For more information on permissions, see [AWS::Lambda::Permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html) and [Granting Permissions to Publish Event Notification Messages to a Destination](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html#grant-destinations-permissions-to-s3).")
  notificationConfiguration?: NotificationConfiguration;

  @doc("This operation is not supported by directory buckets.  Places an Object Lock configuration on the specified bucket. The rule specified in the Object Lock configuration will be applied by default to every new object placed in the specified bucket. For more information, see [Locking Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html).    +  The ``DefaultRetention`` settings require both a mode and a period.  +  The ``DefaultRetention`` period can be either ``Days`` or ``Years`` but you must select one. You cannot specify ``Days`` and ``Years`` at the same time.  +  You can enable Object Lock for new or existing buckets. For more information, see [Configuring Object Lock](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-configure.html). Places an Object Lock configuration on the specified bucket. The rule specified in the Object Lock configuration will be applied by default to every new object placed in the specified bucket. For more information, see [Locking Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html).")
  objectLockConfiguration?: ObjectLockConfiguration;

  @doc("Indicates whether this bucket has an Object Lock configuration enabled. Enable ``ObjectLockEnabled`` when you apply ``ObjectLockConfiguration`` to a bucket.")
  objectLockEnabled?: boolean;

  @doc("Configuration that defines how Amazon S3 handles Object Ownership rules. Specifies the container element for Object Ownership rules. S3 Object Ownership is an Amazon S3 bucket-level setting that you can use to disable access control lists (ACLs) and take ownership of every object in your bucket, simplifying access management for data stored in Amazon S3. For more information, see [Controlling ownership of objects and disabling ACLs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html) in the *Amazon S3 User Guide*.")
  ownershipControls?: OwnershipControls;

  @doc("Configuration that defines how Amazon S3 handles public access. The PublicAccessBlock configuration that you want to apply to this Amazon S3 bucket. You can enable the configuration options in any combination. For more information about when Amazon S3 considers a bucket or object public, see [The Meaning of 'Public'](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status) in the *Amazon S3 User Guide*.")
  publicAccessBlockConfiguration?: PublicAccessBlockConfiguration;

  @doc("Property regionalDomainName")
  regionalDomainName?: string;

  @doc("Configuration for replicating objects in an S3 bucket. To enable replication, you must also enable versioning by using the ``VersioningConfiguration`` property. Amazon S3 can store replicated objects in a single destination bucket or multiple destination buckets. The destination bucket or buckets must already exist. A container for replication rules. You can add up to 1,000 rules. The maximum size of a replication configuration is 2 MB. The latest version of the replication configuration XML is V2. For more information about XML V2 replication configurations, see [Replication configuration](https://docs.aws.amazon.com/AmazonS3/latest/userguide/replication-add-config.html) in the *Amazon S3 User Guide*.")
  replicationConfiguration?: ReplicationConfiguration;

  @doc("An arbitrary set of tags (key-value pairs) for this S3 bucket.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Enables multiple versions of all objects in this bucket. You might enable versioning to prevent objects from being deleted or overwritten by mistake or to archive objects so that you can retrieve previous versions of them. Describes the versioning state of an Amazon S3 bucket. For more information, see [PUT Bucket versioning](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTVersioningStatus.html) in the *Amazon S3 API Reference*.")
  versioningConfiguration?: VersioningConfiguration;

  @doc("Information used to configure the bucket as a static website. For more information, see [Hosting Websites on Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html). Specifies website configuration parameters for an Amazon S3 bucket.")
  websiteConfiguration?: WebsiteConfiguration;

  @doc("Property websiteURL")
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
  @doc("Specifies the transfer acceleration status of the bucket.")
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
  @doc("The ID that identifies the analytics configuration.")
  id?: string;

  @doc("The prefix that an object must have to be included in the analytics results.")
  prefix?: string;

  @doc("Contains data related to access patterns to be collected and made available to analyze the tradeoffs between different storage classes. Specifies data related to access patterns to be collected and made available to analyze the tradeoffs between different storage classes for an Amazon S3 bucket.")
  storageClassAnalysis?: StorageClassAnalysis;

  @doc("The tags to use when evaluating an analytics filter. The analytics only includes objects that meet the filter's criteria. If no filter is specified, all of the contents of the bucket are included in the analysis.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BucketEncryption")
model BucketEncryption {
  @doc("Specifies the default server-side-encryption configuration.")
  @extension("x-ms-identifiers", [])
  serverSideEncryptionConfiguration?: ServerSideEncryptionRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CorsConfiguration")
model CorsConfiguration {
  @doc("A set of origins and methods (cross-origin access that you want to allow). You can add up to 100 rules to the configuration.")
  @extension("x-ms-identifiers", [])
  corsRules?: CorsRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IntelligentTieringConfiguration")
model IntelligentTieringConfiguration {
  @doc("The ID used to identify the S3 Intelligent-Tiering configuration.")
  id?: string;

  @doc("An object key name prefix that identifies the subset of objects to which the rule applies.")
  prefix?: string;

  @doc("Specifies the status of the configuration.")
  status?: IntelligentTieringConfigurationStatus;

  @doc("A container for a key-value pair.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];

  @doc("Specifies a list of S3 Intelligent-Tiering storage class tiers in the configuration. At least one tier must be defined in the list. At most, you can specify two tiers in the list, one for each available AccessTier: ``ARCHIVE_ACCESS`` and ``DEEP_ARCHIVE_ACCESS``.  You only need Intelligent Tiering Configuration enabled on a bucket if you want to automatically move objects stored in the Intelligent-Tiering storage class to Archive Access or Deep Archive Access tiers.")
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
  @doc("Contains information about where to publish the inventory results. Specifies information about where to publish analysis or configuration results for an Amazon S3 bucket.")
  destination?: Destination;

  @doc("Specifies whether the inventory is enabled or disabled. If set to ``True``, an inventory list is generated. If set to ``False``, no inventory list is generated.")
  enabled?: boolean;

  @doc("The ID used to identify the inventory configuration.")
  id?: string;

  @doc("Object versions to include in the inventory list. If set to ``All``, the list includes all the object versions, which adds the version-related fields ``VersionId``, ``IsLatest``, and ``DeleteMarker`` to the list. If set to ``Current``, the list does not contain these version-related fields.")
  includedObjectVersions?: InventoryConfigurationIncludedObjectVersions;

  @doc("Contains the optional fields that are included in the inventory results.")
  @extension("x-ms-identifiers", [])
  optionalFields?: InventoryConfigurationOptionalFields[];

  @doc("Specifies the inventory filter prefix.")
  prefix?: string;

  @doc("Specifies the schedule for generating inventory results.")
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
  @doc("A lifecycle rule for individual objects in an Amazon S3 bucket.")
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
  @doc("The name of the bucket where Amazon S3 should store server access log files. You can store log files in any bucket that you own. By default, logs are stored in the bucket where the ``LoggingConfiguration`` property is defined.")
  destinationBucketName?: string;

  @doc("A prefix for all log object keys. If you store log files from multiple Amazon S3 buckets in a single bucket, you can use a prefix to distinguish which log files came from which bucket.")
  logFilePrefix?: string;

  @doc("Amazon S3 key format for log objects. Only one format, either PartitionedPrefix or SimplePrefix, is allowed. Describes the key format for server access log file in the target bucket. You can choose between SimplePrefix and PartitionedPrefix.")
  targetObjectKeyFormat?: TargetObjectKeyFormat;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricsConfiguration")
model MetricsConfiguration {
  @doc("The access point that was used while performing operations on the object. The metrics configuration only includes objects that meet the filter's criteria.")
  accessPointArn?: string;

  @doc("The ID used to identify the metrics configuration. This can be any value you choose that helps you identify your metrics configuration.")
  id?: string;

  @doc("The prefix that an object must have to be included in the metrics results.")
  prefix?: string;

  @doc("Specifies a list of tag filters to use as a metrics configuration filter. The metrics configuration includes only objects that meet the filter's criteria.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NotificationConfiguration")
model NotificationConfiguration {
  @doc("Enables delivery of events to Amazon EventBridge. Amazon S3 can send events to Amazon EventBridge whenever certain events happen in your bucket, see [Using EventBridge](https://docs.aws.amazon.com/AmazonS3/latest/userguide/EventBridge.html) in the *Amazon S3 User Guide*. Unlike other destinations, delivery of events to EventBridge can be either enabled or disabled for a bucket. If enabled, all events will be sent to EventBridge and you can use EventBridge rules to route events to additional targets. For more information, see [What Is Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html) in the *Amazon EventBridge User Guide*")
  eventBridgeConfiguration?: EventBridgeConfiguration;

  @doc("Describes the LAMlong functions to invoke and the events for which to invoke them.")
  @extension("x-ms-identifiers", [])
  lambdaConfigurations?: LambdaConfiguration[];

  @doc("The Amazon Simple Queue Service queues to publish messages to and the events for which to publish messages.")
  @extension("x-ms-identifiers", [])
  queueConfigurations?: QueueConfiguration[];

  @doc("The topic to which notifications are sent and the events for which notifications are generated.")
  @extension("x-ms-identifiers", [])
  topicConfigurations?: TopicConfiguration[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ObjectLockConfiguration")
model ObjectLockConfiguration {
  @doc("Indicates whether this bucket has an Object Lock configuration enabled. Enable ``ObjectLockEnabled`` when you apply ``ObjectLockConfiguration`` to a bucket.")
  objectLockEnabled?: string;

  @doc("Specifies the Object Lock rule for the specified object. Enable this rule when you apply ``ObjectLockConfiguration`` to a bucket. If Object Lock is turned on, bucket settings require both ``Mode`` and a period of either ``Days`` or ``Years``. You cannot specify ``Days`` and ``Years`` at the same time. For more information, see [ObjectLockRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket-objectlockrule.html) and [DefaultRetention](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket-defaultretention.html). Specifies the Object Lock rule for the specified object. Enable the this rule when you apply ``ObjectLockConfiguration`` to a bucket.")
  rule?: ObjectLockRule;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OwnershipControls")
model OwnershipControls {
  @doc("Specifies the container element for Object Ownership rules.")
  @extension("x-ms-identifiers", [])
  rules?: OwnershipControlsRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PublicAccessBlockConfiguration")
model PublicAccessBlockConfiguration {
  @doc("Specifies whether Amazon S3 should block public access control lists (ACLs) for this bucket and objects in this bucket. Setting this element to ``TRUE`` causes the following behavior:  +  PUT Bucket ACL and PUT Object ACL calls fail if the specified ACL is public.  +  PUT Object calls fail if the request includes a public ACL.  +  PUT Bucket calls fail if the request includes a public ACL.   Enabling this setting doesn't affect existing policies or ACLs.")
  blockPublicAcls?: boolean;

  @doc("Specifies whether Amazon S3 should block public bucket policies for this bucket. Setting this element to ``TRUE`` causes Amazon S3 to reject calls to PUT Bucket policy if the specified bucket policy allows public access.  Enabling this setting doesn't affect existing bucket policies.")
  blockPublicPolicy?: boolean;

  @doc("Specifies whether Amazon S3 should ignore public ACLs for this bucket and objects in this bucket. Setting this element to ``TRUE`` causes Amazon S3 to ignore all public ACLs on this bucket and objects in this bucket. Enabling this setting doesn't affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set.")
  ignorePublicAcls?: boolean;

  @doc("Specifies whether Amazon S3 should restrict public bucket policies for this bucket. Setting this element to ``TRUE`` restricts access to this bucket to only AWS-service principals and authorized users within this account if the bucket has a public policy. Enabling this setting doesn't affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked.")
  restrictPublicBuckets?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationConfiguration")
model ReplicationConfiguration {
  @doc("The Amazon Resource Name (ARN) of the IAMlong (IAM) role that Amazon S3 assumes when replicating objects. For more information, see [How to Set Up Replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-how-setup.html) in the *Amazon S3 User Guide*.")
  role?: string;

  @doc("A container for one or more replication rules. A replication configuration must have at least one rule and can contain a maximum of 1,000 rules.")
  @extension("x-ms-identifiers", [])
  rules?: ReplicationRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Name of the object key.")
  key?: string;

  @doc("Value of the tag.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VersioningConfiguration")
model VersioningConfiguration {
  @doc("The versioning state of the bucket.")
  status?: VersioningConfigurationStatus = "Suspended";
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
  @doc("The name of the error document for the website.")
  errorDocument?: string;

  @doc("The name of the index document for the website.")
  indexDocument?: string;

  @doc("The redirect behavior for every request to this bucket's website endpoint.  If you specify this property, you can't specify any other property. Specifies the redirect behavior of all requests to a website endpoint of an Amazon S3 bucket.")
  redirectAllRequestsTo?: RedirectAllRequestsTo;

  @doc("Rules that define when a redirect is applied and the redirect behavior.")
  @extension("x-ms-identifiers", [])
  routingRules?: RoutingRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StorageClassAnalysis")
model StorageClassAnalysis {
  @doc("Specifies how data related to the storage class analysis for an Amazon S3 bucket should be exported. Specifies how data related to the storage class analysis for an Amazon S3 bucket should be exported.")
  dataExport?: DataExport;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TagFilter")
model TagFilter {
  @doc("The tag key.")
  key?: string;

  @doc("The tag value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServerSideEncryptionRule")
model ServerSideEncryptionRule {
  @doc("Specifies whether Amazon S3 should use an S3 Bucket Key with server-side encryption using KMS (SSE-KMS) for new objects in the bucket. Existing objects are not affected. Setting the ``BucketKeyEnabled`` element to ``true`` causes Amazon S3 to use an S3 Bucket Key. By default, S3 Bucket Key is not enabled. For more information, see [Amazon S3 Bucket Keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-key.html) in the *Amazon S3 User Guide*.")
  bucketKeyEnabled?: boolean;

  @doc("Specifies the default server-side encryption to apply to new objects in the bucket. If a PUT Object request doesn't specify any server-side encryption, this default encryption will be applied. Describes the default server-side encryption to apply to new objects in the bucket. If a PUT Object request doesn't specify any server-side encryption, this default encryption will be applied. If you don't specify a customer managed key at configuration, Amazon S3 automatically creates an AWS KMS key in your AWS account the first time that you add an object encrypted with SSE-KMS to a bucket. By default, Amazon S3 uses this KMS key for SSE-KMS. For more information, see [PUT Bucket encryption](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTencryption.html) in the *Amazon S3 API Reference*.")
  serverSideEncryptionByDefault?: ServerSideEncryptionByDefault;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CorsRule")
model CorsRule {
  @doc("Headers that are specified in the ``Access-Control-Request-Headers`` header. These headers are allowed in a preflight OPTIONS request. In response to any preflight OPTIONS request, Amazon S3 returns any requested headers that are allowed.")
  @extension("x-ms-identifiers", [])
  allowedHeaders?: string[];

  @doc("An HTTP method that you allow the origin to run.  *Allowed values*: ``GET`` | ``PUT`` | ``HEAD`` | ``POST`` | ``DELETE``")
  @extension("x-ms-identifiers", [])
  allowedMethods?: CorsRuleAllowedMethods[];

  @doc("One or more origins you want customers to be able to access the bucket from.")
  @extension("x-ms-identifiers", [])
  allowedOrigins?: string[];

  @doc("One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript ``XMLHttpRequest`` object).")
  @extension("x-ms-identifiers", [])
  exposedHeaders?: string[];

  @doc("A unique identifier for this rule. The value must be no more than 255 characters.")
  id?: string;

  @doc("The time in seconds that your browser is to cache the preflight response for the specified resource.")
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
  @doc("S3 Intelligent-Tiering access tier. See [Storage class for automatically optimizing frequently and infrequently accessed objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html#sc-dynamic-data-access) for a list of access tiers in the S3 Intelligent-Tiering storage class.")
  accessTier?: TieringAccessTier;

  @doc("The number of consecutive days of no access after which an object will be eligible to be transitioned to the corresponding tier. The minimum number of days specified for Archive Access tier must be at least 90 days and Deep Archive Access tier must be at least 180 days. The maximum can be up to 2 years (730 days).")
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
  @doc("The account ID that owns the destination S3 bucket. If no account ID is provided, the owner is not validated before exporting data.   Although this value is optional, we strongly recommend that you set it to help prevent problems if the destination bucket ownership changes.")
  bucketAccountId?: string;

  @doc("The Amazon Resource Name (ARN) of the bucket to which data is exported.")
  bucketArn?: string;

  @doc("Specifies the file format used when exporting data to Amazon S3.  *Allowed values*: ``CSV`` | ``ORC`` | ``Parquet``")
  format?: DestinationFormat;

  @doc("The prefix to use when exporting data. The prefix is prepended to all results.")
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
  @doc("Specifies a lifecycle rule that stops incomplete multipart uploads to an Amazon S3 bucket. Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see [Stopping Incomplete Multipart Uploads Using a Bucket Lifecycle Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in the *Amazon S3 User Guide*.")
  abortIncompleteMultipartUpload?: AbortIncompleteMultipartUpload;

  @doc("Indicates when objects are deleted from Amazon S3 and Amazon S3 Glacier. The date value must be in ISO 8601 format. The time is always midnight UTC. If you specify an expiration and transition time, you must use the same time unit for both properties (either in days or by date). The expiration time must also be later than the transition time. The date value in ISO 8601 format. The timezone is always UTC. (YYYY-MM-DDThh:mm:ssZ)")
  expirationDate?: string;

  @doc("Indicates the number of days after creation when objects are deleted from Amazon S3 and Amazon S3 Glacier. If you specify an expiration and transition time, you must use the same time unit for both properties (either in days or by date). The expiration time must also be later than the transition time.")
  expirationInDays?: int32;

  @doc("Indicates whether Amazon S3 will remove a delete marker without any noncurrent versions. If set to true, the delete marker will be removed if there are no noncurrent versions. This cannot be specified with ``ExpirationInDays``, ``ExpirationDate``, or ``TagFilters``.")
  expiredObjectDeleteMarker?: boolean;

  @doc("Unique identifier for the rule. The value can't be longer than 255 characters.")
  id?: string;

  @doc("Specifies when noncurrent object versions expire. Upon expiration, S3 permanently deletes the noncurrent object versions. You set this lifecycle configuration action on a bucket that has versioning enabled (or suspended) to request that S3 delete noncurrent object versions at a specific period in the object's lifetime. Specifies when noncurrent object versions expire. Upon expiration, S3 permanently deletes the noncurrent object versions. You set this lifecycle configuration action on a bucket that has versioning enabled (or suspended) to request that S3 delete noncurrent object versions at a specific period in the object's lifetime. For more information about setting a lifecycle rule configuration, see [AWS::S3::Bucket Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket-lifecycleconfig-rule.html).")
  noncurrentVersionExpiration?: NoncurrentVersionExpiration;

  @doc("(Deprecated.) For buckets with versioning enabled (or suspended), specifies the time, in days, between when a new version of the object is uploaded to the bucket and when old versions of the object expire. When object versions expire, Amazon S3 permanently deletes them. If you specify a transition and expiration time, the expiration time must be later than the transition time.")
  noncurrentVersionExpirationInDays?: int32;

  @doc("(Deprecated.) For buckets with versioning enabled (or suspended), specifies when non-current objects transition to a specified storage class. If you specify a transition and expiration time, the expiration time must be later than the transition time. If you specify this property, don't specify the ``NoncurrentVersionTransitions`` property. Container for the transition rule that describes when noncurrent objects transition to the ``STANDARD_IA``, ``ONEZONE_IA``, ``INTELLIGENT_TIERING``, ``GLACIER_IR``, ``GLACIER``, or ``DEEP_ARCHIVE`` storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to the ``STANDARD_IA``, ``ONEZONE_IA``, ``INTELLIGENT_TIERING``, ``GLACIER_IR``, ``GLACIER``, or ``DEEP_ARCHIVE`` storage class at a specific period in the object's lifetime. If you specify this property, don't specify the ``NoncurrentVersionTransitions`` property.")
  noncurrentVersionTransition?: NoncurrentVersionTransition;

  @doc("For buckets with versioning enabled (or suspended), one or more transition rules that specify when non-current objects transition to a specified storage class. If you specify a transition and expiration time, the expiration time must be later than the transition time. If you specify this property, don't specify the ``NoncurrentVersionTransition`` property.")
  @extension("x-ms-identifiers", [])
  noncurrentVersionTransitions?: NoncurrentVersionTransition[];

  @doc("Specifies the minimum object size in bytes for this rule to apply to. Objects must be larger than this value in bytes. For more information about size based rules, see [Lifecycle configuration using size-based rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-configuration-examples.html#lc-size-rules) in the *Amazon S3 User Guide*.")
  objectSizeGreaterThan?: string;

  @doc("Specifies the maximum object size in bytes for this rule to apply to. Objects must be smaller than this value in bytes. For more information about sized based rules, see [Lifecycle configuration using size-based rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-configuration-examples.html#lc-size-rules) in the *Amazon S3 User Guide*.")
  objectSizeLessThan?: string;

  @doc("Object key prefix that identifies one or more objects to which this rule applies.  Replacement must be made for object keys containing special characters (such as carriage returns) when using XML requests. For more information, see [XML related object key constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).")
  prefix?: string;

  @doc("If ``Enabled``, the rule is currently being applied. If ``Disabled``, the rule is not currently being applied.")
  status?: RuleStatus;

  @doc("Tags to use to identify a subset of objects to which the lifecycle rule applies.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];

  @doc("(Deprecated.) Specifies when an object transitions to a specified storage class. If you specify an expiration and transition time, you must use the same time unit for both properties (either in days or by date). The expiration time must also be later than the transition time. If you specify this property, don't specify the ``Transitions`` property. Specifies when an object transitions to a specified storage class. For more information about Amazon S3 lifecycle configuration rules, see [Transitioning Objects Using Amazon S3 Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/dev/lifecycle-transition-general-considerations.html) in the *Amazon S3 User Guide*.")
  transition?: Transition;

  @doc("One or more transition rules that specify when an object transitions to a specified storage class. If you specify an expiration and transition time, you must use the same time unit for both properties (either in days or by date). The expiration time must also be later than the transition time. If you specify this property, don't specify the ``Transition`` property.")
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
  @doc("This format defaults the prefix to the given log file prefix for delivering server access log file.")
  simplePrefix?: unknown;

  @doc("Amazon S3 keys for log objects are partitioned in the following format:  ``[DestinationPrefix][SourceAccountId]/[SourceRegion]/[SourceBucket]/[YYYY]/[MM]/[DD]/[YYYY]-[MM]-[DD]-[hh]-[mm]-[ss]-[UniqueString]``  PartitionedPrefix defaults to EventTime delivery when server access logs are delivered.")
  partitionedPrefix?: PartitionedPrefix;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EventBridgeConfiguration")
model EventBridgeConfiguration {
  @doc("Enables delivery of events to Amazon EventBridge.")
  eventBridgeEnabled?: boolean = true;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LambdaConfiguration")
model LambdaConfiguration {
  @doc("The Amazon S3 bucket event for which to invoke the LAMlong function. For more information, see [Supported Event Types](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the *Amazon S3 User Guide*.")
  event?: string;

  @doc("The filtering rules that determine which objects invoke the AWS Lambda function. For example, you can create a filter so that only image files with a ``.jpg`` extension invoke the function when they are added to the Amazon S3 bucket. Specifies object key name filtering rules. For information about key name filtering, see [Configuring event notifications using object key name filtering](https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-how-to-filtering.html) in the *Amazon S3 User Guide*.")
  filter?: NotificationFilter;

  @doc("The Amazon Resource Name (ARN) of the LAMlong function that Amazon S3 invokes when the specified event type occurs.")
  function?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of QueueConfiguration")
model QueueConfiguration {
  @doc("The Amazon S3 bucket event about which you want to publish messages to Amazon SQS. For more information, see [Supported Event Types](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the *Amazon S3 User Guide*.")
  event?: string;

  @doc("The filtering rules that determine which objects trigger notifications. For example, you can create a filter so that Amazon S3 sends notifications only when image files with a ``.jpg`` extension are added to the bucket. For more information, see [Configuring event notifications using object key name filtering](https://docs.aws.amazon.com/AmazonS3/latest/user-guide/notification-how-to-filtering.html) in the *Amazon S3 User Guide*. Specifies object key name filtering rules. For information about key name filtering, see [Configuring event notifications using object key name filtering](https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-how-to-filtering.html) in the *Amazon S3 User Guide*.")
  filter?: NotificationFilter;

  @doc("The Amazon Resource Name (ARN) of the Amazon SQS queue to which Amazon S3 publishes a message when it detects events of the specified type. FIFO queues are not allowed when enabling an SQS queue as the event notification destination.")
  queue?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TopicConfiguration")
model TopicConfiguration {
  @doc("The Amazon S3 bucket event about which to send notifications. For more information, see [Supported Event Types](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the *Amazon S3 User Guide*.")
  event?: string;

  @doc("The filtering rules that determine for which objects to send notifications. For example, you can create a filter so that Amazon S3 sends notifications only when image files with a ``.jpg`` extension are added to the bucket. Specifies object key name filtering rules. For information about key name filtering, see [Configuring event notifications using object key name filtering](https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-how-to-filtering.html) in the *Amazon S3 User Guide*.")
  filter?: NotificationFilter;

  @doc("The Amazon Resource Name (ARN) of the Amazon SNS topic to which Amazon S3 publishes a message when it detects events of the specified type.")
  topic?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ObjectLockRule")
model ObjectLockRule {
  @doc("The default Object Lock retention mode and period that you want to apply to new objects placed in the specified bucket. If Object Lock is turned on, bucket settings require both ``Mode`` and a period of either ``Days`` or ``Years``. You cannot specify ``Days`` and ``Years`` at the same time. For more information about allowable values for mode and period, see [DefaultRetention](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket-defaultretention.html). The container element for specifying the default Object Lock retention settings for new objects placed in the specified bucket.   +  The ``DefaultRetention`` settings require both a mode and a period.  +  The ``DefaultRetention`` period can be either ``Days`` or ``Years`` but you must select one. You cannot specify ``Days`` and ``Years`` at the same time.")
  defaultRetention?: DefaultRetention;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OwnershipControlsRule")
model OwnershipControlsRule {
  @doc("Specifies an object ownership rule.")
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
  @doc("Specifies whether Amazon S3 replicates delete markers. If you specify a ``Filter`` in your replication configuration, you must also include a ``DeleteMarkerReplication`` element. If your ``Filter`` includes a ``Tag`` element, the ``DeleteMarkerReplication`` ``Status`` must be set to Disabled, because Amazon S3 does not support replicating delete markers for tag-based rules. For an example configuration, see [Basic Rule Configuration](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-config-min-rule-config).  For more information about delete marker replication, see [Basic Rule Configuration](https://docs.aws.amazon.com/AmazonS3/latest/dev/delete-marker-replication.html).   If you are using an earlier version of the replication configuration, Amazon S3 handles replication of delete markers differently. For more information, see [Backward Compatibility](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-backward-compat-considerations). Specifies whether Amazon S3 replicates delete markers. If you specify a ``Filter`` in your replication configuration, you must also include a ``DeleteMarkerReplication`` element. If your ``Filter`` includes a ``Tag`` element, the ``DeleteMarkerReplication`` ``Status`` must be set to Disabled, because Amazon S3 does not support replicating delete markers for tag-based rules. For an example configuration, see [Basic Rule Configuration](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-config-min-rule-config).  For more information about delete marker replication, see [Basic Rule Configuration](https://docs.aws.amazon.com/AmazonS3/latest/dev/delete-marker-replication.html).   If you are using an earlier version of the replication configuration, Amazon S3 handles replication of delete markers differently. For more information, see [Backward Compatibility](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-backward-compat-considerations).")
  deleteMarkerReplication?: DeleteMarkerReplication;

  @doc("A container for information about the replication destination and its configurations including enabling the S3 Replication Time Control (S3 RTC). A container for information about the replication destination and its configurations including enabling the S3 Replication Time Control (S3 RTC).")
  destination?: ReplicationDestination;

  @doc("A filter that identifies the subset of objects to which the replication rule applies. A ``Filter`` must specify exactly one ``Prefix``, ``TagFilter``, or an ``And`` child element. The use of the filter field indicates that this is a V2 replication configuration. This field isn't supported in a V1 replication configuration.  V1 replication configuration only supports filtering by key prefix. To filter using a V1 replication configuration, add the ``Prefix`` directly as a child element of the ``Rule`` element. A filter that identifies the subset of objects to which the replication rule applies. A ``Filter`` must specify exactly one ``Prefix``, ``TagFilter``, or an ``And`` child element.")
  filter?: ReplicationRuleFilter;

  @doc("A unique identifier for the rule. The maximum value is 255 characters. If you don't specify a value, AWS CloudFormation generates a random ID. When using a V2 replication configuration this property is capitalized as 'ID'.")
  id?: string;

  @doc("An object key name prefix that identifies the object or objects to which the rule applies. The maximum prefix length is 1,024 characters. To include all objects in a bucket, specify an empty string. To filter using a V1 replication configuration, add the ``Prefix`` directly as a child element of the ``Rule`` element.  Replacement must be made for object keys containing special characters (such as carriage returns) when using XML requests. For more information, see [XML related object key constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).")
  prefix?: string;

  @doc("The priority indicates which rule has precedence whenever two or more replication rules conflict. Amazon S3 will attempt to replicate objects according to all replication rules. However, if there are two or more rules with the same destination bucket, then objects will be replicated according to the rule with the highest priority. The higher the number, the higher the priority.  For more information, see [Replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html) in the *Amazon S3 User Guide*.")
  priority?: int32;

  @doc("A container that describes additional filters for identifying the source objects that you want to replicate. You can choose to enable or disable the replication of these objects. A container that describes additional filters for identifying the source objects that you want to replicate. You can choose to enable or disable the replication of these objects.")
  sourceSelectionCriteria?: SourceSelectionCriteria;

  @doc("Specifies whether the rule is enabled.")
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
  @doc("Name of the host where requests are redirected.")
  hostName?: string;

  @doc("Protocol to use when redirecting requests. The default is the protocol that is used in the original request.")
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
  @doc("Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can specify a different error code to return. Specifies how requests are redirected. In the event of an error, you can specify a different error code to return.")
  redirectRule?: RedirectRule;

  @doc("A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the ``/docs`` folder, redirect to the ``/documents`` folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error. A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the ``/docs`` folder, redirect to the ``/documents`` folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.")
  routingRuleCondition?: RoutingRuleCondition;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DataExport")
model DataExport {
  @doc("The place to store the data for an analysis. Specifies information about where to publish analysis or configuration results for an Amazon S3 bucket.")
  destination?: Destination;

  @doc("The version of the output schema to use when exporting data. Must be ``V_1``.")
  outputSchemaVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServerSideEncryptionByDefault")
model ServerSideEncryptionByDefault {
  @doc("AWS Key Management Service (KMS) customer AWS KMS key ID to use for the default encryption. This parameter is allowed if and only if ``SSEAlgorithm`` is set to ``aws:kms`` or ``aws:kms:dsse``. You can specify the key ID, key alias, or the Amazon Resource Name (ARN) of the KMS key.  +  Key ID: ``1234abcd-12ab-34cd-56ef-1234567890ab``   +  Key ARN: ``arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab``   +  Key Alias: ``alias/alias-name``    If you use a key ID, you can run into a LogDestination undeliverable error when creating a VPC flow log.  If you are using encryption with cross-account or AWS service operations you must use a fully qualified KMS key ARN. For more information, see [Using encryption for cross-account operations](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html#bucket-encryption-update-bucket-policy).  Amazon S3 only supports symmetric encryption KMS keys. For more information, see [Asymmetric keys in KMS](https://docs.aws.amazon.com//kms/latest/developerguide/symmetric-asymmetric.html) in the *Key Management Service Developer Guide*.")
  kmsMasterKeyID?: string;

  @doc("Server-side encryption algorithm to use for the default encryption.")
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
  @doc("Specifies the number of days after which Amazon S3 stops an incomplete multipart upload.")
  daysAfterInitiation?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NoncurrentVersionExpiration")
model NoncurrentVersionExpiration {
  @doc("Specifies how many noncurrent versions S3 will retain. If there are this many more recent noncurrent versions, S3 will take the associated action. For more information about noncurrent versions, see [Lifecycle configuration elements](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html) in the *Amazon S3 User Guide*.")
  newerNoncurrentVersions?: int32;

  @doc("Specifies the number of days an object is noncurrent before S3 can perform the associated action. For information about the noncurrent days calculations, see [How Amazon S3 Calculates When an Object Became Noncurrent](https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations) in the *Amazon S3 User Guide*.")
  noncurrentDays?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NoncurrentVersionTransition")
model NoncurrentVersionTransition {
  @doc("Specifies how many noncurrent versions S3 will retain. If there are this many more recent noncurrent versions, S3 will take the associated action. For more information about noncurrent versions, see [Lifecycle configuration elements](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html) in the *Amazon S3 User Guide*.")
  newerNoncurrentVersions?: int32;

  @doc("The class of storage used to store the object.")
  storageClass?: NoncurrentVersionTransitionStorageClass;

  @doc("Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see [How Amazon S3 Calculates How Long an Object Has Been Noncurrent](https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations) in the *Amazon S3 User Guide*.")
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
  @doc("The storage class to which you want the object to transition.")
  storageClass?: TransitionStorageClass;

  @doc("Indicates when objects are transitioned to the specified storage class. The date value must be in ISO 8601 format. The time is always midnight UTC. The date value in ISO 8601 format. The timezone is always UTC. (YYYY-MM-DDThh:mm:ssZ)")
  transitionDate?: string;

  @doc("Indicates the number of days after creation when objects are transitioned to the specified storage class. The value must be a positive integer.")
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
  @doc("Specifies the partition date source for the partitioned prefix. PartitionDateSource can be EventTime or DeliveryTime.")
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
  @doc("A container for object key name prefix and suffix filtering rules. A container for object key name prefix and suffix filtering rules. For more information about object key name filtering, see [Configuring event notifications using object key name filtering](https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-how-to-filtering.html) in the *Amazon S3 User Guide*.  The same type of filter rule cannot be used more than once. For example, you cannot specify two prefix rules.")
  s3Key?: S3KeyFilter;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DefaultRetention")
model DefaultRetention {
  @doc("The number of days that you want to specify for the default retention period. If Object Lock is turned on, you must specify ``Mode`` and specify either ``Days`` or ``Years``.")
  days?: int32;

  @doc("The default Object Lock retention mode you want to apply to new objects placed in the specified bucket. If Object Lock is turned on, you must specify ``Mode`` and specify either ``Days`` or ``Years``.")
  mode?: DefaultRetentionMode;

  @doc("The number of years that you want to specify for the default retention period. If Object Lock is turned on, you must specify ``Mode`` and specify either ``Days`` or ``Years``.")
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
  @doc("Indicates whether to replicate delete markers. Disabled by default.")
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
  @doc("Specify this only in a cross-account scenario (where source and destination bucket owners are not the same), and you want to change replica ownership to the AWS-account that owns the destination bucket. If this is not specified in the replication configuration, the replicas are owned by same AWS-account that owns the source object. Specify this only in a cross-account scenario (where source and destination bucket owners are not the same), and you want to change replica ownership to the AWS-account that owns the destination bucket. If this is not specified in the replication configuration, the replicas are owned by same AWS-account that owns the source object.")
  accessControlTranslation?: AccessControlTranslation;

  @doc("Destination bucket owner account ID. In a cross-account scenario, if you direct Amazon S3 to change replica ownership to the AWS-account that owns the destination bucket by specifying the ``AccessControlTranslation`` property, this is the account ID of the destination bucket owner. For more information, see [Cross-Region Replication Additional Configuration: Change Replica Owner](https://docs.aws.amazon.com/AmazonS3/latest/dev/crr-change-owner.html) in the *Amazon S3 User Guide*. If you specify the ``AccessControlTranslation`` property, the ``Account`` property is required.")
  account?: string;

  @doc("The Amazon Resource Name (ARN) of the bucket where you want Amazon S3 to store the results.")
  bucket?: string;

  @doc("Specifies encryption-related information. Specifies encryption-related information for an Amazon S3 bucket that is a destination for replicated objects.")
  encryptionConfiguration?: EncryptionConfiguration;

  @doc("A container specifying replication metrics-related settings enabling replication metrics and events. A container specifying replication metrics-related settings enabling replication metrics and events.")
  metrics?: Metrics;

  @doc("A container specifying S3 Replication Time Control (S3 RTC), including whether S3 RTC is enabled and the time when all objects and operations on objects must be replicated. Must be specified together with a ``Metrics`` block. A container specifying S3 Replication Time Control (S3 RTC) related information, including whether S3 RTC is enabled and the time when all objects and operations on objects must be replicated. Must be specified together with a ``Metrics`` block.")
  replicationTime?: ReplicationTime;

  @doc("The storage class to use when replicating objects, such as S3 Standard or reduced redundancy. By default, Amazon S3 uses the storage class of the source object to create the object replica.  For valid values, see the ``StorageClass`` element of the [PUT Bucket replication](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html) action in the *Amazon S3 API Reference*.")
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
  @doc("A container for specifying rule filters. The filters determine the subset of objects to which the rule applies. This element is required only if you specify more than one filter. For example:   +  If you specify both a ``Prefix`` and a ``TagFilter``, wrap these filters in an ``And`` tag.  +  If you specify a filter based on multiple tags, wrap the ``TagFilter`` elements in an ``And`` tag. A container for specifying rule filters. The filters determine the subset of objects to which the rule applies. This element is required only if you specify more than one filter.  For example:  +  If you specify both a ``Prefix`` and a ``TagFilter``, wrap these filters in an ``And`` tag.   +  If you specify a filter based on multiple tags, wrap the ``TagFilter`` elements in an ``And`` tag")
  and?: ReplicationRuleAndOperator;

  @doc("An object key name prefix that identifies the subset of objects to which the rule applies.  Replacement must be made for object keys containing special characters (such as carriage returns) when using XML requests. For more information, see [XML related object key constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).")
  prefix?: string;

  @doc("A container for specifying a tag key and value.  The rule applies only to objects that have the tag in their tag set. Specifies tags to use to identify a subset of objects for an Amazon S3 bucket.")
  tagFilter?: TagFilter;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SourceSelectionCriteria")
model SourceSelectionCriteria {
  @doc("A filter that you can specify for selection for modifications on replicas. A filter that you can specify for selection for modifications on replicas.")
  replicaModifications?: ReplicaModifications;

  @doc("A container for filter information for the selection of Amazon S3 objects encrypted with AWS KMS. A container for filter information for the selection of S3 objects encrypted with AWS KMS.")
  sseKmsEncryptedObjects?: SseKmsEncryptedObjects;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedirectRule")
model RedirectRule {
  @doc("The host name to use in the redirect request.")
  hostName?: string;

  @doc("The HTTP redirect code to use on the response. Not required if one of the siblings is present.")
  httpRedirectCode?: string;

  @doc("Protocol to use when redirecting requests. The default is the protocol that is used in the original request.")
  protocol?: RedirectRuleProtocol;

  @doc("The object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix ``docs/`` (objects in the ``docs/`` folder) to ``documents/``, you can set a condition block with ``KeyPrefixEquals`` set to ``docs/`` and in the Redirect set ``ReplaceKeyPrefixWith`` to ``/documents``. Not required if one of the siblings is present. Can be present only if ``ReplaceKeyWith`` is not provided.  Replacement must be made for object keys containing special characters (such as carriage returns) when using XML requests. For more information, see [XML related object key constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).")
  replaceKeyPrefixWith?: string;

  @doc("The specific object key to use in the redirect request. For example, redirect request to ``error.html``. Not required if one of the siblings is present. Can be present only if ``ReplaceKeyPrefixWith`` is not provided.  Replacement must be made for object keys containing special characters (such as carriage returns) when using XML requests. For more information, see [XML related object key constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).")
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
  @doc("The HTTP error code when the redirect is applied. In the event of an error, if the error code equals this value, then the specified redirect is applied. Required when parent element ``Condition`` is specified and sibling ``KeyPrefixEquals`` is not specified. If both are specified, then both must be true for the redirect to be applied.")
  httpErrorCodeReturnedEquals?: string;

  @doc("The object key name prefix when the redirect is applied. For example, to redirect requests for ``ExamplePage.html``, the key prefix will be ``ExamplePage.html``. To redirect request for all pages with the prefix ``docs/``, the key prefix will be ``/docs``, which identifies all objects in the docs/ folder. Required when the parent element ``Condition`` is specified and sibling ``HttpErrorCodeReturnedEquals`` is not specified. If both conditions are specified, both must be true for the redirect to be applied.")
  keyPrefixEquals?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3KeyFilter")
model S3KeyFilter {
  @doc("A list of containers for the key-value pair that defines the criteria for the filter rule.")
  @extension("x-ms-identifiers", [])
  rules?: FilterRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AccessControlTranslation")
model AccessControlTranslation {
  @doc("Specifies the replica ownership. For default and valid values, see [PUT bucket replication](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html) in the *Amazon S3 API Reference*.")
  owner?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EncryptionConfiguration")
model EncryptionConfiguration {
  @doc("Specifies the ID (Key ARN or Alias ARN) of the customer managed AWS KMS key stored in AWS Key Management Service (KMS) for the destination bucket. Amazon S3 uses this key to encrypt replica objects. Amazon S3 only supports symmetric encryption KMS keys. For more information, see [Asymmetric keys in KMS](https://docs.aws.amazon.com//kms/latest/developerguide/symmetric-asymmetric.html) in the *Key Management Service Developer Guide*.")
  replicaKmsKeyID?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Metrics")
model Metrics {
  @doc("A container specifying the time threshold for emitting the ``s3:Replication:OperationMissedThreshold`` event. A container specifying the time value for S3 Replication Time Control (S3 RTC) and replication metrics ``EventThreshold``.")
  eventThreshold?: ReplicationTimeValue;

  @doc("Specifies whether the replication metrics are enabled.")
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
  @doc("Specifies whether the replication time is enabled.")
  status?: ReplicationTimeStatus;

  @doc("A container specifying the time by which replication should be complete for all objects and operations on objects. A container specifying the time value for S3 Replication Time Control (S3 RTC) and replication metrics ``EventThreshold``.")
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
  @doc("An object key name prefix that identifies the subset of objects to which the rule applies.")
  prefix?: string;

  @doc("An array of tags containing key and value pairs.")
  @extension("x-ms-identifiers", [])
  tagFilters?: TagFilter[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicaModifications")
model ReplicaModifications {
  @doc("Specifies whether Amazon S3 replicates modifications on replicas.  *Allowed values*: ``Enabled`` | ``Disabled``")
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
  @doc("Specifies whether Amazon S3 replicates objects created with server-side encryption using an AWS KMS key stored in AWS Key Management Service.")
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
  @doc("The object key name prefix or suffix identifying one or more objects to which the filtering rule applies. The maximum length is 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, see [Configuring Event Notifications](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the *Amazon S3 User Guide*.")
  name?: string;

  @doc("The value that the filter searches for in object key names.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationTimeValue")
model ReplicationTimeValue {
  @doc("Contains an integer specifying time in minutes.   Valid value: 15")
  minutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface S3Buckets {
  get is ArmResourceRead<S3Bucket>;
  @doc("Create a S3Bucket. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<S3Bucket>;
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
