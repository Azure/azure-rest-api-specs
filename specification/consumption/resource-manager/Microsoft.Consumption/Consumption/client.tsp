import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.Consumption;
using Azure.ClientGenerator.Core;
using Azure.Core;

@@clientName(
  Microsoft.Consumption,
  "ConsumptionManagementClient",
  "python,javascript"
);

// Fix property name changes from lowercase to uppercase (etag -> eTag)
@@clientName(LotSummary.eTag, "etag", "java");
@@clientName(ModernChargeSummary.eTag, "etag", "java");
@@clientName(ChargeSummary.eTag, "etag", "java,python");
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
@@clientName(
  ModernUsageDetailProperties.paygCostInUSD,
  "paygCostInUsd",
  "java"
);

@@clientName(
  LegacyChargeSummaryProperties.azureMarketplaceCharges,
  "marketplaceCharges",
  "go"
);

// =============================================================================
// C# (Azure.ResourceManager.Consumption) customizations
// -----------------------------------------------------------------------------
// All decorators below preserve source/binary back-compat with the shipped
// v1.1.0 surface (originally produced from Swagger via AutoRest). Companion
// SDK customizations live under
// sdk/consumption/Azure.ResourceManager.Consumption/src/Custom/ — each subgroup
// notes the Custom/ file it pairs with when applicable.
// =============================================================================

// --- Type renames: keep the shipped `Consumption*` prefix on every public
//     model so v1.x customers don't see type-name breaks. -----------------------
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
// Rename the generated property to InternalETag so the custom partial in
// Custom/Models/ConsumptionEventSummary.cs can re-expose a settable ETag wrapper
// (the shipped v1.x AutoRest surface had a settable ETag).
@@clientName(EventSummary.eTag, "InternalETag", "csharp");
// Date-typed properties (utcDateTime in the spec) are renamed to end with `On`
// to comply with the .NET SDK design guideline DATE001.
@@clientName(EventProperties.transactionDate, "TransactOn", "csharp");
@@clientName(EventType, "ConsumptionEventType", "csharp");
@@clientName(
  ManagementGroupAggregatedCostResult,
  "ConsumptionAggregatedCostResult",
  "csharp"
);
@@clientName(
  ManagementGroupAggregatedCostProperties.usageStart,
  "UsageStartOn",
  "csharp"
);
@@clientName(
  ManagementGroupAggregatedCostProperties.usageEnd,
  "UsageEndOn",
  "csharp"
);
@@clientName(LotSummary, "ConsumptionLotSummary", "csharp");
@@clientName(LotSource, "ConsumptionLotSource", "csharp");
@@clientName(Status, "ConsumptionLotStatus", "csharp");
@@clientName(ReservationSummary, "ConsumptionReservationSummary", "csharp");
@@clientName(Datagrain, "ReservationSummaryDataGrain", "csharp");
@@clientName(
  ReservationTransaction,
  "ConsumptionReservationTransaction",
  "csharp"
);
@@clientName(
  LegacyReservationTransactionProperties.eventDate,
  "TransactOn",
  "csharp"
);
@@clientName(
  ModernReservationTransaction,
  "ConsumptionModernReservationTransaction",
  "csharp"
);
@@clientName(
  ModernReservationTransactionProperties.eventDate,
  "TransactOn",
  "csharp"
);
@@clientName(Amount, "ConsumptionAmount", "csharp");
@@clientName(
  AmountWithExchangeRate,
  "ConsumptionAmountWithExchangeRate",
  "csharp"
);
@@clientName(BillingFrequency, "ConsumptionBillingFrequency", "csharp");
@@clientName(
  BalancePropertiesAdjustmentDetailsItem,
  "ConsumptionBalanceAdjustmentDetail",
  "csharp"
);
@@clientName(
  BalancePropertiesNewPurchasesDetailsItem,
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
@@clientName(
  ReservationRecommendationDetailsModel,
  "ConsumptionReservationRecommendationDetails",
  "csharp"
);
@@clientName(
  ReservationRecommendationDetailsModel.properties,
  "ReserRecomDetailsProperties",
  "csharp"
);
@@clientName(Scope, "ConsumptionReservationRecommendationScope", "csharp");
@@clientName(Term, "ConsumptionReservationRecommendationTerm", "csharp");
@@clientName(
  LookBackPeriod,
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
@@clientName(
  ReservationRecommendationDetailsProperties.resource,
  "Properties",
  "csharp"
);
@@clientName(LegacyChargeSummary, "ConsumptionLegacyChargeSummary", "csharp");
@@clientName(
  LegacyChargeSummaryProperties.azureMarketplaceCharges,
  "MarketplaceCharges",
  "csharp"
);
@@clientName(MeterDetailsResponse, "ConsumptionMeterDetailsInfo", "csharp");
@@clientName(Metrictype, "ConsumptionMetricType", "csharp");
@@clientName(ModernChargeSummary, "ConsumptionModernChargeSummary", "csharp");
@@clientName(PricingModelType, "ConsumptionPricingModelType", "csharp");
@@clientName(
  ReservationRecommendationDetailsCalculatedSavingsProperties,
  "ConsumptionCalculatedSavingsProperties",
  "csharp"
);
@@clientName(
  ReservationRecommendationDetailsResourceProperties,
  "ConsumptionResourceProperties",
  "csharp"
);
@@clientName(
  ReservationRecommendationDetailsSavingsProperties,
  "ConsumptionSavingsProperties",
  "csharp"
);
@@clientName(
  ReservationRecommendationDetailsUsageProperties,
  "ConsumptionUsageProperties",
  "csharp"
);
@@clientName(SkuProperty, "ConsumptionSkuProperty", "csharp");
@@clientName(Tag, "ConsumptionTag", "csharp");
@@clientName(
  BalancesOperationGroup.getByBillingAccount,
  "GetBalance",
  "csharp"
);
@@clientName(PriceSheet.getByBillingPeriod, "GetPriceSheet", "csharp");
@@clientName(
  AggregatedCostOperationGroup.getByManagementGroup,
  "GetAggregatedCost",
  "csharp"
);
@@clientName(EventsOperationGroup.listByBillingAccount, "GetEvents", "csharp");
// The inner Properties bag also has an `eTag` field that flattens to the same
// generated container; rename to `PropertiesETag` to avoid colliding with the
// resource-level ETag and to match the shipped v1.x AutoRest property names.
@@clientName(CreditSummaryProperties.eTag, "PropertiesETag", "csharp");
@@clientName(EventProperties.eTag, "PropertiesETag", "csharp");
@@clientName(LotProperties.eTag, "PropertiesETag", "csharp");
@@clientName(
  ReservationDetailProperties.usageDate,
  "ConsumptionOccurredOn",
  "csharp"
);
@@clientName(ReservationDetail, "ConsumptionReservationDetail", "csharp");

// SDK guideline DATE001: DateTime/DateTimeOffset properties must end with `On`
// or `At`. The property lives on PricesheetDownloadProperties but is flattened
// onto OperationStatus by the generator. OperationStatus is a new (1.2.0-beta.1)
// type, so renaming is free.
@@clientName(PricesheetDownloadProperties.validTill, "ExpiresOn", "csharp");

// --- Operation renames and relocations: keep shipped v1.x method names
//     (Get*, GetPriceSheet, ...) and move `PriceSheetResults.get` onto its own
//     client surface to match the original AutoRest layout. -------------------
@@clientLocation(PriceSheetResults.get, PriceSheetResults, "csharp");
@@clientName(PriceSheetResults.get, "GetPriceSheet", "csharp");
@@clientName(
  UsageDetailsOperationGroup.list,
  "GetConsumptionUsageDetails",
  "csharp"
);
@@clientName(
  MarketplacesOperationGroup.list,
  "GetConsumptionMarketPlaces",
  "csharp"
);
@@clientName(TagsOperationGroup.get, "GetConsumptionTags", "csharp");
@@clientName(
  ReservationsDetailsOperationGroup.list,
  "GetConsumptionReservationsDetails",
  "csharp"
);
@@clientName(
  ReservationRecommendationsOperationGroup.list,
  "GetConsumptionReservationRecommendations",
  "csharp"
);
@@clientName(
  ReservationRecommendationDetailsOperationGroup.get,
  "GetConsumptionReservationRecommendationDetails",
  "csharp"
);
@@clientName(
  ReservationRecommendationDetailsOperationGroup.get::parameters.scope,
  "reservationScope",
  "csharp"
);
@@clientName(UsageDetailsListParameters.$skiptoken, "skipToken ", "csharp");
@@clientName(MarketplacesListParameters.$skiptoken, "skipToken ", "csharp");

// --- Discriminator subclasses must remain public so consumers (and the SDK's
//     ArmConsumptionModelFactory factory overloads in
//     Custom/ArmConsumptionModelFactory.cs) can construct/cast them.
//     Without @@access(Public, ...) the MPG generator emits them as internal.
@@access(ModernChargeSummary, Access.public, "csharp");
@@access(LegacyChargeSummary, Access.public, "csharp");

// --- Strongly-typed property aliases: surface ResourceIdentifier / Guid /
//     AzureLocation / ETag instead of plain string, matching the shipped v1.x
//     types produced by AutoRest from the original swagger format hints. ------
@@alternateType(
  ReservationDetailProperties.instanceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PriceSheetProperties.billingPeriodId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(PriceSheetProperties.meterId, uuid, "csharp");
@@alternateType(
  EventProperties.billingProfileId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(EventProperties.lotId, armResourceIdentifier, "csharp");
@@alternateType(
  ModernReservationTransactionProperties.billingProfileId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ModernReservationTransactionProperties.invoiceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ModernReservationTransactionProperties.invoiceSectionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ModernReservationTransactionProperties.purchasingSubscriptionGuid,
  uuid,
  "csharp"
);
@@alternateType(
  LegacyReservationTransactionProperties.purchasingSubscriptionGuid,
  uuid,
  "csharp"
);
@@alternateType(MarketplaceProperties.meterId, uuid, "csharp");
@@alternateType(MarketplaceProperties.subscriptionGuid, uuid, "csharp");
@@alternateType(Reseller.resellerId, armResourceIdentifier, "csharp");
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ReservationRecommendationDetailsModel.location,
  azureLocation,
  "csharp"
);
// SDK guideline TYPE003: properties representing an Azure region should be
// typed as AzureLocation, not string. Pairs with the `LocationPropertiesLocation`
// accessor in Custom/Models/ConsumptionModernReservationRecommendation.cs.
@@alternateType(
  ModernReservationRecommendationProperties.location,
  azureLocation,
  "csharp"
);
// --- ETag aliases: every resource-level `etag` / `eTag` is surfaced as
//     Azure.ETag (the shipped v1.x AutoRest type) instead of the spec's raw
//     `eTag` scalar / string. -------------------------------------------------
@@alternateType(ReservationRecommendationDetailsModel.etag, eTag, "csharp");
@@alternateType(Budget.eTag, eTag, "csharp");
@@alternateType(Balance.etag, eTag, "csharp");
@@alternateType(UsageDetail.etag, eTag, "csharp");
@@alternateType(ChargeSummary.eTag, eTag, "csharp");
@@alternateType(ManagementGroupAggregatedCostResult.etag, eTag, "csharp");
@@alternateType(EventSummary.eTag, eTag, "csharp");
@@alternateType(LotSummary.eTag, eTag, "csharp");
@@alternateType(ReservationDetail.etag, eTag, "csharp");
@@alternateType(ReservationSummary.etag, eTag, "csharp");
@@alternateType(Marketplace.etag, eTag, "csharp");
@@alternateType(CreditSummary.eTag, eTag, "csharp");
@@alternateType(PriceSheetResult.etag, eTag, "csharp");
@@alternateType(TagsResult.eTag, eTag, "csharp");
@@alternateType(LegacyUsageDetailProperties.meterId, uuid, "csharp");
@@alternateType(ModernUsageDetailProperties.meterId, uuid, "csharp");
@@alternateType(
  LegacyReservationRecommendationProperties.meterId,
  uuid,
  "csharp"
);
@@alternateType(
  ModernReservationRecommendationProperties.meterId,
  uuid,
  "csharp"
);
// --- Nullable value-type back-compat for required BudgetProperties scalars.
//     The shipped v1.x surface exposed these as nullable; the spec marks them
//     required. `T | null` preserves wire required-ness but emits `T?` in C#.
@@alternateType(BudgetProperties.amount, decimal | null, "csharp");
@@alternateType(BudgetProperties.timeGrain, TimeGrainType | null, "csharp");
@@alternateType(BudgetProperties.category, CategoryType | null, "csharp");

// --- Redirect the discriminated ReservationRecommendation hierarchy to the
//     wrapper models declared below. The spec's ReservationRecommendation uses
//     `...Foundations.Resource` (spread, not extends), which makes the MPG
//     generator drop ResourceData inheritance and the flattened scalar surface
//     that shipped v1.x had. The wrappers extend Foundations.Resource directly
//     so the generator emits ResourceData semantics, and the SDK Custom partials
//     (Custom/Models/Consumption{Legacy,Modern}ReservationRecommendation.cs)
//     re-expose Properties members on the discriminator leaves.
@@alternateType(
  ReservationRecommendation,
  ConsumptionReservationRecommendation,
  "csharp"
);
@@alternateType(
  LegacyReservationRecommendation,
  ConsumptionLegacyReservationRecommendation,
  "csharp"
);
@@alternateType(
  ModernReservationRecommendation,
  ConsumptionModernReservationRecommendation,
  "csharp"
);

// Wrapper models for the ReservationRecommendation hierarchy. These intentionally
// `extends Azure.ResourceManager.Foundations.Resource` (vs. the spread used in
// the spec) so the MPG generator emits them with ResourceData semantics —
// matching the shipped v1.x AutoRest-generated surface. Their `properties`
// bag is itself discriminated (@discriminator("scope")), so we CANNOT use
// @@Legacy.flattenProperty here (flatten-polymorphism rule); the SDK Custom
// partials surface the inner members instead.
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
  etag?: eTag;

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

// --- Usage overrides ---
// Tag / TagsResult / ChargeSummary are produced by service responses but the
// shipped v1.x surface exposed them with public parameterless ctors and
// settable required-properties (matching AutoRest output-as-input behavior).
// Forcing Usage.input restores those surfaces so the SDK Custom factories
// (ArmConsumptionModelFactory.cs) and customer mocking can construct them.
@@usage(Tag, Usage.input, "csharp");
@@usage(TagsResult, Usage.input, "csharp");
@@usage(ChargeSummary, Usage.input, "csharp");

// Keep LotSummary/EventSummary as input + output to preserve public parameterless
// ctor and settable properties (matches shipped v1.0.1 surface).
@@usage(LotSummary, Usage.input | Usage.output, "csharp");
@@usage(EventSummary, Usage.input | Usage.output, "csharp");

// --- Flatten the `properties` envelope on the four "summary/usage" discriminator
//     types so the generated subclasses expose the shipped flat-property surface
//     (the equivalent of AutoRest's swagger `x-ms-client-flatten: true` on the
//     inner `properties` reference). The ReservationRecommendation hierarchy is
//     intentionally NOT flattened — its `properties` is itself
//     @discriminator("scope"), which is incompatible with @@Legacy.flattenProperty
//     (TCGC flatten-polymorphism rule). For that hierarchy the flattening is
//     done via SDK Custom partials instead.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  LegacyUsageDetail.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ModernUsageDetail.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  LegacyChargeSummary.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ModernChargeSummary.properties,
  "csharp"
);
