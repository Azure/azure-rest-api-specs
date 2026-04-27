import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.Consumption;
using Azure.ClientGenerator.Core;
using Azure.Core;

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
@@clientName(EventSummary.eTag, "InternalETag", "csharp");
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
@@clientName(ChargeSummary, "ConsumptionChargeSummary", "csharp");
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
@@clientName(UsageDetail, "ConsumptionUsageDetail", "csharp");
@@clientName(LegacyUsageDetail, "ConsumptionLegacyUsageDetail", "csharp");
@@clientName(LegacyUsageDetailProperties.date, "On", "csharp");
@@clientName(ModernUsageDetail, "ConsumptionModernUsageDetail", "csharp");
@@clientName(ModernUsageDetailProperties.date, "On", "csharp");
@@clientName(MarketplaceProperties.usageStart, "UsageStartOn", "csharp");
@@clientName(MarketplaceProperties.usageEnd, "UsageEndOn", "csharp");
@@clientName(ReservationRecommendationDetailsProperties.resource,
  "Properties",
  "csharp"
);
@@clientName(LegacyChargeSummary, "ConsumptionLegacyChargeSummary", "csharp");
@@clientName(LegacyChargeSummaryProperties.azureMarketplaceCharges,
  "MarketplaceCharges",
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

@@clientLocation(PriceSheetResults.get, PriceSheetResults, "csharp");
@@clientName(PriceSheetResults.get, "GetPriceSheet", "csharp");
@@clientName(UsageDetailsOperationGroup.list,
  "GetConsumptionUsageDetails",
  "csharp"
);
@@clientName(MarketplacesOperationGroup.list,
  "GetConsumptionMarketPlaces",
  "csharp"
);
@@clientName(TagsOperationGroup.get, "GetConsumptionTags", "csharp");
@@clientName(ReservationsDetailsOperationGroup.list,
  "GetConsumptionReservationsDetails",
  "csharp"
);
@@clientName(ReservationRecommendationsOperationGroup.list,
  "GetConsumptionReservationRecommendations",
  "csharp"
);
// Restore the v1.x SDK signature: rename the action method to
// "GetConsumptionReservationRecommendationDetails" and rename the colliding
// query parameter `scope` to `recommendationScope` (the path uses `scope`
// as the ResourceIdentifier, so the auto-generated rename to `scope0` is
// not back-compatible).
@@clientName(ReservationRecommendationDetailsOperationGroup.get,
  "GetConsumptionReservationRecommendationDetails",
  "csharp"
);
@@clientName(ReservationRecommendationDetailsOperationGroup.get::parameters.scope,
  "reservationScope",
  "csharp"
);
@@clientName(UsageDetailsListParameters.$skiptoken, "skipToken ", "csharp");
@@clientName(MarketplacesListParameters.$skiptoken, "skipToken ", "csharp");

@@access(ModernChargeSummary, Access.public, "csharp");
@@access(LegacyChargeSummary, Access.public, "csharp");

@@alternateType(ReservationDetailProperties.instanceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(PriceSheetProperties.billingPeriodId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(PriceSheetProperties.meterId, uuid, "csharp");
@@alternateType(EventProperties.billingProfileId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(EventProperties.lotId, armResourceIdentifier, "csharp");
@@alternateType(ModernReservationTransactionProperties.billingProfileId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ModernReservationTransactionProperties.invoiceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ModernReservationTransactionProperties.invoiceSectionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ModernReservationTransactionProperties.purchasingSubscriptionGuid,
  uuid,
  "csharp"
);
@@alternateType(LegacyReservationTransactionProperties.purchasingSubscriptionGuid,
  uuid,
  "csharp"
);
@@alternateType(MarketplaceProperties.meterId, uuid, "csharp");
@@alternateType(MarketplaceProperties.subscriptionGuid, uuid, "csharp");
@@alternateType(Reseller.resellerId, armResourceIdentifier, "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ReservationRecommendationDetailsModel.location,
  azureLocation,
  "csharp"
);
@@alternateType(ReservationRecommendationDetailsModel.etag,
  EtagProperty.etag,
  "csharp"
);
@@alternateType(Budget.eTag, EtagProperty.etag, "csharp");
@@alternateType(Balance.etag, EtagProperty.etag, "csharp");
@@alternateType(UsageDetail.etag, EtagProperty.etag, "csharp");
@@alternateType(ChargeSummary.eTag, EtagProperty.etag, "csharp");
@@alternateType(ManagementGroupAggregatedCostResult.etag,
  EtagProperty.etag,
  "csharp"
);
@@alternateType(EventSummary.eTag, EtagProperty.etag, "csharp");
@@alternateType(LotSummary.eTag, EtagProperty.etag, "csharp");
@@alternateType(ReservationDetail.etag, EtagProperty.etag, "csharp");
@@alternateType(ReservationSummary.etag, EtagProperty.etag, "csharp");
@@alternateType(Marketplace.etag, EtagProperty.etag, "csharp");
@@alternateType(CreditSummary.eTag, EtagProperty.etag, "csharp");
@@alternateType(PriceSheetResult.etag, EtagProperty.etag, "csharp");
@@alternateType(TagsResult.eTag, EtagProperty.etag, "csharp");
@@alternateType(LegacyUsageDetailProperties.meterId, uuid, "csharp");
@@alternateType(ModernUsageDetailProperties.meterId, uuid, "csharp");
@@alternateType(LegacyReservationRecommendationProperties.meterId,
  uuid,
  "csharp"
);
@@alternateType(ModernReservationRecommendationProperties.meterId,
  uuid,
  "csharp"
);

// Match shipped v1.x SDK surface: AutoRest emitted these required value-type/enum
// properties as nullable on ConsumptionBudgetData. Using `| null` keeps the wire
// contract (still required) but maps to nullable in C# for back-compat.
@@alternateType(BudgetProperties.amount, decimal | null, "csharp");
@@alternateType(BudgetProperties.timeGrain, TimeGrainType | null, "csharp");
@@alternateType(BudgetProperties.category, CategoryType | null, "csharp");
@@alternateType(ReservationRecommendation,
  ConsumptionReservationRecommendation,
  "csharp"
);
@@alternateType(LegacyReservationRecommendation,
  ConsumptionLegacyReservationRecommendation,
  "csharp"
);
@@alternateType(ModernReservationRecommendation,
  ConsumptionModernReservationRecommendation,
  "csharp"
);

// Restore the v1.x SDK base type: ConsumptionReservationRecommendation must
// inherit ResourceData. The spec model uses `...Foundations.Resource` (spread)
// instead of `extends Foundations.Resource`, so the C# MPG generator emits a
// plain class. Declare TypeSpec replacements that use `extends` (which the
// MPG generator translates to `: ResourceData`), redeclare every non-Resource
// property, and re-declare the Legacy / Modern discriminator subclasses
// against the new base. Then swap them in for C# only via @@alternateType so
// OpenAPI / other languages stay unchanged.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model ConsumptionReservationRecommendation
  extends Azure.ResourceManager.Foundations.Resource {
  /** Resource location */
  @visibility(Lifecycle.Read)
  location?: azureLocation;

  /** Resource sku */
  @visibility(Lifecycle.Read)
  sku?: string;

  /** The etag for the resource. */
  @visibility(Lifecycle.Read)
  etag?: EtagProperty.etag;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  /** Specifies the kind of reservation recommendation. */
  kind: ReservationRecommendationKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConsumptionLegacyReservationRecommendation
  extends ConsumptionReservationRecommendation {
  properties: LegacyReservationRecommendationProperties;
  kind: "legacy";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConsumptionModernReservationRecommendation
  extends ConsumptionReservationRecommendation {
  properties: ModernReservationRecommendationProperties;
  kind: "modern";
}

@@usage(Tag, Usage.input, "csharp");
@@usage(TagsResult, Usage.input, "csharp");
@@usage(ChargeSummary, Usage.input, "csharp");

// Keep LotSummary/EventSummary as input + output to preserve public parameterless ctor and settable properties (matches shipped v1.0.1 surface).
@@usage(LotSummary, Usage.input | Usage.output, "csharp");
@@usage(EventSummary, Usage.input | Usage.output, "csharp");

// Flatten properties-envelope models so generated discriminator subclasses expose shipped flat-property surface.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LegacyUsageDetail.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ModernUsageDetail.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LegacyChargeSummary.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ModernChargeSummary.properties,
  "csharp"
);
