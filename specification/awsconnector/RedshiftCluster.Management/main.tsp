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

//---------------------------------------------- RedshiftClusters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Redshift Cluster",
    plural: "Redshift Clusters",
  },
  keywords: ["Microsoft.AwsConnector", "Redshift", "Cluster"],
})
@doc("A Microsoft.AwsConnector resource")
model RedshiftCluster is TrackedResource<RedshiftClusterProperties> {
  @doc("Name of RedshiftCluster")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("redshiftClusters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftCluster")
model RedshiftClusterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsRedshiftClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsRedshiftCluster")
model AwsRedshiftClusterProperties {
  @doc("Major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. Default value is True")
  allowVersionUpgrade?: boolean;

  @doc("The value represents how the cluster is configured to use AQUA (Advanced Query Accelerator) after the cluster is restored. Possible values include the following.enabled - Use AQUA if it is available for the current Region and Amazon Redshift node type.disabled - Don't use AQUA.auto - Amazon Redshift determines whether to use AQUA.")
  aquaConfigurationStatus?: string;

  @doc("The number of days that automated snapshots are retained. If the value is 0, automated snapshots are disabled. Default value is 1")
  automatedSnapshotRetentionPeriod?: int32;

  @doc("The EC2 Availability Zone (AZ) in which you want Amazon Redshift to provision the cluster. Default: A random, system-chosen Availability Zone in the region that is specified by the endpoint")
  availabilityZone?: string;

  @doc("The option to enable relocation for an Amazon Redshift cluster between Availability Zones after the cluster modification is complete.")
  availabilityZoneRelocation?: boolean;

  @doc("The availability zone relocation status of the cluster")
  availabilityZoneRelocationStatus?: string;

  @doc("A boolean value indicating whether the resize operation is using the classic resize process. If you don't provide this parameter or set the value to false , the resize type is elastic.")
  classic?: boolean;

  @doc("A unique identifier for the cluster. You use this identifier to refer to the cluster for any subsequent cluster operations such as deleting or modifying. All alphabetical characters must be lower case, no hypens at the end, no two consecutive hyphens. Cluster name should be unique for all clusters within an AWS account")
  clusterIdentifier?: string;

  @doc("The Amazon Resource Name (ARN) of the cluster namespace.")
  clusterNamespaceArn?: string;

  @doc("The name of the parameter group to be associated with this cluster.")
  clusterParameterGroupName?: string;

  @doc("A list of security groups to be associated with this cluster.")
  @extension("x-ms-identifiers", [])
  clusterSecurityGroups?: string[];

  @doc("The name of a cluster subnet group to be associated with this cluster.")
  clusterSubnetGroupName?: string;

  @doc("The type of the cluster. When cluster type is specified as single-node, the NumberOfNodes parameter is not required and if multi-node, the NumberOfNodes parameter is required")
  clusterType?: string;

  @doc("The version of the Amazon Redshift engine software that you want to deploy on the cluster.The version selected runs on all the nodes in the cluster.")
  clusterVersion?: string;

  @doc("The name of the first database to be created when the cluster is created. To create additional databases after the cluster is created, connect to the cluster with a SQL client and use SQL commands to create a database.")
  dbName?: string;

  @doc("A boolean indicating whether to enable the deferred maintenance window.")
  deferMaintenance?: boolean;

  @doc("An integer indicating the duration of the maintenance window in days. If you specify a duration, you can't specify an end time. The duration must be 45 days or less.")
  deferMaintenanceDuration?: int32;

  @doc("A timestamp indicating end time for the deferred maintenance window. If you specify an end time, you can't specify a duration.")
  deferMaintenanceEndTime?: string;

  @doc("A unique identifier for the deferred maintenance window.")
  deferMaintenanceIdentifier?: string;

  @doc("A timestamp indicating the start time for the deferred maintenance window.")
  deferMaintenanceStartTime?: string;

  @doc("The destination AWS Region that you want to copy snapshots to. Constraints: Must be the name of a valid AWS Region. For more information, see Regions and Endpoints in the Amazon Web Services [https://docs.aws.amazon.com/general/latest/gr/rande.html#redshift_region] General Reference")
  destinationRegion?: string;

  @doc("The Elastic IP (EIP) address for the cluster.")
  elasticIp?: string;

  @doc("If true, the data in the cluster is encrypted at rest.")
  encrypted?: boolean;

  @doc("Property endpoint")
  endpoint?: Endpoint;

  @doc("An option that specifies whether to create the cluster with enhanced VPC routing enabled. To create a cluster that uses enhanced VPC routing, the cluster must be in a VPC. For more information, see Enhanced VPC Routing in the Amazon Redshift Cluster Management Guide.If this option is true , enhanced VPC routing is enabled.Default: false")
  enhancedVpcRouting?: boolean;

  @doc("Specifies the name of the HSM client certificate the Amazon Redshift cluster uses to retrieve the data encryption keys stored in an HSM")
  hsmClientCertificateIdentifier?: string;

  @doc("Specifies the name of the HSM configuration that contains the information the Amazon Redshift cluster can use to retrieve and store keys in an HSM.")
  hsmConfigurationIdentifier?: string;

  @doc("A list of AWS Identity and Access Management (IAM) roles that can be used by the cluster to access other AWS services. You must supply the IAM roles in their Amazon Resource Name (ARN) format. You can supply up to 50 IAM roles in a single request")
  @extension("x-ms-identifiers", [])
  iamRoles?: string[];

  @doc("The AWS Key Management Service (KMS) key ID of the encryption key that you want to use to encrypt data in the cluster.")
  kmsKeyId?: string;

  @doc("Property loggingProperties")
  loggingProperties?: LoggingProperties;

  @doc("The name for the maintenance track that you want to assign for the cluster. This name change is asynchronous. The new track name stays in the PendingModifiedValues for the cluster until the next maintenance window. When the maintenance track changes, the cluster is switched to the latest cluster release available for the maintenance track. At this point, the maintenance track name is applied.")
  maintenanceTrackName?: string;

  @doc("A boolean indicating if the redshift cluster's admin user credentials is managed by Redshift or not. You can't use MasterUserPassword if ManageMasterPassword is true. If ManageMasterPassword is false or not set, Amazon Redshift uses MasterUserPassword for the admin user account's password.")
  manageMasterPassword?: boolean;

  @doc("The number of days to retain newly copied snapshots in the destination AWS Region after they are copied from the source AWS Region. If the value is -1, the manual snapshot is retained indefinitely.The value must be either -1 or an integer between 1 and 3,653.")
  manualSnapshotRetentionPeriod?: int32;

  @doc("The Amazon Resource Name (ARN) for the cluster's admin user credentials secret.")
  masterPasswordSecretArn?: string;

  @doc("The ID of the Key Management Service (KMS) key used to encrypt and store the cluster's admin user credentials secret.")
  masterPasswordSecretKmsKeyId?: string;

  @doc("The password associated with the master user account for the cluster that is being created. You can't use MasterUserPassword if ManageMasterPassword is true. Password must be between 8 and 64 characters in length, should have at least one uppercase letter.Must contain at least one lowercase letter.Must contain one number.Can be any printable ASCII character.")
  masterUserPassword?: string;

  @doc("The user name associated with the master user account for the cluster that is being created. The user name can't be PUBLIC and first character must be a letter.")
  masterUsername?: string;

  @doc("A boolean indicating if the redshift cluster is multi-az or not. If you don't provide this parameter or set the value to false, the redshift cluster will be single-az.")
  multiAZ?: boolean;

  @doc("The namespace resource policy document that will be attached to a Redshift cluster.")
  namespaceResourcePolicy?: unknown;

  @doc("The node type to be provisioned for the cluster.Valid Values: ds2.xlarge | ds2.8xlarge | dc1.large | dc1.8xlarge | dc2.large | dc2.8xlarge | ra3.4xlarge | ra3.16xlarge")
  nodeType?: string;

  @doc("The number of compute nodes in the cluster. This parameter is required when the ClusterType parameter is specified as multi-node.")
  numberOfNodes?: int32;

  @doc("Property ownerAccount")
  ownerAccount?: string;

  @doc("The port number on which the cluster accepts incoming connections. The cluster is accessible only via the JDBC and ODBC connection strings")
  port?: int32;

  @doc("The weekly time range (in UTC) during which automated cluster maintenance can occur.")
  preferredMaintenanceWindow?: string;

  @doc("If true, the cluster can be accessed from a public network.")
  publiclyAccessible?: boolean;

  @doc("The Redshift operation to be performed. Resource Action supports pause-cluster, resume-cluster, failover-primary-compute APIs")
  resourceAction?: string;

  @doc("The identifier of the database revision. You can retrieve this value from the response to the DescribeClusterDbRevisions request.")
  revisionTarget?: string;

  @doc("A boolean indicating if we want to rotate Encryption Keys.")
  rotateEncryptionKey?: boolean;

  @doc("The name of the cluster the source snapshot was created from. This parameter is required if your IAM user has a policy containing a snapshot resource element that specifies anything other than * for the cluster name.")
  snapshotClusterIdentifier?: string;

  @doc("The name of the snapshot copy grant to use when snapshots of an AWS KMS-encrypted cluster are copied to the destination region.")
  snapshotCopyGrantName?: string;

  @doc("Indicates whether to apply the snapshot retention period to newly copied manual snapshots instead of automated snapshots.")
  snapshotCopyManual?: boolean;

  @doc("The number of days to retain automated snapshots in the destination region after they are copied from the source region.  Default is 7.  Constraints: Must be at least 1 and no more than 35.")
  snapshotCopyRetentionPeriod?: int32;

  @doc("The name of the snapshot from which to create the new cluster. This parameter isn't case sensitive.")
  snapshotIdentifier?: string;

  @doc("The list of tags for the cluster parameter group.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster.")
  @extension("x-ms-identifiers", [])
  vpcSecurityGroupIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Endpoint")
model Endpoint {
  @doc("Property address")
  address?: string;

  @doc("Property port")
  port?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoggingProperties")
model LoggingProperties {
  @doc("Property bucketName")
  bucketName?: string;

  @doc("Property s3KeyPrefix")
  s3KeyPrefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key name of the tag. You can specify a value that is 1 to 127 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("The value for the tag. You can specify a value that is 1 to 255 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface RedshiftClusters {
  get is ArmResourceRead<RedshiftCluster>;
  @doc("Create a RedshiftCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<RedshiftCluster>;
  update is ArmCustomPatchAsync<
    RedshiftCluster,
    Azure.ResourceManager.Foundations.TagsUpdateModel<RedshiftCluster>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<RedshiftCluster>;
  listByResourceGroup is ArmResourceListByParent<RedshiftCluster>;
  listBySubscription is ArmListBySubscription<RedshiftCluster>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Redshift::Cluster
//--------------------------------------------------------------------------------------------
