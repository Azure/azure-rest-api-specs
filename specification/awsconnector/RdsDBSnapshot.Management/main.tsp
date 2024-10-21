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

//---------------------------------------------- RdsDBSnapshots ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "RDS DBSnapshot",
    plural: "RDS DBSnapshots",
  },
  keywords: ["Microsoft.AwsConnector", "RDS", "DBSnapshot"],
})
@doc("A Microsoft.AwsConnector resource")
model RdsDBSnapshot is TrackedResource<RdsDBSnapshotProperties> {
  @doc("Name of RdsDBSnapshot")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("rdsDBSnapshots")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RdsDBSnapshot")
model RdsDBSnapshotProperties {
  @doc("AWS Properties")
  awsProperties?: AwsRdsDBSnapshotProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRdsDBSnapshot")
model AwsRdsDBSnapshotProperties {
  @doc("<p>Specifies the allocated storage size in gibibytes (GiB).</p>")
  allocatedStorage?: int32;

  @doc("<p>Specifies the name of the Availability Zone the DB instance was located in at the time of the DB snapshot.</p>")
  availabilityZone?: string;

  @doc("<p>Specifies the DB instance identifier of the DB instance this DB snapshot was created from.</p>")
  dbInstanceIdentifier?: string;

  @doc("<p>The Amazon Resource Name (ARN) for the DB snapshot.</p>")
  dbSnapshotArn?: string;

  @doc("<p>Specifies the identifier for the DB snapshot.</p>")
  dbSnapshotIdentifier?: string;

  @doc("<p>The Oracle system identifier (SID), which is the name of the Oracle database instance that manages your database files. The Oracle SID is also the name of your CDB.</p>")
  dbSystemId?: string;

  @doc("<p>The identifier for the source DB instance, which can't be changed and which is unique to an Amazon Web Services Region.</p>")
  dbiResourceId?: string;

  @doc("<p>Indicates whether the DB instance has a dedicated log volume (DLV) enabled.</p>")
  dedicatedLogVolume?: boolean;

  @doc("<p>Indicates whether the DB snapshot is encrypted.</p>")
  encrypted?: boolean;

  @doc("<p>Specifies the name of the database engine.</p>")
  engine?: string;

  @doc("<p>Specifies the version of the database engine.</p>")
  engineVersion?: string;

  @doc("<p>Indicates whether mapping of Amazon Web Services Identity and Access Management (IAM) accounts to database accounts is enabled.</p>")
  iamDatabaseAuthenticationEnabled?: boolean;

  @doc("<p>Specifies the time in Coordinated Universal Time (UTC) when the DB instance, from which the snapshot was taken, was created.</p>")
  instanceCreateTime?: utcDateTime;

  @doc("<p>Specifies the Provisioned IOPS (I/O operations per second) value of the DB instance at the time of the snapshot.</p>")
  iops?: int32;

  @doc("<p>If <code>Encrypted</code> is true, the Amazon Web Services KMS key identifier for the encrypted DB snapshot.</p> <p>The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key.</p>")
  kmsKeyId?: string;

  @doc("<p>License model information for the restored DB instance.</p>")
  licenseModel?: string;

  @doc("<p>Provides the master username for the DB snapshot.</p>")
  masterUsername?: string;

  @doc("<p>Indicates whether the snapshot is of a DB instance using the multi-tenant configuration (TRUE) or the single-tenant configuration (FALSE).</p>")
  multiTenant?: boolean;

  @doc("<p>Provides the option group name for the DB snapshot.</p>")
  optionGroupName?: string;

  @doc("<p>Specifies the time of the CreateDBSnapshot operation in Coordinated Universal Time (UTC). Doesn't change when the snapshot is copied.</p>")
  originalSnapshotCreateTime?: utcDateTime;

  @doc("<p>The percentage of the estimated data that has been transferred.</p>")
  percentProgress?: int32;

  @doc("<p>Specifies the port that the database engine was listening on at the time of the snapshot.</p>")
  port?: int32;

  @doc("<p>The number of CPU cores and the number of threads per core for the DB instance class of the DB instance when the DB snapshot was created.</p>")
  @extension("x-ms-identifiers", [])
  processorFeatures?: ProcessorFeature[];

  @doc("<p>Specifies when the snapshot was taken in Coordinated Universal Time (UTC). Changes for the copy when the snapshot is copied.</p>")
  snapshotCreateTime?: utcDateTime;

  @doc("<p>The timestamp of the most recent transaction applied to the database that you're backing up. Thus, if you restore a snapshot, SnapshotDatabaseTime is the most recent transaction in the restored DB instance. In contrast, originalSnapshotCreateTime specifies the system time that the snapshot completed.</p> <p>If you back up a read replica, you can determine the replica lag by comparing SnapshotDatabaseTime with originalSnapshotCreateTime. For example, if originalSnapshotCreateTime is two hours later than SnapshotDatabaseTime, then the replica lag is two hours.</p>")
  snapshotDatabaseTime?: utcDateTime;

  @doc("<p>Specifies where manual snapshots are stored: Amazon Web Services Outposts or the Amazon Web Services Region.</p>")
  snapshotTarget?: string;

  @doc("<p>Provides the type of the DB snapshot.</p>")
  snapshotType?: string;

  @doc("<p>The DB snapshot Amazon Resource Name (ARN) that the DB snapshot was copied from. It only has a value in the case of a cross-account or cross-Region copy.</p>")
  sourceDBSnapshotIdentifier?: string;

  @doc("<p>The Amazon Web Services Region that the DB snapshot was created in or copied from.</p>")
  sourceRegion?: string;

  @doc("<p>Specifies the status of this DB snapshot.</p>")
  status?: string;

  @doc("<p>Specifies the storage throughput for the DB snapshot.</p>")
  storageThroughput?: int32;

  @doc("<p>Specifies the storage type associated with DB snapshot.</p>")
  storageType?: string;

  @doc("Property tagList")
  @extension("x-ms-identifiers", [])
  tagList?: Tag[];

  @doc("<p>The ARN from the key store with which to associate the instance for TDE encryption.</p>")
  tdeCredentialArn?: string;

  @doc("<p>The time zone of the DB snapshot. In most cases, the <code>Timezone</code> element is empty. <code>Timezone</code> content appears only for snapshots taken from Microsoft SQL Server DB instances that were created with a time zone specified.</p>")
  timezone?: string;

  @doc("<p>Provides the VPC ID associated with the DB snapshot.</p>")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProcessorFeature")
model ProcessorFeature {
  @doc("<p>The name of the processor feature. Valid names are <code>coreCount</code> and <code>threadsPerCore</code>.</p>")
  name?: string;

  @doc("<p>The value of a processor feature name.</p>")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("<p>A key is the required name of the tag. The string value can be from 1 to 128 Unicode characters in length and can't be prefixed with <code>aws:</code> or <code>rds:</code>. The string can only contain only the set of Unicode letters, digits, white-space, '_', '.', ':', '/', '=', '+', '-', '@' (Java regex: '^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-@]*)$').</p>")
  key?: string;

  @doc("<p>A value is the optional value of the tag. The string value can be from 1 to 256 Unicode characters in length and can't be prefixed with <code>aws:</code> or <code>rds:</code>. The string can only contain only the set of Unicode letters, digits, white-space, '_', '.', ':', '/', '=', '+', '-', '@' (Java regex: '^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-@]*)$').</p>")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface RdsDBSnapshots {
  get is ArmResourceRead<RdsDBSnapshot>;
  @doc("Create a RdsDBSnapshot. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<RdsDBSnapshot>;
  update is ArmCustomPatchAsync<
    RdsDBSnapshot,
    Azure.ResourceManager.Foundations.TagsUpdateModel<RdsDBSnapshot>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<RdsDBSnapshot>;
  listByResourceGroup is ArmResourceListByParent<RdsDBSnapshot>;
  listBySubscription is ArmListBySubscription<RdsDBSnapshot>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\rds\rds-2014-10-31.normal.json
// AWS Shape: DBSnapshot
//
// Related information for backend service:
// AWS Servcie : RDS
// Product Version : 3.7.798.0
// SDK Version : 3.7.312.0
//--------------------------------------------------------------------------------------------
