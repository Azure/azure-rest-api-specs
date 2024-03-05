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

//---------------------------------------------- OrganizationsAccounts ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
@doc("Definition of OrganizationsAccount")
model OrganizationsAccountProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsOrganizationsAccountProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsOrganizationsAccount")
model AwsOrganizationsAccountProperties {
  @doc("Gets and sets the property accountId. If the account was created successfully, the unique identifier (ID) of the new account.")
  accountId?: string;

  @doc("Gets and sets the property accountName. The friendly name of the member account.")
  accountName?: string;

  @doc("Gets and sets the property arn. The Amazon Resource Name (ARN) of the account.")
  arn?: string;

  @doc("Gets and sets the property email. The email address of the owner to assign to the new member account.")
  email?: string;

  @doc("Gets and sets the property joinedMethod. The method by which the account joined the organization.")
  joinedMethod?: JoinedMethod;

  @doc("Gets and sets the property joinedTimestamp. The date the account became a part of the organization.")
  joinedTimestamp?: string;

  @doc("Gets and sets the property parentIds. List of parent nodes for the member account. Currently only one parent at a time is supported. Default is root.")
  @extension("x-ms-identifiers", [])
  parentIds?: string[];

  @doc("Gets and sets the property roleName. The name of an IAM role that AWS Organizations automatically preconfigures in the new member account. Default name is OrganizationAccountAccessRole if not specified.")
  roleName?: string;

  @doc("Gets and sets the property status. The status of the account in the organization.")
  status?: Status;

  @doc("Gets and sets the property tags. A list of tags that you want to attach to the newly created account. For each tag in the list, you must specify both a tag key and a value.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("JoinedMethod enum")
enum JoinedMethod {
  @doc("JoinedMethod enum CREATED")
  CREATED: "CREATED",

  @doc("JoinedMethod enum INVITED")
  INVITED: "INVITED",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key identifier, or name, of the tag.")
  key?: string;

  @doc("Gets and sets the property value. The string value that's associated with the key of the tag. You can set the value of a tag to an empty string, but you can't set the value of a tag to null.")
  value?: string;
}

@doc("Status enum")
enum Status {
  @doc("Status enum ACTIVE")
  ACTIVE: "ACTIVE",

  @doc("Status enum PENDING_CLOSURE")
  PENDING_CLOSURE: "PENDING_CLOSURE",

  @doc("Status enum SUSPENDED")
  SUSPENDED: "SUSPENDED",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface OrganizationsAccounts {
  get is ArmResourceRead<OrganizationsAccount>;
  @doc("Create a OrganizationsAccount. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OrganizationsAccount>;
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
