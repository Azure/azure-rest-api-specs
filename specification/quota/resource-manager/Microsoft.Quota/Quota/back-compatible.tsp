import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Quota;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GroupQuotaDetails.name,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GroupQuotaRequestBase.properties,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GroupQuotaRequestBaseProperties.name,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SubscriptionQuotaDetails.name,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(QuotaAllocationRequestBase.properties,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(QuotaAllocationRequestBaseProperties.name,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GroupQuotaUsagesBase.name,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(QuotaRequestOneResourceSubmitResponse.properties,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(QuotaRequestSubmitResponse202.properties,
  "!javascript"
);

@@clientLocation(CurrentUsagesBases.get, "Usages", "!csharp");
@@clientLocation(CurrentUsagesBases.list, "Usages", "!csharp");

@@clientLocation(GroupQuotasEntities.get, "GroupQuotas", "!csharp");
@@clientLocation(GroupQuotasEntities.createOrUpdate, "GroupQuotas", "!csharp");
@@clientName(GroupQuotasEntities.createOrUpdate::parameters.resource,
  "GroupQuotaPutRequestBody"
);
@@clientLocation(GroupQuotasEntities.update, "GroupQuotas", "!csharp");
@@clientName(GroupQuotasEntities.update::parameters.properties,
  " GroupQuotasPatchRequestBody"
);
@@clientLocation(GroupQuotasEntities.delete, "GroupQuotas", "!csharp");
@@clientLocation(GroupQuotasEntities.list, "GroupQuotas", "!csharp");
@@clientLocation(GroupQuotasEntities.groupQuotaLimitsRequestList,
  "GroupQuotaLimitsRequest",
  "!csharp"
);
@@clientName(GroupQuotasEntities.groupQuotaLimitsRequestList, "List");
@@clientLocation(GroupQuotasEntities.groupQuotaUsagesList,
  "GroupQuotaUsages",
  "!csharp"
);
@@clientName(GroupQuotasEntities.groupQuotaUsagesList, "List");

@@clientLocation(SubmittedResourceRequestStatuses.get,
  "GroupQuotaLimitsRequest",
  "!csharp"
);

@@clientLocation(GroupQuotaLimitLists.list, "GroupQuotaLimits", "!csharp");
@@clientLocation(GroupQuotaLimitLists.update,
  "GroupQuotaLimitsRequest",
  "!csharp"
);
@@clientName(GroupQuotaLimitLists.update::parameters.properties,
  "groupQuotaRequest"
);

@@clientName(SubscriptionQuotaAllocationsLists.update::parameters.properties,
  "allocateQuotaRequest"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(QuotaAllocationRequestStatus.properties,
  "!javascript"
);

@@clientLocation(GroupQuotasEnforcementStatuses.get,
  "GroupQuotaLocationSettings",
  "!csharp"
);
@@clientLocation(GroupQuotasEnforcementStatuses.createOrUpdate,
  "GroupQuotaLocationSettings",
  "!csharp"
);
@@clientName(GroupQuotasEnforcementStatuses.createOrUpdate::parameters.resource,
  "LocationSettings"
);
@@clientLocation(GroupQuotasEnforcementStatuses.update,
  "GroupQuotaLocationSettings",
  "!csharp"
);
@@clientName(GroupQuotasEnforcementStatuses.update::parameters.properties,
  "LocationSettings"
);
@@clientLocation(GroupQuotaSubscriptionRequestStatuses.get,
  "GroupQuotaSubscriptionRequests",
  "!csharp"
);
@@clientLocation(GroupQuotaSubscriptionRequestStatuses.list,
  "GroupQuotaSubscriptionRequests",
  "!csharp"
);
@@clientLocation(CurrentQuotaLimitBases.get, "Quota", "!csharp");
@@clientLocation(CurrentQuotaLimitBases.createOrUpdate, "Quota", "!csharp");
@@clientName(CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "createQuotaRequest"
);
@@clientLocation(CurrentQuotaLimitBases.update, "Quota", "!csharp");
@@clientName(CurrentQuotaLimitBases.update::parameters.properties,
  "createQuotaRequest"
);
@@clientLocation(CurrentQuotaLimitBases.list, "Quota", "!csharp");

@@clientLocation(GroupQuotaSubscriptionIds.get,
  "GroupQuotaSubscriptions",
  "!csharp"
);
@@clientLocation(GroupQuotaSubscriptionIds.createOrUpdate,
  "GroupQuotaSubscriptions",
  "!csharp"
);
@@clientLocation(GroupQuotaSubscriptionIds.update,
  "GroupQuotaSubscriptions",
  "!csharp"
);
@@clientLocation(GroupQuotaSubscriptionIds.delete,
  "GroupQuotaSubscriptions",
  "!csharp"
);
@@clientLocation(GroupQuotaSubscriptionIds.list,
  "GroupQuotaSubscriptions",
  "!csharp"
);
@@clientLocation(QuotaAllocationRequestStatuses.get,
  "GroupQuotaSubscriptionAllocationRequest",
  "!csharp"
);
@@clientLocation(QuotaAllocationRequestStatuses.list,
  "GroupQuotaSubscriptionAllocationRequest",
  "!csharp"
);

@@clientLocation(SubscriptionQuotaAllocationsLists.list,
  "GroupQuotaSubscriptionAllocation",
  "!csharp"
);
@@clientLocation(SubscriptionQuotaAllocationsLists.update,
  "GroupQuotaSubscriptionAllocationRequest",
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(QuotaRequestDetails.properties,
  "!javascript"
);

@@maxLength(Azure.ResourceManager.Extension.ManagementGroup.name, 63);
@@minLength(Azure.ResourceManager.Extension.ManagementGroup.name, 3);
@@clientName(QuotaRequestOneResourceProperties,
  "quotaRequestOneResourceProperties"
);
