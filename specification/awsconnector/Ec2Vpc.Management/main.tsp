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

//---------------------------------------------- Ec2Vpcs ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Ec2Vpc is TrackedResource<Ec2VpcProperties> {
  @doc("Name of Ec2Vpc")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2Vpcs")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2Vpc")
model Ec2VpcProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEc2VpcProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2Vpc")
model AwsEc2VpcProperties {
  @doc("Gets and sets the property cidrBlock. The primary IPv4 CIDR block for the VPC.")
  cidrBlock?: string;

  @doc("Gets and sets the property cidrBlockAssociations. A list of IPv4 CIDR block association IDs for the VPC.")
  @extension("x-ms-identifiers", [])
  cidrBlockAssociations?: string[];

  @doc("Gets and sets the property defaultNetworkAcl. The default network ACL ID that is associated with the VPC.")
  defaultNetworkAcl?: string;

  @doc("Gets and sets the property defaultSecurityGroup. The default security group ID that is associated with the VPC.")
  defaultSecurityGroup?: string;

  @doc("Gets and sets the property enableDnsHostnames. Indicates whether the instances launched in the VPC get DNS hostnames. If enabled, instances in the VPC get DNS hostnames; otherwise, they do not. Disabled by default for nondefault VPCs.")
  enableDnsHostnames?: boolean;

  @doc("Gets and sets the property enableDnsSupport. Indicates whether the DNS resolution is supported for the VPC. If enabled, queries to the Amazon provided DNS server at the 169.254.169.253 IP address, or the reserved IP address at the base of the VPC network range 'plus two' succeed. If disabled, the Amazon provided DNS service in the VPC that resolves public DNS hostnames to IP addresses is not enabled. Enabled by default.")
  enableDnsSupport?: boolean;

  @doc("Gets and sets the property instanceTenancy. The allowed tenancy of instances launched into the VPC.'default': An instance launched into the VPC runs on shared hardware by default, unless you explicitly specify a different tenancy during instance launch.'dedicated': An instance launched into the VPC is a Dedicated Instance by default, unless you explicitly specify a tenancy of host during instance launch. You cannot specify a tenancy of default during instance launch.Updating InstanceTenancy requires no replacement only if you are updating its value from 'dedicated' to 'default'. Updating InstanceTenancy from 'default' to 'dedicated' requires replacement.")
  instanceTenancy?: string;

  @doc("Gets and sets the property ipv4IpamPoolId. The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR")
  ipv4IpamPoolId?: string;

  @doc("Gets and sets the property ipv4NetmaskLength. The netmask length of the IPv4 CIDR you want to allocate to this VPC from an Amazon VPC IP Address Manager (IPAM) pool")
  ipv4NetmaskLength?: int32;

  @doc("Gets and sets the property ipv6CidrBlocks. A list of IPv6 CIDR blocks that are associated with the VPC.")
  @extension("x-ms-identifiers", [])
  ipv6CidrBlocks?: string[];

  @doc("Gets and sets the property tags. The tags for the VPC.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property vpcId. The Id for the model.")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2Vpcs {
  get is ArmResourceRead<Ec2Vpc>;
  @doc("Create a Ec2Vpc. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2Vpc>;
  update is ArmCustomPatchAsync<
    Ec2Vpc,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2Vpc>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2Vpc>;
  listByResourceGroup is ArmResourceListByParent<Ec2Vpc>;
  listBySubscription is ArmListBySubscription<Ec2Vpc>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::VPC
//--------------------------------------------------------------------------------------------
