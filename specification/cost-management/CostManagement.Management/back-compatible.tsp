import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CostManagement;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExportRun.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReportManifest.requestContext);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ViewProperties.query);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DismissAlertPayload.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ForecastResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Dimension.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QueryResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationStatus.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PriceSheetOperationStatus.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IncludedQuantityUtilizationSummary.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SavingsPlanUtilizationSummary.properties);

@@clientLocation(CostAllocationRuleDefinitions.get, "CostAllocationRules");
@@clientLocation(CostAllocationRuleDefinitions.createOrUpdate,
  "CostAllocationRules"
);
@@clientName(CostAllocationRuleDefinitions.createOrUpdate::parameters.resource,
  "costAllocationRule"
);
@@clientLocation(CostAllocationRuleDefinitions.delete, "CostAllocationRules");
@@clientLocation(CostAllocationRuleDefinitions.list, "CostAllocationRules");

@@clientName(Budgets.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Budget.properties);

@@clientName(Exports.createOrUpdate::parameters.resource, "parameters");
@@clientName(Exports.execute::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Export.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CostDetailsOperationResults.manifest);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GenerateDetailedCostReportOperationResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GenerateDetailedCostReportOperationStatuses.properties);

@@clientName(Views.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(ViewOperationGroup.getByScope, Views);
@@clientLocation(ViewOperationGroup.createOrUpdateByScope, Views);
@@clientName(ViewOperationGroup.createOrUpdateByScope::parameters.resource,
  "parameters"
);
@@clientLocation(ViewOperationGroup.deleteByScope, Views);
@@clientLocation(ViewOperationGroup.list, Views);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(View.properties);

@@clientName(Alerts.dismiss::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Alert.properties);

@@clientName(ScheduledActions.createOrUpdate::parameters.resource,
  "scheduledAction"
);
@@clientLocation(ScheduledActionOperationGroup.getByScope, ScheduledActions);
@@clientLocation(ScheduledActionOperationGroup.createOrUpdateByScope,
  ScheduledActions
);
@@clientName(ScheduledActionOperationGroup.createOrUpdateByScope::parameters.resource,
  "scheduledAction"
);
@@clientLocation(ScheduledActionOperationGroup.deleteByScope, ScheduledActions);
@@clientLocation(ScheduledActionOperationGroup.list, ScheduledActions);
@@clientLocation(ScheduledActionOperationGroup.runByScope, ScheduledActions);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScheduledAction.properties);

@@clientName(Settings.createOrUpdateByScope::parameters.resource, "setting");

@@clientLocation(CostAllocationRulesOperationGroup.checkNameAvailability,
  "CostAllocationRules"
);

@@clientLocation(BenefitRecommendationsOperationGroup.list,
  "BenefitRecommendations"
);

@@clientLocation(BenefitUtilizationSummariesOperationGroup.listByBillingAccountId,
  "BenefitUtilizationSummaries"
);
@@clientLocation(BenefitUtilizationSummariesOperationGroup.listByBillingProfileId,
  "BenefitUtilizationSummaries"
);
@@clientLocation(BenefitUtilizationSummariesOperationGroup.listBySavingsPlanOrder,
  "BenefitUtilizationSummaries"
);
@@clientLocation(BenefitUtilizationSummariesOperationGroup.listBySavingsPlanId,
  "BenefitUtilizationSummaries"
);

@@clientLocation(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByBillingAccount,
  "GenerateBenefitUtilizationSummariesReport"
);
@@clientLocation(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByBillingProfile,
  "GenerateBenefitUtilizationSummariesReport"
);
@@clientLocation(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByReservationOrderId,
  "GenerateBenefitUtilizationSummariesReport"
);
@@clientLocation(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByReservationId,
  "GenerateBenefitUtilizationSummariesReport"
);
@@clientLocation(GenerateBenefitUtilizationSummariesReportOperationGroup.generateBySavingsPlanOrderId,
  "GenerateBenefitUtilizationSummariesReport"
);
@@clientLocation(GenerateBenefitUtilizationSummariesReportOperationGroup.generateBySavingsPlanId,
  "GenerateBenefitUtilizationSummariesReport"
);

@@clientLocation(GenerateCostDetailsReportOperationGroup.createOperation,
  GenerateCostDetailsReport
);

@@clientLocation(GenerateDetailedCostReportOperationGroup.createOperation,
  "GenerateDetailedCostReport"
);

@@clientLocation(AlertsOperationGroup.listExternal, Alerts);

@@clientLocation(ForecastOperationGroup.usage, "Forecast");
@@clientLocation(ForecastOperationGroup.externalCloudProviderUsage, "Forecast");

@@clientLocation(DimensionsOperationGroup.list, "Dimensions");
@@clientLocation(DimensionsOperationGroup.byExternalCloudProviderType,
  "Dimensions"
);

@@clientLocation(QueryOperationGroup.usage, "Query");
@@clientLocation(QueryOperationGroup.usageByExternalCloudProviderType, "Query");

@@clientLocation(GenerateReservationDetailsReportOperationGroup.byBillingAccountId,
  "GenerateReservationDetailsReport"
);
@@clientLocation(GenerateReservationDetailsReportOperationGroup.byBillingProfileId,
  "GenerateReservationDetailsReport"
);

@@clientLocation(PriceSheetOperationGroup.downloadByInvoice, "PriceSheet");
@@clientLocation(PriceSheetOperationGroup.downloadByBillingProfile,
  "PriceSheet"
);
@@clientLocation(PriceSheetOperationGroup.downloadByBillingAccount,
  "PriceSheet"
);

@@clientLocation(ScheduledActionsOperationGroup.checkNameAvailability,
  ScheduledActions
);
@@clientLocation(ScheduledActionsOperationGroup.checkNameAvailabilityByScope,
  ScheduledActions
);
