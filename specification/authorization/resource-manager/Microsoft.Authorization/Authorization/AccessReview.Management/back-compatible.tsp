import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewHistoryDefinitionProperties.createdBy);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewHistoryDefinitionProperties.settings);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewHistoryScheduleSettings.pattern);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewHistoryScheduleSettings.range);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewHistoryInstance.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewScheduleDefinitionProperties.createdBy);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewScheduleDefinitionProperties.settings);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewScheduleDefinitionProperties.scope);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewScheduleSettings.recurrence);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewRecurrenceSettings.pattern);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewRecurrenceSettings.range);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewDecisionProperties.principal);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewDecisionProperties.resource);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewDecisionProperties.reviewedBy);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewDecisionProperties.appliedBy);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewDecisionProperties.principalResourceMembership
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewDecisionInsight.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewContactedReviewer.properties);

@@clientLocation(AccessReviewHistoryDefinitions.create,
  "AccessReviewHistoryDefinition"
);
@@clientName(AccessReviewHistoryDefinitions.create::parameters.resource,
  "properties"
);
@@clientLocation(AccessReviewHistoryDefinitions.deleteById,
  "AccessReviewHistoryDefinition"
);
@@clientLocation(AccessReviewHistoryDefinitions.generateDownloadUri,
  "AccessReviewHistoryDefinitionInstance"
);
@@clientLocation(AccessReviewHistoryDefinitions.accessReviewHistoryDefinitionInstancesList,
  "AccessReviewHistoryDefinitionInstances"
);
@@clientName(AccessReviewHistoryDefinitions.accessReviewHistoryDefinitionInstancesList,
  "List"
);
@@clientLocation(ScopeAccessReviewHistoryDefinitions.create,
  "ScopeAccessReviewHistoryDefinition"
);
@@clientName(ScopeAccessReviewHistoryDefinitions.create::parameters.resource,
  "properties"
);
@@clientLocation(ScopeAccessReviewHistoryDefinitions.deleteById,
  "ScopeAccessReviewHistoryDefinition"
);
@@clientLocation(ScopeAccessReviewHistoryDefinitions.generateDownloadUri,
  "ScopeAccessReviewHistoryDefinitionInstance"
);
@@clientLocation(ScopeAccessReviewHistoryDefinitions.scopeAccessReviewHistoryDefinitionInstancesList,
  "ScopeAccessReviewHistoryDefinitionInstances"
);
@@clientName(ScopeAccessReviewHistoryDefinitions.scopeAccessReviewHistoryDefinitionInstancesList,
  "List"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewHistoryDefinition.properties);

@@clientName(AccessReviewScheduleDefinitions.createOrUpdateById::parameters.resource,
  "properties"
);
@@clientName(ScopeAccessReviewScheduleDefinitions.createOrUpdateById::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewScheduleDefinition.properties);

@@clientName(AccessReviewInstances.create::parameters.resource, "properties");
@@clientLocation(AccessReviewInstances.stop, "AccessReviewInstance");
@@clientLocation(AccessReviewInstances.resetDecisions, "AccessReviewInstance");
@@clientLocation(AccessReviewInstances.applyDecisions, "AccessReviewInstance");
@@clientLocation(AccessReviewInstances.sendReminders, "AccessReviewInstance");
@@clientLocation(AccessReviewInstances.accessReviewInstanceDecisionsList,
  "AccessReviewInstanceDecisions"
);
@@clientName(AccessReviewInstances.accessReviewInstanceDecisionsList, "List");
@@clientLocation(AccessReviewInstances.accessReviewInstanceContactedReviewersList,
  "AccessReviewInstanceContactedReviewers"
);
@@clientName(AccessReviewInstances.accessReviewInstanceContactedReviewersList,
  "List"
);
@@clientName(ScopeAccessReviewInstances.create::parameters.resource,
  "properties"
);
@@clientLocation(ScopeAccessReviewInstances.stop, "ScopeAccessReviewInstance");
@@clientLocation(ScopeAccessReviewInstances.recordAllDecisions,
  "ScopeAccessReviewInstance"
);
@@clientName(ScopeAccessReviewInstances.recordAllDecisions::parameters.body,
  "properties"
);
@@clientLocation(ScopeAccessReviewInstances.resetDecisions,
  "ScopeAccessReviewInstance"
);
@@clientLocation(ScopeAccessReviewInstances.applyDecisions,
  "ScopeAccessReviewInstance"
);
@@clientLocation(ScopeAccessReviewInstances.sendReminders,
  "ScopeAccessReviewInstance"
);
@@clientLocation(ScopeAccessReviewInstances.scopeAccessReviewInstanceDecisionsList,
  "ScopeAccessReviewInstanceDecisions"
);
@@clientName(ScopeAccessReviewInstances.scopeAccessReviewInstanceDecisionsList,
  "List"
);
@@clientLocation(ScopeAccessReviewInstances.scopeAccessReviewInstanceContactedReviewersList,
  "ScopeAccessReviewInstanceContactedReviewers"
);
@@clientName(ScopeAccessReviewInstances.scopeAccessReviewInstanceContactedReviewersList,
  "List"
);
@@clientLocation(AccessReviewInstancesAssignedForMyApproval.acceptRecommendations,
  "AccessReviewInstance"
);
@@clientLocation(AccessReviewInstancesAssignedForMyApproval.list,
  "TenantLevelAccessReviewInstanceContactedReviewers"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewInstance.properties);

@@clientLocation(AccessReviewDecisions.getById,
  "AccessReviewInstanceMyDecisions"
);
@@clientLocation(AccessReviewDecisions.patch,
  "AccessReviewInstanceMyDecisions"
);
@@clientLocation(AccessReviewDecisions.list, "AccessReviewInstanceMyDecisions");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewDecision.properties);

@@clientLocation(AccessReviewDefaultSettingsOperationGroup.get,
  "AccessReviewDefaultSettings"
);
@@clientLocation(AccessReviewDefaultSettingsOperationGroup.put,
  "AccessReviewDefaultSettings"
);
@@clientName(AccessReviewDefaultSettingsOperationGroup.put::parameters.resource,
  "properties"
);
@@clientName(ScopeAccessReviewDefaultSettings.put::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessReviewDefaultSettings.properties);
