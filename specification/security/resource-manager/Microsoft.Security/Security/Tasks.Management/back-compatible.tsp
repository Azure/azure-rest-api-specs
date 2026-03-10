import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

@@clientLocation(SecurityTasks.getSubscriptionLevelTask, Tasks);
@@clientLocation(SecurityTasks.listByHomeRegion, Tasks);
@@clientLocation(SecurityTasks.updateSubscriptionLevelTaskState, Tasks);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityTask.properties);

@@clientLocation(TasksOperationGroup.list, Tasks);
