import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

using Azure.ClientGenerator.Core;
using Http;
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
@@clientName(
  GroupQuotaSubscriptionIdProperties,
  "GroupQuotaSubscriptionProperties",
  "csharp"
);
@@clientName(
  QuotaAllocationRequestStatusProperties.requestSubmitTime,
  "RequestSubmittedOn",
  "csharp"
);
@@clientName(
  SubmittedResourceRequestStatus,
  "GroupQuotaRequestStatus",
  "csharp"
);
@@clientName(
  SubmittedResourceRequestStatusProperties,
  "GroupQuotaRequestStatusProperties",
  "csharp"
);
@@clientName(
  SubmittedResourceRequestStatusProperties.requestSubmitTime,
  "RequestSubmittedOn",
  "csharp"
);
@@clientName(AllocatedToSubscription, "SubscriptionAllocatedQuota", "csharp");
@@clientName(RequestState, "QuotaRequestStatus", "csharp");
@@clientName(ResourceUsages, "GroupQuotaResourceUsages", "csharp");
@@clientName(
  GroupQuotasEntities.groupQuotaLimitsRequestList,
  "GetGroupQuotaLimitsRequests",
  "csharp"
);
@@clientName(
  GroupQuotasEntities.groupQuotaUsagesList,
  "GetGroupQuotaUsages",
  "csharp"
);
@@clientName(QuotaRequestDetails, "QuotaRequestDetail", "csharp");
@@clientName(QuotaLimitTypes, "QuotaLimitType", "csharp");
@@clientName(GroupQuotasEntityPatch, "GroupQuotaEntityPatch", "csharp");
@@clientName(GroupQuotasEntityBase, "GroupQuotaEntityBase", "csharp");
@@clientName(GroupQuotaLimitLists.list, "get", "csharp");
@@clientName(SubscriptionQuotaAllocationsLists.list, "get", "csharp");

// Avoids .NET analyzer AZC0030, which rejects model names ending in "Request".
@@clientName(
  QuotaTransferCancelRequest,
  "QuotaTransferCancelContent",
  "csharp"
);
@@clientName(
  IncomingQuotaTransferApproveRequest,
  "IncomingQuotaTransferApproveContent",
  "csharp"
);
@@clientName(
  IncomingQuotaTransferRejectRequest,
  "IncomingQuotaTransferRejectContent",
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
@@clientName(ResponseETagHeader.eTag, "etag", "java");

@@override(
  CurrentQuotaLimitBases.createOrUpdate,
  reorderParameters(
    CurrentQuotaLimitBases.createOrUpdate,
    #["apiVersion", "extensionProvider", "resourceName", "scope", "resource"]
  ),
  "java,python,go,javascript"
);

@@clientName(
  CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "createQuotaRequest",
  "java,python,go,javascript"
);
@@override(
  CurrentQuotaLimitBases.get,
  reorderParameters(
    CurrentQuotaLimitBases.get,
    #["apiVersion", "extensionProvider", "resourceName", "scope"]
  ),
  "java,python,go,javascript"
);
@@override(
  CurrentQuotaLimitBases.update,
  reorderParameters(
    CurrentQuotaLimitBases.update,
    #["apiVersion", "extensionProvider", "resourceName", "scope", "properties"]
  ),
  "java,python,go,javascript"
);

@@clientName(
  CurrentQuotaLimitBases.update::parameters.properties,
  "createQuotaRequest",
  "java,python,go,javascript"
);
@@override(
  QuotaRequestStatus.get,
  reorderParameters(
    QuotaRequestStatus.get,
    #["apiVersion", "extensionProvider", "id", "scope"]
  ),
  "java,python,go,javascript"
);
@@override(
  CurrentUsagesBases.get,
  reorderParameters(
    CurrentUsagesBases.get,
    #["apiVersion", "extensionProvider", "resourceName", "scope"]
  ),
  "java,python,go,javascript"
);
