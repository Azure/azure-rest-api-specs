import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Confluent;
/**
 * Organization resource.
 */
model OrganizationResource
  is Azure.ResourceManager.TrackedResource<
    OrganizationResourceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = OrganizationResource,
    KeyName = "organizationName",
    SegmentName = "organizations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface OrganizationResources {
  /**
   * Get the properties of a specific Organization resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_Get")
  get is ArmResourceRead<OrganizationResource>;

  /**
   * Create Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_Create")
  create is ArmResourceCreateOrReplaceAsync<OrganizationResource>;

  /**
   * Update Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Organization_Update")
  update is ArmCustomPatchSync<
    OrganizationResource,
    PatchModel = OrganizationResourceUpdate
  >;

  /**
   * Delete Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Organization_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    OrganizationResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all Organizations under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;

  /**
   * List all organizations under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_ListBySubscription")
  listBySubscription is ArmListBySubscription<OrganizationResource>;

  /**
   * cloud provider regions available for creating Schema Registry clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_ListRegions")
  listRegions is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<ListRegionsSuccessResponse>
  >;

  /**
   * Deletes API key of a kafka or schema registry cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @action("{apiKeyId}")
  @operationId("Organization_DeleteClusterAPIKey")
  deleteClusterAPIKey is ArmResourceActionSync<
    OrganizationResource,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * Confluent API Key id
       */
      @path
      apiKeyId: string;
    }
  >;

  /**
   * Get API key details of a kafka or schema registry cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{apiKeyId}")
  @operationId("Organization_GetClusterAPIKey")
  getClusterAPIKey is ArmResourceActionSync<
    OrganizationResource,
    void,
    ArmResponse<APIKeyRecord>,
    Parameters = {
      /**
       * Confluent API Key id
       */
      @path
      apiKeyId: string;
    }
  >;

  /**
   * Organization users details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListUsers")
  listUsers is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListUsersSuccessResponse>
  >;

  /**
   * Organization service accounts details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListServiceAccounts")
  listServiceAccounts is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListServiceAccountsSuccessResponse>
  >;

  /**
   * Organization accounts invitation details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListInvitations")
  listInvitations is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListInvitationsSuccessResponse>
  >;

  /**
   * Invite user to the organization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("createInvitation")
  @operationId("Access_InviteUser")
  inviteUser is ArmResourceActionSync<
    OrganizationResource,
    AccessInviteUserAccountModel,
    ArmResponse<InvitationRecord>
  >;

  /**
   * Environment list of an organization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListEnvironments")
  listEnvironments is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListEnvironmentsSuccessResponse>
  >;

  /**
   * Cluster details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListClusters")
  listClusters is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListClusterSuccessResponse>
  >;

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListRoleBindings")
  listRoleBindings is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListRoleBindingsSuccessResponse>
  >;

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_CreateRoleBinding")
  createRoleBinding is ArmResourceActionSync<
    OrganizationResource,
    AccessCreateRoleBindingRequestModel,
    ArmResponse<RoleBindingRecord>
  >;

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @action("{roleBindingId}")
  @operationId("Access_DeleteRoleBinding")
  deleteRoleBinding is ArmResourceActionSync<
    OrganizationResource,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * Confluent Role binding id
       */
      @path
      roleBindingId: string;
    }
  >;

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListRoleBindingNameList")
  listRoleBindingNameList is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessRoleBindingNameListSuccessResponse>
  >;
}

@@doc(OrganizationResource.name, "Organization resource name");
@@doc(OrganizationResource.properties, "Organization resource properties");
@@doc(OrganizationResources.create::parameters.resource,
  "Organization resource model"
);
@@doc(OrganizationResources.update::parameters.properties,
  "Updated Organization resource"
);
@@doc(OrganizationResources.listRegions::parameters.body,
  "List Access Request Model"
);
@@doc(OrganizationResources.listUsers::parameters.body,
  "List Access Request Model"
);
@@doc(OrganizationResources.listServiceAccounts::parameters.body,
  "List Access Request Model"
);
@@doc(OrganizationResources.listInvitations::parameters.body,
  "List Access Request Model"
);
@@doc(OrganizationResources.inviteUser::parameters.body,
  "Invite user account model"
);
@@doc(OrganizationResources.listEnvironments::parameters.body,
  "List Access Request Model"
);
@@doc(OrganizationResources.listClusters::parameters.body,
  "List Access Request Model"
);
@@doc(OrganizationResources.listRoleBindings::parameters.body,
  "List Access Request Model"
);
@@doc(OrganizationResources.createRoleBinding::parameters.body,
  "Create role binding Request Model"
);
@@doc(OrganizationResources.listRoleBindingNameList::parameters.body,
  "List Access Request Model"
);
