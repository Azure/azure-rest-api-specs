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

//---------------------------------------------- Wafv2WebACLAssociations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "WAFv2 Web ACLAssociation",
    plural: "WAFv2 Web ACLAssociations",
  },
  keywords: ["Microsoft.AwsConnector", "WAFv2", "Web", "ACLAssociation"],
})
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
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Wafv2WebACLAssociation")
model Wafv2WebACLAssociationProperties {
  @doc("AWS Properties")
  awsProperties?: AwsWafv2WebACLAssociationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsWafv2WebACLAssociation")
model AwsWafv2WebACLAssociationProperties {
  @doc("Property resourceArn")
  resourceArn?: string;

  @doc("Property webACLArn")
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
