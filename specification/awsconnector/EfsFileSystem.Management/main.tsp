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

//---------------------------------------------- EfsFileSystems ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EFS File System",
    plural: "EFS File Systems",
  },
  keywords: ["Microsoft.AwsConnector", "EFS", "File", "System"],
})
@doc("A Microsoft.AwsConnector resource")
model EfsFileSystem is TrackedResource<EfsFileSystemProperties> {
  @doc("Name of EfsFileSystem")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("efsFileSystems")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EfsFileSystem")
model EfsFileSystemProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEfsFileSystemProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEfsFileSystem")
model AwsEfsFileSystemProperties {
  @doc("Property arn")
  arn?: string;

  @doc("For One Zone file systems, specify the AWS Availability Zone in which to create the file system. Use the format ``us-east-1a`` to specify the Availability Zone. For more information about One Zone file systems, see [EFS file system types](https://docs.aws.amazon.com/efs/latest/ug/availability-durability.html#file-system-type) in the *Amazon EFS User Guide*.  One Zone file systems are not available in all Availability Zones in AWS-Regions where Amazon EFS is available.")
  availabilityZoneName?: string;

  @doc("Use the ``BackupPolicy`` to turn automatic backups on or off for the file system. The backup policy turns automatic backups for the file system on or off.")
  backupPolicy?: BackupPolicy;

  @doc("(Optional) A boolean that specifies whether or not to bypass the ``FileSystemPolicy`` lockout safety check. The lockout safety check determines whether the policy in the request will lock out, or prevent, the IAM principal that is making the request from making future ``PutFileSystemPolicy`` requests on this file system. Set ``BypassPolicyLockoutSafetyCheck`` to ``True`` only when you intend to prevent the IAM principal that is making the request from making subsequent ``PutFileSystemPolicy`` requests on this file system. The default value is ``False``.")
  bypassPolicyLockoutSafetyCheck?: boolean;

  @doc("A Boolean value that, if true, creates an encrypted file system. When creating an encrypted file system, you have the option of specifying a KmsKeyId for an existing kms-key-long. If you don't specify a kms-key, then the default kms-key for EFS, ``/aws/elasticfilesystem``, is used to protect the encrypted file system.")
  encrypted?: boolean;

  @doc("Property fileSystemId")
  fileSystemId?: string;

  @doc("The ``FileSystemPolicy`` for the EFS file system. A file system policy is an IAM resource policy used to control NFS access to an EFS file system. For more information, see [Using to control NFS access to Amazon EFS](https://docs.aws.amazon.com/efs/latest/ug/iam-access-control-nfs-efs.html) in the *Amazon EFS User Guide*.")
  fileSystemPolicy?: unknown;

  @doc("Describes the protection on the file system. Describes the protection on the file system.")
  fileSystemProtection?: FileSystemProtection;

  @doc("Use to create one or more tags associated with the file system. Each tag is a user-defined key-value pair. Name your file system on creation by including a ``'Key':'Name','Value':'{value}'`` key-value pair. Each key must be unique. For more information, see [Tagging resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html) in the *General Reference Guide*.")
  @extension("x-ms-identifiers", [])
  fileSystemTags?: ElasticFileSystemTag[];

  @doc("The ID of the kms-key-long to be used to protect the encrypted file system. This parameter is only required if you want to use a nondefault kms-key. If this parameter is not specified, the default kms-key for EFS is used. This ID can be in one of the following formats:  +  Key ID - A unique identifier of the key, for example ``1234abcd-12ab-34cd-56ef-1234567890ab``.  +  ARN - An Amazon Resource Name (ARN) for the key, for example ``arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab``.  +  Key alias - A previously created display name for a key, for example ``alias/projectKey1``.  +  Key alias ARN - An ARN for a key alias, for example ``arn:aws:kms:us-west-2:444455556666:alias/projectKey1``.   If ``KmsKeyId`` is specified, the ``Encrypted`` parameter must be set to true.")
  kmsKeyId?: string;

  @doc("An array of ``LifecyclePolicy`` objects that define the file system's ``LifecycleConfiguration`` object. A ``LifecycleConfiguration`` object informs Lifecycle management of the following:  +  When to move files in the file system from primary storage to IA storage.  + When to move files in the file system from primary storage or IA storage to Archive storage. +  When to move files that are in IA or Archive storage to primary storage.    EFS requires that each ``LifecyclePolicy`` object have only a single transition. This means that in a request body, ``LifecyclePolicies`` needs to be structured as an array of ``LifecyclePolicy`` objects, one object for each transition, ``TransitionToIA``, ``TransitionToArchive`` ``TransitionToPrimaryStorageClass``. See the example requests in the following section for more information.")
  @extension("x-ms-identifiers", [])
  lifecyclePolicies?: LifecyclePolicy[];

  @doc("The Performance mode of the file system. We recommend ``generalPurpose`` performance mode for all file systems. File systems using the ``maxIO`` performance mode can scale to higher levels of aggregate throughput and operations per second with a tradeoff of slightly higher latencies for most file operations. The performance mode can't be changed after the file system has been created. The ``maxIO`` mode is not supported on One Zone file systems.  Due to the higher per-operation latencies with Max I/O, we recommend using General Purpose performance mode for all file systems.  Default is ``generalPurpose``.")
  performanceMode?: string;

  @doc("The throughput, measured in mebibytes per second (MiBps), that you want to provision for a file system that you're creating. Required if ``ThroughputMode`` is set to ``provisioned``. Valid values are 1-3414 MiBps, with the upper limit depending on Region. To increase this limit, contact SUP. For more information, see [Amazon EFS quotas that you can increase](https://docs.aws.amazon.com/efs/latest/ug/limits.html#soft-limits) in the *Amazon EFS User Guide*.")
  provisionedThroughputInMibps?: int32;

  @doc("Describes the replication configuration for a specific file system. Describes the replication configuration for a specific file system.")
  replicationConfiguration?: ReplicationConfiguration;

  @doc("Specifies the throughput mode for the file system. The mode can be ``bursting``, ``provisioned``, or ``elastic``. If you set ``ThroughputMode`` to ``provisioned``, you must also set a value for ``ProvisionedThroughputInMibps``. After you create the file system, you can decrease your file system's Provisioned throughput or change between the throughput modes, with certain time restrictions. For more information, see [Specifying throughput with provisioned mode](https://docs.aws.amazon.com/efs/latest/ug/performance.html#provisioned-throughput) in the *Amazon EFS User Guide*.  Default is ``bursting``.")
  throughputMode?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BackupPolicy")
model BackupPolicy {
  @doc("Set the backup policy status for the file system.  +   *ENABLED* - Turns automatic backups on for the file system.   +   *DISABLED* - Turns automatic backups off for the file system.")
  status?: BackupPolicyStatus;
}

@doc("BackupPolicyStatus enum")
union BackupPolicyStatus {
  @doc("BackupPolicyStatus enum DISABLED")
  DISABLED: "DISABLED",

  @doc("BackupPolicyStatus enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FileSystemProtection")
model FileSystemProtection {
  @doc("The status of the file system's replication overwrite protection.  +   ``ENABLED`` – The file system cannot be used as the destination file system in a replication configuration. The file system is writeable. Replication overwrite protection is ``ENABLED`` by default.   +   ``DISABLED`` – The file system can be used as the destination file system in a replication configuration. The file system is read-only and can only be modified by EFS replication.  +   ``REPLICATING`` – The file system is being used as the destination file system in a replication configuration. The file system is read-only and is only modified only by EFS replication.   If the replication configuration is deleted, the file system's replication overwrite protection is re-enabled, the file system becomes writeable.")
  replicationOverwriteProtection?: FileSystemProtectionReplicationOverwriteProtection;
}

@doc("FileSystemProtectionReplicationOverwriteProtection enum")
union FileSystemProtectionReplicationOverwriteProtection {
  @doc("FileSystemProtectionReplicationOverwriteProtection enum DISABLED")
  DISABLED: "DISABLED",

  @doc("FileSystemProtectionReplicationOverwriteProtection enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticFileSystemTag")
model ElasticFileSystemTag {
  @doc("The tag key (String). The key can't start with ``aws:``.")
  key?: string;

  @doc("The value of the tag key.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LifecyclePolicy")
model LifecyclePolicy {
  @doc("The number of days after files were last accessed in primary storage (the Standard storage class) at which to move them to Archive storage. Metadata operations such as listing the contents of a directory don't count as file access events.")
  transitionToArchive?: string;

  @doc("The number of days after files were last accessed in primary storage (the Standard storage class) at which to move them to Infrequent Access (IA) storage. Metadata operations such as listing the contents of a directory don't count as file access events.")
  transitionToIA?: string;

  @doc("Whether to move files back to primary (Standard) storage after they are accessed in IA or Archive storage. Metadata operations such as listing the contents of a directory don't count as file access events.")
  transitionToPrimaryStorageClass?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationConfiguration")
model ReplicationConfiguration {
  @doc("An array of destination objects. Only one destination object is supported.")
  @extension("x-ms-identifiers", [])
  destinations?: ReplicationDestination[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationDestination")
model ReplicationDestination {
  @doc("The AWS For One Zone file systems, the replication configuration must specify the Availability Zone in which the destination file system is located.  Use the format ``us-east-1a`` to specify the Availability Zone. For more information about One Zone file systems, see [EFS file system types](https://docs.aws.amazon.com/efs/latest/ug/storage-classes.html) in the *Amazon EFS User Guide*.  One Zone file system type is not available in all Availability Zones in AWS-Regions where Amazon EFS is available.")
  availabilityZoneName?: string;

  @doc("The ID of the destination Amazon EFS file system.")
  fileSystemId?: string;

  @doc("The ID of an kms-key-long used to protect the encrypted file system.")
  kmsKeyId?: string;

  @doc("The AWS-Region in which the destination file system is located.  For One Zone file systems, the replication configuration must specify the AWS-Region in which the destination file system is located.")
  region?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EfsFileSystems {
  get is ArmResourceRead<EfsFileSystem>;
  @doc("Create a EfsFileSystem. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<EfsFileSystem>;
  update is ArmCustomPatchAsync<
    EfsFileSystem,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EfsFileSystem>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EfsFileSystem>;
  listByResourceGroup is ArmResourceListByParent<EfsFileSystem>;
  listBySubscription is ArmListBySubscription<EfsFileSystem>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EFS::FileSystem
//--------------------------------------------------------------------------------------------
