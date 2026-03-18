import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleAssignmentSchedule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleAssignmentScheduleInstance.properties);

@@clientName(RoleAssignmentScheduleRequests.create::parameters.resource,
  "parameters"
);
@@clientName(RoleAssignmentScheduleRequests.validate::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleAssignmentScheduleRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleEligibilitySchedule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleEligibilityScheduleInstance.properties);

@@clientName(RoleEligibilityScheduleRequests.create::parameters.resource,
  "parameters"
);
@@clientName(RoleEligibilityScheduleRequests.validate::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleEligibilityScheduleRequest.properties);

@@clientName(RoleManagementPolicies.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleManagementPolicy.properties);

@@clientName(RoleManagementPolicyAssignments.create::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleManagementPolicyAssignment.properties);

@@clientLocation(EligibleChildResourcesOperationGroup.get,
  "EligibleChildResources"
);
