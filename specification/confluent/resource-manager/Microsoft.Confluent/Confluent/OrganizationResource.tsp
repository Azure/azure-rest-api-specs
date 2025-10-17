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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OrganizationResourceAPIKeyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Organization resource name
         */
        @path @segment("organizations") organizationName: string,
      },
      {
        /**
         * Confluent API Key id
         */
        @path @segment("apiKeys") apiKeyId: string,
      },
      ResourceProviderDefaultErrorResponse
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OrganizationResourceAPIKeyActions {
  /**
   * Get API key details of a kafka or schema registry cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @operationId("Organization_GetClusterAPIKey")
  getClusterAPIKey is OrganizationResourceAPIKeyOps.Read<
    OrganizationResource,
    {},
    ArmResponse<APIKeyRecord>
  >;

  /**
   * Deletes API key of a kafka or schema registry cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  @operationId("Organization_DeleteClusterAPIKey")
  deleteClusterAPIKey is OrganizationResourceAPIKeyOps.DeleteSync<
    OrganizationResource,
    {},
    OkResponse | NoContentResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OrganizationResourceRoleBindingIdOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Organization resource name
         */
        @path
        @segment("organizations")
        organizationName: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        access: "access",

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        default: "default",

        /**
         * Confluent Role binding id
         */
        @path
        @segment("deleteRoleBinding")
        roleBindingId: string,
      },
      ResourceProviderDefaultErrorResponse
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OrganizationResourceRoleBindingIdOperationGroup
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Organization resource name
         */
        @path @segment("organizations") organizationName: string,
      },
      {},
      ResourceProviderDefaultErrorResponse
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OrganizationResourceRoleBindingIdActions {
  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  deleteRoleBinding is OrganizationResourceRoleBindingIdOps.DeleteSync<
    OrganizationResource,
    {},
    OkResponse | NoContentResponse
  >;
}

@armResourceOperations
interface OrganizationResources {
  /**
   * Get the properties of a specific Organization resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<
    OrganizationResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is OrganizationResourceRoleBindingIdOperationGroup.CreateOrUpdateAsync<
    OrganizationResource,
    OptionalRequestBody = true
  >;

  /**
   * Update Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is OrganizationResourceRoleBindingIdOperationGroup.CustomPatchSync<
    OrganizationResource,
    PatchModel = OrganizationResourceUpdate,
    OptionalRequestBody = true
  >;

  /**
   * Delete Organization resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    OrganizationResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all Organizations under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByResourceGroup is ArmResourceListByParent<
    OrganizationResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all organizations under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listBySubscription is ArmListBySubscription<
    OrganizationResource,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * cloud provider regions available for creating Schema Registry clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listRegions is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<ListRegionsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization users details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("access/default/listUsers")
  listUsers is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListUsersSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization service accounts details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("access/default/listServiceAccounts")
  listServiceAccounts is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListServiceAccountsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization accounts invitation details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("access/default/listInvitations")
  listInvitations is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListInvitationsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Invite user to the organization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("access/default/createInvitation")
  inviteUser is ArmResourceActionSync<
    OrganizationResource,
    AccessInviteUserAccountModel,
    ArmResponse<InvitationRecord>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Environment list of an organization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("access/default/listEnvironments")
  listEnvironments is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListEnvironmentsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Cluster details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("access/default/listClusters")
  listClusters is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListClusterSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("access/default/listRoleBindings")
  listRoleBindings is ArmResourceActionSync<
    OrganizationResource,
    ListAccessRequestModel,
    ArmResponse<AccessListRoleBindingsSuccessResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("access/default/createRoleBinding")
  createRoleBinding is ArmResourceActionSync<
    OrganizationResource,
    AccessCreateRoleBindingRequestModel,
    ArmResponse<RoleBindingRecord>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Organization role bindings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("access/default/listRoleBindingNameList")
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
