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

//---------------------------------------------- Wafv2IPSets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Wafv2IPSet is TrackedResource<Wafv2IPSetProperties> {
  @doc("Name of Wafv2IPSet")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("wafv2IPSets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Wafv2IPSet")
model Wafv2IPSetProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsWafv2IPSetProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsWafv2IPSet")
model AwsWafv2IPSetProperties {
  @doc("Gets and sets the property addresses. List of IPAddresses.")
  @extension("x-ms-identifiers", [])
  addresses?: string[];

  @doc("Gets and sets the property arn. ARN of the WAF entity.")
  arn?: string;

  @doc("Gets and sets the property description. Description of the entity.")
  description?: string;

  @doc("Gets and sets the property iPAddressVersion. Type of addresses in the IPSet, use IPV4 for IPV4 IP addresses, IPV6 for IPV6 address.")
  iPAddressVersion?: string;

  @doc("Gets and sets the property id. Id of the IPSet")
  id?: string;

  @doc("Gets and sets the property name. Name of the IPSet.")
  name?: string;

  @doc("Gets and sets the property scope. Use CLOUDFRONT for CloudFront IPSet, use REGIONAL for Application Load Balancer and API Gateway.")
  scope?: string;

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Wafv2IPSets {
  get is ArmResourceRead<Wafv2IPSet>;
  @doc("Create a Wafv2IPSet. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Wafv2IPSet>;
  update is ArmCustomPatchAsync<
    Wafv2IPSet,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Wafv2IPSet>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Wafv2IPSet>;
  listByResourceGroup is ArmResourceListByParent<Wafv2IPSet>;
  listBySubscription is ArmListBySubscription<Wafv2IPSet>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::WAFv2::IPSet
//--------------------------------------------------------------------------------------------
