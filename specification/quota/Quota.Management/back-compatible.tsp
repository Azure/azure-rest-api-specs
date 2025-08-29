import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Quota;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(GroupQuotaDetails.name);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(GroupQuotaRequestBase.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(GroupQuotaRequestBaseProperties.name);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SubscriptionQuotaDetails.name);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(QuotaAllocationRequestBase.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(QuotaAllocationRequestBaseProperties.name);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(GroupQuotaUsagesBase.name);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(QuotaRequestOneResourceSubmitResponse.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(QuotaRequestSubmitResponse202.properties);

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

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(QuotaAllocationRequestStatus.properties);

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
@@clientLocation(GroupQuotasEnforcementStatuses.list,
  "GroupQuotaLocationSettings",
  "!csharp"
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

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(QuotaRequestDetails.properties);

@@maxLength(Azure.ResourceManager.Extension.ManagementGroup.name, 63);
@@minLength(Azure.ResourceManager.Extension.ManagementGroup.name, 3);
