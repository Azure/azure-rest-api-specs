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

//---------------------------------------------- OrganizationsAccounts ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Organizations Account",
    plural: "Organizations Accounts",
  },
  keywords: ["Microsoft.AwsConnector", "Organizations", "Account"],
})
@doc("A Microsoft.AwsConnector resource")
model OrganizationsAccount is TrackedResource<OrganizationsAccountProperties> {
  @doc("Name of OrganizationsAccount")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("organizationsAccounts")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OrganizationsAccount")
model OrganizationsAccountProperties {
  @doc("AWS Properties")
  awsProperties?: AwsOrganizationsAccountProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsOrganizationsAccount")
model AwsOrganizationsAccountProperties {
  @doc("If the account was created successfully, the unique identifier (ID) of the new account.")
  accountId?: string;

  @doc("The friendly name of the member account.")
  accountName?: string;

  @doc("The Amazon Resource Name (ARN) of the account.")
  arn?: string;

  @doc("The email address of the owner to assign to the new member account.")
  email?: string;

  @doc("The method by which the account joined the organization.")
  joinedMethod?: JoinedMethod;

  @doc("The date the account became a part of the organization.")
  joinedTimestamp?: string;

  @doc("List of parent nodes for the member account. Currently only one parent at a time is supported. Default is root.")
  @extension("x-ms-identifiers", [])
  parentIds?: string[];

  @doc("The name of an IAM role that AWS Organizations automatically preconfigures in the new member account. Default name is OrganizationAccountAccessRole if not specified.")
  roleName?: string = "OrganizationAccountAccessRole";

  @doc("The status of the account in the organization.")
  status?: Status;

  @doc("A list of tags that you want to attach to the newly created account. For each tag in the list, you must specify both a tag key and a value.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("JoinedMethod enum")
union JoinedMethod {
  @doc("JoinedMethod enum CREATED")
  CREATED: "CREATED",

  @doc("JoinedMethod enum INVITED")
  INVITED: "INVITED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key identifier, or name, of the tag.")
  key?: string;

  @doc("The string value that's associated with the key of the tag. You can set the value of a tag to an empty string, but you can't set the value of a tag to null.")
  value?: string;
}

@doc("Status enum")
union Status {
  @doc("Status enum ACTIVE")
  ACTIVE: "ACTIVE",

  @doc("Status enum PENDING_CLOSURE")
  PENDING_CLOSURE: "PENDING_CLOSURE",

  @doc("Status enum SUSPENDED")
  SUSPENDED: "SUSPENDED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface OrganizationsAccounts {
  get is ArmResourceRead<OrganizationsAccount>;
  @doc("Create a OrganizationsAccount. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<OrganizationsAccount>;
  update is ArmCustomPatchAsync<
    OrganizationsAccount,
    Azure.ResourceManager.Foundations.TagsUpdateModel<OrganizationsAccount>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationsAccount>;
  listByResourceGroup is ArmResourceListByParent<OrganizationsAccount>;
  listBySubscription is ArmListBySubscription<OrganizationsAccount>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Organizations::Account
//--------------------------------------------------------------------------------------------
