import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager.Foundations;
using Microsoft.AppComplianceAutomation;

@@clientName(Microsoft.AppComplianceAutomation,
  "AppComplianceAutomationMgmt",
  "python"
);

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@clientName(EvidenceResource, "AppComplianceReportEvidence", "csharp");
@@clientName(EvidenceProperties,
  "AppComplianceReportEvidenceProperties",
  "csharp"
);
@@clientName(ReportResource, "AppComplianceReport", "csharp");
@@clientName(ScopingConfigurationResource,
  "AppComplianceReportScopingConfiguration",
  "csharp"
);
@@clientName(ScopingConfigurationProperties,
  "AppComplianceReportScopingConfigurationProperties",
  "csharp"
);
@@usage(SnapshotResource, Usage.input | Usage.output, "csharp");
@@clientName(SnapshotResource, "AppComplianceReportSnapshot", "csharp");
@@clientName(SnapshotProperties,
  "AppComplianceReportSnapshotProperties",
  "csharp"
);
@@clientName(WebhookResource, "AppComplianceReportWebhook", "csharp");
@@clientName(WebhookProperties,
  "AppComplianceReportWebhookProperties",
  "csharp"
);
@@alternateType(WebhookProperties.payloadUrl, url, "csharp");
@@alternateType(WebhookProperties.tenantId, uuid, "csharp");
@@clientName(SendAllEvents, "SendAllEvent", "csharp");
@@clientName(Category, "AppComplianceCategory", "csharp");
@@clientName(CategoryStatus, "AppComplianceCategoryStatus", "csharp");
@@clientName(ProviderActions.checkNameAvailability,
  "CheckAppComplianceReportNameAvailability",
  "csharp"
);
@@clientName(Report.checkNameAvailability,
  "CheckAppComplianceReportNestedResourceNameAvailability",
  "csharp"
);
@@clientName(CheckNameAvailabilityReason,
  "AppComplianceReportNameUnavailabilityReason",
  "csharp"
);
@@clientName(CheckNameAvailabilityRequest,
  "AppComplianceReportNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityRequest.type, "ResourceType", "csharp");
@@clientName(CheckNameAvailabilityResponse,
  "AppComplianceReportNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@alternateType(CheckNameAvailabilityRequest.type, armResourceType, "csharp");
@@clientName(ComplianceReportItem, "AppComplianceReportItem", "csharp");
@@alternateType(ComplianceReportItem.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ComplianceReportItem.resourceType, armResourceType, "csharp");
@@clientName(ComplianceReportItem.resourceStatusChangeDate,
  "ResourceStatusChangedOn",
  "csharp"
);
@@clientName(ComplianceResult, "AppComplianceResult", "csharp");
@@clientName(ContentType, "WebhookContentType", "csharp");
@@clientName(Control, "AppComplianceControl", "csharp");
@@alternateType(Control.controlDescriptionHyperLink, url, "csharp");
@@clientName(ControlFamily, "AppComplianceControlFamily", "csharp");
@@clientName(ControlStatus, "AppComplianceControlStatus", "csharp");
@@clientName(DeliveryStatus, "WebhookDeliveryStatus", "csharp");
@@clientName(DownloadResponse, "AppComplianceDownloadResult", "csharp");
@@clientName(DownloadResponseComplianceDetailedPdfReport,
  "AppComplianceDetailedPdfReport",
  "csharp"
);
@@alternateType(DownloadResponseComplianceDetailedPdfReport.sasUri,
  url,
  "csharp"
);
@@clientName(DownloadResponseCompliancePdfReport,
  "AppCompliancePdfReport",
  "csharp"
);
@@alternateType(DownloadResponseCompliancePdfReport.sasUri, url, "csharp");
@@clientName(DownloadType, "AppComplianceDownloadType", "csharp");
@@clientName(EvidenceFileDownloadResponse,
  "EvidenceFileDownloadResult",
  "csharp"
);
@@clientName(EvidenceFileDownloadResponseEvidenceFile,
  "EvidenceFileUrlInfo",
  "csharp"
);
@@alternateType(EvidenceFileDownloadResponseEvidenceFile.url, url, "csharp");
@@clientName(EvidenceType, "AppComplianceReportEvidenceType", "csharp");
@@clientName(GetCollectionCountRequest,
  "ReportCollectionGetCountContent",
  "csharp"
);
@@clientName(GetCollectionCountRequest.type,
  "GetCollectionCountRequestType",
  "csharp"
);
@@clientName(GetCollectionCountResponse,
  "ReportCollectionGetCountResult",
  "csharp"
);
@@clientName(GetOverviewStatusRequest,
  "AppComplianceGetOverviewStatusContent",
  "csharp"
);
@@clientName(GetOverviewStatusRequest.type,
  "GetOverviewStatusRequestType",
  "csharp"
);
@@clientName(GetOverviewStatusResponse,
  "AppComplianceGetOverviewStatusResult",
  "csharp"
);
@@clientName(InputType, "ScopingQuestionInputType", "csharp");
@@clientName(ListInUseStorageAccountsRequest,
  "ReportListInUseStorageAccountsContent",
  "csharp"
);
@@clientName(ListInUseStorageAccountsResponse,
  "ReportListInUseStorageAccountsResult",
  "csharp"
);
@@clientName(NotificationEvent, "WebhookNotificationEvent", "csharp");
@@clientName(OnboardRequest, "AppComplianceOnboardContent", "csharp");
@@clientName(OnboardResponse, "AppComplianceOnboardResult", "csharp");
@@clientName(OverviewStatus, "ReportOverviewStatus", "csharp");
@@clientName(ProvisioningState, "AppComplianceProvisioningState", "csharp");
@@clientName(Recommendation, "RecommendationDetails", "csharp");
@@clientName(ReportPatchProperties,
  "AppComplianceReportPatchProperties",
  "csharp"
);
@@alternateType(ReportPatchProperties.tenantId, uuid, "csharp");
@@clientName(ReportProperties, "AppComplianceReportProperties", "csharp");
@@alternateType(ReportProperties.tenantId, uuid, "csharp");
@@clientName(ReportStatus, "AppComplianceReportStatus", "csharp");
@@clientName(ResourceItem, "ReportResourceItem", "csharp");
@@alternateType(ResourceItem.resourceId, armResourceIdentifier, "csharp");
@@alternateType(ResourceItem.resourceType, armResourceType, "csharp");
@@clientName(ResourceMetadata, "ReportResourceMetadata", "csharp");
@@alternateType(ResourceMetadata.resourceId, armResourceIdentifier, "csharp");
@@alternateType(ResourceMetadata.resourceType, armResourceType, "csharp");
@@clientName(ResourceOrigin, "ReportResourceOrigin", "csharp");
@@clientName(ResourceOrigin.AWS, "Aws", "csharp");
@@clientName(ResourceOrigin.GCP, "Gcp", "csharp");
@@clientName(ResourceStatus, "ReportResourceStatus", "csharp");
@@clientName(Responsibility, "CustomerResponsibility", "csharp");
@@clientName(ResponsibilityEnvironment.AWS, "Aws", "csharp");
@@clientName(ResponsibilityEnvironment.GCP, "Gcp", "csharp");
@@clientName(ResponsibilityResource, "ResponsibilityResourceItem", "csharp");
@@alternateType(ResponsibilityResource.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ResponsibilityResource.resourceType, armResourceType, "csharp");
@@clientName(ResponsibilityResource.resourceStatusChangeDate,
  "ResourceStatusChangedOn",
  "csharp"
);
@@clientName(Result, "ReportResult", "csharp");
@@clientName(Rule, "QuestionRuleItem", "csharp");
@@clientName(StatusItem, "OverviewStatusItem", "csharp");
@@clientName(StorageInfo, "ReportStorageInfo", "csharp");
@@alternateType(StorageInfo.location, azureLocation, "csharp");
@@clientName(SyncCertRecordResponse, "SyncCertRecordResult", "csharp");
@@clientName(TriggerEvaluationResponse, "TriggerEvaluationResult", "csharp");
@@alternateType(QuickAssessment.resourceId, armResourceIdentifier, "csharp");
@@clientName(QuickAssessment.timestamp, "CreatedOn", "csharp");
@@clientName(SnapshotDownloadRequest,
  "SnapshotDownloadRequestContent",
  "csharp"
);
@@clientName(TriggerEvaluationRequest, "TriggerEvaluationContent", "csharp");
@@alternateType(SnapshotDownloadRequest.reportCreatorTenantId, uuid, "csharp");
@@clientName(SyncCertRecordRequest, "SyncCertRecordContent", "csharp");
@@clientName(EvidenceFileDownloadRequest,
  "EvidenceFileDownloadRequestContent",
  "csharp"
);
@@alternateType(EvidenceFileDownloadRequest.reportCreatorTenantId,
  uuid,
  "csharp"
);
@@clientName(ProviderActions.getCollectionCount,
  "GetCollectionCountProviderAction",
  "csharp"
);
@@clientName(ProviderActions.listInUseStorageAccounts,
  "GetInUseStorageAccountsProviderAction",
  "csharp"
);
@@clientName(ProviderActions.getOverviewStatus,
  "GetOverviewStatusProviderAction",
  "csharp"
);
@@clientName(ProviderActions.onboard, "OnboardProviderAction", "csharp");
@@clientName(ProviderActions.triggerEvaluation,
  "TriggerEvaluationProviderAction",
  "csharp"
);
