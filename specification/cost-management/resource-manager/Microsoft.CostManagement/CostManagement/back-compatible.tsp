import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CostManagement;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExportRun.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ReportManifest.requestContext
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ViewProperties.query);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DismissAlertPayload.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ForecastResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Dimension.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(QueryResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OperationStatus.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(IncludedQuantityUtilizationSummary.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SavingsPlanUtilizationSummary.properties
);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Budget.properties);

@@clientName(Exports.createOrUpdate::parameters.resource, "parameters");
@@clientName(Exports.execute::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Export.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CostDetailsOperationResults.manifest
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GenerateDetailedCostReportOperationResult.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GenerateDetailedCostReportOperationStatuses.properties
);

@@clientName(Views.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(ViewOperationGroup.getByScope, Views);
@@clientLocation(ViewOperationGroup.createOrUpdateByScope, Views);
@@clientName(ViewOperationGroup.createOrUpdateByScope::parameters.resource,
  "parameters"
);
@@clientLocation(ViewOperationGroup.deleteByScope, Views);
@@clientLocation(ViewOperationGroup.listByScope, Views);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(View.properties);

@@clientName(Alerts.dismiss::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Alert.properties);

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
@@clientLocation(ScheduledActionOperationGroup.listByScope, ScheduledActions);
@@clientLocation(ScheduledActionOperationGroup.runByScope, ScheduledActions);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScheduledAction.properties);

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
@@clientName(BenefitRecommendationModel, "benefitRecommendationModel");
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByBillingProfile::parameters.body,
  "benefitUtilizationSummariesRequest"
);
@@clientName(CostAllocationRulesOperationGroup.checkNameAvailability::parameters.body,
  "costAllocationRuleCheckNameAvailabilityRequest"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByBillingAccount::parameters.body,
  "benefitUtilizationSummariesRequest"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateBySavingsPlanOrderId::parameters.body,
  "benefitUtilizationSummariesRequest"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateBySavingsPlanId::parameters.body,
  "benefitUtilizationSummariesRequest"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByReservationOrderId::parameters.body,
  "benefitUtilizationSummariesRequest"
);
@@clientName(GenerateBenefitUtilizationSummariesReportOperationGroup.generateByReservationId::parameters.body,
  "benefitUtilizationSummariesRequest"
);
@@clientName(ForecastOperationGroup.externalCloudProviderUsage::parameters.body,
  "parameters"
);
@@clientName(QueryOperationGroup.usageByExternalCloudProviderType::parameters.body,
  "parameters"
);
@@clientName(ScheduledActionsOperationGroup.checkNameAvailability::parameters.body,
  "checkNameAvailabilityRequest"
);
@@clientName(BenefitRecommendationProperties,
  "benefitRecommendationProperties"
);
@@clientName(RecommendationUsageDetails, "recommendationUsageDetails");
@@clientName(AllSavingsBenefitDetails, "allSavingsBenefitDetails");
@@clientName(AllSavingsList, "allSavingsList");
@@clientName(SharedScopeBenefitRecommendationProperties,
  "sharedScopeBenefitRecommendationProperties"
);
@@clientName(SingleScopeBenefitRecommendationProperties,
  "singleScopeBenefitRecommendationProperties"
);
@@visibility(Setting.kind,
  Lifecycle.Create,
  Lifecycle.Read,
  Lifecycle.Update,
  Lifecycle.Delete,
  Lifecycle.Query
);
