import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Quota;

// csharp
@@clientName(LimitJsonObject, "QuotaLimitJsonObject", "csharp");
@@clientName(LimitObject, "QuotaLimitObject", "csharp");
@@clientName(OperationList, "QuotaOperationListResult", "csharp");
@@clientName(OperationResponse, "QuotaOperationResult", "csharp");
@@clientName(OperationDisplay, "QuotaOperationDisplay", "csharp");
@@clientName(ResourceName, "QuotaRequestResourceName", "csharp");
@@clientName(SubRequest, "QuotaSubRequestDetail", "csharp");
@@alternateType(SubRequest.subRequestId, Azure.Core.uuid, "csharp");
@@clientName(UsagesObject, "QuotaUsagesObject", "csharp");
@@clientName(UsagesProperties, "QuotaUsagesProperties", "csharp");
@@alternateType(UsagesProperties.quotaPeriod, duration, "csharp");
@@clientName(UsagesTypes, "QuotaUsagesType", "csharp");
@@clientName(UsagesProperties.resourceType, "ResourceTypeName", "csharp");
@@clientName(QuotaProperties.resourceType, "ResourceTypeName", "csharp");
@@alternateType(QuotaProperties.quotaPeriod, duration, "csharp");
@@clientName(SubRequest.resourceType, "ResourceTypeName", "csharp");
@@clientName(GroupQuotasEntity, "GroupQuotaEntity", "csharp");
@@clientName(GroupQuotasEntityBase, "GroupQuotaEntityBase", "csharp");
@@clientName(GroupQuotaSubscriptionId, "GroupQuotaSubscription", "csharp");
@@clientName(GroupQuotaSubscriptionIdProperties,
  "GroupQuotaSubscriptionProperties",
  "csharp"
);
@@clientName(QuotaAllocationRequestStatusProperties.requestSubmitTime,
  "RequestSubmittedOn",
  "csharp"
);
@@clientName(SubmittedResourceRequestStatus,
  "GroupQuotaRequestStatus",
  "csharp"
);
@@clientName(SubmittedResourceRequestStatusProperties,
  "GroupQuotaRequestStatusProperties",
  "csharp"
);
@@clientName(SubmittedResourceRequestStatusProperties.requestSubmitTime,
  "RequestSubmittedOn",
  "csharp"
);
@@clientName(AllocatedToSubscription, "SubscriptionAllocatedQuota", "csharp");
@@clientName(RequestState, "QuotaRequestStatus", "csharp");
@@clientName(ResourceUsages, "GroupQuotaResourceUsages", "csharp");
@@clientName(GroupQuotasEntities.groupQuotaLimitsRequestList,
  "GetGroupQuotaLimitsRequests",
  "csharp"
);
@@usage(QuotaAllocationRequestStatus, Usage.input, "csharp");
@@usage(QuotaAllocationRequestBase, Usage.input, "csharp");
@@usage(GroupQuotaSubscriptionRequestStatusProperties, Usage.input, "csharp");
@@usage(GroupQuotaSubscriptionIdProperties, Usage.input, "csharp");
@@usage(SubmittedResourceRequestStatusProperties, Usage.input, "csharp");
@@usage(GroupQuotaRequestBase, Usage.input, "csharp");
@@usage(GroupQuotaSubscriptionRequestStatus, Usage.input, "csharp");
@@usage(GroupQuotaSubscriptionId, Usage.input, "csharp");
@@usage(SubmittedResourceRequestStatus, Usage.input, "csharp");

@@clientName(Microsoft.Quota, "QuotaMgmtClient", "python");

// Java-specific fixes for breaking changes
@@clientName(CurrentQuotaLimitBasesResponseHeaders.eTag, "etag", "java");
