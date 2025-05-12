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

alias OrganizationResourcePath = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...Azure.ResourceManager.Legacy.Provider;
  /**
   * Organization resource name
   */
  @path @segment("organizations") organizationName: string;
};

interface OrganizationResourceAPIKeyOps extends Azure.ResourceManager.Legacy.LegacyOperations<
  OrganizationResourcePath,
  {
    /**
     * Confluent API Key id
     */
    @path @segment("apiKeys") apiKeyId: string,
  },
  ResourceProviderDefaultErrorResponse
> {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface OrganizationResourceAPIKeyActions {
  /**
   * Get API key details of a kafka or schema registry cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @operationId("Organization_GetClusterAPIKey")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Confluent/organizations/{organizationName}/apiKeys/{apiKeyId}")
  getClusterAPIKey is OrganizationResourceAPIKeyOps.ActionSync<
    OrganizationResource,
    void,
    ArmResponse<APIKeyRecord>
  >;

  /**
   * Deletes API key of a kafka or schema registry cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @operationId("Organization_DeleteClusterAPIKey")
  deleteClusterAPIKey is OrganizationResourceAPIKeyOps.ActionSync<
    OrganizationResource,
    void,
    OkResponse | NoContentResponse
  >;
}

interface OrganizationResourceRoleBindingIdOps extends Azure.ResourceManager.Legacy.LegacyOperations<
  OrganizationResourcePath,
  {
    /**
     * Confluent Role binding id
     */
    @path @segment("deleteRoleBinding") roleBindingId: string,
  },
  ResourceProviderDefaultErrorResponse
> {}

interface OrganizationResourceRoleBindingIdActions {
  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @operationId("Access_DeleteRoleBinding")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Confluent/organizations/{organizationName}/access/default/deleteRoleBinding/{roleBindingId}")
  deleteRoleBinding is OrganizationResourceRoleBindingIdOps.ActionSync<
    OrganizationResource,
    void,
    OkResponse | NoContentResponse
  >;
}

@armResourceOperations
interface OrganizationResources {
  /**
   * Get the properties of a specific Organization resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_Get")
  get is ArmResourceRead<
    OrganizationResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_Create")
  create is ArmResourceCreateOrReplaceAsync<
    OrganizationResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Update Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Organization_Update")
  update is ArmCustomPatchSync<
    OrganizationResource,
    PatchModel = OrganizationResourceUpdate,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Delete Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Organization_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    OrganizationResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all Organizations under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    OrganizationResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all organizations under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    OrganizationResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * cloud provider regions available for creating Schema Registry clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organization_ListRegions")
  listRegions is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<ListRegionsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  

  /**
   * Organization users details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListUsers")
  listUsers is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListUsersSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization service accounts details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListServiceAccounts")
  listServiceAccounts is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListServiceAccountsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization accounts invitation details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListInvitations")
  listInvitations is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListInvitationsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Invite user to the organization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("access/default/createInvitation")
  @operationId("Access_InviteUser")
  inviteUser is ArmResourceActionSync<
    OrganizationResource,
    AccessInviteUserAccountModel,
    ArmResponse<InvitationRecord>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Environment list of an organization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListEnvironments")
  listEnvironments is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListEnvironmentsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Cluster details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListClusters")
  listClusters is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListClusterSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListRoleBindings")
  listRoleBindings is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListRoleBindingsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_CreateRoleBinding")
  createRoleBinding is ArmResourceActionSync<
    OrganizationResource,
    AccessCreateRoleBindingRequestModel,
    ArmResponse<RoleBindingRecord>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Access_ListRoleBindingNameList")
  listRoleBindingNameList is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessRoleBindingNameListSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
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
