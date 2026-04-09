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
 * Role Eligibility schedule request
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model RoleEligibilityScheduleRequest
  is Azure.ResourceManager.ExtensionResource<RoleEligibilityScheduleRequestProperties> {
  ...ResourceNameParameter<
    Resource = RoleEligibilityScheduleRequest,
    KeyName = "roleEligibilityScheduleRequestName",
    SegmentName = "roleEligibilityScheduleRequests",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface RoleEligibilityScheduleRequests {
  /**
   * Get the specified role eligibility schedule request.
   */
  @tag("RoleEligibilityScheduleRequests")
  get is Extension.Read<
    Extension.ScopeParameter,
    RoleEligibilityScheduleRequest,
    Error = CloudError
  >;

  /**
   * Creates a role eligibility schedule request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("RoleEligibilityScheduleRequests")
  create is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    RoleEligibilityScheduleRequest,
    Response = ArmResourceCreatedSyncResponse<RoleEligibilityScheduleRequest>,
    Error = CloudError
  >;

  /**
   * Gets role eligibility schedule requests for a scope.
   */
  @tag("RoleEligibilityScheduleRequests")
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleEligibilityScheduleRequest,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role eligibility schedule requests at or above the scope. Use $filter=principalId eq {id} to return all role eligibility schedule requests at, above or below the scope for the specified principal. Use $filter=asRequestor() to return all role eligibility schedule requests requested by the current user. Use $filter=asTarget() to return all role eligibility schedule requests created for the current user. Use $filter=asApprover() to return all role eligibility schedule requests where the current user is an approver.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;

  /**
   * Cancels a pending role eligibility schedule request.
   */
  @tag("RoleEligibilityScheduleRequests")
  cancel is Extension.ActionSync<
    Extension.ScopeParameter,
    RoleEligibilityScheduleRequest,
    void,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Validates a new role eligibility schedule request.
   */
  @tag("RoleEligibilityScheduleRequests")
  validate is Extension.ActionSync<
    Extension.ScopeParameter,
    RoleEligibilityScheduleRequest,
    RoleEligibilityScheduleRequest,
    ArmResponse<RoleEligibilityScheduleRequest>,
    Error = CloudError
  >;
}

@@doc(RoleEligibilityScheduleRequest.name,
  "The name (guid) of the role eligibility schedule request to get."
);
@@doc(RoleEligibilityScheduleRequest.properties,
  "Role eligibility schedule request properties."
);
@@doc(RoleEligibilityScheduleRequests.create::parameters.resource,
  "Parameters for the role eligibility schedule request."
);
@@doc(RoleEligibilityScheduleRequests.validate::parameters.body,
  "Parameters for the role eligibility schedule request."
);
