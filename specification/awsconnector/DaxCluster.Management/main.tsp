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

//---------------------------------------------- DaxClusters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "DAX Cluster",
    plural: "DAX Clusters",
  },
  keywords: ["Microsoft.AwsConnector", "DAX", "Cluster"],
})
@doc("A Microsoft.AwsConnector resource")
model DaxCluster is TrackedResource<DaxClusterProperties> {
  @doc("Name of DaxCluster")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("daxClusters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DaxCluster")
model DaxClusterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsDaxClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsDaxCluster")
model AwsDaxClusterProperties {
  @doc("<p>The number of nodes in the cluster that are active (i.e., capable of serving requests).</p>")
  activeNodes?: int32;

  @doc("<p>The Amazon Resource Name (ARN) that uniquely identifies the cluster. </p>")
  clusterArn?: string;

  @doc("<p>The endpoint for this DAX cluster, consisting of a DNS name, a port number, and a URL. Applications should use the URL to configure the DAX client to find their cluster.</p>")
  clusterDiscoveryEndpoint?: Endpoint;

  @doc("<p>The type of encryption supported by the cluster's endpoint. Values are:</p> <ul> <li> <p> <code>NONE</code> for no encryption</p> <p> <code>TLS</code> for Transport Layer Security</p> </li> </ul>")
  clusterEndpointEncryptionType?: ClusterEndpointEncryptionTypeEnumValue;

  @doc("<p>The name of the DAX cluster.</p>")
  clusterName?: string;

  @doc("<p>The description of the cluster.</p>")
  description?: string;

  @doc("<p>A valid Amazon Resource Name (ARN) that identifies an IAM role. At runtime, DAX will assume this role and use the role's permissions to access DynamoDB on your behalf.</p>")
  iamRoleArn?: string;

  @doc("<p>A list of nodes to be removed from the cluster.</p>")
  @extension("x-ms-identifiers", [])
  nodeIdsToRemove?: string[];

  @doc("<p>The node type for the nodes in the cluster. (All nodes in a DAX cluster are of the same type.)</p>")
  nodeType?: string;

  @doc("<p>A list of nodes that are currently in the cluster.</p>")
  @extension("x-ms-identifiers", [])
  nodes?: Node[];

  @doc("<p>Describes a notification topic and its status. Notification topics are used for publishing DAX events to subscribers using Amazon Simple Notification Service (SNS).</p>")
  notificationConfiguration?: NotificationConfiguration;

  @doc("<p>The parameter group being used by nodes in the cluster.</p>")
  parameterGroup?: ParameterGroupStatus;

  @doc("<p>A range of time when maintenance of DAX cluster software will be performed. For example: <code>sun:01:00-sun:09:00</code>. Cluster maintenance normally takes less than 30 minutes, and is performed automatically within the maintenance window.</p>")
  preferredMaintenanceWindow?: string;

  @doc("<p>The description of the server-side encryption status on the specified DAX cluster.</p>")
  sseDescription?: SSEDescription;

  @doc("<p>A list of security groups, and the status of each, for the nodes in the cluster.</p>")
  @extension("x-ms-identifiers", [])
  securityGroups?: SecurityGroupMembership[];

  @doc("<p>The current status of the cluster.</p>")
  status?: string;

  @doc("<p>The subnet group where the DAX cluster is running.</p>")
  subnetGroup?: string;

  @doc("<p>The total number of nodes in the cluster.</p>")
  totalNodes?: int32;
}

@doc("ClusterEndpointEncryptionType enum")
union ClusterEndpointEncryptionType {
  @doc("ClusterEndpointEncryptionType enum NONE")
  NONE: "NONE",

  @doc("ClusterEndpointEncryptionType enum TLS")
  TLS: "TLS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterEndpointEncryptionTypeEnumValue")
model ClusterEndpointEncryptionTypeEnumValue {
  @doc("Property value")
  value?: ClusterEndpointEncryptionType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Endpoint")
model Endpoint {
  @doc("<p>The DNS hostname of the endpoint.</p>")
  address?: string;

  @doc("<p>The port number that applications should use to connect to the endpoint.</p>")
  port?: int32;

  @doc("<p>The URL that applications should use to connect to the endpoint. The default ports are 8111 for the 'dax' protocol and 9111 for the 'daxs' protocol.</p>")
  url?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Node")
model Node {
  @doc("<p>The Availability Zone (AZ) in which the node has been deployed.</p>")
  availabilityZone?: string;

  @doc("<p>The endpoint for the node, consisting of a DNS name and a port number. Client applications can connect directly to a node endpoint, if desired (as an alternative to allowing DAX client software to intelligently route requests and responses to nodes in the DAX cluster.</p>")
  endpoint?: Endpoint;

  @doc("<p>The date and time (in UNIX epoch format) when the node was launched.</p>")
  nodeCreateTime?: utcDateTime;

  @doc("<p>A system-generated identifier for the node.</p>")
  nodeId?: string;

  @doc("<p>The current status of the node. For example: <code>available</code>.</p>")
  nodeStatus?: string;

  @doc("<p>The status of the parameter group associated with this node. For example, <code>in-sync</code>.</p>")
  parameterGroupStatus?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NotificationConfiguration")
model NotificationConfiguration {
  @doc("<p>The Amazon Resource Name (ARN) that identifies the topic. </p>")
  topicArn?: string;

  @doc("<p>The current state of the topic. A value of “active” means that notifications will be sent to the topic. A value of “inactive” means that notifications will not be sent to the topic.</p>")
  topicStatus?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ParameterGroupStatus")
model ParameterGroupStatus {
  @doc("<p>The node IDs of one or more nodes to be rebooted.</p>")
  @extension("x-ms-identifiers", [])
  nodeIdsToReboot?: string[];

  @doc("<p>The status of parameter updates. </p>")
  parameterApplyStatus?: string;

  @doc("<p>The name of the parameter group.</p>")
  parameterGroupName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SSEDescription")
model SSEDescription {
  @doc("<p>The current state of server-side encryption:</p> <ul> <li> <p> <code>ENABLING</code> - Server-side encryption is being enabled.</p> </li> <li> <p> <code>ENABLED</code> - Server-side encryption is enabled.</p> </li> <li> <p> <code>DISABLING</code> - Server-side encryption is being disabled.</p> </li> <li> <p> <code>DISABLED</code> - Server-side encryption is disabled.</p> </li> </ul>")
  status?: SSEStatusEnumValue;
}

@doc("SSEStatus enum")
union SSEStatus {
  @doc("SSEStatus enum DISABLED")
  DISABLED: "DISABLED",

  @doc("SSEStatus enum DISABLING")
  DISABLING: "DISABLING",

  @doc("SSEStatus enum ENABLED")
  ENABLED: "ENABLED",

  @doc("SSEStatus enum ENABLING")
  ENABLING: "ENABLING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SSEStatusEnumValue")
model SSEStatusEnumValue {
  @doc("Property value")
  value?: SSEStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SecurityGroupMembership")
model SecurityGroupMembership {
  @doc("<p>The unique ID for this security group.</p>")
  securityGroupIdentifier?: string;

  @doc("<p>The status of this security group.</p>")
  status?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface DaxClusters {
  get is ArmResourceRead<DaxCluster>;
  @doc("Create a DaxCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<DaxCluster>;
  update is ArmCustomPatchAsync<
    DaxCluster,
    Azure.ResourceManager.Foundations.TagsUpdateModel<DaxCluster>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DaxCluster>;
  listByResourceGroup is ArmResourceListByParent<DaxCluster>;
  listBySubscription is ArmListBySubscription<DaxCluster>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\dax\dax-2017-04-19.normal.json
// AWS Shape: Cluster
//
// Related information for backend service:
// AWS Servcie : DAX
// Product Version : 3.7.798.0
// SDK Version : 3.7.300.83
//--------------------------------------------------------------------------------------------
