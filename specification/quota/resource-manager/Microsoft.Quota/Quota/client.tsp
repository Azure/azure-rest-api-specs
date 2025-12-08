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
@@clientName(GroupQuotasEntities.groupQuotaUsagesList,
  "GetGroupQuotaUsages",
  "csharp"
);
@@clientName(QuotaRequestDetails, "QuotaRequestDetail", "csharp");
@@clientName(QuotaLimitTypes, "QuotaLimitType", "csharp");
@@clientName(GroupQuotasEntityPatch, "GroupQuotaEntityPatch", "csharp");
@@clientName(GroupQuotasEntityBase, "GroupQuotaEntityBase", "csharp");
@@clientName(GroupQuotaLimitLists.list, "get", "csharp");
@@clientName(SubscriptionQuotaAllocationsLists.list, "get", "csharp");

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
@@clientName(ResponseETagHeader.eTag, "etag", "java");

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op currentQuotaLimitBasesCreateOrUpdate(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  apiVersion: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  extensionProvider: "Microsoft.Quota",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  resourceName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  scope: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  createQuotaRequest: CurrentQuotaLimitBase,
): CurrentQuotaLimitBase;

@@override(CurrentQuotaLimitBases.createOrUpdate,
  currentQuotaLimitBasesCreateOrUpdate,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op currentQuotaLimitBasesGet(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  apiVersion: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  extensionProvider: "Microsoft.Quota",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  resourceName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  scope: string,
): CurrentQuotaLimitBase;

@@override(CurrentQuotaLimitBases.get,
  currentQuotaLimitBasesGet,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op currentQuotaLimitBasesUpdate(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  apiVersion: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  extensionProvider: "Microsoft.Quota",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  resourceName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  scope: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  createQuotaRequest: CurrentQuotaLimitBase,
): CurrentQuotaLimitBase;

@@override(CurrentQuotaLimitBases.update,
  currentQuotaLimitBasesUpdate,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op quotaRequestStatusGet(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  apiVersion: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  extensionProvider: "Microsoft.Quota",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  id: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  scope: string,
): QuotaRequestDetails;

@@override(QuotaRequestStatus.get,
  quotaRequestStatusGet,
  "java,go,python,javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op currentUsagesBasesGet(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  apiVersion: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  extensionProvider: "Microsoft.Quota",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  resourceName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  scope: string,
): CurrentUsagesBase;

@@override(CurrentUsagesBases.get,
  currentUsagesBasesGet,
  "java,go,python,javascript"
);
