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

//---------------------------------------------- Ec2TransitGatewayMulticastDomainAssociations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Ec2TransitGatewayMulticastDomainAssociation
  is TrackedResource<Ec2TransitGatewayMulticastDomainAssociationProperties> {
  @doc("Name of Ec2TransitGatewayMulticastDomainAssociation")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2TransitGatewayMulticastDomainAssociations")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Ec2TransitGatewayMulticastDomainAssociation")
model Ec2TransitGatewayMulticastDomainAssociationProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEc2TransitGatewayMulticastDomainAssociationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsEc2TransitGatewayMulticastDomainAssociation")
model AwsEc2TransitGatewayMulticastDomainAssociationProperties {
  @doc("Gets and sets the property resourceId. The ID of the resource.")
  resourceId?: string;

  @doc("Gets and sets the property resourceType. The type of resource, for example a VPC attachment.")
  resourceType?: string;

  @doc("Gets and sets the property state. The state of the subnet association.")
  state?: string;

  @doc("Gets and sets the property subnetId. The IDs of the subnets to associate with the transit gateway multicast domain.")
  subnetId?: string;

  @doc("Gets and sets the property transitGatewayAttachmentId. The ID of the transit gateway attachment.")
  transitGatewayAttachmentId?: string;

  @doc("Gets and sets the property transitGatewayMulticastDomainId. The ID of the transit gateway multicast domain.")
  transitGatewayMulticastDomainId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2TransitGatewayMulticastDomainAssociations {
  get is ArmResourceRead<Ec2TransitGatewayMulticastDomainAssociation>;
  @doc("Create a Ec2TransitGatewayMulticastDomainAssociation. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2TransitGatewayMulticastDomainAssociation>;
  update is ArmCustomPatchAsync<
    Ec2TransitGatewayMulticastDomainAssociation,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2TransitGatewayMulticastDomainAssociation>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2TransitGatewayMulticastDomainAssociation>;
  listByResourceGroup is ArmResourceListByParent<Ec2TransitGatewayMulticastDomainAssociation>;
  listBySubscription is ArmListBySubscription<Ec2TransitGatewayMulticastDomainAssociation>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::TransitGatewayMulticastDomainAssociation
//--------------------------------------------------------------------------------------------
