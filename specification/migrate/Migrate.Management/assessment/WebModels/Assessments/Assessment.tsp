import "../Common/CommonAssessmentPropertiesEnums.tsp";
import "../Common/VmUptime.tsp";
import "../Common/CostComponent.tsp";
import "../Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Machine assessment resource.")
@parentResource(Group)
model Assessment is ProxyResource<MachineAssessmentProperties> {
  @doc("Machine Assessment ARM name")
  @key("assessmentName")
  @segment("assessments")
  @path
  name: string;
}

@doc("Properties of an assessment.")
model MachineAssessmentProperties extends AzureResourceProperties {
  //   @doc("""
  // Gets or sets the assessment error summary.
  //             This is the number of
  // machines affected by each type of error in this assessment.
  // """)
  // @added(ApiVersions.v2022_02_02_preview)
  //   assessmentErrorSummary?: Record<int32>;

  @doc("""
Gets or sets the aggregate ultra storage cost for all machines in the
assessment.
""")
  @added(ApiVersions.v2020_05_01_preview)
  monthlyUltraStorageCost?: float32;

  @doc("Gets or sets the name of the tag with which the assessment is created.")
  @added(ApiVersions.v2020_05_01_preview)
  tagName?: string;

  @doc("Gets or sets enterprise agreement subscription id.")
  eaSubscriptionId?: string;

  @doc("Gets or sets Azure Pricing Tier - Free, Basic, etc.")
  azurePricingTier?: AzurePricingTier;

  @doc("Gets or sets the Azure Storage Redundancy. Example: Locally Redundant Storage.")
  azureStorageRedundancy?: AzureStorageRedundancy;

  @doc("Gets or sets the Azure Reserved Instance - 1-Year, 3-Year.")
  reservedInstance?: AzureReservedInstance;

  @doc("""
Gets or sets the user configurable setting to display the azure hybrid use
benefit.
""")
  azureHybridUseBenefit?: AzureHybridUseBenefit;

  @doc("Gets or sets the azure storage type. Premium, Standard etc.")
  azureDiskType?: AzureDiskType;

  @doc("Gets or sets the Azure VM families.")
  azureVmFamilies?: AzureVmFamily[];

  @doc("Gets or sets the aggregate Compute Cost for all machines in the assessment.")
  monthlyComputeCost?: float32;

  @doc("Gets or sets the aggregate Bandwidth Cost for all machines in the assessment.")
  monthlyBandwidthCost?: float32;

  @doc("Gets or sets the aggregate Storage Cost for all machines in the assessment.")
  monthlyStorageCost?: float32;

  @doc("""
Gets or sets the aggregate premium storage cost for all machines in the
assessment.
""")
  monthlyPremiumStorageCost?: float32;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("""
Gets or sets the aggregate standard SSD storage cost for all the machines in
the assessment.
""")
  monthlyStandardSSDStorageCost?: float32;

  @doc("""
Gets or sets the Cloud suitability summary for all the machines in the
assessment.
""")
  suitabilitySummary?: Record<int32>;

  @doc("Gets or sets the Number of machines part of the assessment.")
  numberOfMachines?: int32;

  @doc("""
Gets or sets the duration for which the VMs are up in the on-premises
environment.
""")
  vmUptime?: VmUptime;

  @doc("Gets the group type for the assessment.")
  @visibility("read")
  groupType?: GroupType;

  @doc("Assessment type of the assessment.")
  @visibility("read")
  assessmentType?: AssessmentType;

  @doc("Azure Location or Azure region where to which the machines will be migrated.")
  @visibility("read")
  azureLocation?: string;

  @doc("Azure Offer Code.")
  @visibility("read")
  azureOfferCode?: AzureOfferCode;

  @doc("Currency in which prices should be reported.")
  @visibility("read")
  currency?: AzureCurrency;

  @doc("""
Percentage of buffer that user wants on performance metrics when recommending
Azure sizes.
""")
  @visibility("read")
  scalingFactor?: float32;

  @doc("""
Percentile of the utilization data values to be considered while assessing
machines.
""")
  @visibility("read")
  percentile?: Percentile;

  @doc("""
Time Range for which the historic utilization data should be considered for
assessment.
""")
  @visibility("read")
  timeRange?: TimeRange;

  @doc("Gets or sets the start time to consider performance data for assessment.")
  perfDataStartTime?: utcDateTime;

  @doc("Gets or sets the end time to consider performance data for assessment.")
  perfDataEndTime?: utcDateTime;

  @doc("User configurable setting to display the Stage of Assessment.")
  @visibility("read")
  stage?: AssessmentStage;

  @doc("Custom discount percentage.")
  @visibility("read")
  discountPercentage?: float32;

  @doc("Assessment sizing criterion.")
  @visibility("read")
  sizingCriterion?: AssessmentSizingCriterion;

  @doc("Confidence Rating in Percentage.")
  @visibility("read")
  confidenceRatingInPercentage?: float32;

  @doc("Last time when rates were queried.")
  @visibility("read")
  pricesTimestamp?: string;

  @doc("Date and Time when assessment was created.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Date and Time when assessment was last updated.")
  @visibility("read")
  updatedTimestamp?: string;

  @doc("Whether assessment is in valid state and all machines have been assessed.")
  @visibility("read")
  status?: AssessmentStatus;

  @doc("Schema version.")
  @visibility("read")
  schemaVersion?: string;
}
