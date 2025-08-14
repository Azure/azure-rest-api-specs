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

@@clientLocation(CurrentUsagesBases.get, "Usages");
@@clientLocation(CurrentUsagesBases.list, "Usages");

@@clientLocation(GroupQuotasEntities.get, "GroupQuotas");
@@clientLocation(GroupQuotasEntities.createOrUpdate, "GroupQuotas");
@@clientName(GroupQuotasEntities.createOrUpdate::parameters.resource,
  "GroupQuotaPutRequestBody"
);
@@clientLocation(GroupQuotasEntities.update, "GroupQuotas");
@@clientName(GroupQuotasEntities.update::parameters.properties,
  " GroupQuotasPatchRequestBody"
);
@@clientLocation(GroupQuotasEntities.delete, "GroupQuotas");
@@clientLocation(GroupQuotasEntities.list, "GroupQuotas");
@@clientLocation(GroupQuotasEntities.groupQuotaLimitsRequestList,
  "GroupQuotaLimitsRequest"
);
@@clientName(GroupQuotasEntities.groupQuotaLimitsRequestList, "List");
@@clientLocation(GroupQuotasEntities.groupQuotaUsagesList, "GroupQuotaUsages");
@@clientName(GroupQuotasEntities.groupQuotaUsagesList, "List");

@@clientLocation(SubmittedResourceRequestStatuses.get,
  "GroupQuotaLimitsRequest"
);

@@clientLocation(GroupQuotaLimitLists.list, "GroupQuotaLimits");
@@clientLocation(GroupQuotaLimitLists.update, "GroupQuotaLimitsRequest");
@@clientName(GroupQuotaLimitLists.update::parameters.properties,
  "groupQuotaRequest"
);

@@clientName(SubscriptionQuotaAllocationsLists.update::parameters.properties,
  "allocateQuotaRequest"
);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(QuotaAllocationRequestStatus.properties);

@@clientLocation(GroupQuotasEnforcementStatuses.get,
  "GroupQuotaLocationSettings"
);
@@clientLocation(GroupQuotasEnforcementStatuses.createOrUpdate,
  "GroupQuotaLocationSettings"
);
@@clientName(GroupQuotasEnforcementStatuses.createOrUpdate::parameters.resource,
  "LocationSettings"
);
@@clientLocation(GroupQuotasEnforcementStatuses.update,
  "GroupQuotaLocationSettings"
);
@@clientName(GroupQuotasEnforcementStatuses.update::parameters.properties,
  "LocationSettings"
);
@@clientLocation(GroupQuotasEnforcementStatuses.list,
  "GroupQuotaLocationSettings"
);

@@clientLocation(GroupQuotaSubscriptionRequestStatuses.get,
  "GroupQuotaSubscriptionRequests"
);
@@clientLocation(GroupQuotaSubscriptionRequestStatuses.list,
  "GroupQuotaSubscriptionRequests"
);
@@clientLocation(CurrentQuotaLimitBases.get, "Quota");
@@clientLocation(CurrentQuotaLimitBases.createOrUpdate, "Quota");
@@clientName(CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "createQuotaRequest"
);
@@clientLocation(CurrentQuotaLimitBases.update, "Quota");
@@clientName(CurrentQuotaLimitBases.update::parameters.properties,
  "createQuotaRequest"
);
@@clientLocation(CurrentQuotaLimitBases.list, "Quota");

@@clientLocation(GroupQuotaSubscriptionIds.get, "GroupQuotaSubscriptions");
@@clientLocation(GroupQuotaSubscriptionIds.createOrUpdate,
  "GroupQuotaSubscriptions"
);
@@clientLocation(GroupQuotaSubscriptionIds.update, "GroupQuotaSubscriptions");
@@clientLocation(GroupQuotaSubscriptionIds.delete, "GroupQuotaSubscriptions");
@@clientLocation(GroupQuotaSubscriptionIds.list, "GroupQuotaSubscriptions");

@@clientLocation(QuotaAllocationRequestStatuses.get,
  "GroupQuotaSubscriptionAllocationRequest"
);
@@clientLocation(QuotaAllocationRequestStatuses.list,
  "GroupQuotaSubscriptionAllocationRequest"
);

@@clientLocation(SubscriptionQuotaAllocationsLists.list,
  "GroupQuotaSubscriptionAllocation"
);
@@clientLocation(SubscriptionQuotaAllocationsLists.update,
  "GroupQuotaSubscriptionAllocationRequest"
);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(QuotaRequestDetails.properties);

@@maxLength(Azure.ResourceManager.Extension.ManagementGroup.name, 63);
@@minLength(Azure.ResourceManager.Extension.ManagementGroup.name, 3);
