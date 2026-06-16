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
 * Role Assignment schedule
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model RoleAssignmentSchedule
  is Azure.ResourceManager.ExtensionResource<RoleAssignmentScheduleProperties> {
  ...ResourceNameParameter<
    Resource = RoleAssignmentSchedule,
    KeyName = "roleAssignmentScheduleName",
    SegmentName = "roleAssignmentSchedules",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface RoleAssignmentSchedules {
  /**
   * Get the specified role assignment schedule for a resource scope
   */
  @tag("roleAssignmentSchedules")
  get is Extension.Read<
    Extension.ScopeParameter,
    RoleAssignmentSchedule,
    Error = CloudError
  >;

  /**
   * Gets role assignment schedules for a resource scope.
   */
  @tag("roleAssignmentSchedules")
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleAssignmentSchedule,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignment schedules at or above the scope. Use $filter=principalId eq {id} to return all role assignment schedules at, above or below the scope for the specified principal. Use $filter=assignedTo('{userId}') to return all role assignment schedules for the current user. Use $filter=asTarget() to return all role assignment schedules created for the current user.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;
}

@@doc(RoleAssignmentSchedule.name,
  "The name (guid) of the role assignment schedule to get."
);
@@doc(RoleAssignmentSchedule.properties,
  "Role assignment schedule properties."
);
