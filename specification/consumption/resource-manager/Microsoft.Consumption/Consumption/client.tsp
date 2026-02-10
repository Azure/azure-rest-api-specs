import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.Consumption;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Consumption,
  "ConsumptionManagementClient",
  "python,javascript"
);

// Fix property name changes from lowercase to uppercase (etag -> eTag)
@@clientName(LotSummary.eTag, "etag", "java");
@@clientName(ModernChargeSummary.eTag, "etag", "java");
@@clientName(ChargeSummary.eTag, "etag", "java");
@@clientName(LegacyChargeSummary.eTag, "etag", "java");
@@clientName(EventSummary.eTag, "etag", "java");
@@clientName(Budget.eTag, "etag", "java");
@@clientName(TagsResult.eTag, "etag", "java");
@@clientName(CreditSummary.eTag, "etag", "java,go");
@@clientName(EventProperties.eTag, "etag", "java");
@@clientName(LotProperties.eTag, "etag", "java");
@@clientName(CreditSummaryProperties.eTag, "etag", "java");

// Fix USD property name changes (costInUSD -> costInUsd, paygCostInUSD -> paygCostInUsd)
@@clientName(ModernUsageDetailProperties.costInUSD, "costInUsd", "java");
@@clientName(ModernUsageDetailProperties.paygCostInUSD,
  "paygCostInUsd",
  "java"
);

@@clientName(LegacyChargeSummaryProperties.azureMarketplaceCharges,
  "marketplaceCharges",
  "go"
);

// csharp configurations
@@clientName(Budget, "ConsumptionBudget", "csharp");
@@clientName(CategoryType, "BudgetCategory", "csharp");
@@clientName(CurrentSpend, "BudgetCurrentSpend", "csharp");
@@clientName(BudgetFilter, "ConsumptionBudgetFilter", "csharp");
@@clientName(ForecastSpend, "BudgetForecastSpend", "csharp");
@@clientName(Notification, "BudgetAssociatedNotification", "csharp");
@@clientName(Notification.enabled, "IsEnabled", "csharp");
@@clientName(TimeGrainType, "BudgetTimeGrainType", "csharp");
@@clientName(Balance, "ConsumptionBalanceResult", "csharp");
@@clientName(BalanceProperties.priceHidden, "IsPriceHidden", "csharp");
@@clientName(CreditSummary, "ConsumptionCreditSummary", "csharp");
@@clientName(EventSummary, "ConsumptionEventSummary", "csharp");
@@clientName(EventProperties.transactionDate, "TransactOn", "csharp");
@@clientName(EventType, "ConsumptionEventType", "csharp");
@@clientName(ManagementGroupAggregatedCostResult,
  "ConsumptionAggregatedCostResult",
  "csharp"
);
@@clientName(ManagementGroupAggregatedCostProperties.usageStart,
  "UsageStartOn",
  "csharp"
);
@@clientName(ManagementGroupAggregatedCostProperties.usageEnd,
  "UsageEndOn",
  "csharp"
);
@@clientName(LotSummary, "ConsumptionLotSummary", "csharp");
@@clientName(LotSource, "ConsumptionLotSource", "csharp");
@@clientName(Status, "ConsumptionLotStatus", "csharp");
@@clientName(ReservationSummary, "ConsumptionReservationSummary", "csharp");
@@clientName(Datagrain, "ReservationSummaryDataGrain", "csharp");
@@clientName(ReservationTransaction,
  "ConsumptionReservationTransaction",
  "csharp"
);
@@clientName(LegacyReservationTransactionProperties.eventDate,
  "TransactOn",
  "csharp"
);
@@clientName(ModernReservationTransaction,
  "ConsumptionModernReservationTransaction",
  "csharp"
);
@@clientName(ModernReservationTransactionProperties.eventDate,
  "TransactOn",
  "csharp"
);
@@clientName(Amount, "ConsumptionAmount", "csharp");
@@clientName(AmountWithExchangeRate,
  "ConsumptionAmountWithExchangeRate",
  "csharp"
);
@@clientName(BillingFrequency, "ConsumptionBillingFrequency", "csharp");
@@clientName(BalancePropertiesAdjustmentDetailsItem,
  "ConsumptionBalanceAdjustmentDetail",
  "csharp"
);
@@clientName(BalancePropertiesNewPurchasesDetailsItem,
  "ConsumptionBalanceNewPurchasesDetail",
  "csharp"
);
@@clientName(Reseller, "ConsumptionReseller", "csharp");
@@clientName(CultureCode, "RecipientNotificationLanguageCode", "csharp");
@@clientName(CultureCode.`en-us`, "EnglishUnitedStates", "csharp");
@@clientName(CultureCode.`ja-jp`, "JapaneseJapan", "csharp");
@@clientName(CultureCode.`zh-cn`, "ChinesePrc", "csharp");
@@clientName(CultureCode.`de-de`, "GermanGermany", "csharp");
@@clientName(CultureCode.`es-es`, "SpanishSpain", "csharp");
@@clientName(CultureCode.`fr-fr`, "FrenchFrance", "csharp");
@@clientName(CultureCode.`it-it`, "ItalianItaly", "csharp");
@@clientName(CultureCode.`ko-kr`, "KoreanKorea", "csharp");
@@clientName(CultureCode.`pt-br`, "PortugueseBrazil", "csharp");
@@clientName(CultureCode.`ru-ru`, "RussianRussia", "csharp");
@@clientName(CultureCode.`zh-tw`, "ChineseTaiwan", "csharp");
@@clientName(CultureCode.`cs-cz`, "CzechCzechRepublic", "csharp");
@@clientName(CultureCode.`pl-pl`, "PolishPoland", "csharp");
@@clientName(CultureCode.`tr-tr`, "TurkishTurkey", "csharp");
@@clientName(CultureCode.`da-dk`, "DanishDenmark", "csharp");
@@clientName(CultureCode.`en-gb`, "EnglishUnitedKingdom", "csharp");
@@clientName(CultureCode.`hu-hu`, "HungarianHungary", "csharp");
@@clientName(CultureCode.`nb-no`, "NorwegianNorway", "csharp");
@@clientName(CultureCode.`nl-nl`, "DutchNetherlands", "csharp");
@@clientName(CultureCode.`pt-pt`, "PortuguesePortugal", "csharp");
@@clientName(CultureCode.`sv-se`, "SwedishSweden", "csharp");
@@clientName(MeterDetails, "ConsumptionMeterDetails", "csharp");
@@clientName(OperatorType, "NotificationAlertTriggerType", "csharp");
@@clientName(ThresholdType, "NotificationThresholdType", "csharp");
@@clientName(ReservationSummaryProperties.usageDate, "UseOn", "csharp");
// @@clientName(ChargeSummary, "ConsumptionChargeSummary", "csharp");
@@clientName(Marketplace, "ConsumptionMarketplace", "csharp");
@@clientName(ReservationRecommendationDetailsModel,
  "ConsumptionReservationRecommendationDetails",
  "csharp"
);
@@clientName(ReservationRecommendationDetailsModel.properties,
  "ReserRecomDetailsProperties",
  "csharp"
);
@@clientName(Scope, "ConsumptionReservationRecommendationScope", "csharp");
@@clientName(Term, "ConsumptionReservationRecommendationTerm", "csharp");
@@clientName(LookBackPeriod,
  "ConsumptionReservationRecommendationLookBackPeriod",
  "csharp"
);
@@clientName(TagsResult, "ConsumptionTagsResult", "csharp");
// @@clientName(UsageDetail, "ConsumptionUsageDetail", "csharp");
@@clientName(LegacyUsageDetail, "ConsumptionLegacyUsageDetail", "csharp");
@@clientName(ModernUsageDetail, "ConsumptionModernUsageDetail", "csharp");
@@clientName(MarketplaceProperties.usageStart, "UsageStartOn", "csharp");
@@clientName(MarketplaceProperties.usageEnd, "UsageEndOn", "csharp");
@@clientName(ReservationRecommendationDetailsProperties.resource,
  "Properties",
  "csharp"
);
@@clientName(LegacyChargeSummary, "ConsumptionLegacyChargeSummary", "csharp");
@@clientName(ReservationRecommendation,
  "ConsumptionReservationRecommendation",
  "csharp"
);
@@clientName(LegacyReservationRecommendation,
  "ConsumptionLegacyReservationRecommendation",
  "csharp"
);
@@clientName(ModernReservationRecommendation,
  "ConsumptionModernReservationRecommendation",
  "csharp"
);
@@clientName(MeterDetailsResponse, "ConsumptionMeterDetailsInfo", "csharp");
@@clientName(Metrictype, "ConsumptionMetricType", "csharp");
@@clientName(ModernChargeSummary, "ConsumptionModernChargeSummary", "csharp");
@@clientName(PricingModelType, "ConsumptionPricingModelType", "csharp");
@@clientName(ReservationRecommendationDetailsCalculatedSavingsProperties,
  "ConsumptionCalculatedSavingsProperties",
  "csharp"
);
@@clientName(ReservationRecommendationDetailsResourceProperties,
  "ConsumptionResourceProperties",
  "csharp"
);
@@clientName(ReservationRecommendationDetailsSavingsProperties,
  "ConsumptionSavingsProperties",
  "csharp"
);
@@clientName(ReservationRecommendationDetailsUsageProperties,
  "ConsumptionUsageProperties",
  "csharp"
);
@@clientName(SkuProperty, "ConsumptionSkuProperty", "csharp");
@@clientName(Tag, "ConsumptionTag", "csharp");
@@clientName(BalancesOperationGroup.getByBillingAccount,
  "GetBalance",
  "csharp"
);
@@clientName(PriceSheet.getByBillingPeriod, "GetPriceSheet", "csharp");
@@clientName(AggregatedCostOperationGroup.getByManagementGroup,
  "GetAggregatedCost",
  "csharp"
);
@@clientName(EventsOperationGroup.listByBillingAccount, "GetEvents", "csharp");
@@clientName(CreditSummaryProperties.eTag, "PropertiesETag", "csharp");
@@clientName(EventProperties.eTag, "PropertiesETag", "csharp");
@@clientName(LotProperties.eTag, "PropertiesETag", "csharp");
@@clientName(ReservationDetailProperties.usageDate,
  "ConsumptionOccurredOn",
  "csharp"
);
@@clientName(ReservationDetail, "ConsumptionReservationDetail", "csharp");
@@alternateType(ReservationDetailProperties.instanceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(PriceSheetProperties.billingPeriodId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(PriceSheetProperties.meterId, Azure.Core.uuid, "csharp");
@@alternateType(EventProperties.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(EventProperties.lotId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ModernReservationTransactionProperties.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ModernReservationTransactionProperties.invoiceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ModernReservationTransactionProperties.invoiceSectionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ModernReservationTransactionProperties.purchasingSubscriptionGuid,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(LegacyReservationTransactionProperties.purchasingSubscriptionGuid,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Reseller.resellerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ReservationRecommendationDetailsModel.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(ReservationRecommendationDetailsModel.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(Budget.eTag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(Balance.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(ManagementGroupAggregatedCostResult.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(EventSummary.eTag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(LotSummary.eTag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(ReservationDetail.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(ReservationSummary.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);

@@clientLocation(PriceSheetResults.get, PriceSheetResults, "csharp");
// Rename the operation to match the contract's expected method name (GetPriceSheet)
@@clientName(PriceSheetResults.get, "GetPriceSheet", "csharp");

@@alternateType(UsageDetail, ConsumptionUsageDetail, "csharp");
@@alternateType(ChargeSummary, ConsumptionChargeSummary, "csharp");

/**
 * An usage detail resource.
 */
@discriminator("kind")
model ConsumptionUsageDetail {
  ...Azure.ResourceManager.Foundations.Resource;

  /**
   * Specifies the kind of usage details.
   */
  kind: UsageDetailsKind;

  /**
   * The etag for the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.EtagProperty.etag;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * A charge summary resource.
 */
@discriminator("kind")
model ConsumptionChargeSummary {
  ...Azure.ResourceManager.Foundations.ProxyResource;

  /**
   * Specifies the kind of charge summary.
   */
  kind: ChargeSummaryKind;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  eTag?: Azure.Core.EtagProperty.etag;
}
