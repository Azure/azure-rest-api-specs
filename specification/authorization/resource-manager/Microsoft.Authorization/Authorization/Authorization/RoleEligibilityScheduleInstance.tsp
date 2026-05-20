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
 * Information about current or upcoming role eligibility schedule instance
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model RoleEligibilityScheduleInstance
  is Azure.ResourceManager.ExtensionResource<RoleEligibilityScheduleInstanceProperties> {
  ...ResourceNameParameter<
    Resource = RoleEligibilityScheduleInstance,
    KeyName = "roleEligibilityScheduleInstanceName",
    SegmentName = "roleEligibilityScheduleInstances",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface RoleEligibilityScheduleInstances {
  /**
   * Gets the specified role eligibility schedule instance.
   */
  @tag("roleEligibilityScheduleInstances")
  get is Extension.Read<
    Extension.ScopeParameter,
    RoleEligibilityScheduleInstance,
    Error = CloudError
  >;

  /**
   * Gets role eligibility schedule instances of a role eligibility schedule.
   */
  @tag("roleEligibilityScheduleInstances")
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleEligibilityScheduleInstance,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignment schedules at or above the scope. Use $filter=principalId eq {id} to return all role assignment schedules at, above or below the scope for the specified principal. Use $filter=assignedTo('{userId}') to return all role eligibility schedules for the user. Use $filter=asTarget() to return all role eligibility schedules created for the current user.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;
}

@@doc(RoleEligibilityScheduleInstance.name,
  "The name (hash of schedule name + time) of the role eligibility schedule to get."
);
@@doc(RoleEligibilityScheduleInstance.properties,
  "Role eligibility schedule instance properties."
);
