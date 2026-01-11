import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Commerce;

@@clientName(Microsoft.Commerce, "UsageManagementClient", "python");
@@clientName(OfferTermInfoName, "OfferTermInfoEnum", "python");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(UsageAggregatesListParameters.aggregationGranularity,
  "Daily",
  "python"
);

@@alternateType(Microsoft.Commerce.OfferTermInfo, ClientCustomizations.OfferTermInfo, "java");
@@alternateType(Microsoft.Commerce.MonetaryCredit, ClientCustomizations.MonetaryCredit, "java");
@@alternateType(Microsoft.Commerce.MonetaryCommitment, ClientCustomizations.MonetaryCommitment, "java");
@@alternateType(Microsoft.Commerce.RecurringCharge, ClientCustomizations.RecurringCharge, "java");

namespace ClientCustomizations {
  /** Base offer term info definition without discriminator to preserve Java hierarchy. */
  model OfferTermInfo {
    /** Name of the offer term */
    Name: OfferTermInfoName;

    /** Indicates the date from which the offer term is effective. */
    EffectiveDate?: utcDateTime;
  }

  /** Indicates that this is a monetary credit offer. */
  model MonetaryCredit extends OfferTermInfo {
    /** The amount of credit provided under the terms of the given offer level. */
    Credit?: decimal;

    /** An array of meter ids that are excluded from the given offer terms. */
    ExcludedMeterIds?: Azure.Core.uuid[];

    /** Name of the offer term */
    Name: OfferTermInfoName.MonetaryCredit;
  }

  /** Indicates that a monetary commitment is required for this offer. */
  model MonetaryCommitment extends OfferTermInfo {
    /** Key/value pairs describing tiered meter rates. */
    TieredDiscount?: Record<decimal>;

    /** An array of meter ids that are excluded from the given offer terms. */
    ExcludedMeterIds?: Azure.Core.uuid[];

    /** Name of the offer term */
    Name: OfferTermInfoName.MonetaryCommitment;
  }

  /** Indicates a recurring charge is present for this offer. */
  model RecurringCharge extends OfferTermInfo {
    /** The amount of recurring charge as per the offer term. */
    RecurringCharge?: int32;

    /** Name of the offer term */
    Name: OfferTermInfoName.RecurringCharge;
  }
}
