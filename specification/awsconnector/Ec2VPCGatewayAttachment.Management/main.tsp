import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
  version: "2024-08-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

//---------------------------------------------- Ec2VPCGatewayAttachments ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Ec2VPCGatewayAttachment
  is TrackedResource<Ec2VPCGatewayAttachmentProperties> {
  @doc("Name of Ec2VPCGatewayAttachment")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2VPCGatewayAttachments")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Ec2VPCGatewayAttachment")
model Ec2VPCGatewayAttachmentProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEc2VPCGatewayAttachmentProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsEc2VPCGatewayAttachment")
model AwsEc2VPCGatewayAttachmentProperties {
  @doc("Gets and sets the property attachmentType. Used to identify if this resource is an Internet Gateway or Vpn Gateway Attachment ")
  attachmentType?: string;

  @doc("Gets and sets the property internetGatewayId. The ID of the internet gateway. You must specify either InternetGatewayId or VpnGatewayId, but not both.")
  internetGatewayId?: string;

  @doc("Gets and sets the property vpcId. The ID of the VPC.")
  vpcId?: string;

  @doc("Gets and sets the property vpnGatewayId. The ID of the virtual private gateway. You must specify either InternetGatewayId or VpnGatewayId, but not both.")
  vpnGatewayId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2VPCGatewayAttachments {
  get is ArmResourceRead<Ec2VPCGatewayAttachment>;
  @doc("Create a Ec2VPCGatewayAttachment. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2VPCGatewayAttachment>;
  update is ArmCustomPatchAsync<
    Ec2VPCGatewayAttachment,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2VPCGatewayAttachment>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2VPCGatewayAttachment>;
  listByResourceGroup is ArmResourceListByParent<Ec2VPCGatewayAttachment>;
  listBySubscription is ArmListBySubscription<Ec2VPCGatewayAttachment>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::VPCGatewayAttachment
//--------------------------------------------------------------------------------------------
