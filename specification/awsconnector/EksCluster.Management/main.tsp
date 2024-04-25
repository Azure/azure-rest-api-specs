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
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
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
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEksClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEksCluster")
model AwsEksClusterProperties {
  @doc("Gets and sets the property accessConfig. An object representing the Access Config to use for the cluster.")
  accessConfig?: AccessConfig;

  @doc("Gets and sets the property arn. The ARN of the cluster, such as arn:aws:eks:us-west-2:666666666666:cluster/prod.")
  arn?: string;

  @doc("Gets and sets the property certificateAuthorityData. The certificate-authority-data for your cluster.")
  certificateAuthorityData?: string;

  @doc("Gets and sets the property clusterSecurityGroupId. The cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control plane to data plane communication.")
  clusterSecurityGroupId?: string;

  @doc("Gets and sets the property encryptionConfig.")
  @extension("x-ms-identifiers", [])
  encryptionConfig?: EncryptionConfig[];

  @doc("Gets and sets the property encryptionConfigKeyArn. Amazon Resource Name (ARN) or alias of the customer master key (CMK).")
  encryptionConfigKeyArn?: string;

  @doc("Gets and sets the property endpoint. The endpoint for your Kubernetes API server, such as https://5E1D0CEXAMPLEA591B746AFC5AB30262.yl4.us-west-2.eks.amazonaws.com.")
  endpoint?: string;

  @doc("Gets and sets the property id. The unique ID given to your cluster.")
  id?: string;

  @doc("Gets and sets the property kubernetesNetworkConfig. The Kubernetes network configuration for the cluster.")
  kubernetesNetworkConfig?: KubernetesNetworkConfig;

  @doc("Gets and sets the property logging. Enable exporting the Kubernetes control plane logs for your cluster to CloudWatch Logs based on log types. By default, cluster control plane logs aren't exported to CloudWatch Logs.")
  logging?: Logging;

  @doc("Gets and sets the property name. The unique name to give to your cluster.")
  name?: string;

  @doc("Gets and sets the property openIdConnectIssuerUrl. The issuer URL for the cluster's OIDC identity provider, such as https://oidc.eks.us-west-2.amazonaws.com/id/EXAMPLED539D4633E53DE1B716D3041E. If you need to remove https:// from this output value, you can include the following code in your template.")
  openIdConnectIssuerUrl?: string;

  @doc("Gets and sets the property outpostConfig. An object representing the Outpost configuration to use for AWS EKS outpost cluster.")
  outpostConfig?: OutpostConfig;

  @doc("Gets and sets the property resourcesVpcConfig. An object representing the VPC configuration to use for an Amazon EKS cluster.")
  resourcesVpcConfig?: ResourcesVpcConfig;

  @doc("Gets and sets the property roleArn. The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf.")
  roleArn?: string;

  @doc("Gets and sets the property tags. An array of key-value pairs to apply to this resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property version. The desired Kubernetes version for your cluster. If you don't specify a value here, the latest version available in Amazon EKS is used.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AccessConfig")
model AccessConfig {
  @doc("Gets and sets the property authenticationMode. Specify the authentication mode that should be used to create your cluster.")
  authenticationMode?: AccessConfigAuthenticationMode;

  @doc("Gets and sets the property bootstrapClusterCreatorAdminPermissions. Set this value to false to avoid creating a default cluster admin Access Entry using the IAM principal used to create the cluster.")
  bootstrapClusterCreatorAdminPermissions?: boolean;
}

@doc("AccessConfigAuthenticationMode enum")
union AccessConfigAuthenticationMode {
  @doc("AccessConfigAuthenticationMode enum API")
  API: "API",

  @doc("AccessConfigAuthenticationMode enum API_AND_CONFIG_MAP")
  API_AND_CONFIG_MAP: "API_AND_CONFIG_MAP",

  @doc("AccessConfigAuthenticationMode enum CONFIG_MAP")
  CONFIG_MAP: "CONFIG_MAP",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EncryptionConfig")
model EncryptionConfig {
  @doc("Gets and sets the property provider. The encryption provider for the cluster.")
  provider?: Provider;

  @doc("Gets and sets the property resources. Specifies the resources to be encrypted. The only supported value is 'secrets'.")
  @extension("x-ms-identifiers", [])
  resources?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KubernetesNetworkConfig")
model KubernetesNetworkConfig {
  @doc("Gets and sets the property ipFamily. Ipv4 or Ipv6. You can only specify ipv6 for 1.21 and later clusters that use version 1.10.1 or later of the Amazon VPC CNI add-on")
  ipFamily?: KubernetesNetworkConfigIpFamily;

  @doc("Gets and sets the property serviceIpv4Cidr. The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks. We recommend that you specify a block that does not overlap with resources in other networks that are peered or connected to your VPC. ")
  serviceIpv4Cidr?: string;

  @doc("Gets and sets the property serviceIpv6Cidr. The CIDR block to assign Kubernetes service IP addresses from.")
  serviceIpv6Cidr?: string;
}

@doc("KubernetesNetworkConfigIpFamily enum")
union KubernetesNetworkConfigIpFamily {
  @doc("KubernetesNetworkConfigIpFamily enum ipv4")
  ipv4: "ipv4",

  @doc("KubernetesNetworkConfigIpFamily enum ipv6")
  ipv6: "ipv6",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Logging")
model Logging {
  @doc("Gets and sets the property clusterLogging. The cluster control plane logging configuration for your cluster.  The cluster control plane logging configuration for your cluster. ")
  clusterLogging?: ClusterLogging;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OutpostConfig")
model OutpostConfig {
  @doc("Gets and sets the property controlPlaneInstanceType. Specify the Instance type of the machines that should be used to create your cluster.")
  controlPlaneInstanceType?: string;

  @doc("Gets and sets the property controlPlanePlacement. Specify the placement group of the control plane machines for your cluster. Specify the placement group of the control plane machines for your cluster.")
  controlPlanePlacement?: ControlPlanePlacement;

  @doc("Gets and sets the property outpostArns. Specify one or more Arn(s) of Outpost(s) on which you would like to create your cluster.")
  @extension("x-ms-identifiers", [])
  outpostArns?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourcesVpcConfig")
model ResourcesVpcConfig {
  @doc("Gets and sets the property endpointPrivateAccess. Set this value to true to enable private access for your cluster's Kubernetes API server endpoint. If you enable private access, Kubernetes API requests from within your cluster's VPC use the private VPC endpoint. The default value for this parameter is false, which disables private access for your Kubernetes API server. If you disable private access and you have nodes or AWS Fargate pods in the cluster, then ensure that publicAccessCidrs includes the necessary CIDR blocks for communication with the nodes or Fargate pods.")
  endpointPrivateAccess?: boolean;

  @doc("Gets and sets the property endpointPublicAccess. Set this value to false to disable public access to your cluster's Kubernetes API server endpoint. If you disable public access, your cluster's Kubernetes API server can only receive requests from within the cluster VPC. The default value for this parameter is true, which enables public access for your Kubernetes API server.")
  endpointPublicAccess?: boolean;

  @doc("Gets and sets the property publicAccessCidrs. The CIDR blocks that are allowed access to your cluster's public Kubernetes API server endpoint. Communication to the endpoint from addresses outside of the CIDR blocks that you specify is denied. The default value is 0.0.0.0/0. If you've disabled private endpoint access and you have nodes or AWS Fargate pods in the cluster, then ensure that you specify the necessary CIDR blocks.")
  @extension("x-ms-identifiers", [])
  publicAccessCidrs?: string[];

  @doc("Gets and sets the property securityGroupIds. Specify one or more security groups for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane. If you don't specify a security group, the default security group for your VPC is used.")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Gets and sets the property subnetIds. Specify subnets for your Amazon EKS nodes. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your nodes and the Kubernetes control plane.")
  @extension("x-ms-identifiers", [])
  subnetIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Provider")
model Provider {
  @doc("Gets and sets the property keyArn. Amazon Resource Name (ARN) or alias of the KMS key. The KMS key must be symmetric, created in the same region as the cluster, and if the KMS key was created in a different account, the user must have access to the KMS key.")
  keyArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterLogging")
model ClusterLogging {
  @doc("Gets and sets the property enabledTypes. Enable control plane logs for your cluster, all log types will be disabled if the array is empty")
  @extension("x-ms-identifiers", [])
  enabledTypes?: LoggingTypeConfig[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ControlPlanePlacement")
model ControlPlanePlacement {
  @doc("Gets and sets the property groupName. Specify the placement group name of the control place machines for your cluster.")
  groupName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoggingTypeConfig")
model LoggingTypeConfig {
  @doc("Gets and sets the property type. name of the log type")
  type?: LoggingTypeConfigType;
}

@doc("LoggingTypeConfigType enum")
union LoggingTypeConfigType {
  @doc("LoggingTypeConfigType enum api")
  api: "api",

  @doc("LoggingTypeConfigType enum audit")
  audit: "audit",

  @doc("LoggingTypeConfigType enum authenticator")
  authenticator: "authenticator",

  @doc("LoggingTypeConfigType enum controllerManager")
  controllerManager: "controllerManager",

  @doc("LoggingTypeConfigType enum scheduler")
  scheduler: "scheduler",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EksClusters {
  get is ArmResourceRead<EksCluster>;
  @doc("Create a EksCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EksCluster>;
  delete is ArmResourceDeleteWithoutOkAsync<EksCluster>;
  list is ArmResourceListByParent<EksCluster>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EKS::Cluster
//--------------------------------------------------------------------------------------------
