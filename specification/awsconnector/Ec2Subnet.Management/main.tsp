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

//---------------------------------------------- Ec2Subnets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEc2SubnetProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2Subnet")
model AwsEc2SubnetProperties {
  @doc("Gets and sets the property assignIpv6AddressOnCreation.")
  assignIpv6AddressOnCreation?: boolean;

  @doc("Gets and sets the property availabilityZone.")
  availabilityZone?: string;

  @doc("Gets and sets the property availabilityZoneId.")
  availabilityZoneId?: string;

  @doc("Gets and sets the property cidrBlock.")
  cidrBlock?: string;

  @doc("Gets and sets the property enableDns64.")
  enableDns64?: boolean;

  @doc("Gets and sets the property ipv4IpamPoolId. The ID of an IPv4 IPAM pool you want to use for allocating this subnet's CIDR")
  ipv4IpamPoolId?: string;

  @doc("Gets and sets the property ipv4NetmaskLength. The netmask length of the IPv4 CIDR you want to allocate to this subnet from an Amazon VPC IP Address Manager (IPAM) pool")
  ipv4NetmaskLength?: int32;

  @doc("Gets and sets the property ipv6CidrBlock.")
  ipv6CidrBlock?: string;

  @doc("Gets and sets the property ipv6CidrBlocks.")
  @extension("x-ms-identifiers", [])
  ipv6CidrBlocks?: string[];

  @doc("Gets and sets the property ipv6IpamPoolId. The ID of an IPv6 IPAM pool you want to use for allocating this subnet's CIDR")
  ipv6IpamPoolId?: string;

  @doc("Gets and sets the property ipv6Native.")
  ipv6Native?: boolean;

  @doc("Gets and sets the property ipv6NetmaskLength. The netmask length of the IPv6 CIDR you want to allocate to this subnet from an Amazon VPC IP Address Manager (IPAM) pool")
  ipv6NetmaskLength?: int32;

  @doc("Gets and sets the property mapPublicIpOnLaunch.")
  mapPublicIpOnLaunch?: boolean;

  @doc("Gets and sets the property networkAclAssociationId.")
  networkAclAssociationId?: string;

  @doc("Gets and sets the property outpostArn.")
  outpostArn?: string;

  @doc("Gets and sets the property privateDnsNameOptionsOnLaunch.")
  privateDnsNameOptionsOnLaunch?: PrivateDnsNameOptionsOnLaunchModelProperties;

  @doc("Gets and sets the property subnetId.")
  subnetId?: string;

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property vpcId.")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PrivateDnsNameOptionsOnLaunchModelProperties")
model PrivateDnsNameOptionsOnLaunchModelProperties {
  @doc("Gets and sets the property enableResourceNameDnsAAAARecord.")
  enableResourceNameDnsAAAARecord?: boolean;

  @doc("Gets and sets the property enableResourceNameDnsARecord.")
  enableResourceNameDnsARecord?: boolean;

  @doc("Gets and sets the property hostnameType.")
  hostnameType?: string;
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
interface Ec2Subnets {
  get is ArmResourceRead<Ec2Subnet>;
  @doc("Create a Ec2Subnet. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2Subnet>;
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
