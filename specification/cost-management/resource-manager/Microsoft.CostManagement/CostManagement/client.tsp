import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Http;
using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.CostManagement;

// Rename PivotTypeType back to PivotType for Java
@@clientName(PivotTypeType, "PivotType", "java,javascript");

// Rename KpiTypeType back to KpiType for Java
@@clientName(KpiTypeType, "KpiType", "java,javascript");

// Rename DownloadURL back to DownloadUrl for Java
@@clientName(DownloadURL, "DownloadUrl", "java");

// Rename ReportURL back to ReportUrl for Java
@@clientName(ReportURL, "ReportUrl", "java");

// Rename statusModificationUserName back to statusModificationUsername for Java
@@clientName(AlertProperties.statusModificationUserName,
  "statusModificationUsername",
  "java"
);

@@alternateType(AlertPropertiesDetails.tagFilter, unknown, "java");

// Rename eTag back to etag for Java (backward compatibility)
@@clientName(CostManagementProxyResource.eTag, "etag", "java");
@@clientName(CostManagementResource.eTag, "etag", "java");
@@clientName(View.eTag, "etag", "java");
@@clientName(ScheduledAction.eTag, "etag", "java");
@@clientName(Export.eTag, "etag", "java");
@@clientName(Alert.eTag, "etag", "java");

@@clientName(Microsoft.CostManagement.ErrorResponse,
  "CostManagementErrorResponse",
  "csharp"
);
@@clientLocation(ViewOperationGroup.getByScope, ViewOperationGroup, "csharp");
@@clientLocation(ViewOperationGroup.createOrUpdateByScope,
  ViewOperationGroup,
  "csharp"
);
@@clientLocation(ViewOperationGroup.deleteByScope,
  ViewOperationGroup,
  "csharp"
);
@@clientLocation(ViewOperationGroup.listByScope, ViewOperationGroup, "csharp");
@@clientLocation(ScheduledActionOperationGroup.getByScope,
  ScheduledActionOperationGroup,
  "csharp"
);
@@clientLocation(ScheduledActionOperationGroup.createOrUpdateByScope,
  ScheduledActionOperationGroup,
  "csharp"
);
@@clientLocation(ScheduledActionOperationGroup.deleteByScope,
  ScheduledActionOperationGroup,
  "csharp"
);
@@clientLocation(ScheduledActionOperationGroup.listByScope,
  ScheduledActionOperationGroup,
  "csharp"
);
@@clientLocation(ScheduledActionOperationGroup.runByScope,
  ScheduledActionOperationGroup,
  "csharp"
);
@@clientName(Microsoft.CostManagement, "CostManagementClient", "python");
@@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "python,javascript,java"
);
@@clientName(Term.P1Y, "P1_Y", "python");
@@clientName(Term.P3Y, "P3_Y", "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op GetGenerateDetailedCostReportOperationResultCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  extensionProvider: "Microsoft.CostManagement",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path("operationId")
  operationId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path(#{ allowReserved: true })
  scope: string,
): GenerateDetailedCostReportOperationResult;

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op GetGenerateDetailedCostReportOperationStatusCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  extensionProvider: "Microsoft.CostManagement",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path("operationId")
  operationId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path(#{ allowReserved: true })
  scope: string,
): GenerateDetailedCostReportOperationStatus;

@@override(GenerateDetailedCostReportOperationResults.get,
  GetGenerateDetailedCostReportOperationResultCustomized,
  "python,go,java,javascript"
);
@@override(GenerateDetailedCostReportOperationStatus.get,
  GetGenerateDetailedCostReportOperationStatusCustomized,
  "python,go,java,javascript"
);
@@clientName(DimensionsOperationGroup.byExternalCloudProviderType,
  "listByExternalCloudProviderType",
  "javascript"
);
@@clientName(FormatType, "ExportFormatType", "csharp");
@@clientName(StatusType, "ExportScheduleStatusType", "csharp");
@@clientName(RecurrenceType, "ExportScheduleRecurrenceType", "csharp");
@@clientName(ReportType, "ViewReportType", "csharp");
@@clientName(MetricType, "ViewMetricType", "csharp");
@@clientName(KpiProperties, "ViewKpiProperties", "csharp");
@@clientName(ChartType, "ViewChartType", "csharp");
@@clientName(PivotProperties, "ViewPivotProperties", "csharp");
@@clientName(ExecutionType, "ExportRunExecutionType", "csharp");
@@clientName(ExecutionStatus, "ExportRunExecutionStatus", "csharp");
@@clientName(ErrorDetails, "ExportRunErrorDetails", "csharp");
@@clientName(BenefitKind, "BillingAccountBenefitKind", "csharp");
@@clientName(DaysOfWeek, "ScheduledActionDaysOfWeek", "csharp");
@@clientName(WeeksOfMonth, "ScheduledActionWeeksOfMonth", "csharp");
@@clientName(FileFormat, "ScheduledActionFileFormat", "csharp");
@@clientName(Term, "BenefitRecommendationPeriodTerm", "csharp");
@@clientName(Scope, "BenefitRecommendationScope", "csharp");
@@clientName(Grain, "BenefitRecommendationUsageGrain", "csharp");
@@clientName(OperatorType, "ComparisonOperatorType", "csharp");
@@clientName(AlertCriteria, "AlertCriterion", "csharp");
@@clientName(AlertProperties.modificationTime, "ModifiedOn", "csharp");
@@clientName(AlertProperties.creationTime, "CreatedOn", "csharp");
@@clientName(AlertProperties.closeTime, "CloseOn", "csharp");
@@clientName(AlertProperties.statusModificationTime,
  "StatusModifiedOn",
  "csharp"
);
@@alternateType(AlertProperties.creationTime, utcDateTime, "csharp");
@@alternateType(AlertProperties.closeTime, utcDateTime, "csharp");
@@alternateType(AlertProperties.modificationTime, utcDateTime, "csharp");
@@alternateType(AlertProperties.statusModificationTime, utcDateTime, "csharp");
@@alternateType(DownloadURL.downloadUrl, url, "csharp");
@@clientName(ExportDefinition.type, "ExportType", "csharp");
@@clientName(ForecastDefinition.type, "ForecastType", "csharp");
@@clientName(QueryDefinition.type, "ExportType", "csharp");
@@clientName(QueryGrouping.type, "ColumnType", "csharp");
@@clientName(ReportConfigGrouping.type, "QueryColumnType", "csharp");
@@alternateType(ViewProperties.scope,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ScheduledActionProperties.scope,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ScheduledActionProperties.viewId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ExportDeliveryDestination.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(KpiProperties.id, Azure.Core.armResourceIdentifier, "csharp");

// Mark getExecutionHistory as pageable so it generates Pageable<ExportRun> / AsyncPageable<ExportRun>
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the operation back to pageable for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Exports.getExecutionHistory,
  "csharp"
);

// Mark Exports.list as pageable so GetAll generates Pageable<CostManagementExportResource>
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the operation back to pageable for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Exports.list, "csharp");

@@clientName(DimensionProperties.filterEnabled, "IsFilterEnabled", "csharp");
@@clientName(DimensionProperties.groupingEnabled,
  "IsGroupingEnabled",
  "csharp"
);
@@clientName(KpiProperties.enabled, "IsEnabled", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "CostManagementUnavailabilityReason",
  "csharp"
);
@@clientName(BenefitUtilizationSummariesRequest,
  "BenefitUtilizationSummariesContent",
  "csharp"
);
@@clientName(GrainParameter, "GrainContent", "csharp");
@@clientName(AlertPropertiesDefinition.type, "AlertType", "csharp");
@@clientName(View, "CostManagementView", "csharp");
@@clientName(AlertCategory, "CostManagementAlertCategory", "csharp");
@@clientName(AlertOperator, "CostManagementAlertOperator", "csharp");
@@clientName(AlertSource, "CostManagementAlertSource", "csharp");
@@clientName(AlertsResult, "CostManagementAlertsResult", "csharp");
@@clientName(AlertStatus, "CostManagementAlertStatus", "csharp");
@@clientName(AlertType, "CostManagementAlertType", "csharp");
@@clientName(DimensionsListResult,
  "CostManagementDimensionsListResult",
  "csharp"
);
@@clientName(PivotTypeType, "ViewPivotType", "csharp");
@@clientName(KpiTypeType, "ViewKpiType", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "CostManagementNameAvailabilityContent",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "CostManagementNameAvailabilityResult",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "NameAvailable",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);
@@clientName(Status, "ReportOperationStatus", "csharp");

// Rename to remove banned 'Definition' suffix (comment #21, #25, #26)
@@clientName(CostAllocationRuleDefinition, "CostAllocationRule", "csharp");
@@clientName(GenerateCostDetailsReportRequestDefinition,
  "GenerateCostDetailsReportContent",
  "csharp"
);
@@clientName(GenerateDetailedCostReportDefinition,
  "GenerateDetailedCostReportContent",
  "csharp"
);
@@clientName(Status.status, "StatusValue", "csharp");
@@clientName(ScheduledActionOperationGroup.listByScope,
  "GetAllByScope",
  "csharp"
);

@@usage(Alert, Usage.input | Usage.output, "csharp");
@@usage(AllSavingsBenefitDetails, Usage.input | Usage.output, "csharp");
@@usage(BenefitRecommendationModel, Usage.input | Usage.output, "csharp");
@@usage(BenefitUtilizationSummary, Usage.input | Usage.output, "csharp");
@@usage(ExportRun, Usage.input | Usage.output, "csharp");
@@usage(ExportRunReplacement, Usage.input | Usage.output, "csharp");
@@usage(ErrorDetails, Usage.input | Usage.output, "csharp");
@@usage(IncludedQuantityUtilizationSummary,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(RecommendationUsageDetails, Usage.input | Usage.output, "csharp");
@@usage(SavingsPlanUtilizationSummary, Usage.input | Usage.output, "csharp");
@@usage(SharedScopeBenefitRecommendationProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(SingleScopeBenefitRecommendationProperties,
  Usage.input | Usage.output,
  "csharp"
);

// Operation renames to match baseline method names
@@clientName(DimensionsOperationGroup.list, "GetDimensions", "csharp");
@@clientName(DimensionsOperationGroup.byExternalCloudProviderType,
  "ByExternalCloudProviderTypeDimensions",
  "csharp"
);
@@clientName(QueryOperationGroup.usage, "UsageQuery", "csharp");
@@clientName(QueryOperationGroup.usageByExternalCloudProviderType,
  "UsageByExternalCloudProviderTypeQuery",
  "csharp"
);
@@clientName(ForecastOperationGroup.usage, "UsageForecast", "csharp");
@@clientName(ForecastOperationGroup.externalCloudProviderUsage,
  "ExternalCloudProviderUsageForecast",
  "csharp"
);
@@clientName(BenefitRecommendationsOperationGroup.list,
  "GetBenefitRecommendations",
  "csharp"
);
@@clientName(BenefitUtilizationSummariesOperationGroup.listByBillingAccountId,
  "GetBenefitUtilizationSummariesByBillingAccountId",
  "csharp"
);
@@clientName(BenefitUtilizationSummariesOperationGroup.listByBillingProfileId,
  "GetBenefitUtilizationSummariesByBillingProfileId",
  "csharp"
);
@@clientName(BenefitUtilizationSummariesOperationGroup.listBySavingsPlanOrder,
  "GetBenefitUtilizationSummariesBySavingsPlanOrder",
  "csharp"
);
@@clientName(BenefitUtilizationSummariesOperationGroup.listBySavingsPlanId,
  "GetBenefitUtilizationSummariesBySavingsPlanId",
  "csharp"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByBillingAccount,
  "GenerateBenefitUtilizationSummariesReportBillingAccountScope",
  "csharp"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByBillingProfile,
  "GenerateBenefitUtilizationSummariesReportBillingProfileScope",
  "csharp"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByReservationOrderId,
  "GenerateBenefitUtilizationSummariesReportReservationOrderScope",
  "csharp"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByReservationId,
  "GenerateBenefitUtilizationSummariesReportReservationScope",
  "csharp"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateBySavingsPlanOrderId,
  "GenerateBenefitUtilizationSummariesReportSavingsPlanOrderScope",
  "csharp"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateBySavingsPlanId,
  "GenerateBenefitUtilizationSummariesReportAsyncSavingsPlanScope",
  "csharp"
);
@@clientName(GenerateReservationDetailsReportOperationGroup.byBillingAccountId,
  "ByBillingAccountIdGenerateReservationDetailsReport",
  "csharp"
);
@@clientName(GenerateReservationDetailsReportOperationGroup.byBillingProfileId,
  "ByBillingProfileIdGenerateReservationDetailsReport",
  "csharp"
);
@@clientName(PriceSheetOperationGroup.downloadByInvoice,
  "DownloadPriceSheet",
  "csharp"
);
@@clientName(PriceSheetOperationGroup.downloadByBillingProfile,
  "DownloadByBillingProfilePriceSheet",
  "csharp"
);
@@clientName(ScheduledActionsOperationGroup.checkNameAvailability,
  "CheckCostManagementNameAvailabilityByScheduledAction",
  "csharp"
);
@@clientName(ScheduledActionsOperationGroup.checkNameAvailabilityByScope,
  "CheckCostManagementNameAvailabilityByScopeScheduledAction",
  "csharp"
);
@@clientName(AlertsOperationGroup.listExternal,
  "GetCostManagementAlerts",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the operation back to pageable for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(AlertsOperationGroup.listExternal,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the Alerts.list operation back to pageable for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Alerts.list, "csharp");

@@clientName(Alert, "CostManagementAlert", "csharp");
@@clientName(Export, "CostManagementExport", "csharp");

// Property renames for backward compatibility
@@clientName(MetricType.AHUB, "Ahub", "csharp");
@@clientName(KpiProperties.type, "KpiType", "csharp");
@@clientName(PivotProperties.type, "PivotType", "csharp");
@@clientName(ForecastColumn.type, "ForecastColumnType", "csharp");
@@clientName(QueryColumn.type, "QueryColumnType", "csharp");
@@clientName(ReportConfigDefinition.type, "TypePropertiesQueryType", "csharp");

// Fix ETag and Location type mismatches (string → ETag/AzureLocation)
@@alternateType(CostManagementResource.eTag, Azure.Core.eTag, "csharp");
@@alternateType(CostManagementResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(CostManagementProxyResource.eTag, Azure.Core.eTag, "csharp");


// @@hierarchyBuilding cannot be used here, fall back to the model replacement approach.
/** Result of forecast. It contains all columns listed under groupings and aggregation. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For csharp backward compatibility"
model ForecastResultReplacement
  extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<ForecastResult, "id" | "name" | "type">;
}
@@alternateType(ForecastResult, ForecastResultReplacement, "csharp");
@@clientName(ForecastResult, "ForecastResultTemp", "csharp");
@@clientName(ForecastResultReplacement, "ForecastResult", "csharp");

// @@hierarchyBuilding cannot be used here, fall back to the model replacement approach.
/** List of Dimension. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For csharp backward compatibility"
model DimensionReplacement extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<Dimension, "id" | "name" | "type">;
}
@@alternateType(Dimension, DimensionReplacement, "csharp");
@@clientName(Dimension, "DimensionTemp", "csharp");
@@clientName(DimensionReplacement, "CostManagementDimension", "csharp");

// @@hierarchyBuilding cannot be used here, fall back to the model replacement approach.
/** Result of query. It contains all columns listed under groupings and aggregation. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For csharp backward compatibility"
model QueryResultReplacement
  extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<QueryResult, "id" | "name" | "type">;
}
@@alternateType(QueryResult, QueryResultReplacement, "csharp");
@@clientName(QueryResult, "QueryResultTemp", "csharp");
@@clientName(QueryResultReplacement, "QueryResult", "csharp");

// @@hierarchyBuilding cannot be used here, fall back to the model replacement approach.
/** An export run. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For csharp backward compatibility"
model ExportRunReplacement extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<ExportRun, "id" | "name" | "type">;
}
@@alternateType(ExportRun, ExportRunReplacement, "csharp");
@@clientName(ExportRun, "ExportRunTemp", "csharp");
@@clientName(ExportRunReplacement, "ExportRun", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "flattenProperty is needed for C# backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExportDataset.configuration, "csharp");
