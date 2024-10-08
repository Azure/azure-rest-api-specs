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

//---------------------------------------------- OrganizationsOrganizations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Organizations Organization",
    plural: "Organizations Organizations",
  },
  keywords: ["Microsoft.AwsConnector", "Organizations", "Organization"],
})
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
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OrganizationsOrganization")
model OrganizationsOrganizationProperties {
  @doc("AWS Properties")
  awsProperties?: AwsOrganizationsOrganizationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsOrganizationsOrganization")
model AwsOrganizationsOrganizationProperties {
  @doc("The Amazon Resource Name (ARN) of an organization.")
  arn?: string;

  @doc("Specifies the feature set supported by the new organization. Each feature set supports different levels of functionality.")
  featureSet?: FeatureSet = "ALL";

  @doc("The unique identifier (ID) of an organization.")
  id?: string;

  @doc("The Amazon Resource Name (ARN) of the account that is designated as the management account for the organization.")
  managementAccountArn?: string;

  @doc("The email address that is associated with the AWS account that is designated as the management account for the organization.")
  managementAccountEmail?: string;

  @doc("The unique identifier (ID) of the management account of an organization.")
  managementAccountId?: string;

  @doc("The unique identifier (ID) for the root.")
  rootId?: string;
}

@doc("FeatureSet enum")
union FeatureSet {
  @doc("FeatureSet enum ALL")
  ALL: "ALL",

  @doc("FeatureSet enum CONSOLIDATED_BILLING")
  CONSOLIDATED_BILLING: "CONSOLIDATED_BILLING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface OrganizationsOrganizations {
  get is ArmResourceRead<OrganizationsOrganization>;
  @doc("Create a OrganizationsOrganization. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<OrganizationsOrganization>;
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
