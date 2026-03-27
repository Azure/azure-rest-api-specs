import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Authorization;
/**
 * Role Assignment schedule request
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model RoleAssignmentScheduleRequest
  is Azure.ResourceManager.ExtensionResource<RoleAssignmentScheduleRequestProperties> {
  ...ResourceNameParameter<
    Resource = RoleAssignmentScheduleRequest,
    KeyName = "roleAssignmentScheduleRequestName",
    SegmentName = "roleAssignmentScheduleRequests",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface RoleAssignmentScheduleRequests {
  /**
   * Get the specified role assignment schedule request.
   */
  @tag("RoleAssignmentScheduleRequests")
  get is Extension.Read<
    Extension.ScopeParameter,
    RoleAssignmentScheduleRequest,
    Error = CloudError
  >;

  /**
   * Creates a role assignment schedule request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("RoleAssignmentScheduleRequests")
  create is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    RoleAssignmentScheduleRequest,
    Response = ArmResourceCreatedSyncResponse<RoleAssignmentScheduleRequest>,
    Error = CloudError
  >;

  /**
   * Gets role assignment schedule requests for a scope.
   */
  @tag("RoleAssignmentScheduleRequests")
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleAssignmentScheduleRequest,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignment schedule requests at or above the scope. Use $filter=principalId eq {id} to return all role assignment schedule requests at, above or below the scope for the specified principal. Use $filter=asRequestor() to return all role assignment schedule requests requested by the current user. Use $filter=asTarget() to return all role assignment schedule requests created for the current user. Use $filter=asApprover() to return all role assignment schedule requests where the current user is an approver.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;

  /**
   * Cancels a pending role assignment schedule request.
   */
  @tag("RoleAssignmentScheduleRequests")
  cancel is Extension.ActionSync<
    Extension.ScopeParameter,
    RoleAssignmentScheduleRequest,
    void,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Validates a new role assignment schedule request.
   */
  @tag("RoleAssignmentScheduleRequests")
  validate is Extension.ActionSync<
    Extension.ScopeParameter,
    RoleAssignmentScheduleRequest,
    RoleAssignmentScheduleRequest,
    ArmResponse<RoleAssignmentScheduleRequest>,
    Error = CloudError
  >;
}

@@doc(RoleAssignmentScheduleRequest.name,
  "The name (guid) of the role assignment schedule request to get."
);
@@doc(RoleAssignmentScheduleRequest.properties,
  "Role assignment schedule request properties."
);
@@doc(RoleAssignmentScheduleRequests.create::parameters.resource,
  "Parameters for the role assignment schedule request."
);
@@doc(RoleAssignmentScheduleRequests.validate::parameters.body,
  "Parameters for the role assignment schedule request."
);
