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

//---------------------------------------------- EmrClusters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EMR Cluster",
    plural: "EMR Clusters",
  },
  keywords: ["Microsoft.AwsConnector", "EMR", "Cluster"],
})
@doc("A Microsoft.AwsConnector resource")
model EmrCluster is TrackedResource<EmrClusterProperties> {
  @doc("Name of EmrCluster")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("emrClusters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EmrCluster")
model EmrClusterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEmrClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEmrCluster")
model AwsEmrClusterProperties {
  @doc("<p>The applications installed on this cluster.</p>")
  @extension("x-ms-identifiers", [])
  applications?: Application[];

  @doc("<p>An IAM role for automatic scaling policies. The default role is <code>EMR_AutoScaling_DefaultRole</code>. The IAM role provides permissions that the automatic scaling feature requires to launch and terminate Amazon EC2 instances in an instance group.</p>")
  autoScalingRole?: string;

  @doc("<p>Specifies whether the cluster should terminate after completing all steps.</p>")
  autoTerminate?: boolean;

  @doc("<p>The Amazon Resource Name of the cluster.</p>")
  clusterArn?: string;

  @doc("<p>Applies only to Amazon EMR releases 4.x and later. The list of configurations that are supplied to the Amazon EMR cluster.</p>")
  @extension("x-ms-identifiers", [])
  configurations?: Configuration[];

  @doc("<p>Available only in Amazon EMR releases 5.7.0 and later. The ID of a custom Amazon EBS-backed Linux AMI if the cluster uses a custom AMI.</p>")
  customAmiId?: string;

  @doc("<p>The IOPS, of the Amazon EBS root device volume of the Linux AMI that is used for each Amazon EC2 instance. Available in Amazon EMR releases 6.15.0 and later.</p>")
  ebsRootVolumeIops?: int32;

  @doc("<p>The size, in GiB, of the Amazon EBS root device volume of the Linux AMI that is used for each Amazon EC2 instance. Available in Amazon EMR releases 4.x and later.</p>")
  ebsRootVolumeSize?: int32;

  @doc("<p>The throughput, in MiB/s, of the Amazon EBS root device volume of the Linux AMI that is used for each Amazon EC2 instance. Available in Amazon EMR releases 6.15.0 and later.</p>")
  ebsRootVolumeThroughput?: int32;

  @doc("<p>Provides information about the Amazon EC2 instances in a cluster grouped by category. For example, key name, subnet ID, IAM instance profile, and so on.</p>")
  ec2InstanceAttributes?: Ec2InstanceAttributes;

  @doc("<p>The unique identifier for the cluster.</p>")
  id?: string;

  @doc("<note> <p>The instance fleet configuration is available only in Amazon EMR releases 4.8.0 and later, excluding 5.0.x versions.</p> </note> <p>The instance group configuration of the cluster. A value of <code>INSTANCE_GROUP</code> indicates a uniform instance group configuration. A value of <code>INSTANCE_FLEET</code> indicates an instance fleets configuration.</p>")
  instanceCollectionType?: InstanceCollectionTypeEnumValue;

  @doc("<p>Attributes for Kerberos configuration when Kerberos authentication is enabled using a security configuration. For more information see <a href='https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-kerberos.html'>Use Kerberos Authentication</a> in the <i>Amazon EMR Management Guide</i>.</p>")
  kerberosAttributes?: KerberosAttributes;

  @doc("<p> The KMS key used for encrypting log files. This attribute is only available with Amazon EMR 5.30.0 and later, excluding Amazon EMR 6.0.0. </p>")
  logEncryptionKmsKeyId?: string;

  @doc("<p>The path to the Amazon S3 location where logs for this cluster are stored.</p>")
  logUri?: string;

  @doc("<p>The DNS name of the master node. If the cluster is on a private subnet, this is the private DNS name. On a public subnet, this is the public DNS name.</p>")
  masterPublicDnsName?: string;

  @doc("<p>The name of the cluster. This parameter can't contain the characters &lt;, &gt;, $, |, or ` (backtick).</p>")
  name?: string;

  @doc("<p>An approximation of the cost of the cluster, represented in m1.small/hours. This value is incremented one time for every hour an m1.small instance runs. Larger instances are weighted more, so an Amazon EC2 instance that is roughly four times more expensive would result in the normalized instance hours being incremented by four. This result is only an approximation and does not reflect the actual billing rate.</p>")
  normalizedInstanceHours?: int32;

  @doc("<p>The Amazon Linux release specified in a cluster launch RunJobFlow request. If no Amazon Linux release was specified, the default Amazon Linux release is shown in the response.</p>")
  osReleaseLabel?: string;

  @doc("<p> The Amazon Resource Name (ARN) of the Outpost where the cluster is launched. </p>")
  outpostArn?: string;

  @doc("<p>Placement group configured for an Amazon EMR cluster.</p>")
  @extension("x-ms-identifiers", [])
  placementGroups?: PlacementGroupConfig[];

  @doc("<p>The Amazon EMR release label, which determines the version of open-source application packages installed on the cluster. Release labels are in the form <code>emr-x.x.x</code>, where x.x.x is an Amazon EMR release version such as <code>emr-5.14.0</code>. For more information about Amazon EMR release versions and included application versions and features, see <a href='https://docs.aws.amazon.com/emr/latest/ReleaseGuide/'>https://docs.aws.amazon.com/emr/latest/ReleaseGuide/</a>. The release label applies only to Amazon EMR releases version 4.0 and later. Earlier versions use <code>AmiVersion</code>.</p>")
  releaseLabel?: string;

  @doc("<p>Applies only when <code>CustomAmiID</code> is used. Specifies the type of updates that the Amazon Linux AMI package repositories apply when an instance boots using the AMI.</p>")
  repoUpgradeOnBoot?: RepoUpgradeOnBootEnumValue;

  @doc("<p>The AMI version requested for this cluster.</p>")
  requestedAmiVersion?: string;

  @doc("<p>The AMI version running on this cluster.</p>")
  runningAmiVersion?: string;

  @doc("<p>The way that individual Amazon EC2 instances terminate when an automatic scale-in activity occurs or an instance group is resized. <code>TERMINATE_AT_INSTANCE_HOUR</code> indicates that Amazon EMR terminates nodes at the instance-hour boundary, regardless of when the request to terminate the instance was submitted. This option is only available with Amazon EMR 5.1.0 and later and is the default for clusters created using that version. <code>TERMINATE_AT_TASK_COMPLETION</code> indicates that Amazon EMR adds nodes to a deny list and drains tasks from nodes before terminating the Amazon EC2 instances, regardless of the instance-hour boundary. With either behavior, Amazon EMR removes the least active nodes first and blocks instance termination if it could lead to HDFS corruption. <code>TERMINATE_AT_TASK_COMPLETION</code> is available only in Amazon EMR releases 4.1.0 and later, and is the default for versions of Amazon EMR earlier than 5.1.0.</p>")
  scaleDownBehavior?: ScaleDownBehaviorEnumValue;

  @doc("<p>The name of the security configuration applied to the cluster.</p>")
  securityConfiguration?: string;

  @doc("<p>The IAM role that Amazon EMR assumes in order to access Amazon Web Services resources on your behalf.</p>")
  serviceRole?: string;

  @doc("<p>The current status details about the cluster.</p>")
  status?: ClusterStatus;

  @doc("<p>Specifies the number of steps that can be executed concurrently.</p>")
  stepConcurrencyLevel?: int32;

  @doc("<p>A list of tags associated with a cluster.</p>")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("<p>Indicates whether Amazon EMR will lock the cluster to prevent the Amazon EC2 instances from being terminated by an API call or user intervention, or in the event of a cluster error.</p>")
  terminationProtected?: boolean;

  @doc("<p>Indicates whether Amazon EMR should gracefully replace Amazon EC2 core instances that have degraded within the cluster.</p>")
  unhealthyNodeReplacement?: boolean;

  @doc("<p>Indicates whether the cluster is visible to IAM principals in the Amazon Web Services account associated with the cluster. When <code>true</code>, IAM principals in the Amazon Web Services account can perform Amazon EMR cluster actions on the cluster that their IAM policies allow. When <code>false</code>, only the IAM principal that created the cluster and the Amazon Web Services account root user can perform Amazon EMR actions, regardless of IAM permissions policies attached to other IAM principals.</p> <p>The default value is <code>true</code> if a value is not provided when creating a cluster using the Amazon EMR API <a>RunJobFlow</a> command, the CLI <a href='https://docs.aws.amazon.com/cli/latest/reference/emr/create-cluster.html'>create-cluster</a> command, or the Amazon Web Services Management Console.</p>")
  visibleToAllUsers?: boolean;
}

@doc("InstanceCollectionType enum")
union InstanceCollectionType {
  @doc("InstanceCollectionType enum INSTANCE_FLEET")
  INSTANCE_FLEET: "INSTANCE_FLEET",

  @doc("InstanceCollectionType enum INSTANCE_GROUP")
  INSTANCE_GROUP: "INSTANCE_GROUP",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceCollectionTypeEnumValue")
model InstanceCollectionTypeEnumValue {
  @doc("Property value")
  value?: InstanceCollectionType;
}

@doc("ScaleDownBehavior enum")
union ScaleDownBehavior {
  @doc("ScaleDownBehavior enum TERMINATE_AT_INSTANCE_HOUR")
  TERMINATE_AT_INSTANCE_HOUR: "TERMINATE_AT_INSTANCE_HOUR",

  @doc("ScaleDownBehavior enum TERMINATE_AT_TASK_COMPLETION")
  TERMINATE_AT_TASK_COMPLETION: "TERMINATE_AT_TASK_COMPLETION",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScaleDownBehaviorEnumValue")
model ScaleDownBehaviorEnumValue {
  @doc("Property value")
  value?: ScaleDownBehavior;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Application")
model Application {
  @doc("<p>This option is for advanced users only. This is meta information about third-party applications that third-party vendors use for testing purposes.</p>")
  additionalInfo?: Record<string>;

  @doc("<p>Arguments for Amazon EMR to pass to the application.</p>")
  @extension("x-ms-identifiers", [])
  args?: string[];

  @doc("<p>The name of the application.</p>")
  name?: string;

  @doc("<p>The version of the application.</p>")
  version?: string;
}

@doc("RepoUpgradeOnBoot enum")
union RepoUpgradeOnBoot {
  @doc("RepoUpgradeOnBoot enum NONE")
  NONE: "NONE",

  @doc("RepoUpgradeOnBoot enum SECURITY")
  SECURITY: "SECURITY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RepoUpgradeOnBootEnumValue")
model RepoUpgradeOnBootEnumValue {
  @doc("Property value")
  value?: RepoUpgradeOnBoot;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Configuration")
model Configuration {
  @doc("<p>The classification within a configuration.</p>")
  classification?: string;

  @doc("<p>A list of additional configurations to apply within a configuration object.</p>")
  @extension("x-ms-identifiers", [])
  configurations?: Configuration[];

  @doc("<p>A set of properties specified within a configuration classification.</p>")
  properties?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2InstanceAttributes")
model Ec2InstanceAttributes {
  @doc("<p>A list of additional Amazon EC2 security group IDs for the master node.</p>")
  @extension("x-ms-identifiers", [])
  additionalMasterSecurityGroups?: string[];

  @doc("<p>A list of additional Amazon EC2 security group IDs for the core and task nodes.</p>")
  @extension("x-ms-identifiers", [])
  additionalSlaveSecurityGroups?: string[];

  @doc("<p>The Availability Zone in which the cluster will run. </p>")
  ec2AvailabilityZone?: string;

  @doc("<p>The name of the Amazon EC2 key pair to use when connecting with SSH into the master node as a user named 'hadoop'.</p>")
  ec2KeyName?: string;

  @doc("<p>Set this parameter to the identifier of the Amazon VPC subnet where you want the cluster to launch. If you do not specify this value, and your account supports EC2-Classic, the cluster launches in EC2-Classic.</p>")
  ec2SubnetId?: string;

  @doc("<p>The identifier of the Amazon EC2 security group for the master node.</p>")
  emrManagedMasterSecurityGroup?: string;

  @doc("<p>The identifier of the Amazon EC2 security group for the core and task nodes.</p>")
  emrManagedSlaveSecurityGroup?: string;

  @doc("<p>The IAM role that was specified when the cluster was launched. The Amazon EC2 instances of the cluster assume this role.</p>")
  iamInstanceProfile?: string;

  @doc("<p>Applies to clusters configured with the instance fleets option. Specifies one or more Availability Zones in which to launch Amazon EC2 cluster instances when the EC2-Classic network configuration is supported. Amazon EMR chooses the Availability Zone with the best fit from among the list of <code>RequestedEc2AvailabilityZones</code>, and then launches all cluster instances within that Availability Zone. If you do not specify this value, Amazon EMR chooses the Availability Zone for you. <code>RequestedEc2SubnetIDs</code> and <code>RequestedEc2AvailabilityZones</code> cannot be specified together.</p>")
  @extension("x-ms-identifiers", [])
  requestedEc2AvailabilityZones?: string[];

  @doc("<p>Applies to clusters configured with the instance fleets option. Specifies the unique identifier of one or more Amazon EC2 subnets in which to launch Amazon EC2 cluster instances. Subnets must exist within the same VPC. Amazon EMR chooses the Amazon EC2 subnet with the best fit from among the list of <code>RequestedEc2SubnetIds</code>, and then launches all cluster instances within that Subnet. If this value is not specified, and the account and Region support EC2-Classic networks, the cluster launches instances in the EC2-Classic network and uses <code>RequestedEc2AvailabilityZones</code> instead of this setting. If EC2-Classic is not supported, and no Subnet is specified, Amazon EMR chooses the subnet for you. <code>RequestedEc2SubnetIDs</code> and <code>RequestedEc2AvailabilityZones</code> cannot be specified together.</p>")
  @extension("x-ms-identifiers", [])
  requestedEc2SubnetIds?: string[];

  @doc("<p>The identifier of the Amazon EC2 security group for the Amazon EMR service to access clusters in VPC private subnets.</p>")
  serviceAccessSecurityGroup?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KerberosAttributes")
model KerberosAttributes {
  @doc("<p>The Active Directory password for <code>ADDomainJoinUser</code>.</p>")
  adDomainJoinPassword?: string;

  @doc("<p>Required only when establishing a cross-realm trust with an Active Directory domain. A user with sufficient privileges to join resources to the domain.</p>")
  adDomainJoinUser?: string;

  @doc("<p>Required only when establishing a cross-realm trust with a KDC in a different realm. The cross-realm principal password, which must be identical across realms.</p>")
  crossRealmTrustPrincipalPassword?: string;

  @doc("<p>The password used within the cluster for the kadmin service on the cluster-dedicated KDC, which maintains Kerberos principals, password policies, and keytabs for the cluster.</p>")
  kdcAdminPassword?: string;

  @doc("<p>The name of the Kerberos realm to which all nodes in a cluster belong. For example, <code>EC2.INTERNAL</code>. </p>")
  realm?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlacementGroupConfig")
model PlacementGroupConfig {
  @doc("<p>Role of the instance in the cluster.</p> <p>Starting with Amazon EMR release 5.23.0, the only supported instance role is <code>MASTER</code>.</p>")
  instanceRole?: InstanceRoleTypeEnumValue;

  @doc("<p>Amazon EC2 Placement Group strategy associated with instance role.</p> <p>Starting with Amazon EMR release 5.23.0, the only supported placement strategy is <code>SPREAD</code> for the <code>MASTER</code> instance role.</p>")
  placementStrategy?: PlacementGroupStrategyEnumValue;
}

@doc("InstanceRoleType enum")
union InstanceRoleType {
  @doc("InstanceRoleType enum CORE")
  CORE: "CORE",

  @doc("InstanceRoleType enum MASTER")
  MASTER: "MASTER",

  @doc("InstanceRoleType enum TASK")
  TASK: "TASK",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceRoleTypeEnumValue")
model InstanceRoleTypeEnumValue {
  @doc("Property value")
  value?: InstanceRoleType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterStatus")
model ClusterStatus {
  @doc("<p>A list of tuples that provides information about the errors that caused a cluster to terminate. This structure can contain up to 10 different <code>ErrorDetail</code> tuples.</p>")
  @extension("x-ms-identifiers", [])
  errorDetails?: ErrorDetail[];

  @doc("<p>The current state of the cluster.</p>")
  state?: ClusterStateEnumValue;

  @doc("<p>The reason for the cluster status change.</p>")
  stateChangeReason?: ClusterStateChangeReason;

  @doc("<p>A timeline that represents the status of a cluster over the lifetime of the cluster.</p>")
  timeline?: ClusterTimeline;
}

@doc("PlacementGroupStrategy enum")
union PlacementGroupStrategy {
  @doc("PlacementGroupStrategy enum CLUSTER")
  CLUSTER: "CLUSTER",

  @doc("PlacementGroupStrategy enum NONE")
  NONE: "NONE",

  @doc("PlacementGroupStrategy enum PARTITION")
  PARTITION: "PARTITION",

  @doc("PlacementGroupStrategy enum SPREAD")
  SPREAD: "SPREAD",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlacementGroupStrategyEnumValue")
model PlacementGroupStrategyEnumValue {
  @doc("Property value")
  value?: PlacementGroupStrategy;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("<p>A user-defined key, which is the minimum required information for a valid tag. For more information, see <a href='https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-tags.html'>Tag</a>. </p>")
  key?: string;

  @doc("<p>A user-defined value, which is optional in a tag. For more information, see <a href='https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-tags.html'>Tag Clusters</a>. </p>")
  value?: string;
}

@doc("ClusterState enum")
union ClusterState {
  @doc("ClusterState enum BOOTSTRAPPING")
  BOOTSTRAPPING: "BOOTSTRAPPING",

  @doc("ClusterState enum RUNNING")
  RUNNING: "RUNNING",

  @doc("ClusterState enum STARTING")
  STARTING: "STARTING",

  @doc("ClusterState enum TERMINATED")
  TERMINATED: "TERMINATED",

  @doc("ClusterState enum TERMINATED_WITH_ERRORS")
  TERMINATED_WITH_ERRORS: "TERMINATED_WITH_ERRORS",

  @doc("ClusterState enum TERMINATING")
  TERMINATING: "TERMINATING",

  @doc("ClusterState enum WAITING")
  WAITING: "WAITING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterStateEnumValue")
model ClusterStateEnumValue {
  @doc("Property value")
  value?: ClusterState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ErrorDetail")
model ErrorDetail {
  @doc("<p>The name or code associated with the error.</p>")
  errorCode?: string;

  @doc("<p>A list of key value pairs that provides contextual information about why an error occured.</p>")
  @extension("x-ms-identifiers", [])
  errorData?: StringMap[];

  @doc("<p>A message that describes the error.</p>")
  errorMessage?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterStateChangeReason")
model ClusterStateChangeReason {
  @doc("<p>The programmatic code for the state change reason.</p>")
  code?: ClusterStateChangeReasonCodeEnumValue;

  @doc("<p>The descriptive message for the state change reason.</p>")
  message?: string;
}

@doc("ClusterStateChangeReasonCode enum")
union ClusterStateChangeReasonCode {
  @doc("ClusterStateChangeReasonCode enum ALL_STEPS_COMPLETED")
  ALL_STEPS_COMPLETED: "ALL_STEPS_COMPLETED",

  @doc("ClusterStateChangeReasonCode enum BOOTSTRAP_FAILURE")
  BOOTSTRAP_FAILURE: "BOOTSTRAP_FAILURE",

  @doc("ClusterStateChangeReasonCode enum INSTANCE_FAILURE")
  INSTANCE_FAILURE: "INSTANCE_FAILURE",

  @doc("ClusterStateChangeReasonCode enum INSTANCE_FLEET_TIMEOUT")
  INSTANCE_FLEET_TIMEOUT: "INSTANCE_FLEET_TIMEOUT",

  @doc("ClusterStateChangeReasonCode enum INTERNAL_ERROR")
  INTERNAL_ERROR: "INTERNAL_ERROR",

  @doc("ClusterStateChangeReasonCode enum STEP_FAILURE")
  STEP_FAILURE: "STEP_FAILURE",

  @doc("ClusterStateChangeReasonCode enum USER_REQUEST")
  USER_REQUEST: "USER_REQUEST",

  @doc("ClusterStateChangeReasonCode enum VALIDATION_ERROR")
  VALIDATION_ERROR: "VALIDATION_ERROR",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterStateChangeReasonCodeEnumValue")
model ClusterStateChangeReasonCodeEnumValue {
  @doc("Property value")
  value?: ClusterStateChangeReasonCode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterTimeline")
model ClusterTimeline {
  @doc("<p>The creation date and time of the cluster.</p>")
  creationDateTime?: utcDateTime;

  @doc("<p>The date and time when the cluster was terminated.</p>")
  endDateTime?: utcDateTime;

  @doc("<p>The date and time when the cluster was ready to run steps.</p>")
  readyDateTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StringMap")
model StringMap {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EmrClusters {
  get is ArmResourceRead<EmrCluster>;
  @doc("Create a EmrCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<EmrCluster>;
  update is ArmCustomPatchAsync<
    EmrCluster,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EmrCluster>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EmrCluster>;
  listByResourceGroup is ArmResourceListByParent<EmrCluster>;
  listBySubscription is ArmListBySubscription<EmrCluster>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\elasticmapreduce\elasticmapreduce-2009-03-31.normal.json
// AWS Shape: Cluster
//
// Related information for backend service:
// AWS Servcie : EMR
// Product Version : 3.7.798.0
// SDK Version : 3.7.304.31
//--------------------------------------------------------------------------------------------
