import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleAssignmentSchedule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleAssignmentScheduleInstance.properties);

@@clientName(RoleAssignmentScheduleRequests.create::parameters.resource,
  "parameters"
);
@@clientName(RoleAssignmentScheduleRequests.validate::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleAssignmentScheduleRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleEligibilitySchedule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleEligibilityScheduleInstance.properties);

@@clientName(RoleEligibilityScheduleRequests.create::parameters.resource,
  "parameters"
);
@@clientName(RoleEligibilityScheduleRequests.validate::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleEligibilityScheduleRequest.properties);

@@clientName(RoleManagementPolicies.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleManagementPolicy.properties);

@@clientName(RoleManagementPolicyAssignments.create::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleManagementPolicyAssignment.properties);

@@clientLocation(EligibleChildResourcesOperationGroup.get,
  "EligibleChildResources"
);
