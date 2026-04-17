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
 * Information about current or upcoming role assignment schedule instance
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model RoleAssignmentScheduleInstance
  is Azure.ResourceManager.ExtensionResource<RoleAssignmentScheduleInstanceProperties> {
  ...ResourceNameParameter<
    Resource = RoleAssignmentScheduleInstance,
    KeyName = "roleAssignmentScheduleInstanceName",
    SegmentName = "roleAssignmentScheduleInstances",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface RoleAssignmentScheduleInstances {
  /**
   * Gets the specified role assignment schedule instance.
   */
  @tag("roleAssignmentScheduleInstances")
  get is Extension.Read<
    Extension.ScopeParameter,
    RoleAssignmentScheduleInstance,
    Error = CloudError
  >;

  /**
   * Gets role assignment schedule instances of a role assignment schedule.
   */
  @tag("roleAssignmentScheduleInstances")
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleAssignmentScheduleInstance,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignment schedules at or above the scope. Use $filter=principalId eq {id} to return all role assignment schedules at, above or below the scope for the specified principal.  Use $filter=assignedTo('{userId}') to return all role assignment schedule instances for the user. Use $filter=asTarget() to return all role assignment schedule instances created for the current user.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;
}

@@doc(RoleAssignmentScheduleInstance.name,
  "The name (hash of schedule name + time) of the role assignment schedule to get."
);
@@doc(RoleAssignmentScheduleInstance.properties,
  "Role assignment schedule instance properties."
);
