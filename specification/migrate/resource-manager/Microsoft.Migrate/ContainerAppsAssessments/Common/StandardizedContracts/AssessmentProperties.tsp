import "./CommonModels.tsp";
import "./CommonAssessmentPropertiesEnums.tsp";
import "../Enums/Enums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Assessment properties class.")
model AssessmentProperties<TScope, TSettings, TDetails>
  is AzureResourceProperties {
  @doc("Gets or sets the scope of assessment.")
  scope?: TScope;

  @doc("Gets or sets the settings for the assessment.")
  settings?: TSettings;

  @doc("Gets or sets the details of the assessment.")
  details?: TDetails;
}

@doc("Assessment settings class.")
model AssessmentSettings {
  @doc("Azure Location or Azure region where to which the machines will be migrated.")
  azureLocation?: string;

  @doc("Currency in which prices should be reported.")
  currency?: AzureCurrency;

  @doc("""
    Percentage of buffer that user wants on performance metrics when recommending
    Azure sizes.
    """)
  scalingFactor?: float32;

  @doc("Custom discount percentage.")
  discountPercentage?: float32;

  @doc("Assessment sizing criterion.")
  sizingCriterion?: AssessmentSizingCriterion;

  @doc("Gets or sets the performance data.")
  performanceData?: PerformanceData;

  @doc("Gets or sets the savings settings.")
  savingsSettings?: SavingsSettings;

  @doc("Gets or sets the billing settings.")
  billingSettings?: BillingSettings;

  @doc("Gets or sets user configurable setting to display the environment type.")
  environmentType?: EnvironmentType;
}

@doc("Performance data class.")
model PerformanceData {
  @doc("""
    Percentile of the utilization data values to be considered while assessing
    machines.
    """)
  percentile?: Percentile;

  @doc("""
    Time Range for which the historic utilization data should be considered for
    assessment.
    """)
  timeRange?: TimeRange;

  @doc("Gets or sets the start time to consider performance data for assessment.")
  perfDataStartTime?: utcDateTime;

  @doc("Gets or sets the end time to consider performance data for assessment.")
  perfDataEndTime?: utcDateTime;
}

@doc("Savings settings class.")
model SavingsSettings {
  @doc("Gets or sets the savings options.")
  savingsOptions?: SavingsOptions;

  @doc("Gets or sets the Azure offer code.")
  azureOfferCode?: AzureOffer;
}

@doc("Billing settings class.")
model BillingSettings {
  @doc("Gets or sets the licensing program.")
  licensingProgram?: LicensingProgram;

  @doc("Gets or sets the subscription ID for licensing program selected.")
  subscriptionId?: string;
}

@doc("Assessment details class.")
model AssessmentDetails {
  @doc("Confidence Rating in Percentage.")
  @visibility(Lifecycle.Read)
  confidenceRatingInPercentage?: float32;

  @doc("Last time when rates were queried.")
  @visibility(Lifecycle.Read)
  pricesTimestamp?: utcDateTime;

  @doc("Date and Time when assessment was created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("Date and Time when assessment was last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;

  @doc("Whether assessment is in valid state and all machines have been assessed.")
  @visibility(Lifecycle.Read)
  status?: AssessmentStatus;
}
