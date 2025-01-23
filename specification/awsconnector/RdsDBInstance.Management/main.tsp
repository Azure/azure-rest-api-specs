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

//---------------------------------------------- RdsDBInstances ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "RDS DBInstance",
    plural: "RDS DBInstances",
  },
  keywords: ["Microsoft.AwsConnector", "RDS", "DBInstance"],
})
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RdsDBInstance")
model RdsDBInstanceProperties {
  @doc("AWS Properties")
  awsProperties?: AwsRdsDBInstanceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRdsDBInstance")
model AwsRdsDBInstanceProperties {
  @doc("The amount of storage in gibibytes (GiB) to be initially allocated for the database instance.  If any value is set in the ``Iops`` parameter, ``AllocatedStorage`` must be at least 100 GiB, which corresponds to the minimum Iops value of 1,000. If you increase the ``Iops`` value (in 1,000 IOPS increments), then you must also increase the ``AllocatedStorage`` value (in 100-GiB increments).    *Amazon Aurora*  Not applicable. Aurora cluster volumes automatically grow as the amount of data in your database increases, though you are only charged for the space that you use in an Aurora cluster volume.  *Db2*  Constraints to the amount of storage for each storage type are the following:  +  General Purpose (SSD) storage (gp3): Must be an integer from 20 to 64000.  +  Provisioned IOPS storage (io1): Must be an integer from 100 to 64000.    *MySQL*  Constraints to the amount of storage for each storage type are the following:   +  General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536.  +  Provisioned IOPS storage (io1): Must be an integer from 100 to 65536.  +  Magnetic storage (standard): Must be an integer from 5 to 3072.    *MariaDB*  Constraints to the amount of storage for each storage type are the following:   +  General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536.  +  Provisioned IOPS storage (io1): Must be an integer from 100 to 65536.  +  Magnetic storage (standard): Must be an integer from 5 to 3072.    *PostgreSQL*  Constraints to the amount of storage for each storage type are the following:   +  General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536.  +  Provisioned IOPS storage (io1): Must be an integer from 100 to 65536.  +  Magnetic storage (standard): Must be an integer from 5 to 3072.    *Oracle*  Constraints to the amount of storage for each storage type are the following:   +  General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536.  +  Provisioned IOPS storage (io1): Must be an integer from 100 to 65536.  +  Magnetic storage (standard): Must be an integer from 10 to 3072.    *SQL Server*  Constraints to the amount of storage for each storage type are the following:   +  General Purpose (SSD) storage (gp2):  +  Enterprise and Standard editions: Must be an integer from 20 to 16384.  +  Web and Express editions: Must be an integer from 20 to 16384.    +  Provisioned IOPS storage (io1):  +  Enterprise and Standard editions: Must be an integer from 20 to 16384.  +  Web and Express editions: Must be an integer from 20 to 16384.    +  Magnetic storage (standard):  +  Enterprise and Standard editions: Must be an integer from 20 to 1024.  +  Web and Express editions: Must be an integer from 20 to 1024.")
  allocatedStorage?: string;

  @doc("A value that indicates whether major version upgrades are allowed. Changing this parameter doesn't result in an outage and the change is asynchronously applied as soon as possible. Constraints: Major version upgrades must be allowed when specifying a value for the ``EngineVersion`` parameter that is a different major version than the DB instance's current version.")
  allowMajorVersionUpgrade?: boolean;

  @doc("The IAMlong (IAM) roles associated with the DB instance.   *Amazon Aurora*  Not applicable. The associated roles are managed by the DB cluster.")
  @extension("x-ms-identifiers", [])
  associatedRoles?: DBInstanceRole[];

  @doc("A value that indicates whether minor engine upgrades are applied automatically to the DB instance during the maintenance window. By default, minor engine upgrades are applied automatically.")
  autoMinorVersionUpgrade?: boolean;

  @doc("Property automaticBackupReplicationKmsKeyId")
  automaticBackupReplicationKmsKeyId?: string;

  @doc("The destination region for the backup replication of the DB instance. For more info, see [Replicating automated backups to another Region](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReplicateBackups.html) in the *Amazon RDS User Guide*.")
  automaticBackupReplicationRegion?: string;

  @doc("The Availability Zone (AZ) where the database will be created. For information on AWS-Regions and Availability Zones, see [Regions and Availability Zones](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html). For Amazon Aurora, each Aurora DB cluster hosts copies of its storage in three separate Availability Zones. Specify one of these Availability Zones. Aurora automatically chooses an appropriate Availability Zone if you don't specify one. Default: A random, system-chosen Availability Zone in the endpoint's AWS-Region. Constraints:  +  The ``AvailabilityZone`` parameter can't be specified if the DB instance is a Multi-AZ deployment.  +  The specified Availability Zone must be in the same AWS-Region as the current endpoint.   Example: ``us-east-1d``")
  availabilityZone?: string;

  @doc("The number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups.  *Amazon Aurora*  Not applicable. The retention period for automated backups is managed by the DB cluster. Default: 1 Constraints:  +  Must be a value from 0 to 35  +  Can't be set to 0 if the DB instance is a source to read replicas")
  backupRetentionPeriod?: int32 = 1;

  @doc("The identifier of the CA certificate for this DB instance. For more information, see [Using SSL/TLS to encrypt a connection to a DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.")
  caCertificateIdentifier?: string;

  @doc("The details of the DB instance's server certificate. Returns the details of the DB instance’s server certificate. For more information, see [Using SSL/TLS to encrypt a connection to a DB instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.")
  certificateDetails?: CertificateDetails;

  @doc("Specifies whether the DB instance is restarted when you rotate your SSL/TLS certificate. By default, the DB instance is restarted when you rotate your SSL/TLS certificate. The certificate is not updated until the DB instance is restarted.  Set this parameter only if you are *not* using SSL/TLS to connect to the DB instance.  If you are using SSL/TLS to connect to the DB instance, follow the appropriate instructions for your DB engine to rotate your SSL/TLS certificate:  +  For more information about rotating your SSL/TLS certificate for RDS DB engines, see [Rotating Your SSL/TLS Certificate.](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL-certificate-rotation.html) in the *Amazon RDS User Guide.*   +  For more information about rotating your SSL/TLS certificate for Aurora DB engines, see [Rotating Your SSL/TLS Certificate](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL-certificate-rotation.html) in the *Amazon Aurora User Guide*.   This setting doesn't apply to RDS Custom DB instances.")
  certificateRotationRestart?: boolean;

  @doc("For supported engines, indicates that the DB instance should be associated with the specified character set.  *Amazon Aurora*  Not applicable. The character set is managed by the DB cluster. For more information, see [AWS::RDS::DBCluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbcluster.html).")
  characterSetName?: string;

  @doc("Specifies whether to copy tags from the DB instance to snapshots of the DB instance. By default, tags are not copied. This setting doesn't apply to Amazon Aurora DB instances. Copying tags to snapshots is managed by the DB cluster. Setting this value for an Aurora DB instance has no effect on the DB cluster setting.")
  copyTagsToSnapshot?: boolean;

  @doc("The instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance. This setting is required for RDS Custom. Constraints:  +  The profile must exist in your account.  +  The profile must have an IAM role that Amazon EC2 has permissions to assume.  +  The instance profile name and the associated IAM role name must start with the prefix ``AWSRDSCustom``.   For the list of permissions required for the IAM role, see [Configure IAM and your VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-setup-orcl.html#custom-setup-orcl.iam-vpc) in the *Amazon RDS User Guide*.")
  customIAMInstanceProfile?: string;

  @doc("The identifier of the DB cluster that the instance will belong to.")
  dbClusterIdentifier?: string;

  @doc("The identifier for the Multi-AZ DB cluster snapshot to restore from. For more information on Multi-AZ DB clusters, see [Multi-AZ DB cluster deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*. Constraints:  +  Must match the identifier of an existing Multi-AZ DB cluster snapshot.  +  Can't be specified when ``DBSnapshotIdentifier`` is specified.  +  Must be specified when ``DBSnapshotIdentifier`` isn't specified.  +  If you are restoring from a shared manual Multi-AZ DB cluster snapshot, the ``DBClusterSnapshotIdentifier`` must be the ARN of the shared snapshot.  +  Can't be the identifier of an Aurora DB cluster snapshot.")
  dbClusterSnapshotIdentifier?: string;

  @doc("Property dbInstanceArn")
  dbInstanceArn?: string;

  @doc("The compute and memory capacity of the DB instance, for example ``db.m5.large``. Not all DB instance classes are available in all AWS-Regions, or for all database engines. For the full list of DB instance classes, and availability for your engine, see [DB instance classes](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the *Amazon RDS User Guide* or [Aurora DB instance classes](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.DBInstanceClass.html) in the *Amazon Aurora User Guide*.")
  dbInstanceClass?: string;

  @doc("A name for the DB instance. If you specify a name, AWS CloudFormation converts it to lowercase. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the DB instance. For more information, see [Name Type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-name.html). For information about constraints that apply to DB instance identifiers, see [Naming constraints in Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html#RDS_Limits.Constraints) in the *Amazon RDS User Guide*.  If you specify a name, you can't perform updates that require replacement of this resource. You can perform updates that require no or some interruption. If you must replace the resource, specify a new name.")
  dbInstanceIdentifier?: string;

  @doc("The meaning of this parameter differs according to the database engine you use.  If you specify the ``DBSnapshotIdentifier`` property, this property only applies to RDS for Oracle.   *Amazon Aurora*  Not applicable. The database name is managed by the DB cluster.  *Db2*  The name of the database to create when the DB instance is created. If this parameter isn't specified, no database is created in the DB instance. Constraints:  +  Must contain 1 to 64 letters or numbers.  +  Must begin with a letter. Subsequent characters can be letters, underscores, or digits (0-9).  +  Can't be a word reserved by the specified database engine.    *MySQL*  The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Constraints:  +  Must contain 1 to 64 letters or numbers.  +  Can't be a word reserved by the specified database engine    *MariaDB*  The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Constraints:  +  Must contain 1 to 64 letters or numbers.  +  Can't be a word reserved by the specified database engine    *PostgreSQL*  The name of the database to create when the DB instance is created. If this parameter is not specified, the default ``postgres`` database is created in the DB instance. Constraints:  +  Must begin with a letter. Subsequent characters can be letters, underscores, or digits (0-9).  +  Must contain 1 to 63 characters.  +  Can't be a word reserved by the specified database engine    *Oracle*  The Oracle System ID (SID) of the created DB instance. If you specify ``null``, the default value ``ORCL`` is used. You can't specify the string NULL, or any other reserved word, for ``DBName``.  Default: ``ORCL``  Constraints:  +  Can't be longer than 8 characters    *SQL Server*  Not applicable. Must be null.")
  dbName?: string;

  @doc("The name of an existing DB parameter group or a reference to an [AWS::RDS::DBParameterGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-dbparametergroup.html) resource created in the template. To list all of the available DB parameter group names, use the following command:  ``aws rds describe-db-parameter-groups --query 'DBParameterGroups[].DBParameterGroupName' --output text``   If any of the data members of the referenced parameter group are changed during an update, the DB instance might need to be restarted, which causes some interruption. If the parameter group contains static parameters, whether they were changed or not, an update triggers a reboot.  If you don't specify a value for ``DBParameterGroupName`` property, the default DB parameter group for the specified engine and engine version is used.")
  dbParameterGroupName?: string;

  @doc("A list of the DB security groups to assign to the DB instance. The list can include both the name of existing DB security groups or references to AWS::RDS::DBSecurityGroup resources created in the template.  If you set DBSecurityGroups, you must not set VPCSecurityGroups, and vice versa. Also, note that the DBSecurityGroups property exists only for backwards compatibility with older regions and is no longer recommended for providing security information to an RDS DB instance. Instead, use VPCSecurityGroups.  If you specify this property, AWS CloudFormation sends only the following properties (if specified) to Amazon RDS during create operations:  +   ``AllocatedStorage``   +   ``AutoMinorVersionUpgrade``   +   ``AvailabilityZone``   +   ``BackupRetentionPeriod``   +   ``CharacterSetName``   +   ``DBInstanceClass``   +   ``DBName``   +   ``DBParameterGroupName``   +   ``DBSecurityGroups``   +   ``DBSubnetGroupName``   +   ``Engine``   +   ``EngineVersion``   +   ``Iops``   +   ``LicenseModel``   +   ``MasterUsername``   +   ``MasterUserPassword``   +   ``MultiAZ``   +   ``OptionGroupName``   +   ``PreferredBackupWindow``   +   ``PreferredMaintenanceWindow``    All other properties are ignored. Specify a virtual private cloud (VPC) security group if you want to submit other properties, such as ``StorageType``, ``StorageEncrypted``, or ``KmsKeyId``. If you're already using the ``DBSecurityGroups`` property, you can't use these other properties by updating your DB instance to use a VPC security group. You must recreate the DB instance.")
  @extension("x-ms-identifiers", [])
  dbSecurityGroups?: string[];

  @doc("The name or Amazon Resource Name (ARN) of the DB snapshot that's used to restore the DB instance. If you're restoring from a shared manual DB snapshot, you must specify the ARN of the snapshot. By specifying this property, you can create a DB instance from the specified DB snapshot. If the ``DBSnapshotIdentifier`` property is an empty string or the ``AWS::RDS::DBInstance`` declaration has no ``DBSnapshotIdentifier`` property, AWS CloudFormation creates a new database. If the property contains a value (other than an empty string), AWS CloudFormation creates a database from the specified snapshot. If a snapshot with the specified name doesn't exist, AWS CloudFormation can't create the database and it rolls back the stack. Some DB instance properties aren't valid when you restore from a snapshot, such as the ``MasterUsername`` and ``MasterUserPassword`` properties. For information about the properties that you can specify, see the ``RestoreDBInstanceFromDBSnapshot`` action in the *Amazon RDS API Reference*. After you restore a DB instance with a ``DBSnapshotIdentifier`` property, you must specify the same ``DBSnapshotIdentifier`` property for any future updates to the DB instance. When you specify this property for an update, the DB instance is not restored from the DB snapshot again, and the data in the database is not changed. However, if you don't specify the ``DBSnapshotIdentifier`` property, an empty DB instance is created, and the original DB instance is deleted. If you specify a property that is different from the previous snapshot restore property, a new DB instance is restored from the specified ``DBSnapshotIdentifier`` property, and the original DB instance is deleted. If you specify the ``DBSnapshotIdentifier`` property to restore a DB instance (as opposed to specifying it for DB instance updates), then don't specify the following properties:  +   ``CharacterSetName``   +   ``DBClusterIdentifier``   +   ``DBName``   +   ``DeleteAutomatedBackups``   +   ``EnablePerformanceInsights``   +   ``KmsKeyId``   +   ``MasterUsername``   +   ``MasterUserPassword``   +   ``PerformanceInsightsKMSKeyId``   +   ``PerformanceInsightsRetentionPeriod``   +   ``PromotionTier``   +   ``SourceDBInstanceIdentifier``   +   ``SourceRegion``   +   ``StorageEncrypted`` (for an encrypted snapshot)  +   ``Timezone``     *Amazon Aurora*  Not applicable. Snapshot restore is managed by the DB cluster.")
  dbSnapshotIdentifier?: string;

  @doc("A DB subnet group to associate with the DB instance. If you update this value, the new subnet group must be a subnet group in a new VPC.  If there's no DB subnet group, then the DB instance isn't a VPC DB instance. For more information about using Amazon RDS in a VPC, see [Using Amazon RDS with Amazon Virtual Private Cloud (VPC)](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.html) in the *Amazon RDS User Guide*.   *Amazon Aurora*  Not applicable. The DB subnet group is managed by the DB cluster. If specified, the setting must match the DB cluster setting.")
  dbSubnetGroupName?: string;

  @doc("The Oracle system identifier (SID), which is the name of the Oracle database instance that manages your database files. In this context, the term 'Oracle database instance' refers exclusively to the system global area (SGA) and Oracle background processes. If you don't specify a SID, the value defaults to ``RDSCDB``. The Oracle SID is also the name of your CDB.")
  dbSystemId?: string;

  @doc("Property dbiResourceId")
  dbiResourceId?: string;

  @doc("Indicates whether the DB instance has a dedicated log volume (DLV) enabled.")
  dedicatedLogVolume?: boolean;

  @doc("A value that indicates whether to remove automated backups immediately after the DB instance is deleted. This parameter isn't case-sensitive. The default is to remove automated backups immediately after the DB instance is deleted.  *Amazon Aurora*  Not applicable. When you delete a DB cluster, all automated backups for that DB cluster are deleted and can't be recovered. Manual DB cluster snapshots of the DB cluster are not deleted.")
  deleteAutomatedBackups?: boolean;

  @doc("A value that indicates whether the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. For more information, see [Deleting a DB Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html).   *Amazon Aurora*  Not applicable. You can enable or disable deletion protection for the DB cluster. For more information, see ``CreateDBCluster``. DB instances in a DB cluster can be deleted even when deletion protection is enabled for the DB cluster.")
  deletionProtection?: boolean;

  @doc("The Active Directory directory ID to create the DB instance in. Currently, only Db2, MySQL, Microsoft SQL Server, Oracle, and PostgreSQL DB instances can be created in an Active Directory Domain. For more information, see [Kerberos Authentication](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/kerberos-authentication.html) in the *Amazon RDS User Guide*.")
  domain?: string;

  @doc("The ARN for the Secrets Manager secret with the credentials for the user joining the domain. Example: ``arn:aws:secretsmanager:region:account-number:secret:myselfmanagedADtestsecret-123456``")
  domainAuthSecretArn?: string;

  @doc("The IPv4 DNS IP addresses of your primary and secondary Active Directory domain controllers. Constraints:  +  Two IP addresses must be provided. If there isn't a secondary domain controller, use the IP address of the primary domain controller for both entries in the list.   Example: ``123.124.125.126,234.235.236.237``")
  @extension("x-ms-identifiers", [])
  domainDnsIps?: string[];

  @doc("The fully qualified domain name (FQDN) of an Active Directory domain. Constraints:  +  Can't be longer than 64 characters.   Example: ``mymanagedADtest.mymanagedAD.mydomain``")
  domainFqdn?: string;

  @doc("The name of the IAM role to use when making API calls to the Directory Service. This setting doesn't apply to the following DB instances:  +  Amazon Aurora (The domain is managed by the DB cluster.)  +  RDS Custom")
  domainIAMRoleName?: string;

  @doc("The Active Directory organizational unit for your DB instance to join. Constraints:  +  Must be in the distinguished name format.  +  Can't be longer than 64 characters.   Example: ``OU=mymanagedADtestOU,DC=mymanagedADtest,DC=mymanagedAD,DC=mydomain``")
  domainOu?: string;

  @doc("The list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see [Publishing Database Logs to Amazon CloudWatch Logs](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the *Amazon Relational Database Service User Guide*.  *Amazon Aurora*  Not applicable. CloudWatch Logs exports are managed by the DB cluster.   *Db2*  Valid values: ``diag.log``, ``notify.log``   *MariaDB*  Valid values: ``audit``, ``error``, ``general``, ``slowquery``   *Microsoft SQL Server*  Valid values: ``agent``, ``error``   *MySQL*  Valid values: ``audit``, ``error``, ``general``, ``slowquery``   *Oracle*  Valid values: ``alert``, ``audit``, ``listener``, ``trace``, ``oemagent``   *PostgreSQL*  Valid values: ``postgresql``, ``upgrade``")
  @extension("x-ms-identifiers", [])
  enableCloudwatchLogsExports?: string[];

  @doc("A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled. This property is supported for RDS for MariaDB, RDS for MySQL, and RDS for PostgreSQL. For more information, see [IAM Database Authentication for MariaDB, MySQL, and PostgreSQL](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html) in the *Amazon RDS User Guide.*   *Amazon Aurora*  Not applicable. Mapping AWS IAM accounts to database accounts is managed by the DB cluster.")
  enableIAMDatabaseAuthentication?: boolean;

  @doc("Specifies whether to enable Performance Insights for the DB instance. For more information, see [Using Amazon Performance Insights](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html) in the *Amazon RDS User Guide*. This setting doesn't apply to RDS Custom DB instances.")
  enablePerformanceInsights?: boolean;

  @doc("The connection endpoint for the DB instance.  The endpoint might not be shown for instances with the status of ``creating``. This data type represents the information you need to connect to an Amazon RDS DB instance. This data type is used as a response element in the following actions:  +   ``CreateDBInstance``   +   ``DescribeDBInstances``   +   ``DeleteDBInstance``    For the data structure that represents Amazon Aurora DB cluster endpoints, see ``DBClusterEndpoint``.")
  endpoint?: Endpoint;

  @doc("The name of the database engine to use for this DB instance. Not every database engine is available in every AWS Region. This property is required when creating a DB instance.  You can change the architecture of an Oracle database from the non-container database (CDB) architecture to the CDB architecture by updating the ``Engine`` value in your templates from ``oracle-ee`` or ``oracle-ee-cdb`` to ``oracle-se2-cdb``. Converting to the CDB architecture requires an interruption.  Valid Values:  +   ``aurora-mysql`` (for Aurora MySQL DB instances)  +   ``aurora-postgresql`` (for Aurora PostgreSQL DB instances)  +   ``custom-oracle-ee`` (for RDS Custom for Oracle DB instances)  +   ``custom-oracle-ee-cdb`` (for RDS Custom for Oracle DB instances)  +   ``custom-sqlserver-ee`` (for RDS Custom for SQL Server DB instances)  +   ``custom-sqlserver-se`` (for RDS Custom for SQL Server DB instances)  +   ``custom-sqlserver-web`` (for RDS Custom for SQL Server DB instances)  +   ``db2-ae``   +   ``db2-se``   +   ``mariadb``   +   ``mysql``   +   ``oracle-ee``   +   ``oracle-ee-cdb``   +   ``oracle-se2``   +   ``oracle-se2-cdb``   +   ``postgres``   +   ``sqlserver-ee``   +   ``sqlserver-se``   +   ``sqlserver-ex``   +   ``sqlserver-web``")
  engine?: string;

  @doc("The version number of the database engine to use. For a list of valid engine versions, use the ``DescribeDBEngineVersions`` action. The following are the database engines and links to information about the major and minor versions that are available with Amazon RDS. Not every database engine is available for every AWS Region.  *Amazon Aurora*  Not applicable. The version number of the database engine to be used by the DB instance is managed by the DB cluster.  *Db2*  See [Amazon RDS for Db2](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Db2.html#Db2.Concepts.VersionMgmt) in the *Amazon RDS User Guide.*   *MariaDB*  See [MariaDB on Amazon RDS Versions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MariaDB.html#MariaDB.Concepts.VersionMgmt) in the *Amazon RDS User Guide.*   *Microsoft SQL Server*  See [Microsoft SQL Server Versions on Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.VersionSupport) in the *Amazon RDS User Guide.*   *MySQL*  See [MySQL on Amazon RDS Versions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt) in the *Amazon RDS User Guide.*   *Oracle*  See [Oracle Database Engine Release Notes](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.Oracle.PatchComposition.html) in the *Amazon RDS User Guide.*   *PostgreSQL*  See [Supported PostgreSQL Database Versions](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts.General.DBVersions) in the *Amazon RDS User Guide.*")
  engineVersion?: string;

  @doc("The number of I/O operations per second (IOPS) that the database provisions. The value must be equal to or greater than 1000.  If you specify this property, you must follow the range of allowed ratios of your requested IOPS rate to the amount of storage that you allocate (IOPS to allocated storage). For example, you can provision an Oracle database instance with 1000 IOPS and 200 GiB of storage (a ratio of 5:1), or specify 2000 IOPS with 200 GiB of storage (a ratio of 10:1). For more information, see [Amazon RDS Provisioned IOPS Storage to Improve Performance](https://docs.aws.amazon.com/AmazonRDS/latest/DeveloperGuide/CHAP_Storage.html#USER_PIOPS) in the *Amazon RDS User Guide*.  If you specify ``io1`` for the ``StorageType`` property, then you must also specify the ``Iops`` property.  Constraints:  +  For RDS for Db2, MariaDB, MySQL, Oracle, and PostgreSQL - Must be a multiple between .5 and 50 of the storage amount for the DB instance.  +  For RDS for SQL Server - Must be a multiple between 1 and 50 of the storage amount for the DB instance.")
  iops?: int32;

  @doc("The ARN of the AWS KMS key that's used to encrypt the DB instance, such as ``arn:aws:kms:us-east-1:012345678910:key/abcd1234-a123-456a-a12b-a123b4cd56ef``. If you enable the StorageEncrypted property but don't specify this property, AWS CloudFormation uses the default KMS key. If you specify this property, you must set the StorageEncrypted property to true.  If you specify the ``SourceDBInstanceIdentifier`` property, the value is inherited from the source DB instance if the read replica is created in the same region. If you create an encrypted read replica in a different AWS Region, then you must specify a KMS key for the destination AWS Region. KMS encryption keys are specific to the region that they're created in, and you can't use encryption keys from one region in another region. If you specify the ``SnapshotIdentifier`` property, the ``StorageEncrypted`` property value is inherited from the snapshot, and if the DB instance is encrypted, the specified ``KmsKeyId`` property is used. If you specify ``DBSecurityGroups``, AWS CloudFormation ignores this property. To specify both a security group and this property, you must use a VPC security group. For more information about Amazon RDS and VPC, see [Using Amazon RDS with Amazon VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.html) in the *Amazon RDS User Guide*.  *Amazon Aurora*  Not applicable. The KMS key identifier is managed by the DB cluster.")
  kmsKeyId?: string;

  @doc("License model information for this DB instance.  Valid Values:  +  Aurora MySQL - ``general-public-license``   +  Aurora PostgreSQL - ``postgresql-license``   +  RDS for Db2 - ``bring-your-own-license``. For more information about RDS for Db2 licensing, see [](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/db2-licensing.html) in the *Amazon RDS User Guide.*   +  RDS for MariaDB - ``general-public-license``   +  RDS for Microsoft SQL Server - ``license-included``   +  RDS for MySQL - ``general-public-license``   +  RDS for Oracle - ``bring-your-own-license`` or ``license-included``   +  RDS for PostgreSQL - ``postgresql-license``     If you've specified ``DBSecurityGroups`` and then you update the license model, AWS CloudFormation replaces the underlying DB instance. This will incur some interruptions to database availability.")
  licenseModel?: string;

  @doc("Specifies whether to manage the master user password with AWS Secrets Manager. For more information, see [Password management with Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide.*  Constraints:  +  Can't manage the master user password with AWS Secrets Manager if ``MasterUserPassword`` is specified.")
  manageMasterUserPassword?: boolean;

  @doc("The password for the master user. The password can include any printable ASCII character except '/', ''', or '@'.  *Amazon Aurora*  Not applicable. The password for the master user is managed by the DB cluster.  *RDS for Db2*  Must contain from 8 to 255 characters.  *RDS for MariaDB*  Constraints: Must contain from 8 to 41 characters.  *RDS for Microsoft SQL Server*  Constraints: Must contain from 8 to 128 characters.  *RDS for MySQL*  Constraints: Must contain from 8 to 41 characters.  *RDS for Oracle*  Constraints: Must contain from 8 to 30 characters.  *RDS for PostgreSQL*  Constraints: Must contain from 8 to 128 characters.")
  masterUserPassword?: string;

  @doc("The secret managed by RDS in AWS Secrets Manager for the master user password. For more information, see [Password management with Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide.* The ``MasterUserSecret`` return value specifies the secret managed by RDS in AWS Secrets Manager for the master user password. For more information, see [Password management with Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide* and [Password management with Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/rds-secrets-manager.html) in the *Amazon Aurora User Guide.*")
  masterUserSecret?: MasterUserSecret;

  @doc("The master user name for the DB instance.  If you specify the ``SourceDBInstanceIdentifier`` or ``DBSnapshotIdentifier`` property, don't specify this property. The value is inherited from the source DB instance or snapshot. When migrating a self-managed Db2 database, we recommend that you use the same master username as your self-managed Db2 instance name.   *Amazon Aurora*  Not applicable. The name for the master user is managed by the DB cluster.   *RDS for Db2*  Constraints:  +  Must be 1 to 16 letters or numbers.  +  First character must be a letter.  +  Can't be a reserved word for the chosen database engine.    *RDS for MariaDB*  Constraints:   +  Must be 1 to 16 letters or numbers.  +  Can't be a reserved word for the chosen database engine.    *RDS for Microsoft SQL Server*  Constraints:   +  Must be 1 to 128 letters or numbers.  +  First character must be a letter.  +  Can't be a reserved word for the chosen database engine.    *RDS for MySQL*  Constraints:   +  Must be 1 to 16 letters or numbers.  +  First character must be a letter.  +  Can't be a reserved word for the chosen database engine.    *RDS for Oracle*  Constraints:   +  Must be 1 to 30 letters or numbers.  +  First character must be a letter.  +  Can't be a reserved word for the chosen database engine.    *RDS for PostgreSQL*  Constraints:   +  Must be 1 to 63 letters or numbers.  +  First character must be a letter.  +  Can't be a reserved word for the chosen database engine.")
  masterUsername?: string;

  @doc("The upper limit in gibibytes (GiB) to which Amazon RDS can automatically scale the storage of the DB instance. For more information about this setting, including limitations that apply to it, see [Managing capacity automatically with Amazon RDS storage autoscaling](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PIOPS.StorageTypes.html#USER_PIOPS.Autoscaling) in the *Amazon RDS User Guide*. This setting doesn't apply to the following DB instances:  +  Amazon Aurora (Storage is managed by the DB cluster.)  +  RDS Custom")
  maxAllocatedStorage?: int32;

  @doc("The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collection of Enhanced Monitoring metrics, specify 0. The default is 0. If ``MonitoringRoleArn`` is specified, then you must set ``MonitoringInterval`` to a value other than 0. This setting doesn't apply to RDS Custom. Valid Values: ``0, 1, 5, 10, 15, 30, 60``")
  monitoringInterval?: int32;

  @doc("The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to Amazon CloudWatch Logs. For example, ``arn:aws:iam:123456789012:role/emaccess``. For information on creating a monitoring role, see [Setting Up and Enabling Enhanced Monitoring](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html#USER_Monitoring.OS.Enabling) in the *Amazon RDS User Guide*. If ``MonitoringInterval`` is set to a value other than ``0``, then you must supply a ``MonitoringRoleArn`` value. This setting doesn't apply to RDS Custom DB instances.")
  monitoringRoleArn?: string;

  @doc("Specifies whether the database instance is a Multi-AZ DB instance deployment. You can't set the ``AvailabilityZone`` parameter if the ``MultiAZ`` parameter is set to true.   For more information, see [Multi-AZ deployments for high availability](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html) in the *Amazon RDS User Guide*.  *Amazon Aurora*  Not applicable. Amazon Aurora storage is replicated across all of the Availability Zones and doesn't require the ``MultiAZ`` option to be set.")
  multiAZ?: boolean;

  @doc("The name of the NCHAR character set for the Oracle DB instance. This setting doesn't apply to RDS Custom DB instances.")
  ncharCharacterSetName?: string;

  @doc("The network type of the DB instance. Valid values:  +   ``IPV4``   +   ``DUAL``    The network type is determined by the ``DBSubnetGroup`` specified for the DB instance. A ``DBSubnetGroup`` can support only the IPv4 protocol or the IPv4 and IPv6 protocols (``DUAL``). For more information, see [Working with a DB instance in a VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon RDS User Guide.*")
  networkType?: string;

  @doc("Indicates that the DB instance should be associated with the specified option group. Permanent options, such as the TDE option for Oracle Advanced Security TDE, can't be removed from an option group. Also, that option group can't be removed from a DB instance once it is associated with a DB instance.")
  optionGroupName?: string;

  @doc("The AWS KMS key identifier for encryption of Performance Insights data. The KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key. If you do not specify a value for ``PerformanceInsightsKMSKeyId``, then Amazon RDS uses your default KMS key. There is a default KMS key for your AWS account. Your AWS account has a different default KMS key for each AWS Region. For information about enabling Performance Insights, see [EnablePerformanceInsights](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-database-instance.html#cfn-rds-dbinstance-enableperformanceinsights).")
  performanceInsightsKMSKeyId?: string;

  @doc("The number of days to retain Performance Insights data. This setting doesn't apply to RDS Custom DB instances. Valid Values:  +   ``7``   +   *month* * 31, where *month* is a number of months from 1-23. Examples: ``93`` (3 months * 31), ``341`` (11 months * 31), ``589`` (19 months * 31)  +   ``731``    Default: ``7`` days If you specify a retention period that isn't valid, such as ``94``, Amazon RDS returns an error.")
  performanceInsightsRetentionPeriod?: int32;

  @doc("The port number on which the database accepts connections.  *Amazon Aurora*  Not applicable. The port number is managed by the DB cluster.  *Db2*  Default value: ``50000``")
  port?: string;

  @doc("The daily time range during which automated backups are created if automated backups are enabled, using the ``BackupRetentionPeriod`` parameter. For more information, see [Backup Window](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow) in the *Amazon RDS User Guide.*  Constraints:  +  Must be in the format ``hh24:mi-hh24:mi``.  +  Must be in Universal Coordinated Time (UTC).  +  Must not conflict with the preferred maintenance window.  +  Must be at least 30 minutes.    *Amazon Aurora*  Not applicable. The daily time range for creating automated backups is managed by the DB cluster.")
  preferredBackupWindow?: string;

  @doc("The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC). Format: ``ddd:hh24:mi-ddd:hh24:mi``  The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region, occurring on a random day of the week. To see the time blocks available, see [Adjusting the Preferred DB Instance Maintenance Window](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow) in the *Amazon RDS User Guide.*   This property applies when AWS CloudFormation initially creates the DB instance. If you use AWS CloudFormation to update the DB instance, those updates are applied immediately.  Constraints: Minimum 30-minute window.")
  preferredMaintenanceWindow?: string;

  @doc("The number of CPU cores and the number of threads per core for the DB instance class of the DB instance. This setting doesn't apply to Amazon Aurora or RDS Custom DB instances.")
  @extension("x-ms-identifiers", [])
  processorFeatures?: ProcessorFeature[];

  @doc("The order of priority in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance. For more information, see [Fault Tolerance for an Aurora DB Cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.AuroraHighAvailability.html#Aurora.Managing.FaultTolerance) in the *Amazon Aurora User Guide*. This setting doesn't apply to RDS Custom DB instances. Default: ``1``  Valid Values: ``0 - 15``")
  promotionTier?: int32 = 1;

  @doc("Indicates whether the DB instance is an internet-facing instance. If you specify true, AWS CloudFormation creates an instance with a publicly resolvable DNS name, which resolves to a public IP address. If you specify false, AWS CloudFormation creates an internal instance with a DNS name that resolves to a private IP address.  The default behavior value depends on your VPC setup and the database subnet group. For more information, see the ``PubliclyAccessible`` parameter in the [CreateDBInstance](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html) in the *Amazon RDS API Reference*.")
  publiclyAccessible?: boolean;

  @doc("The open mode of an Oracle read replica. For more information, see [Working with Oracle Read Replicas for Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-read-replicas.html) in the *Amazon RDS User Guide*. This setting is only supported in RDS for Oracle. Default: ``open-read-only``  Valid Values: ``open-read-only`` or ``mounted``")
  replicaMode?: string;

  @doc("The date and time to restore from. Constraints:  +  Must be a time in Universal Coordinated Time (UTC) format.  +  Must be before the latest restorable time for the DB instance.  +  Can't be specified if the ``UseLatestRestorableTime`` parameter is enabled.   Example: ``2009-09-07T23:45:00Z``")
  restoreTime?: string;

  @doc("The identifier of the Multi-AZ DB cluster that will act as the source for the read replica. Each DB cluster can have up to 15 read replicas. Constraints:  +  Must be the identifier of an existing Multi-AZ DB cluster.  +  Can't be specified if the ``SourceDBInstanceIdentifier`` parameter is also specified.  +  The specified DB cluster must have automatic backups enabled, that is, its backup retention period must be greater than 0.  +  The source DB cluster must be in the same AWS-Region as the read replica. Cross-Region replication isn't supported.")
  sourceDBClusterIdentifier?: string;

  @doc("The Amazon Resource Name (ARN) of the replicated automated backups from which to restore, for example, ``arn:aws:rds:us-east-1:123456789012:auto-backup:ab-L2IJCEXJP7XQ7HOJ4SIEXAMPLE``. This setting doesn't apply to RDS Custom.")
  sourceDBInstanceAutomatedBackupsArn?: string;

  @doc("If you want to create a read replica DB instance, specify the ID of the source DB instance. Each DB instance can have a limited number of read replicas. For more information, see [Working with Read Replicas](https://docs.aws.amazon.com/AmazonRDS/latest/DeveloperGuide/USER_ReadRepl.html) in the *Amazon RDS User Guide*. For information about constraints that apply to DB instance identifiers, see [Naming constraints in Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html#RDS_Limits.Constraints) in the *Amazon RDS User Guide*. The ``SourceDBInstanceIdentifier`` property determines whether a DB instance is a read replica. If you remove the ``SourceDBInstanceIdentifier`` property from your template and then update your stack, AWS CloudFormation promotes the Read Replica to a standalone DB instance.   +  If you specify a source DB instance that uses VPC security groups, we recommend that you specify the ``VPCSecurityGroups`` property. If you don't specify the property, the read replica inherits the value of the ``VPCSecurityGroups`` property from the source DB when you create the replica. However, if you update the stack, AWS CloudFormation reverts the replica's ``VPCSecurityGroups`` property to the default value because it's not defined in the stack's template. This change might cause unexpected issues.  +  Read replicas don't support deletion policies. AWS CloudFormation ignores any deletion policy that's associated with a read replica.  +  If you specify ``SourceDBInstanceIdentifier``, don't specify the ``DBSnapshotIdentifier`` property. You can't create a read replica from a snapshot.  +  Don't set the ``BackupRetentionPeriod``, ``DBName``, ``MasterUsername``, ``MasterUserPassword``, and ``PreferredBackupWindow`` properties. The database attributes are inherited from the source DB instance, and backups are disabled for read replicas.  +  If the source DB instance is in a different region than the read replica, specify the source region in ``SourceRegion``, and specify an ARN for a valid DB instance in ``SourceDBInstanceIdentifier``. For more information, see [Constructing a Amazon RDS Amazon Resource Name (ARN)](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html#USER_Tagging.ARN) in the *Amazon RDS User Guide*.  +  For DB instances in Amazon Aurora clusters, don't specify this property. Amazon RDS automatically assigns writer and reader DB instances.")
  sourceDBInstanceIdentifier?: string;

  @doc("The resource ID of the source DB instance from which to restore.")
  sourceDbiResourceId?: string;

  @doc("The ID of the region that contains the source DB instance for the read replica.")
  sourceRegion?: string;

  @doc("A value that indicates whether the DB instance is encrypted. By default, it isn't encrypted. If you specify the ``KmsKeyId`` property, then you must enable encryption. If you specify the ``SourceDBInstanceIdentifier`` property, don't specify this property. The value is inherited from the source DB instance, and if the DB instance is encrypted, the specified ``KmsKeyId`` property is used. If you specify the ``DBSnapshotIdentifier`` and the specified snapshot is encrypted, don't specify this property. The value is inherited from the snapshot, and the specified ``KmsKeyId`` property is used. If you specify the ``DBSnapshotIdentifier`` and the specified snapshot isn't encrypted, you can use this property to specify that the restored DB instance is encrypted. Specify the ``KmsKeyId`` property for the KMS key to use for encryption. If you don't want the restored DB instance to be encrypted, then don't set this property or set it to ``false``.  *Amazon Aurora*  Not applicable. The encryption for DB instances is managed by the DB cluster.")
  storageEncrypted?: boolean;

  @doc("Specifies the storage throughput value for the DB instance. This setting applies only to the ``gp3`` storage type.  This setting doesn't apply to RDS Custom or Amazon Aurora.")
  storageThroughput?: int32;

  @doc("The storage type to associate with the DB instance. If you specify ``io1``, ``io2``, or ``gp3``, you must also include a value for the ``Iops`` parameter. This setting doesn't apply to Amazon Aurora DB instances. Storage is managed by the DB cluster. Valid Values: ``gp2 | gp3 | io1 | io2 | standard``  Default: ``io1``, if the ``Iops`` parameter is specified. Otherwise, ``gp2``.")
  storageType?: string;

  @doc("An optional array of key-value pairs to apply to this DB instance.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property tdeCredentialArn")
  tdeCredentialArn?: string;

  @doc("Property tdeCredentialPassword")
  tdeCredentialPassword?: string;

  @doc("The time zone of the DB instance. The time zone parameter is currently supported only by [Microsoft SQL Server](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.TimeZone).")
  timezone?: string;

  @doc("Specifies whether the DB instance class of the DB instance uses its default processor features. This setting doesn't apply to RDS Custom DB instances.")
  useDefaultProcessorFeatures?: boolean;

  @doc("Specifies whether the DB instance is restored from the latest backup time. By default, the DB instance isn't restored from the latest backup time. Constraints:  +  Can't be specified if the ``RestoreTime`` parameter is provided.")
  useLatestRestorableTime?: boolean;

  @doc("A list of the VPC security group IDs to assign to the DB instance. The list can include both the physical IDs of existing VPC security groups and references to [AWS::EC2::SecurityGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group.html) resources created in the template. If you plan to update the resource, don't specify VPC security groups in a shared VPC.  If you set ``VPCSecurityGroups``, you must not set [DBSecurityGroups](https://docs.aws.amazon.com//AWSCloudFormation/latest/UserGuide/aws-properties-rds-database-instance.html#cfn-rds-dbinstance-dbsecuritygroups), and vice versa.  You can migrate a DB instance in your stack from an RDS DB security group to a VPC security group, but keep the following in mind:  +  You can't revert to using an RDS security group after you establish a VPC security group membership.  +  When you migrate your DB instance to VPC security groups, if your stack update rolls back because the DB instance update fails or because an update fails in another AWS CloudFormation resource, the rollback fails because it can't revert to an RDS security group.  +  To use the properties that are available when you use a VPC security group, you must recreate the DB instance. If you don't, AWS CloudFormation submits only the property values that are listed in the [DBSecurityGroups](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-database-instance.html#cfn-rds-dbinstance-dbsecuritygroups) property.    To avoid this situation, migrate your DB instance to using VPC security groups only when that is the only change in your stack template.   *Amazon Aurora*  Not applicable. The associated list of EC2 VPC security groups is managed by the DB cluster. If specified, the setting must match the DB cluster setting.")
  @extension("x-ms-identifiers", [])
  vpcSecurityGroups?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DBInstanceRole")
model DBInstanceRole {
  @doc("The name of the feature associated with the AWS Identity and Access Management (IAM) role. IAM roles that are associated with a DB instance grant permission for the DB instance to access other AWS services on your behalf. For the list of supported feature names, see the ``SupportedFeatureNames`` description in [DBEngineVersion](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DBEngineVersion.html) in the *Amazon RDS API Reference*.")
  featureName?: string;

  @doc("The Amazon Resource Name (ARN) of the IAM role that is associated with the DB instance.")
  roleArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CertificateDetails")
model CertificateDetails {
  @doc("The CA identifier of the CA certificate used for the DB instance's server certificate.")
  caIdentifier?: string;

  @doc("The expiration date of the DB instance’s server certificate.")
  validTill?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Endpoint")
model Endpoint {
  @doc("Specifies the DNS address of the DB instance.")
  address?: string;

  @doc("Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.")
  hostedZoneId?: string;

  @doc("Specifies the port that the database engine is listening on.")
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
@doc("Definition of ProcessorFeature")
model ProcessorFeature {
  @doc("The name of the processor feature. Valid names are ``coreCount`` and ``threadsPerCore``.")
  name?: ProcessorFeatureName;

  @doc("The value of a processor feature name.")
  value?: string;
}

@doc("ProcessorFeatureName enum")
union ProcessorFeatureName {
  @doc("ProcessorFeatureName enum coreCount")
  coreCount: "coreCount",

  @doc("ProcessorFeatureName enum threadsPerCore")
  threadsPerCore: "threadsPerCore",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("A key is the required name of the tag. The string value can be from 1 to 128 Unicode characters in length and can't be prefixed with ``aws:`` or ``rds:``. The string can only contain only the set of Unicode letters, digits, white-space, '_', '.', ':', '/', '=', '+', '-', '@' (Java regex: '^([\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-@]*)$').")
  key?: string;

  @doc("A value is the optional value of the tag. The string value can be from 1 to 256 Unicode characters in length and can't be prefixed with ``aws:`` or ``rds:``. The string can only contain only the set of Unicode letters, digits, white-space, '_', '.', ':', '/', '=', '+', '-', '@' (Java regex: '^([\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-@]*)$').")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface RdsDBInstances {
  get is ArmResourceRead<RdsDBInstance>;
  @doc("Create a RdsDBInstance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<RdsDBInstance>;
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
