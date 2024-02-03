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

//---------------------------------------------- Wafv2WebACLAssociations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Wafv2WebACLAssociation
  is TrackedResource<Wafv2WebACLAssociationProperties> {
  @doc("Name of Wafv2WebACLAssociation")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("wafv2WebACLAssociations")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of Wafv2WebACLAssociation")
model Wafv2WebACLAssociationProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsWafv2WebACLAssociationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of awsWafv2WebACLAssociation")
model AwsWafv2WebACLAssociationProperties {
  @doc("Gets and sets the property resourceArn.")
  resourceArn?: string;

  @doc("Gets and sets the property webACLArn.")
  webACLArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Wafv2WebACLAssociations {
  get is ArmResourceRead<Wafv2WebACLAssociation>;
  @doc("Create a Wafv2WebACLAssociation. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Wafv2WebACLAssociation>;
  update is ArmCustomPatchAsync<
    Wafv2WebACLAssociation,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Wafv2WebACLAssociation>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Wafv2WebACLAssociation>;
  listByResourceGroup is ArmResourceListByParent<Wafv2WebACLAssociation>;
  listBySubscription is ArmListBySubscription<Wafv2WebACLAssociation>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::WAFv2::WebACLAssociation
//--------------------------------------------------------------------------------------------
