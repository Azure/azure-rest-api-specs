import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Commerce;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AggregationGranularity {
  /**
   * Daily
   */
  Daily,

  /**
   * Hourly
   */
  Hourly,
}

/**
 * Name of the offer term
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum OfferTermInfoName {
  /**
   * Recurring Charge
   */
  RecurringCharge: "Recurring Charge",

  /**
   * Monetary Commitment
   */
  MonetaryCommitment: "Monetary Commitment",

  /**
   * Monetary Credit
   */
  MonetaryCredit: "Monetary Credit",
}

/**
 * Describes the usageAggregation.
 */
model UsageAggregation {
  /**
   * Unique Id for the usage aggregate.
   */
  id?: string;

  /**
   * Name of the usage aggregate.
   */
  name?: string;

  /**
   * Type of the resource being returned.
   */
  type?: string;

  /**
   * Usage data.
   */
  properties?: UsageSample;
}

/**
 * Describes a sample of the usageAggregation.
 */
model UsageSample {
  /**
   * The subscription identifier for the Azure user.
   */
  subscriptionId?: Azure.Core.uuid;

  /**
   * Unique ID for the resource that was consumed (aka ResourceID).
   */
  meterId?: string;

  /**
   * UTC start time for the usage bucket to which this usage aggregate belongs.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageStartTime?: utcDateTime;

  /**
   * UTC end time for the usage bucket to which this usage aggregate belongs.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageEndTime?: utcDateTime;

  /**
   * The amount of the resource consumption that occurred in this time frame.
   */
  quantity?: float32;

  /**
   * The unit in which the usage for this resource is being counted, e.g. Hours, GB.
   */
  unit?: string;

  /**
   * Friendly name of the resource being consumed.
   */
  meterName?: string;

  /**
   * Category of the consumed resource.
   */
  meterCategory?: string;

  /**
   * Sub-category of the consumed resource.
   */
  meterSubCategory?: string;

  /**
   * Region of the meterId used for billing purposes
   */
  meterRegion?: string;

  /**
   * Key-value pairs of instance details (legacy format).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  infoFields?: unknown;

  /**
   * Key-value pairs of instance details represented as a string.
   */
  instanceData?: string;
}

/**
 * Describes the format of Error response with a wrapper object
 */
@error
model ErrorObjectResponse {
  /**
   * Wrapper object for error information
   */
  error?: ErrorResponse;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorResponse {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * Price and Metadata information for resources
 */
model ResourceRateCardInfo {
  /**
   * The currency in which the rates are provided.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Currency?: string;

  /**
   * The culture in which the resource information is localized.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Locale?: string;

  /**
   * All rates are pretax, so this will always be returned as 'false'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IsTaxIncluded?: boolean;

  /**
   * A list of offer terms.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["Name"])
  OfferTerms?: OfferTermInfo[];

  /**
   * A list of meters.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["MeterId"])
  Meters?: MeterInfo[];
}

/**
 * Describes the offer term.
 */
@discriminator("Name")
model OfferTermInfo {
  /**
   * Name of the offer term
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Name: OfferTermInfoName;

  /**
   * Indicates the date from which the offer term is effective.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  EffectiveDate?: utcDateTime;
}

/**
 * Detailed information about the meter.
 */
model MeterInfo {
  /**
   * The unique identifier of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MeterId?: Azure.Core.uuid;

  /**
   * The name of the meter, within the given meter category
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MeterName?: string;

  /**
   * The category of the meter, e.g., 'Cloud services', 'Networking', etc..
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MeterCategory?: string;

  /**
   * The subcategory of the meter, e.g., 'A6 Cloud services', 'ExpressRoute (IXP)', etc..
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MeterSubCategory?: string;

  /**
   * The unit in which the meter consumption is charged, e.g., 'Hours', 'GB', etc.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unit?: string;

  /**
   * Provides additional meter data. 'Third Party' indicates a meter with no discount. Blanks indicate First Party.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MeterTags?: string[];

  /**
   * The region in which the Azure service is available.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MeterRegion?: string;

  /**
   * The list of key/value pairs for the meter rates, in the format 'key':'value' where key = the meter quantity, and value = the corresponding price
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MeterRates?: Record<float32>;

  /**
   * Indicates the date from which the meter rate is effective.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EffectiveDate?: utcDateTime;

  /**
   * The resource quantity that is included in the offer at no cost. Consumption beyond this quantity will be charged.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IncludedQuantity?: float32;
}

/**
 * Parameters that are used in the odata $filter query parameter for providing RateCard information.
 */
model RateCardQueryParameters {
  /**
   * The Offer ID parameter consists of the 'MS-AZR-' prefix, plus the Offer ID number (e.g., MS-AZR-0026P). See https://azure.microsoft.com/en-us/support/legal/offer-details/ for more information on the list of available Offer IDs, country/region availability, and billing currency.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pattern("^MS-AZR-\\d{4}P(-\\d{4}P)*$")
  OfferDurableId: string;

  /**
   * The currency in which the rates need to be provided.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Currency: string;

  /**
   * The culture in which the resource metadata needs to be localized.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Locale: string;

  /**
   * 2 letter ISO code where the offer was purchased.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RegionInfo: string;
}

/**
 * Indicates that this is a monetary credit offer.
 */
model MonetaryCredit extends OfferTermInfo {
  /**
   * The amount of credit provided under the terms of the given offer level.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Credit?: decimal;

  /**
   * An array of meter ids that are excluded from the given offer terms.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ExcludedMeterIds?: Azure.Core.uuid[];

  /**
   * Name of the offer term
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Name: OfferTermInfoName.MonetaryCredit;
}

/**
 * Indicates that a monetary commitment is required for this offer
 */
model MonetaryCommitment extends OfferTermInfo {
  /**
   * The list of key/value pairs for the tiered meter rates, in the format 'key':'value' where key = price, and value = the corresponding discount percentage. This field is used only by offer terms of type 'Monetary Commitment'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TieredDiscount?: Record<decimal>;

  /**
   * An array of meter ids that are excluded from the given offer terms.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ExcludedMeterIds?: Azure.Core.uuid[];

  /**
   * Name of the offer term
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Name: OfferTermInfoName.MonetaryCommitment;
}

/**
 * Indicates a recurring charge is present for this offer.
 */
model RecurringCharge extends OfferTermInfo {
  /**
   * The amount of recurring charge as per the offer term.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RecurringCharge?: int32;

  /**
   * Name of the offer term
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Name: OfferTermInfoName.RecurringCharge;
}
