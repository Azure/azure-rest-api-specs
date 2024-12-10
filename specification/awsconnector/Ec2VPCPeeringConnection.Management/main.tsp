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

//---------------------------------------------- Ec2VPCPeeringConnections ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 VPCPeering Connection",
    plural: "EC2 VPCPeering Connections",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "VPCPeering", "Connection"],
})
@doc("A Microsoft.AwsConnector resource")
model Ec2VPCPeeringConnection
  is TrackedResource<Ec2VPCPeeringConnectionProperties> {
  @doc("Name of Ec2VPCPeeringConnection")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2VPCPeeringConnections")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2VPCPeeringConnection")
model Ec2VPCPeeringConnectionProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2VPCPeeringConnectionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2VPCPeeringConnection")
model AwsEc2VPCPeeringConnectionProperties {
  @doc("Property id")
  id?: string;

  @doc("The AWS account ID of the owner of the accepter VPC.")
  peerOwnerId?: string;

  @doc("The Region code for the accepter VPC, if the accepter VPC is located in a Region other than the Region in which you make the request.")
  peerRegion?: string;

  @doc("The Amazon Resource Name (ARN) of the VPC peer role for the peering connection in another AWS account.")
  peerRoleArn?: string;

  @doc("The ID of the VPC with which you are creating the VPC peering connection. You must specify this parameter in the request.")
  peerVpcId?: string;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The ID of the VPC.")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2VPCPeeringConnections {
  get is ArmResourceRead<Ec2VPCPeeringConnection>;
  @doc("Create a Ec2VPCPeeringConnection. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2VPCPeeringConnection>;
  update is ArmCustomPatchAsync<
    Ec2VPCPeeringConnection,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2VPCPeeringConnection>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2VPCPeeringConnection>;
  listByResourceGroup is ArmResourceListByParent<Ec2VPCPeeringConnection>;
  listBySubscription is ArmListBySubscription<Ec2VPCPeeringConnection>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::VPCPeeringConnection
//--------------------------------------------------------------------------------------------
