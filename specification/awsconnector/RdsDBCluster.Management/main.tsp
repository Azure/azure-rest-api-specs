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

//---------------------------------------------- RdsDBClusters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "RDS DBCluster",
    plural: "RDS DBClusters",
  },
  keywords: ["Microsoft.AwsConnector", "RDS", "DBCluster"],
})
@doc("A Microsoft.AwsConnector resource")
model RdsDBCluster is TrackedResource<RdsDBClusterProperties> {
  @doc("Name of RdsDBCluster")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("rdsDBClusters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RdsDBCluster")
model RdsDBClusterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsRdsDBClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRdsDBCluster")
model AwsRdsDBClusterProperties {
  @doc("The amount of storage in gibibytes (GiB) to allocate to each DB instance in the Multi-AZ DB cluster.")
  allocatedStorage?: int32;

  @doc("Provides a list of the AWS Identity and Access Management (IAM) roles that are associated with the DB cluster. IAM roles that are associated with a DB cluster grant permission for the DB cluster to access other AWS services on your behalf.")
  @extension("x-ms-identifiers", [])
  associatedRoles?: DBClusterRole[];

  @doc("A value that indicates whether minor engine upgrades are applied automatically to the DB cluster during the maintenance window. By default, minor engine upgrades are applied automatically.")
  autoMinorVersionUpgrade?: boolean;

  @doc("A list of Availability Zones (AZs) where instances in the DB cluster can be created. For information on AWS Regions and Availability Zones, see Choosing the Regions and Availability Zones in the Amazon Aurora User Guide.")
  @extension("x-ms-identifiers", [])
  availabilityZones?: string[];

  @doc("The target backtrack window, in seconds. To disable backtracking, set this value to 0.")
  backtrackWindow?: int32;

  @doc("The number of days for which automated backups are retained.")
  backupRetentionPeriod?: int32 = 1;

  @doc("A value that indicates whether to copy all tags from the DB cluster to snapshots of the DB cluster. The default is not to copy them.")
  copyTagsToSnapshot?: boolean;

  @doc("The Amazon Resource Name (ARN) for the DB cluster.")
  dbClusterArn?: string;

  @doc("The DB cluster identifier. This parameter is stored as a lowercase string.")
  dbClusterIdentifier?: string;

  @doc("The compute and memory capacity of each DB instance in the Multi-AZ DB cluster, for example db.m6g.xlarge.")
  dbClusterInstanceClass?: string;

  @doc("The name of the DB cluster parameter group to associate with this DB cluster.")
  dbClusterParameterGroupName?: string = "default.aurora5.6";

  @doc("The AWS Region-unique, immutable identifier for the DB cluster.")
  dbClusterResourceId?: string;

  @doc("The name of the DB parameter group to apply to all instances of the DB cluster.")
  dbInstanceParameterGroupName?: string;

  @doc("A DB subnet group that you want to associate with this DB cluster.")
  dbSubnetGroupName?: string;

  @doc("Reserved for future use.")
  dbSystemId?: string;

  @doc("The name of your database. If you don't provide a name, then Amazon RDS won't create a database in this DB cluster. For naming constraints, see Naming Constraints in the Amazon RDS User Guide.")
  databaseName?: string;

  @doc("A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled.")
  deletionProtection?: boolean;

  @doc("The Active Directory directory ID to create the DB cluster in.")
  domain?: string;

  @doc("Specify the name of the IAM role to be used when making API calls to the Directory Service.")
  domainIAMRoleName?: string;

  @doc("The list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see Publishing Database Logs to Amazon CloudWatch Logs in the Amazon Aurora User Guide.")
  @extension("x-ms-identifiers", [])
  enableCloudwatchLogsExports?: string[];

  @doc("Specifies whether to enable this DB cluster to forward write operations to the primary cluster of a global cluster (Aurora global database). By default, write operations are not allowed on Aurora DB clusters that are secondary clusters in an Aurora global database.")
  enableGlobalWriteForwarding?: boolean;

  @doc("A value that indicates whether to enable the HTTP endpoint for DB cluster. By default, the HTTP endpoint is disabled.")
  enableHttpEndpoint?: boolean;

  @doc("A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.")
  enableIAMDatabaseAuthentication?: boolean;

  @doc("Property endpoint")
  endpoint?: Endpoint;

  @doc("The name of the database engine to be used for this DB cluster. Valid Values: aurora (for MySQL 5.6-compatible Aurora), aurora-mysql (for MySQL 5.7-compatible Aurora), and aurora-postgresql")
  engine?: string;

  @doc("The DB engine mode of the DB cluster, either provisioned, serverless, parallelquery, global, or multimaster.")
  engineMode?: string;

  @doc("The version number of the database engine to use.")
  engineVersion?: string;

  @doc("If you are configuring an Aurora global database cluster and want your Aurora DB cluster to be a secondary member in the global database cluster, specify the global cluster ID of the global database cluster. To define the primary database cluster of the global cluster, use the AWS::RDS::GlobalCluster resource.If you aren't configuring a global database cluster, don't specify this property.")
  globalClusterIdentifier?: string;

  @doc("The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for each DB instance in the Multi-AZ DB cluster.")
  iops?: int32;

  @doc("The Amazon Resource Name (ARN) of the AWS Key Management Service master key that is used to encrypt the database instances in the DB cluster, such as arn:aws:kms:us-east-1:012345678910:key/abcd1234-a123-456a-a12b-a123b4cd56ef. If you enable the StorageEncrypted property but don't specify this property, the default master key is used. If you specify this property, you must set the StorageEncrypted property to true.")
  kmsKeyId?: string;

  @doc("A value that indicates whether to manage the master user password with AWS Secrets Manager.")
  manageMasterUserPassword?: boolean;

  @doc("The master password for the DB instance.")
  masterUserPassword?: string;

  @doc("Contains the secret managed by RDS in AWS Secrets Manager for the master user password.")
  masterUserSecret?: MasterUserSecret;

  @doc("The name of the master user for the DB cluster. You must specify MasterUsername, unless you specify SnapshotIdentifier. In that case, don't specify MasterUsername.")
  masterUsername?: string;

  @doc("The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB cluster. To turn off collecting Enhanced Monitoring metrics, specify 0. The default is 0.")
  monitoringInterval?: int32;

  @doc("The Amazon Resource Name (ARN) for the IAM role that permits RDS to send Enhanced Monitoring metrics to Amazon CloudWatch Logs.")
  monitoringRoleArn?: string;

  @doc("The network type of the DB cluster.")
  networkType?: string;

  @doc("A value that indicates whether to turn on Performance Insights for the DB cluster.")
  performanceInsightsEnabled?: boolean;

  @doc("The Amazon Web Services KMS key identifier for encryption of Performance Insights data.")
  performanceInsightsKmsKeyId?: string;

  @doc("The amount of time, in days, to retain Performance Insights data.")
  performanceInsightsRetentionPeriod?: int32;

  @doc("The port number on which the instances in the DB cluster accept connections. Default: 3306 if engine is set as aurora or 5432 if set to aurora-postgresql.")
  port?: int32;

  @doc("The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter. The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region. To see the time blocks available, see Adjusting the Preferred DB Cluster Maintenance Window in the Amazon Aurora User Guide.")
  preferredBackupWindow?: string;

  @doc("The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC). The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region, occurring on a random day of the week. To see the time blocks available, see Adjusting the Preferred DB Cluster Maintenance Window in the Amazon Aurora User Guide.")
  preferredMaintenanceWindow?: string;

  @doc("A value that indicates whether the DB cluster is publicly accessible.")
  publiclyAccessible?: boolean;

  @doc("Property readEndpoint")
  readEndpoint?: ReadEndpoint;

  @doc("The Amazon Resource Name (ARN) of the source DB instance or DB cluster if this DB cluster is created as a Read Replica.")
  replicationSourceIdentifier?: string;

  @doc("The date and time to restore the DB cluster to. Value must be a time in Universal Coordinated Time (UTC) format. An example: 2015-03-07T23:45:00Z")
  restoreToTime?: string;

  @doc("The type of restore to be performed. You can specify one of the following values:full-copy - The new DB cluster is restored as a full copy of the source DB cluster.copy-on-write - The new DB cluster is restored as a clone of the source DB cluster.")
  restoreType?: string = "full-copy";

  @doc("The ScalingConfiguration property type specifies the scaling configuration of an Aurora Serverless DB cluster. The ScalingConfiguration property type specifies the scaling configuration of an Aurora Serverless DB cluster.")
  scalingConfiguration?: ScalingConfiguration;

  @doc("Contains the scaling configuration of an Aurora Serverless v2 DB cluster. Contains the scaling configuration of an Aurora Serverless v2 DB cluster.")
  serverlessV2ScalingConfiguration?: ServerlessV2ScalingConfiguration;

  @doc("The identifier for the DB snapshot or DB cluster snapshot to restore from.You can use either the name or the Amazon Resource Name (ARN) to specify a DB cluster snapshot. However, you can use only the ARN to specify a DB snapshot.After you restore a DB cluster with a SnapshotIdentifier property, you must specify the same SnapshotIdentifier property for any future updates to the DB cluster. When you specify this property for an update, the DB cluster is not restored from the snapshot again, and the data in the database is not changed. However, if you don't specify the SnapshotIdentifier property, an empty DB cluster is created, and the original DB cluster is deleted. If you specify a property that is different from the previous snapshot restore property, the DB cluster is restored from the specified SnapshotIdentifier property, and the original DB cluster is deleted.")
  snapshotIdentifier?: string;

  @doc("The identifier of the source DB cluster from which to restore.")
  sourceDBClusterIdentifier?: string;

  @doc("The AWS Region which contains the source DB cluster when replicating a DB cluster. For example, us-east-1.")
  sourceRegion?: string;

  @doc("Indicates whether the DB instance is encrypted.If you specify the DBClusterIdentifier, SnapshotIdentifier, or SourceDBInstanceIdentifier property, don't specify this property. The value is inherited from the cluster, snapshot, or source DB instance.")
  storageEncrypted?: boolean;

  @doc("Specifies the storage throughput value for the DB cluster. This setting applies only to the gp3 storage type.")
  storageThroughput?: int32;

  @doc("Specifies the storage type to be associated with the DB cluster.")
  storageType?: string;

  @doc("An array of key-value pairs to apply to this resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("A value that indicates whether to restore the DB cluster to the latest restorable backup time. By default, the DB cluster is not restored to the latest restorable backup time.")
  useLatestRestorableTime?: boolean;

  @doc("A list of EC2 VPC security groups to associate with this DB cluster.")
  @extension("x-ms-identifiers", [])
  vpcSecurityGroupIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DBClusterRole")
model DBClusterRole {
  @doc("The name of the feature associated with the AWS Identity and Access Management (IAM) role. For the list of supported feature names, see DBEngineVersion in the Amazon RDS API Reference.")
  featureName?: string;

  @doc("The Amazon Resource Name (ARN) of the IAM role that is associated with the DB cluster.")
  roleArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Endpoint")
model Endpoint {
  @doc("The connection endpoint for the DB cluster.")
  address?: string;

  @doc("The port number that will accept connections on this DB cluster.")
  port?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MasterUserSecret")
model MasterUserSecret {
  @doc("The AWS KMS key identifier that is used to encrypt the secret.")
  kmsKeyId?: string;

  @doc("The Amazon Resource Name (ARN) of the secret.")
  secretArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReadEndpoint")
model ReadEndpoint {
  @doc("The reader endpoint for the DB cluster.")
  address?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScalingConfiguration")
model ScalingConfiguration {
  @doc("A value that indicates whether to allow or disallow automatic pause for an Aurora DB cluster in serverless DB engine mode. A DB cluster can be paused only when it's idle (it has no connections).")
  autoPause?: boolean;

  @doc("The maximum capacity for an Aurora DB cluster in serverless DB engine mode.For Aurora MySQL, valid capacity values are 1, 2, 4, 8, 16, 32, 64, 128, and 256.For Aurora PostgreSQL, valid capacity values are 2, 4, 8, 16, 32, 64, 192, and 384.The maximum capacity must be greater than or equal to the minimum capacity.")
  maxCapacity?: int32;

  @doc("The minimum capacity for an Aurora DB cluster in serverless DB engine mode.For Aurora MySQL, valid capacity values are 1, 2, 4, 8, 16, 32, 64, 128, and 256.For Aurora PostgreSQL, valid capacity values are 2, 4, 8, 16, 32, 64, 192, and 384.The minimum capacity must be less than or equal to the maximum capacity.")
  minCapacity?: int32;

  @doc("The amount of time, in seconds, that Aurora Serverless v1 tries to find a scaling point to perform seamless scaling before enforcing the timeout action.The default is 300.")
  secondsBeforeTimeout?: int32;

  @doc("The time, in seconds, before an Aurora DB cluster in serverless mode is paused.")
  secondsUntilAutoPause?: int32;

  @doc("The action to take when the timeout is reached, either ForceApplyCapacityChange or RollbackCapacityChange.ForceApplyCapacityChange sets the capacity to the specified value as soon as possible.RollbackCapacityChange, the default, ignores the capacity change if a scaling point isn't found in the timeout period.For more information, see Autoscaling for Aurora Serverless v1 in the Amazon Aurora User Guide.")
  timeoutAction?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServerlessV2ScalingConfiguration")
model ServerlessV2ScalingConfiguration {
  @doc("The maximum number of Aurora capacity units (ACUs) for a DB instance in an Aurora Serverless v2 cluster. You can specify ACU values in half-step increments, such as 40, 40.5, 41, and so on. The largest value that you can use is 128.")
  maxCapacity?: float32;

  @doc("The minimum number of Aurora capacity units (ACUs) for a DB instance in an Aurora Serverless v2 cluster. You can specify ACU values in half-step increments, such as 8, 8.5, 9, and so on. The smallest value that you can use is 0.5.")
  minCapacity?: float32;
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
interface RdsDBClusters {
  get is ArmResourceRead<RdsDBCluster>;
  @doc("Create a RdsDBCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<RdsDBCluster>;
  update is ArmCustomPatchAsync<
    RdsDBCluster,
    Azure.ResourceManager.Foundations.TagsUpdateModel<RdsDBCluster>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<RdsDBCluster>;
  listByResourceGroup is ArmResourceListByParent<RdsDBCluster>;
  listBySubscription is ArmListBySubscription<RdsDBCluster>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::RDS::DBCluster
//--------------------------------------------------------------------------------------------
