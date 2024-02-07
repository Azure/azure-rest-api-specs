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

//---------------------------------------------- RdsDBInstances ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model RdsDBInstance is TrackedResource<RdsDBInstanceProperties> {
  @doc("Name of RdsDBInstance")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("rdsDBInstances")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of RdsDBInstance")
model RdsDBInstanceProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsRdsDBInstanceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsRdsDBInstance")
model AwsRdsDBInstanceProperties {
  @doc("Gets and sets the property allocatedStorage. The amount of storage (in gigabytes) to be initially allocated for the database instance.")
  allocatedStorage?: string;

  @doc("Gets and sets the property allowMajorVersionUpgrade. A value that indicates whether major version upgrades are allowed. Changing this parameter doesn't result in an outage and the change is asynchronously applied as soon as possible.")
  allowMajorVersionUpgrade?: boolean;

  @doc("Gets and sets the property associatedRoles. The AWS Identity and Access Management (IAM) roles associated with the DB instance.")
  @extension("x-ms-identifiers", [])
  associatedRoles?: DBInstanceRole[];

  @doc("Gets and sets the property autoMinorVersionUpgrade. A value that indicates whether minor engine upgrades are applied automatically to the DB instance during the maintenance window. By default, minor engine upgrades are applied automatically.")
  autoMinorVersionUpgrade?: boolean;

  @doc("Gets and sets the property automaticBackupReplicationRegion. Enables replication of automated backups to a different Amazon Web Services Region.")
  automaticBackupReplicationRegion?: string;

  @doc("Gets and sets the property availabilityZone. The Availability Zone (AZ) where the database will be created. For information on AWS Regions and Availability Zones.")
  availabilityZone?: string;

  @doc("Gets and sets the property backupRetentionPeriod. The number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups.")
  backupRetentionPeriod?: int32;

  @doc("Gets and sets the property cACertificateIdentifier. The identifier of the CA certificate for this DB instance.")
  cACertificateIdentifier?: string;

  @doc("Gets and sets the property certificateDetails. Returns the details of the DB instance's server certificate.")
  certificateDetails?: CertificateDetails;

  @doc("Gets and sets the property certificateRotationRestart. A value that indicates whether the DB instance is restarted when you rotate your SSL/TLS certificate.By default, the DB instance is restarted when you rotate your SSL/TLS certificate. The certificate is not updated until the DB instance is restarted.If you are using SSL/TLS to connect to the DB instance, follow the appropriate instructions for your DB engine to rotate your SSL/TLS certificateThis setting doesn't apply to RDS Custom.")
  certificateRotationRestart?: boolean;

  @doc("Gets and sets the property characterSetName. For supported engines, indicates that the DB instance should be associated with the specified character set.")
  characterSetName?: string;

  @doc("Gets and sets the property copyTagsToSnapshot. A value that indicates whether to copy tags from the DB instance to snapshots of the DB instance. By default, tags are not copied.")
  copyTagsToSnapshot?: boolean;

  @doc("Gets and sets the property customIAMInstanceProfile. The instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance. The instance profile must meet the following requirements: * The profile must exist in your account. * The profile must have an IAM role that Amazon EC2 has permissions to assume. * The instance profile name and the associated IAM role name must start with the prefix AWSRDSCustom .For the list of permissions required for the IAM role, see Configure IAM and your VPC in the Amazon RDS User Guide .This setting is required for RDS Custom.")
  customIAMInstanceProfile?: string;

  @doc("Gets and sets the property dBClusterIdentifier. The identifier of the DB cluster that the instance will belong to.")
  dBClusterIdentifier?: string;

  @doc("Gets and sets the property dBClusterSnapshotIdentifier. The identifier for the RDS for MySQL Multi-AZ DB cluster snapshot to restore from. For more information on Multi-AZ DB clusters, see Multi-AZ deployments with two readable standby DB instances in the Amazon RDS User Guide .Constraints: * Must match the identifier of an existing Multi-AZ DB cluster snapshot. * Can't be specified when DBSnapshotIdentifier is specified. * Must be specified when DBSnapshotIdentifier isn't specified. * If you are restoring from a shared manual Multi-AZ DB cluster snapshot, the DBClusterSnapshotIdentifier must be the ARN of the shared snapshot. * Can't be the identifier of an Aurora DB cluster snapshot. * Can't be the identifier of an RDS for PostgreSQL Multi-AZ DB cluster snapshot.")
  dBClusterSnapshotIdentifier?: string;

  @doc("Gets and sets the property dBInstanceArn. The Amazon Resource Name (ARN) for the DB instance.")
  dBInstanceArn?: string;

  @doc("Gets and sets the property dBInstanceClass. The compute and memory capacity of the DB instance, for example, db.m4.large. Not all DB instance classes are available in all AWS Regions, or for all database engines.")
  dBInstanceClass?: string;

  @doc("Gets and sets the property dBInstanceIdentifier. A name for the DB instance. If you specify a name, AWS CloudFormation converts it to lowercase. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the DB instance.")
  dBInstanceIdentifier?: string;

  @doc("Gets and sets the property dBName. The meaning of this parameter differs according to the database engine you use.")
  dBName?: string;

  @doc("Gets and sets the property dBParameterGroupName. The name of an existing DB parameter group or a reference to an AWS::RDS::DBParameterGroup resource created in the template.")
  dBParameterGroupName?: string;

  @doc("Gets and sets the property dBSecurityGroups. A list of the DB security groups to assign to the DB instance. The list can include both the name of existing DB security groups or references to AWS::RDS::DBSecurityGroup resources created in the template.")
  @extension("x-ms-identifiers", [])
  dBSecurityGroups?: string[];

  @doc("Gets and sets the property dBSnapshotIdentifier. The name or Amazon Resource Name (ARN) of the DB snapshot that's used to restore the DB instance. If you're restoring from a shared manual DB snapshot, you must specify the ARN of the snapshot.")
  dBSnapshotIdentifier?: string;

  @doc("Gets and sets the property dBSubnetGroupName. A DB subnet group to associate with the DB instance. If you update this value, the new subnet group must be a subnet group in a new VPC.")
  dBSubnetGroupName?: string;

  @doc("Gets and sets the property dBSystemId. The Oracle system ID (Oracle SID) for a container database (CDB). The Oracle SID is also the name of the CDB. This setting is valid for RDS Custom only.")
  dBSystemId?: string;

  @doc("Gets and sets the property dbiResourceId. The AWS Region-unique, immutable identifier for the DB instance. This identifier is found in AWS CloudTrail log entries whenever the AWS KMS key for the DB instance is accessed.")
  dbiResourceId?: string;

  @doc("Gets and sets the property dedicatedLogVolume. Indicates whether the DB instance has a dedicated log volume (DLV) enabled.")
  dedicatedLogVolume?: boolean;

  @doc("Gets and sets the property deleteAutomatedBackups. A value that indicates whether to remove automated backups immediately after the DB instance is deleted. This parameter isn't case-sensitive. The default is to remove automated backups immediately after the DB instance is deleted.")
  deleteAutomatedBackups?: boolean;

  @doc("Gets and sets the property deletionProtection. A value that indicates whether the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled.")
  deletionProtection?: boolean;

  @doc("Gets and sets the property domain. The Active Directory directory ID to create the DB instance in. Currently, only MySQL, Microsoft SQL Server, Oracle, and PostgreSQL DB instances can be created in an Active Directory Domain.")
  domain?: string;

  @doc("Gets and sets the property domainAuthSecretArn. The ARN for the Secrets Manager secret with the credentials for the user joining the domain.")
  domainAuthSecretArn?: string;

  @doc("Gets and sets the property domainDnsIps. The IPv4 DNS IP addresses of your primary and secondary Active Directory domain controllers.")
  @extension("x-ms-identifiers", [])
  domainDnsIps?: string[];

  @doc("Gets and sets the property domainFqdn. The fully qualified domain name (FQDN) of an Active Directory domain.")
  domainFqdn?: string;

  @doc("Gets and sets the property domainIAMRoleName. Specify the name of the IAM role to be used when making API calls to the Directory Service.")
  domainIAMRoleName?: string;

  @doc("Gets and sets the property domainOu. The Active Directory organizational unit for your DB instance to join.")
  domainOu?: string;

  @doc("Gets and sets the property enableCloudwatchLogsExports. The list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine being used.")
  @extension("x-ms-identifiers", [])
  enableCloudwatchLogsExports?: string[];

  @doc("Gets and sets the property enableIAMDatabaseAuthentication. A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.")
  enableIAMDatabaseAuthentication?: boolean;

  @doc("Gets and sets the property enablePerformanceInsights. A value that indicates whether to enable Performance Insights for the DB instance.")
  enablePerformanceInsights?: boolean;

  @doc("Gets and sets the property endpoint. Specifies the connection endpoint.")
  endpoint?: Endpoint;

  @doc("Gets and sets the property engine. The name of the database engine that you want to use for this DB instance.")
  engine?: string;

  @doc("Gets and sets the property engineVersion. The version number of the database engine to use.")
  engineVersion?: string;

  @doc("Gets and sets the property iops. The number of I/O operations per second (IOPS) that the database provisions.")
  iops?: int32;

  @doc("Gets and sets the property kmsKeyId. The ARN of the AWS Key Management Service (AWS KMS) master key that's used to encrypt the DB instance.")
  kmsKeyId?: string;

  @doc("Gets and sets the property licenseModel. License model information for this DB instance.")
  licenseModel?: string;

  @doc("Gets and sets the property manageMasterUserPassword. A value that indicates whether to manage the master user password with AWS Secrets Manager.")
  manageMasterUserPassword?: boolean;

  @doc("Gets and sets the property masterUserPassword. The password for the master user.")
  masterUserPassword?: string;

  @doc("Gets and sets the property masterUserSecret. Contains the secret managed by RDS in AWS Secrets Manager for the master user password.")
  masterUserSecret?: MasterUserSecret;

  @doc("Gets and sets the property masterUsername. The master user name for the DB instance.")
  masterUsername?: string;

  @doc("Gets and sets the property maxAllocatedStorage. The upper limit to which Amazon RDS can automatically scale the storage of the DB instance.")
  maxAllocatedStorage?: int32;

  @doc("Gets and sets the property monitoringInterval. The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0.")
  monitoringInterval?: int32;

  @doc("Gets and sets the property monitoringRoleArn. The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to Amazon CloudWatch Logs.")
  monitoringRoleArn?: string;

  @doc("Gets and sets the property multiAZ. Specifies whether the database instance is a multiple Availability Zone deployment.")
  multiAZ?: boolean;

  @doc("Gets and sets the property ncharCharacterSetName. The name of the NCHAR character set for the Oracle DB instance. This parameter doesn't apply to RDS Custom.")
  ncharCharacterSetName?: string;

  @doc("Gets and sets the property networkType. The network type of the DB cluster.")
  networkType?: string;

  @doc("Gets and sets the property optionGroupName. Indicates that the DB instance should be associated with the specified option group.")
  optionGroupName?: string;

  @doc("Gets and sets the property performanceInsightsKMSKeyId. The AWS KMS key identifier for encryption of Performance Insights data. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key.")
  performanceInsightsKMSKeyId?: string;

  @doc("Gets and sets the property performanceInsightsRetentionPeriod. The amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years).")
  performanceInsightsRetentionPeriod?: int32;

  @doc("Gets and sets the property port. The port number on which the database accepts connections.")
  port?: string;

  @doc("Gets and sets the property preferredBackupWindow. The daily time range during which automated backups are created if automated backups are enabled, using the BackupRetentionPeriod parameter.")
  preferredBackupWindow?: string;

  @doc("Gets and sets the property preferredMaintenanceWindow. he weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC).")
  preferredMaintenanceWindow?: string;

  @doc("Gets and sets the property processorFeatures. The number of CPU cores and the number of threads per core for the DB instance class of the DB instance.")
  @extension("x-ms-identifiers", [])
  processorFeatures?: ProcessorFeature[];

  @doc("Gets and sets the property promotionTier. A value that specifies the order in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance.")
  promotionTier?: int32;

  @doc("Gets and sets the property publiclyAccessible. Indicates whether the DB instance is an internet-facing instance. If you specify true, AWS CloudFormation creates an instance with a publicly resolvable DNS name, which resolves to a public IP address. If you specify false, AWS CloudFormation creates an internal instance with a DNS name that resolves to a private IP address.")
  publiclyAccessible?: boolean;

  @doc("Gets and sets the property replicaMode. The open mode of an Oracle read replica. The default is open-read-only.")
  replicaMode?: string;

  @doc("Gets and sets the property restoreTime. The date and time to restore from.")
  restoreTime?: string;

  @doc("Gets and sets the property sourceDBClusterIdentifier. The identifier of the Multi-AZ DB cluster that will act as the source for the read replica. Each DB cluster can have up to 15 read replicas.")
  sourceDBClusterIdentifier?: string;

  @doc("Gets and sets the property sourceDBInstanceAutomatedBackupsArn. The Amazon Resource Name (ARN) of the replicated automated backups from which to restore.")
  sourceDBInstanceAutomatedBackupsArn?: string;

  @doc("Gets and sets the property sourceDBInstanceIdentifier. If you want to create a Read Replica DB instance, specify the ID of the source DB instance. Each DB instance can have a limited number of Read Replicas.")
  sourceDBInstanceIdentifier?: string;

  @doc("Gets and sets the property sourceDbiResourceId. The resource ID of the source DB instance from which to restore.")
  sourceDbiResourceId?: string;

  @doc("Gets and sets the property sourceRegion. The ID of the region that contains the source DB instance for the Read Replica.")
  sourceRegion?: string;

  @doc("Gets and sets the property storageEncrypted. A value that indicates whether the DB instance is encrypted. By default, it isn't encrypted.")
  storageEncrypted?: boolean;

  @doc("Gets and sets the property storageThroughput. Specifies the storage throughput for the DB instance.")
  storageThroughput?: int32;

  @doc("Gets and sets the property storageType. Specifies the storage type to be associated with the DB instance.")
  storageType?: string;

  @doc("Gets and sets the property tags. Tags to assign to the DB instance.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property tdeCredentialArn. The ARN from the key store with which to associate the instance for TDE encryption.")
  tdeCredentialArn?: string;

  @doc("Gets and sets the property tdeCredentialPassword. The password for the given ARN from the key store in order to access the device.")
  tdeCredentialPassword?: string;

  @doc("Gets and sets the property timezone. The time zone of the DB instance. The time zone parameter is currently supported only by Microsoft SQL Server.")
  timezone?: string;

  @doc("Gets and sets the property useDefaultProcessorFeatures. A value that indicates whether the DB instance class of the DB instance uses its default processor features.")
  useDefaultProcessorFeatures?: boolean;

  @doc("Gets and sets the property useLatestRestorableTime. A value that indicates whether the DB instance is restored from the latest backup time. By default, the DB instance isn't restored from the latest backup time.")
  useLatestRestorableTime?: boolean;

  @doc("Gets and sets the property vPCSecurityGroups. A list of the VPC security group IDs to assign to the DB instance. The list can include both the physical IDs of existing VPC security groups and references to AWS::EC2::SecurityGroup resources created in the template.")
  @extension("x-ms-identifiers", [])
  vPCSecurityGroups?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of DBInstanceRole")
model DBInstanceRole {
  @doc("Gets and sets the property featureName. The name of the feature associated with the AWS Identity and Access Management (IAM) role. IAM roles that are associated with a DB instance grant permission for the DB instance to access other AWS services on your behalf.")
  featureName?: string;

  @doc("Gets and sets the property roleArn. The Amazon Resource Name (ARN) of the IAM role that is associated with the DB instance.")
  roleArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of CertificateDetails")
model CertificateDetails {
  @doc("Gets and sets the property cAIdentifier. The CA identifier of the CA certificate used for the DB instance's server certificate.")
  cAIdentifier?: string;

  @doc("Gets and sets the property validTill. The expiration date of the DB instance’s server certificate.")
  validTill?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Endpoint")
model Endpoint {
  @doc("Gets and sets the property address. Specifies the DNS address of the DB instance.")
  address?: string;

  @doc("Gets and sets the property hostedZoneId. Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.")
  hostedZoneId?: string;

  @doc("Gets and sets the property port. Specifies the port that the database engine is listening on.")
  port?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of MasterUserSecret")
model MasterUserSecret {
  @doc("Gets and sets the property kmsKeyId. The AWS KMS key identifier that is used to encrypt the secret.")
  kmsKeyId?: string;

  @doc("Gets and sets the property secretArn. The Amazon Resource Name (ARN) of the secret.")
  secretArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of ProcessorFeature")
model ProcessorFeature {
  @doc("Gets and sets the property name. The name of the processor feature. Valid names are coreCount and threadsPerCore.")
  name?: ProcessorFeatureName;

  @doc("Gets and sets the property value. The value of a processor feature name.")
  value?: string;
}

@doc("ProcessorFeatureName enum")
enum ProcessorFeatureName {
  @doc("ProcessorFeatureName enum coreCount")
  coreCount: "coreCount",

  @doc("ProcessorFeatureName enum threadsPerCore")
  threadsPerCore: "threadsPerCore",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -. ")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -. ")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface RdsDBInstances {
  get is ArmResourceRead<RdsDBInstance>;
  @doc("Create a RdsDBInstance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RdsDBInstance>;
  update is ArmCustomPatchAsync<
    RdsDBInstance,
    Azure.ResourceManager.Foundations.TagsUpdateModel<RdsDBInstance>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<RdsDBInstance>;
  listByResourceGroup is ArmResourceListByParent<RdsDBInstance>;
  listBySubscription is ArmListBySubscription<RdsDBInstance>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::RDS::DBInstance
//--------------------------------------------------------------------------------------------
