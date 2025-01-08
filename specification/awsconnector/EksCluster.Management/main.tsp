import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

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

//---------------------------------------------- EksClusters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
@singleton
model EksCluster is ExtensionResource<EksClusterProperties> {
  @doc("Name of EksCluster")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("eksClusters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EksCluster")
model EksClusterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEksClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEksCluster")
model AwsEksClusterProperties {
  @doc("<p>The access configuration for the cluster.</p>")
  accessConfig?: AccessConfigResponse;

  @doc("<p>The Amazon Resource Name (ARN) of the cluster.</p>")
  arn?: string;

  @doc("<p>The <code>certificate-authority-data</code> for your cluster.</p>")
  certificateAuthority?: Certificate;

  @doc("<p>A unique, case-sensitive identifier that you provide to ensure the idempotency of the request.</p>")
  clientRequestToken?: string;

  @doc("<p>The configuration used to connect to a cluster for registration.</p>")
  connectorConfig?: ConnectorConfigResponse;

  @doc("<p>The Unix epoch timestamp at object creation.</p>")
  createdAt?: utcDateTime;

  @doc("<p>The encryption configuration for the cluster.</p>")
  @extension("x-ms-identifiers", [])
  encryptionConfig?: EncryptionConfig[];

  @doc("<p>The endpoint for your Kubernetes API server.</p>")
  endpoint?: string;

  @doc("<p>An object representing the health of your local Amazon EKS cluster on an Amazon Web Services Outpost. This object isn't available for clusters on the Amazon Web Services cloud.</p>")
  health?: ClusterHealth;

  @doc("<p>The ID of your local Amazon EKS cluster on an Amazon Web Services Outpost. This property isn't available for an Amazon EKS cluster on the Amazon Web Services cloud.</p>")
  id?: string;

  @doc("<p>The identity provider information for the cluster.</p>")
  identity?: Identity;

  @doc("<p>The Kubernetes network configuration for the cluster.</p>")
  kubernetesNetworkConfig?: KubernetesNetworkConfigResponse;

  @doc("<p>The logging configuration for your cluster.</p>")
  logging?: Logging;

  @doc("<p>The name of your cluster.</p>")
  name?: string;

  @doc("<p>An object representing the configuration of your local Amazon EKS cluster on an Amazon Web Services Outpost. This object isn't available for clusters on the Amazon Web Services cloud.</p>")
  outpostConfig?: OutpostConfigResponse;

  @doc("<p>The platform version of your Amazon EKS cluster. For more information about clusters deployed on the Amazon Web Services Cloud, see <a href='https://docs.aws.amazon.com/eks/latest/userguide/platform-versions.html'>Platform versions</a> in the <i> <i>Amazon EKS User Guide</i> </i>. For more information about local clusters deployed on an Outpost, see <a href='https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-platform-versions.html'>Amazon EKS local cluster platform versions</a> in the <i> <i>Amazon EKS User Guide</i> </i>.</p>")
  platformVersion?: string;

  @doc("<p>The VPC configuration used by the cluster control plane. Amazon EKS VPC resources have specific requirements to work properly with Kubernetes. For more information, see <a href='https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html'>Cluster VPC considerations</a> and <a href='https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html'>Cluster security group considerations</a> in the <i>Amazon EKS User Guide</i>.</p>")
  resourcesVpcConfig?: VpcConfigResponse;

  @doc("<p>The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to Amazon Web Services API operations on your behalf.</p>")
  roleArn?: string;

  @doc("<p>The current status of the cluster.</p>")
  status?: ClusterStatusEnumValue;

  @doc("<p>Metadata that assists with categorization and organization. Each tag consists of a key and an optional value. You define both. Tags don't propagate to any other cluster or Amazon Web Services resources.</p>")
  tags?: Record<string>;

  @doc("<p>The Kubernetes server version for the cluster.</p>")
  version?: string;
}

@doc("ClusterStatus enum")
union ClusterStatus {
  @doc("ClusterStatus enum ACTIVE")
  ACTIVE: "ACTIVE",

  @doc("ClusterStatus enum CREATING")
  CREATING: "CREATING",

  @doc("ClusterStatus enum DELETING")
  DELETING: "DELETING",

  @doc("ClusterStatus enum FAILED")
  FAILED: "FAILED",

  @doc("ClusterStatus enum PENDING")
  PENDING: "PENDING",

  @doc("ClusterStatus enum UPDATING")
  UPDATING: "UPDATING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterStatusEnumValue")
model ClusterStatusEnumValue {
  @doc("Property value")
  value?: ClusterStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AccessConfigResponse")
model AccessConfigResponse {
  @doc("<p>The current authentication mode of the cluster.</p>")
  authenticationMode?: AuthenticationModeEnumValue;

  @doc("<p>Specifies whether or not the cluster creator IAM principal was set as a cluster admin access entry during cluster creation time.</p>")
  bootstrapClusterCreatorAdminPermissions?: boolean;
}

@doc("AuthenticationMode enum")
union AuthenticationMode {
  @doc("AuthenticationMode enum API")
  API: "API",

  @doc("AuthenticationMode enum API_AND_CONFIG_MAP")
  API_AND_CONFIG_MAP: "API_AND_CONFIG_MAP",

  @doc("AuthenticationMode enum CONFIG_MAP")
  CONFIG_MAP: "CONFIG_MAP",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AuthenticationModeEnumValue")
model AuthenticationModeEnumValue {
  @doc("Property value")
  value?: AuthenticationMode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Certificate")
model Certificate {
  @doc("<p>The Base64-encoded certificate data required to communicate with your cluster. Add this to the <code>certificate-authority-data</code> section of the <code>kubeconfig</code> file for your cluster.</p>")
  data?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConnectorConfigResponse")
model ConnectorConfigResponse {
  @doc("<p>A unique code associated with the cluster for registration purposes.</p>")
  activationCode?: string;

  @doc("<p>The expiration time of the connected cluster. The cluster's YAML file must be applied through the native provider.</p>")
  activationExpiry?: utcDateTime;

  @doc("<p>A unique ID associated with the cluster for registration purposes.</p>")
  activationId?: string;

  @doc("<p>The cluster's cloud service provider.</p>")
  provider?: string;

  @doc("<p>The Amazon Resource Name (ARN) of the role to communicate with services from the connected Kubernetes cluster.</p>")
  roleArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EncryptionConfig")
model EncryptionConfig {
  @doc("<p>Key Management Service (KMS) key. Either the ARN or the alias can be used.</p>")
  provider?: Provider;

  @doc("<p>Specifies the resources to be encrypted. The only supported value is <code>secrets</code>.</p>")
  @extension("x-ms-identifiers", [])
  resources?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterHealth")
model ClusterHealth {
  @doc("<p>An object representing the health issues of your local Amazon EKS cluster on an Amazon Web Services Outpost.</p>")
  @extension("x-ms-identifiers", [])
  issues?: ClusterIssue[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Identity")
model Identity {
  @doc("<p>An object representing the <a href='https://openid.net/connect/'>OpenID Connect</a> identity provider information.</p>")
  oidc?: OIDC;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KubernetesNetworkConfigResponse")
model KubernetesNetworkConfigResponse {
  @doc("<p>The IP family used to assign Kubernetes <code>Pod</code> and <code>Service</code> objects IP addresses. The IP family is always <code>ipv4</code>, unless you have a <code>1.21</code> or later cluster running version <code>1.10.1</code> or later of the Amazon VPC CNI plugin for Kubernetes and specified <code>ipv6</code> when you created the cluster. </p>")
  ipFamily?: IpFamilyEnumValue;

  @doc("<p>The CIDR block that Kubernetes <code>Pod</code> and <code>Service</code> object IP addresses are assigned from. Kubernetes assigns addresses from an <code>IPv4</code> CIDR block assigned to a subnet that the node is in. If you didn't specify a CIDR block when you created the cluster, then Kubernetes assigns addresses from either the <code>10.100.0.0/16</code> or <code>172.20.0.0/16</code> CIDR blocks. If this was specified, then it was specified when the cluster was created and it can't be changed.</p>")
  serviceIpv4Cidr?: string;

  @doc("<p>The CIDR block that Kubernetes pod and service IP addresses are assigned from if you created a 1.21 or later cluster with version 1.10.1 or later of the Amazon VPC CNI add-on and specified <code>ipv6</code> for <b>ipFamily</b> when you created the cluster. Kubernetes assigns service addresses from the unique local address range (<code>fc00::/7</code>) because you can't specify a custom IPv6 CIDR block when you create the cluster.</p>")
  serviceIpv6Cidr?: string;
}

@doc("IpFamily enum")
union IpFamily {
  @doc("IpFamily enum ipv4")
  Ipv4: "ipv4",

  @doc("IpFamily enum ipv6")
  Ipv6: "ipv6",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IpFamilyEnumValue")
model IpFamilyEnumValue {
  @doc("Property value")
  value?: IpFamily;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Logging")
model Logging {
  @doc("<p>The cluster control plane logging configuration for your cluster.</p>")
  @extension("x-ms-identifiers", [])
  clusterLogging?: LogSetup[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OutpostConfigResponse")
model OutpostConfigResponse {
  @doc("<p>The Amazon EC2 instance type used for the control plane. The instance type is the same for all control plane instances.</p>")
  controlPlaneInstanceType?: string;

  @doc("<p>An object representing the placement configuration for all the control plane instances of your local Amazon EKS cluster on an Amazon Web Services Outpost. For more information, see <a href='https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-capacity-considerations.html'>Capacity considerations</a> in the <i>Amazon EKS User Guide</i>.</p>")
  controlPlanePlacement?: ControlPlanePlacementResponse;

  @doc("<p>The ARN of the Outpost that you specified for use with your local Amazon EKS cluster on Outposts.</p>")
  @extension("x-ms-identifiers", [])
  outpostArns?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VpcConfigResponse")
model VpcConfigResponse {
  @doc("<p>The cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication.</p>")
  clusterSecurityGroupId?: string;

  @doc("<p>This parameter indicates whether the Amazon EKS private API server endpoint is enabled. If the Amazon EKS private API server endpoint is enabled, Kubernetes API requests that originate from within your cluster's VPC use the private VPC endpoint instead of traversing the internet. If this value is disabled and you have nodes or Fargate pods in the cluster, then ensure that <code>publicAccessCidrs</code> includes the necessary CIDR blocks for communication with the nodes or Fargate pods. For more information, see <a href='https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html'>Amazon EKS cluster endpoint access control</a> in the <i> <i>Amazon EKS User Guide</i> </i>.</p>")
  endpointPrivateAccess?: boolean;

  @doc("<p>Whether the public API server endpoint is enabled.</p>")
  endpointPublicAccess?: boolean;

  @doc("<p>The CIDR blocks that are allowed access to your cluster's public Kubernetes API server endpoint.</p>")
  @extension("x-ms-identifiers", [])
  publicAccessCidrs?: string[];

  @doc("<p>The security groups associated with the cross-account elastic network interfaces that are used to allow communication between your nodes and the Kubernetes control plane.</p>")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("<p>The subnets associated with your cluster.</p>")
  @extension("x-ms-identifiers", [])
  subnetIds?: string[];

  @doc("<p>The VPC associated with your cluster.</p>")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Provider")
model Provider {
  @doc("<p>Amazon Resource Name (ARN) or alias of the KMS key. The KMS key must be symmetric and created in the same Amazon Web Services Region as the cluster. If the KMS key was created in a different account, the <a href='https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html'>IAM principal</a> must have access to the KMS key. For more information, see <a href='https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-modifying-external-accounts.html'>Allowing users in other accounts to use a KMS key</a> in the <i>Key Management Service Developer Guide</i>.</p>")
  keyArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterIssue")
model ClusterIssue {
  @doc("<p>The error code of the issue.</p>")
  code?: ClusterIssueCodeEnumValue;

  @doc("<p>A description of the issue.</p>")
  message?: string;

  @doc("<p>The resource IDs that the issue relates to.</p>")
  @extension("x-ms-identifiers", [])
  resourceIds?: string[];
}

@doc("ClusterIssueCode enum")
union ClusterIssueCode {
  @doc("ClusterIssueCode enum AccessDenied")
  AccessDenied: "AccessDenied",

  @doc("ClusterIssueCode enum ClusterUnreachable")
  ClusterUnreachable: "ClusterUnreachable",

  @doc("ClusterIssueCode enum ConfigurationConflict")
  ConfigurationConflict: "ConfigurationConflict",

  @doc("ClusterIssueCode enum Ec2SecurityGroupNotFound")
  Ec2SecurityGroupNotFound: "Ec2SecurityGroupNotFound",

  @doc("ClusterIssueCode enum Ec2ServiceNotSubscribed")
  Ec2ServiceNotSubscribed: "Ec2ServiceNotSubscribed",

  @doc("ClusterIssueCode enum Ec2SubnetNotFound")
  Ec2SubnetNotFound: "Ec2SubnetNotFound",

  @doc("ClusterIssueCode enum IamRoleNotFound")
  IamRoleNotFound: "IamRoleNotFound",

  @doc("ClusterIssueCode enum InsufficientFreeAddresses")
  InsufficientFreeAddresses: "InsufficientFreeAddresses",

  @doc("ClusterIssueCode enum InternalFailure")
  InternalFailure: "InternalFailure",

  @doc("ClusterIssueCode enum KmsGrantRevoked")
  KmsGrantRevoked: "KmsGrantRevoked",

  @doc("ClusterIssueCode enum KmsKeyDisabled")
  KmsKeyDisabled: "KmsKeyDisabled",

  @doc("ClusterIssueCode enum KmsKeyMarkedForDeletion")
  KmsKeyMarkedForDeletion: "KmsKeyMarkedForDeletion",

  @doc("ClusterIssueCode enum KmsKeyNotFound")
  KmsKeyNotFound: "KmsKeyNotFound",

  @doc("ClusterIssueCode enum Other")
  Other: "Other",

  @doc("ClusterIssueCode enum ResourceLimitExceeded")
  ResourceLimitExceeded: "ResourceLimitExceeded",

  @doc("ClusterIssueCode enum ResourceNotFound")
  ResourceNotFound: "ResourceNotFound",

  @doc("ClusterIssueCode enum StsRegionalEndpointDisabled")
  StsRegionalEndpointDisabled: "StsRegionalEndpointDisabled",

  @doc("ClusterIssueCode enum UnsupportedVersion")
  UnsupportedVersion: "UnsupportedVersion",

  @doc("ClusterIssueCode enum VpcNotFound")
  VpcNotFound: "VpcNotFound",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterIssueCodeEnumValue")
model ClusterIssueCodeEnumValue {
  @doc("Property value")
  value?: ClusterIssueCode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OIDC")
model OIDC {
  @doc("<p>The issuer URL for the OIDC identity provider.</p>")
  issuer?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogSetup")
model LogSetup {
  @doc("<p>If a log type is enabled, that log type exports its control plane logs to CloudWatch Logs. If a log type isn't enabled, that log type doesn't export its control plane logs. Each individual log type can be enabled or disabled independently.</p>")
  enabled?: boolean;

  @doc("<p>The available cluster control plane log types.</p>")
  @extension("x-ms-identifiers", [])
  types?: LogType[];
}

@doc("LogType enum")
union LogType {
  @doc("LogType enum api")
  Api: "api",

  @doc("LogType enum audit")
  Audit: "audit",

  @doc("LogType enum authenticator")
  Authenticator: "authenticator",

  @doc("LogType enum controllerManager")
  ControllerManager: "controllerManager",

  @doc("LogType enum scheduler")
  Scheduler: "scheduler",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogTypeEnumValue")
model LogTypeEnumValue {
  @doc("Property value")
  value?: LogType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ControlPlanePlacementResponse")
model ControlPlanePlacementResponse {
  @doc("<p>The name of the placement group for the Kubernetes control plane instances.</p>")
  groupName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EksClusters {
  get is ArmResourceRead<EksCluster>;
  @doc("Create a EksCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<EksCluster>;
  delete is ArmResourceDeleteWithoutOkAsync<EksCluster>;
  list is ArmResourceListByParent<EksCluster>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\eks\eks-2017-11-01.normal.json
// AWS Shape: Cluster
//
// Related information for backend service:
// AWS Servcie : EKS
// Product Version : 3.7.798.0
// SDK Version : 3.7.305.19
//--------------------------------------------------------------------------------------------
