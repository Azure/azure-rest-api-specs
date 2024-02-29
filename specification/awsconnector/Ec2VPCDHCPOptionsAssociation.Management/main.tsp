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

//---------------------------------------------- Ec2VPCDHCPOptionsAssociations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Ec2VPCDHCPOptionsAssociation
  is TrackedResource<Ec2VPCDHCPOptionsAssociationProperties> {
  @doc("Name of Ec2VPCDHCPOptionsAssociation")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2VPCDHCPOptionsAssociations")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Ec2VPCDHCPOptionsAssociation")
model Ec2VPCDHCPOptionsAssociationProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEc2VPCDHCPOptionsAssociationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsEc2VPCDHCPOptionsAssociation")
model AwsEc2VPCDHCPOptionsAssociationProperties {
  @doc("Gets and sets the property dhcpOptionsId. The ID of the DHCP options set, or default to associate no DHCP options with the VPC.")
  dhcpOptionsId?: string;

  @doc("Gets and sets the property vpcId. The ID of the VPC.")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2VPCDHCPOptionsAssociations {
  get is ArmResourceRead<Ec2VPCDHCPOptionsAssociation>;
  @doc("Create a Ec2VPCDHCPOptionsAssociation. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2VPCDHCPOptionsAssociation>;
  update is ArmCustomPatchAsync<
    Ec2VPCDHCPOptionsAssociation,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2VPCDHCPOptionsAssociation>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2VPCDHCPOptionsAssociation>;
  listByResourceGroup is ArmResourceListByParent<Ec2VPCDHCPOptionsAssociation>;
  listBySubscription is ArmListBySubscription<Ec2VPCDHCPOptionsAssociation>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::VPCDHCPOptionsAssociation
//--------------------------------------------------------------------------------------------
