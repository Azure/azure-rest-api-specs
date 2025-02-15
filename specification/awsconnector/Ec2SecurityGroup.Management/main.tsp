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

//---------------------------------------------- Ec2SecurityGroups ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Security Group",
    plural: "EC2 Security Groups",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Security", "Group"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2SecurityGroup is TrackedResource<Ec2SecurityGroupProperties> {
  @doc("Name of Ec2SecurityGroup")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2SecurityGroups")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2SecurityGroup")
model Ec2SecurityGroupProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2SecurityGroupProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2SecurityGroup")
model AwsEc2SecurityGroupProperties {
  @doc("<p>A description of the security group.</p>")
  description?: string;

  @doc("<p>The ID of the security group.</p>")
  groupId?: string;

  @doc("<p>The name of the security group.</p>")
  groupName?: string;

  @doc("<p>The inbound rules associated with the security group.</p>")
  @extension("x-ms-identifiers", [])
  ipPermissions?: IpPermission[];

  @doc("<p>The outbound rules associated with the security group.</p>")
  @extension("x-ms-identifiers", [])
  ipPermissionsEgress?: IpPermission[];

  @doc("<p>The Amazon Web Services account ID of the owner of the security group.</p>")
  ownerId?: string;

  @doc("<p>Any tags assigned to the security group.</p>")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("<p>The ID of the VPC for the security group.</p>")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IpPermission")
model IpPermission {
  @doc("<p>If the protocol is TCP or UDP, this is the start of the port range. If the protocol is ICMP or ICMPv6, this is the ICMP type or -1 (all ICMP types).</p>")
  fromPort?: int32;

  @doc("<p>The IP protocol name (<code>tcp</code>, <code>udp</code>, <code>icmp</code>, <code>icmpv6</code>) or number (see <a href='http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml'>Protocol Numbers</a>).</p> <p>Use <code>-1</code> to specify all protocols. When authorizing security group rules, specifying <code>-1</code> or a protocol number other than <code>tcp</code>, <code>udp</code>, <code>icmp</code>, or <code>icmpv6</code> allows traffic on all ports, regardless of any port range you specify. For <code>tcp</code>, <code>udp</code>, and <code>icmp</code>, you must specify a port range. For <code>icmpv6</code>, the port range is optional; if you omit the port range, traffic for all types and codes is allowed.</p>")
  ipProtocol?: string;

  @doc("<p>The IPv4 address ranges.</p>")
  @extension("x-ms-identifiers", [])
  ipRanges?: IpRange[];

  @doc("<p>The IPv6 address ranges.</p>")
  @extension("x-ms-identifiers", [])
  ipv6Ranges?: Ipv6Range[];

  @doc("<p>The prefix list IDs.</p>")
  @extension("x-ms-identifiers", [])
  prefixListIds?: PrefixListId[];

  @doc("<p>If the protocol is TCP or UDP, this is the end of the port range. If the protocol is ICMP or ICMPv6, this is the ICMP code or -1 (all ICMP codes). If the start port is -1 (all ICMP types), then the end port must be -1 (all ICMP codes).</p>")
  toPort?: int32;

  @doc("<p>The security group and Amazon Web Services account ID pairs.</p>")
  @extension("x-ms-identifiers", [])
  userIdGroupPairs?: UserIdGroupPair[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("<p>The key of the tag.</p> <p>Constraints: Tag keys are case-sensitive and accept a maximum of 127 Unicode characters. May not begin with <code>aws:</code>.</p>")
  key?: string;

  @doc("<p>The value of the tag.</p> <p>Constraints: Tag values are case-sensitive and accept a maximum of 256 Unicode characters.</p>")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IpRange")
model IpRange {
  @doc("<p>The IPv4 address range. You can either specify a CIDR block or a source security group, not both. To specify a single IPv4 address, use the /32 prefix length.</p>")
  cidrIp?: string;

  @doc("<p>A description for the security group rule that references this IPv4 address range.</p> <p>Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&amp;;{}!$*</p>")
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ipv6Range")
model Ipv6Range {
  @doc("<p>The IPv6 address range. You can either specify a CIDR block or a source security group, not both. To specify a single IPv6 address, use the /128 prefix length.</p>")
  cidrIpv6?: string;

  @doc("<p>A description for the security group rule that references this IPv6 address range.</p> <p>Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&amp;;{}!$*</p>")
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PrefixListId")
model PrefixListId {
  @doc("<p>A description for the security group rule that references this prefix list ID.</p> <p>Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*</p>")
  description?: string;

  @doc("<p>The ID of the prefix.</p>")
  @clientName("prefixListIdcsharp", "csharp")
  prefixListId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of UserIdGroupPair")
model UserIdGroupPair {
  @doc("<p>A description for the security group rule that references this user ID group pair.</p> <p>Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*</p>")
  description?: string;

  @doc("<p>The ID of the security group.</p>")
  groupId?: string;

  @doc("<p>[Default VPC] The name of the security group. For a security group in a nondefault VPC, use the security group ID. </p> <p>For a referenced security group in another VPC, this value is not returned if the referenced security group is deleted.</p>")
  groupName?: string;

  @doc("<p>The status of a VPC peering connection, if applicable.</p>")
  peeringStatus?: string;

  @doc("<p>The ID of an Amazon Web Services account.</p> <p>For a referenced security group in another VPC, the account ID of the referenced security group is returned in the response. If the referenced security group is deleted, this value is not returned.</p>")
  userId?: string;

  @doc("<p>The ID of the VPC for the referenced security group, if applicable.</p>")
  vpcId?: string;

  @doc("<p>The ID of the VPC peering connection, if applicable.</p>")
  vpcPeeringConnectionId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2SecurityGroups {
  get is ArmResourceRead<Ec2SecurityGroup>;
  @doc("Create a Ec2SecurityGroup. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2SecurityGroup>;
  update is ArmCustomPatchAsync<
    Ec2SecurityGroup,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2SecurityGroup>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2SecurityGroup>;
  listByResourceGroup is ArmResourceListByParent<Ec2SecurityGroup>;
  listBySubscription is ArmListBySubscription<Ec2SecurityGroup>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: SecurityGroup
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.798.0
// SDK Version : 3.7.325.2
//--------------------------------------------------------------------------------------------
