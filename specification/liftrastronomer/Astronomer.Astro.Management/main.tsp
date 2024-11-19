import "./LiftrBase.Data/main.tsp";

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Data;

@armProviderNamespace
@service({
  title: "Astronomer.Astro",
})
@versioned(Astronomer.Astro.Versions)
namespace Astronomer.Astro;

@doc("Supported API versions for the Astronomer.Astro resource provider.")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview, LiftrBase.Data.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  @useDependency(LiftrBase.Data.Versions.v1_preview)
  v1_preview: "2023-08-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview, LiftrBase.Data.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  @useDependency(LiftrBase.Data.Versions.v1_preview)
  v1: "2023-08-01",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v2024_08_27_preview, LiftrBase.Data.Versions.v2024_08_27_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v2024_08_27_preview)
  @useDependency(LiftrBase.Data.Versions.v2024_08_27_preview)
  v2024_08_27_preview: "2024-08-27-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v2024_08_27, LiftrBase.Data.Versions.v2024_08_27")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v2024_08_27)
  @useDependency(LiftrBase.Data.Versions.v2024_08_27)
  v2024_08_27: "2024-08-27",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v2024_11_01_preview, LiftrBase.Data.Versions.v2024_11_01_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v2024_11_01_preview)
  @useDependency(LiftrBase.Data.Versions.v2024_11_01_preview)
  v2024_11_01_preview: "2024-11-01-preview",

}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Organization Resource by Astronomer")
model OrganizationResource is TrackedResource<OrganizationProperties> {
  @key("organizationName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("organizations")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Organizations resource")
  @path
  name: string;

  ...Legacy.ManagedServiceIdentityV4Property;
}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<OrganizationResource>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    OrganizationResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  update is ArmCustomPatchAsync<
    OrganizationResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      OrganizationResource,
      OrganizationProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  listBySubscription is ArmListBySubscription<OrganizationResource>;

  @added(Versions.v2024_11_01_preview)
  @doc("list of users with roles.")
  @armResourceAction(OrganizationResource)
  @action("getUsers")
  @post
  getUsers(
    ...ResourceInstanceParameters<OrganizationResource>,
    @doc("properties of GetUsersRequest")
    @body
    properties: GetUsersRequest,
  ): ArmResponse<GetUsersSuccessResponse> | ErrorResponse;

  @added(Versions.v2024_11_01_preview)
  @doc("list of available roles.")
  @armResourceAction(OrganizationResource)
  @action("getRoles")
  @post
  getRoles(
    ...ResourceInstanceParameters<OrganizationResource>,
    @doc("properties of GetRolesRequest")
    @body
    properties: GetRolesRequest,
  ): ArmResponse<GetRolesSuccessResponse> | ErrorResponse;

  @added(Versions.v2024_11_01_preview)
  @doc("list of available resources.")
  @armResourceAction(OrganizationResource)
  @action("getResources")
  @post
  getResources(
    ...ResourceInstanceParameters<OrganizationResource>,
    @doc("properties of GetResourcesRequest")
    @body
    properties: GetResourcesRequest,
  ): ArmResponse<GetResourcesSuccessResponse> | ErrorResponse;

  @added(Versions.v2024_11_01_preview)
  @doc("manage roles of users")
  @armResourceAction(OrganizationResource)
  @action("manageRoles")
  @post
  manageRoles(
    ...ResourceInstanceParameters<OrganizationResource>,
    @doc("properties of ManageRolesRequest")
    @body
    properties: ManageRolesModel,
  ): ArmResponse<ManageRolesModel> | ErrorResponse;

  @added(Versions.v2024_11_01_preview)
  @doc("remove user")
  @armResourceAction(OrganizationResource)
  @action("removeUser")
  @post
  removeUser(
    ...ResourceInstanceParameters<OrganizationResource>,
    @doc("properties of RemoveUserRequest")
    @body
    properties: RemoveUserRequest,
  ): ArmDeletedNoContentResponse | ErrorResponse;
}
  
@added(Versions.v2024_11_01_preview)
@doc("Request model for get users API")
model GetUsersRequest {
  @doc("parameters to filter results")
  searchParamsDictionary?: unknown;

  @doc("page details")
  pageInfo?: PageInfo;
}

@added(Versions.v2024_11_01_preview)
@doc("PageInfo model")
model PageInfo {
  @doc("numbers of objects to skip")
  offset?: int64;

  @doc("max numbers of objects in response")
  limit?: int64;
  
  @doc("total numbers of objects")
  totalCount?: int64;
}

@added(Versions.v2024_11_01_preview)
@doc("Response model for get users API")
model GetUsersSuccessResponse {
  @doc("User object array")
  users : User[];

  @doc("page details")
  pageInfo?: PageInfo;
  
}

@added(Versions.v2024_11_01_preview)
@doc("User object")
model User {
  @doc("User id")
  id?: string;

  @doc("user type")
  type?: string;

  @doc("email")
  email: string;

  @doc("Full name")
  fullName?: string;

  @doc("Auth type")
  authType?: string;

  @doc("User status")
  status?: string;

  @doc("avatar url")
  avatarUrl?: string;

  @doc("roles assigned to user")
  roles: Role[];

  @doc("User metadata")
  metadataUser? : unknown;


}

@added(Versions.v2024_11_01_preview)
@doc("Role object")
model Role {
  @doc("Role id")
  id?: string;

  @doc("Role name")
  name: string;

  @doc("Role type")
  type?: string;

  @doc("description")
  description?: string;

  @doc("scope")
  scope?: string;
}

@added(Versions.v2024_11_01_preview)
@doc("Request model for get roles API")
model GetRolesRequest {
  @doc("parameters to filter results")
  searchParamsDictionary?: unknown;

  @doc("page details")
  pageInfo?: PageInfo;
}

@added(Versions.v2024_11_01_preview)
@doc("Response model for get roles API")
model GetRolesSuccessResponse {
  @doc("Role object array")
  roles : Role[];

  @doc("page details")
  pageInfo?: PageInfo;

}

@added(Versions.v2024_11_01_preview)
@doc("Request model for get resources API")
model GetResourcesRequest {
  @doc("parameters to filter results")
  searchParamsDictionary?: unknown;

  @doc("page details")
  pageInfo?: PageInfo;
}

@added(Versions.v2024_11_01_preview)
@doc("Response model for get resources API")
model GetResourcesSuccessResponse {
  @doc("Resource object array")
  resources : PartnerResource[];

  @doc("page details")
  pageInfo?: PageInfo;

}

@added(Versions.v2024_11_01_preview)
@doc("Partner Resource object")
model PartnerResource {
  @doc("Resource id")
  id?: string;

  @doc("Resource name")
  name: string;

  @doc("Resource type")
  type?: string;

}

@added(Versions.v2024_11_01_preview)
@doc("Request model for manage roles API")
model ManageRolesModel {
  
  @doc("Users object array")
  principals : User[];

  @doc("Role object array")
  roles : Role[];

  @doc("Additional properties to assign roles")
  additionalProperties?: unknown;
}

@added(Versions.v2024_11_01_preview)
@doc("Request model for manage roles API")
model RemoveUserRequest {
  
  @doc("User object")
  principal : User;

  @doc("Additional properties for deleting user")
  additionalProperties?: unknown;
}







