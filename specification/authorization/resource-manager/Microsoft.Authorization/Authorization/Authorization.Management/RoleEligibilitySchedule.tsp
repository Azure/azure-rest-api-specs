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
 * Role eligibility schedule
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model RoleEligibilitySchedule
  is Azure.ResourceManager.ExtensionResource<RoleEligibilityScheduleProperties> {
  ...ResourceNameParameter<
    Resource = RoleEligibilitySchedule,
    KeyName = "roleEligibilityScheduleName",
    SegmentName = "roleEligibilitySchedules",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface RoleEligibilitySchedules {
  /**
   * Get the specified role eligibility schedule for a resource scope
   */
  @tag("roleEligibilitySchedules")
  get is Extension.Read<
    Extension.ScopeParameter,
    RoleEligibilitySchedule,
    Error = CloudError
  >;

  /**
   * Gets role eligibility schedules for a resource scope.
   */
  @tag("roleEligibilitySchedules")
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleEligibilitySchedule,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role eligibility schedules at or above the scope. Use $filter=principalId eq {id} to return all role eligibility schedules at, above or below the scope for the specified principal. Use $filter=assignedTo('{userId}') to return all role eligibility schedules for the user. Use $filter=asTarget() to return all role eligibility schedules created for the current user.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;
}

@@doc(RoleEligibilitySchedule.name,
  "The name (guid) of the role eligibility schedule to get."
);
@@doc(RoleEligibilitySchedule.properties,
  "role eligibility schedule properties."
);
