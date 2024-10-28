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

//---------------------------------------------- Ec2Subnets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Subnet",
    plural: "EC2 Subnets",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Subnet"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2Subnet is TrackedResource<Ec2SubnetProperties> {
  @doc("Name of Ec2Subnet")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2Subnets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2Subnet")
model Ec2SubnetProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2SubnetProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2Subnet")
model AwsEc2SubnetProperties {
  @doc("Indicates whether a network interface created in this subnet receives an IPv6 address. The default value is ``false``. If you specify ``AssignIpv6AddressOnCreation``, you must also specify an IPv6 CIDR block.")
  assignIpv6AddressOnCreation?: boolean;

  @doc("The Availability Zone of the subnet. If you update this property, you must also update the ``CidrBlock`` property.")
  availabilityZone?: string;

  @doc("The AZ ID of the subnet.")
  availabilityZoneId?: string;

  @doc("The IPv4 CIDR block assigned to the subnet. If you update this property, we create a new subnet, and then delete the existing one.")
  cidrBlock?: string;

  @doc("Indicates whether DNS queries made to the Amazon-provided DNS Resolver in this subnet should return synthetic IPv6 addresses for IPv4-only destinations. For more information, see [DNS64 and NAT64](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html#nat-gateway-nat64-dns64) in the *User Guide*.")
  enableDns64?: boolean;

  @doc("Indicates the device position for local network interfaces in this subnet. For example, ``1`` indicates local network interfaces in this subnet are the secondary network interface (eth1).")
  enableLniAtDeviceIndex?: int32;

  @doc("An IPv4 IPAM pool ID for the subnet.")
  ipv4IpamPoolId?: string;

  @doc("An IPv4 netmask length for the subnet.")
  ipv4NetmaskLength?: int32;

  @doc("The IPv6 CIDR block. If you specify ``AssignIpv6AddressOnCreation``, you must also specify an IPv6 CIDR block.")
  ipv6CidrBlock?: string;

  @doc("The IPv6 network ranges for the subnet, in CIDR notation.")
  @extension("x-ms-identifiers", [])
  ipv6CidrBlocks?: string[];

  @doc("An IPv6 IPAM pool ID for the subnet.")
  ipv6IpamPoolId?: string;

  @doc("Indicates whether this is an IPv6 only subnet. For more information, see [Subnet basics](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html#subnet-basics) in the *User Guide*.")
  ipv6Native?: boolean;

  @doc("An IPv6 netmask length for the subnet.")
  ipv6NetmaskLength?: int32;

  @doc("Indicates whether instances launched in this subnet receive a public IPv4 address. The default value is ``false``.  AWS charges for all public IPv4 addresses, including public IPv4 addresses associated with running instances and Elastic IP addresses. For more information, see the *Public IPv4 Address* tab on the [VPC pricing page](https://docs.aws.amazon.com/vpc/pricing/).")
  mapPublicIpOnLaunch?: boolean;

  @doc("Property networkAclAssociationId")
  networkAclAssociationId?: string;

  @doc("The Amazon Resource Name (ARN) of the Outpost.")
  outpostArn?: string;

  @doc("The hostname type for EC2 instances launched into this subnet and how DNS A and AAAA record queries to the instances should be handled. For more information, see [Amazon EC2 instance hostname types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-naming.html) in the *User Guide*. Available options:  +  EnableResourceNameDnsAAAARecord (true | false)  +  EnableResourceNameDnsARecord (true | false)  +  HostnameType (ip-name | resource-name)")
  privateDnsNameOptionsOnLaunch?: PrivateDnsNameOptionsOnLaunchModelProperties;

  @doc("Property subnetId")
  subnetId?: string;

  @doc("Any tags assigned to the subnet.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The ID of the VPC the subnet is in. If you update this property, you must also update the ``CidrBlock`` property.")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PrivateDnsNameOptionsOnLaunchModelProperties")
model PrivateDnsNameOptionsOnLaunchModelProperties {
  @doc("Property enableResourceNameDnsAAAARecord")
  enableResourceNameDnsAAAARecord?: boolean;

  @doc("Property enableResourceNameDnsARecord")
  enableResourceNameDnsARecord?: boolean;

  @doc("Property hostnameType")
  hostnameType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The tag key.")
  key?: string;

  @doc("The tag value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2Subnets {
  get is ArmResourceRead<Ec2Subnet>;
  @doc("Create a Ec2Subnet. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2Subnet>;
  update is ArmCustomPatchAsync<
    Ec2Subnet,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2Subnet>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2Subnet>;
  listByResourceGroup is ArmResourceListByParent<Ec2Subnet>;
  listBySubscription is ArmListBySubscription<Ec2Subnet>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::Subnet
//--------------------------------------------------------------------------------------------
