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

//---------------------------------------------- OrganizationsOrganizations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model OrganizationsOrganization
  is TrackedResource<OrganizationsOrganizationProperties> {
  @doc("Name of OrganizationsOrganization")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("organizationsOrganizations")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of OrganizationsOrganization")
model OrganizationsOrganizationProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsOrganizationsOrganizationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of awsOrganizationsOrganization")
model AwsOrganizationsOrganizationProperties {
  @doc("Gets and sets the property arn. The Amazon Resource Name (ARN) of an organization.")
  arn?: string;

  @doc("Gets and sets the property featureSet. Specifies the feature set supported by the new organization. Each feature set supports different levels of functionality.")
  featureSet?: FeatureSet;

  @doc("Gets and sets the property id. The unique identifier (ID) of an organization.")
  id?: string;

  @doc("Gets and sets the property managementAccountArn. The Amazon Resource Name (ARN) of the account that is designated as the management account for the organization.")
  managementAccountArn?: string;

  @doc("Gets and sets the property managementAccountEmail. The email address that is associated with the AWS account that is designated as the management account for the organization.")
  managementAccountEmail?: string;

  @doc("Gets and sets the property managementAccountId. The unique identifier (ID) of the management account of an organization.")
  managementAccountId?: string;

  @doc("Gets and sets the property rootId. The unique identifier (ID) for the root.")
  rootId?: string;
}

@doc("FeatureSet enum")
enum FeatureSet {
  @doc("FeatureSet enum ALL")
  ALL: "ALL",

  @doc("FeatureSet enum CONSOLIDATED_BILLING")
  CONSOLIDATED_BILLING: "CONSOLIDATED_BILLING",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface OrganizationsOrganizations {
  get is ArmResourceRead<OrganizationsOrganization>;
  @doc("Create a OrganizationsOrganization. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OrganizationsOrganization>;
  update is ArmCustomPatchAsync<
    OrganizationsOrganization,
    Azure.ResourceManager.Foundations.TagsUpdateModel<OrganizationsOrganization>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationsOrganization>;
  listByResourceGroup is ArmResourceListByParent<OrganizationsOrganization>;
  listBySubscription is ArmListBySubscription<OrganizationsOrganization>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Organizations::Organization
//--------------------------------------------------------------------------------------------
