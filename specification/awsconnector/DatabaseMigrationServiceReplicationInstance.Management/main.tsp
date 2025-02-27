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

//---------------------------------------------- DatabaseMigrationServiceReplicationInstances ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Database  Migration  Service Replication Instance",
    plural: "Database  Migration  Service Replication Instances",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Database ",
    "Migration ",
    "Service",
    "Replication",
    "Instance"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model DatabaseMigrationServiceReplicationInstance
  is TrackedResource<DatabaseMigrationServiceReplicationInstanceProperties> {
  @doc("Name of DatabaseMigrationServiceReplicationInstance")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("databaseMigrationServiceReplicationInstances")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DatabaseMigrationServiceReplicationInstance")
model DatabaseMigrationServiceReplicationInstanceProperties {
  @doc("AWS Properties")
  awsProperties?: AwsDatabaseMigrationServiceReplicationInstanceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsDatabaseMigrationServiceReplicationInstance")
model AwsDatabaseMigrationServiceReplicationInstanceProperties {
  @doc("<p>The amount of storage (in gigabytes) that is allocated for the replication instance.</p>")
  allocatedStorage?: int32;

  @doc("<p>Boolean value indicating if minor version upgrades will be automatically applied to the instance.</p>")
  autoMinorVersionUpgrade?: boolean;

  @doc("<p>The Availability Zone for the instance.</p>")
  availabilityZone?: string;

  @doc("<p>The DNS name servers supported for the replication instance to access your on-premise source or target database.</p>")
  dnsNameServers?: string;

  @doc("<p>The engine version number of the replication instance.</p> <p>If an engine version number is not specified when a replication instance is created, the default is the latest engine version available.</p> <p>When modifying a major engine version of an instance, also set <code>AllowMajorVersionUpgrade</code> to <code>true</code>.</p>")
  engineVersion?: string;

  @doc("<p> The expiration date of the free replication instance that is part of the Free DMS program. </p>")
  freeUntil?: utcDateTime;

  @doc("<p>The time the replication instance was created.</p>")
  instanceCreateTime?: utcDateTime;

  @doc("<p>An KMS key identifier that is used to encrypt the data on the replication instance.</p> <p>If you don't specify a value for the <code>KmsKeyId</code> parameter, then DMS uses your default encryption key.</p> <p>KMS creates the default encryption key for your Amazon Web Services account. Your Amazon Web Services account has a different default encryption key for each Amazon Web Services Region.</p>")
  kmsKeyId?: string;

  @doc("<p> Specifies whether the replication instance is a Multi-AZ deployment. You can't set the <code>AvailabilityZone</code> parameter if the Multi-AZ parameter is set to <code>true</code>. </p>")
  multiAZ?: boolean;

  @doc("<p>The type of IP address protocol used by a replication instance, such as IPv4 only or Dual-stack that supports both IPv4 and IPv6 addressing. IPv6 only is not yet supported.</p>")
  networkType?: string;

  @doc("<p>The pending modification values.</p>")
  pendingModifiedValues?: ReplicationPendingModifiedValues;

  @doc("<p>The maintenance window times for the replication instance. Any pending upgrades to the replication instance are performed during this time.</p>")
  preferredMaintenanceWindow?: string;

  @doc("<p> Specifies the accessibility options for the replication instance. A value of <code>true</code> represents an instance with a public IP address. A value of <code>false</code> represents an instance with a private IP address. The default value is <code>true</code>. </p>")
  publiclyAccessible?: boolean;

  @doc("<p>The Amazon Resource Name (ARN) of the replication instance.</p>")
  replicationInstanceArn?: string;

  @doc("<p>The compute and memory capacity of the replication instance as defined for the specified replication instance class. It is a required parameter, although a default value is pre-selected in the DMS console.</p> <p>For more information on the settings and capacities for the available replication instance classes, see <a href='https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.html#CHAP_ReplicationInstance.InDepth'> Selecting the right DMS replication instance for your migration</a>. </p>")
  replicationInstanceClass?: string;

  @doc("<p>The replication instance identifier is a required parameter. This parameter is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must contain 1-63 alphanumeric characters or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Cannot end with a hyphen or contain two consecutive hyphens.</p> </li> </ul> <p>Example: <code>myrepinstance</code> </p>")
  replicationInstanceIdentifier?: string;

  @doc("<p>One or more IPv6 addresses for the replication instance.</p>")
  @extension("x-ms-identifiers", [])
  replicationInstanceIpv6Addresses?: string[];

  @doc("<p>The private IP address of the replication instance.</p>")
  replicationInstancePrivateIpAddress?: string;

  @doc("<p>One or more private IP addresses for the replication instance.</p>")
  @extension("x-ms-identifiers", [])
  replicationInstancePrivateIpAddresses?: string[];

  @doc("<p>The public IP address of the replication instance.</p>")
  replicationInstancePublicIpAddress?: string;

  @doc("<p>One or more public IP addresses for the replication instance.</p>")
  @extension("x-ms-identifiers", [])
  replicationInstancePublicIpAddresses?: string[];

  @doc("<p>The status of the replication instance. The possible return values include:</p> <ul> <li> <p> <code>'available'</code> </p> </li> <li> <p> <code>'creating'</code> </p> </li> <li> <p> <code>'deleted'</code> </p> </li> <li> <p> <code>'deleting'</code> </p> </li> <li> <p> <code>'failed'</code> </p> </li> <li> <p> <code>'modifying'</code> </p> </li> <li> <p> <code>'upgrading'</code> </p> </li> <li> <p> <code>'rebooting'</code> </p> </li> <li> <p> <code>'resetting-master-credentials'</code> </p> </li> <li> <p> <code>'storage-full'</code> </p> </li> <li> <p> <code>'incompatible-credentials'</code> </p> </li> <li> <p> <code>'incompatible-network'</code> </p> </li> <li> <p> <code>'maintenance'</code> </p> </li> </ul>")
  replicationInstanceStatus?: string;

  @doc("<p>The subnet group for the replication instance.</p>")
  replicationSubnetGroup?: ReplicationSubnetGroup;

  @doc("<p>The Availability Zone of the standby replication instance in a Multi-AZ deployment.</p>")
  secondaryAvailabilityZone?: string;

  @doc("<p>The VPC security group for the instance.</p>")
  @extension("x-ms-identifiers", [])
  vpcSecurityGroups?: VpcSecurityGroupMembership[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationPendingModifiedValues")
model ReplicationPendingModifiedValues {
  @doc("<p>The amount of storage (in gigabytes) that is allocated for the replication instance.</p>")
  allocatedStorage?: int32;

  @doc("<p>The engine version number of the replication instance.</p>")
  engineVersion?: string;

  @doc("<p> Specifies whether the replication instance is a Multi-AZ deployment. You can't set the <code>AvailabilityZone</code> parameter if the Multi-AZ parameter is set to <code>true</code>. </p>")
  multiAZ?: boolean;

  @doc("<p>The type of IP address protocol used by a replication instance, such as IPv4 only or Dual-stack that supports both IPv4 and IPv6 addressing. IPv6 only is not yet supported.</p>")
  networkType?: string;

  @doc("<p>The compute and memory capacity of the replication instance as defined for the specified replication instance class.</p> <p>For more information on the settings and capacities for the available replication instance classes, see <a href='https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.html#CHAP_ReplicationInstance.InDepth'> Selecting the right DMS replication instance for your migration</a>. </p>")
  replicationInstanceClass?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ReplicationSubnetGroup")
model ReplicationSubnetGroup {
  @doc("<p>A description for the replication subnet group.</p>")
  replicationSubnetGroupDescription?: string;

  @doc("<p>The identifier of the replication instance subnet group.</p>")
  replicationSubnetGroupIdentifier?: string;

  @doc("<p>The status of the subnet group.</p>")
  subnetGroupStatus?: string;

  @doc("<p>The subnets that are in the subnet group.</p>")
  @extension("x-ms-identifiers", [])
  subnets?: Subnet[];

  @doc("<p>The IP addressing protocol supported by the subnet group. This is used by a replication instance with values such as IPv4 only or Dual-stack that supports both IPv4 and IPv6 addressing. IPv6 only is not yet supported.</p>")
  @extension("x-ms-identifiers", [])
  supportedNetworkTypes?: string[];

  @doc("<p>The ID of the VPC.</p>")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VpcSecurityGroupMembership")
model VpcSecurityGroupMembership {
  @doc("<p>The status of the VPC security group.</p>")
  status?: string;

  @doc("<p>The VPC security group ID.</p>")
  vpcSecurityGroupId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Subnet")
model Subnet {
  @doc("<p>The Availability Zone of the subnet.</p>")
  subnetAvailabilityZone?: AvailabilityZone;

  @doc("<p>The subnet identifier.</p>")
  subnetIdentifier?: string;

  @doc("<p>The status of the subnet.</p>")
  subnetStatus?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AvailabilityZone")
model AvailabilityZone {
  @doc("<p>The name of the Availability Zone.</p>")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface DatabaseMigrationServiceReplicationInstances {
  get is ArmResourceRead<DatabaseMigrationServiceReplicationInstance>;
  @doc("Create a DatabaseMigrationServiceReplicationInstance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<DatabaseMigrationServiceReplicationInstance>;
  update is ArmCustomPatchAsync<
    DatabaseMigrationServiceReplicationInstance,
    Azure.ResourceManager.Foundations.TagsUpdateModel<DatabaseMigrationServiceReplicationInstance>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DatabaseMigrationServiceReplicationInstance>;
  listByResourceGroup is ArmResourceListByParent<DatabaseMigrationServiceReplicationInstance>;
  listBySubscription is ArmListBySubscription<DatabaseMigrationServiceReplicationInstance>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\dms\dms-2016-01-01.normal.json
// AWS Shape: ReplicationInstance
//
// Related information for backend service:
// AWS Servcie : Database Migration Service
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.82
//--------------------------------------------------------------------------------------------
