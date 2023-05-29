import "../Common/CommonAssessmentPropertiesEnums.tsp";
import "../Common/AvsEnums.tsp";
import "../Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("AVS assessment resource.")
@parentResource(Group)
model AvsAssessment is ProxyResource<AvsAssessmentProperties> {
    @doc("AVS Assessment ARM name")
    @key("assessmentName")
    @segment("avsAssessments")
    @path
    name: string;
}

@doc("Properties of the AVS assessment.")
model AvsAssessmentProperties extends AzureResourceProperties {
    //     @doc("""
    //   Gets the assessment error summary.
    //               This is the number of machines
    //   affected by each type of error in this assessment.
    //   """)
    //     @visibility("read")
    //     @added(ApiVersions.v2022_02_02_preview)
    //     assessmentErrorSummary?: Record<int32>;

    @doc("Failures to tolerate and RAID level in a common property.")
    @visibility("read")
    failuresToTolerateAndRaidLevel?: FttAndRaidLevel;

    @doc("VCPU over subscription.")
    @visibility("read")
    vcpuOversubscription?: float32;

    @doc("AVS node type.")
    @visibility("read")
    nodeType?: AzureAvsNodeType;

    @doc("Reserved instance.")
    @visibility("read")
    reservedInstance?: AzureReservedInstance;

    @doc("Total monthly cost.")
    @visibility("read")
    totalMonthlyCost?: float32;

    @doc("Gets or sets the Assessment cloud suitability.")
    @visibility("read")
    suitability?: CloudSuitability;

    @doc("Gets or sets the Assessment suitability explanation.")
    @visibility("read")
    suitabilityExplanation?: AzureAvsSuitabilityExplanation;

    @doc("Recommended number of nodes.")
    @visibility("read")
    numberOfNodes?: int32;

    @doc("Predicted CPU utilization.")
    @visibility("read")
    cpuUtilization?: float32;

    @doc("Predicted RAM utilization.")
    @visibility("read")
    ramUtilization?: float32;

    @doc("Predicted storage utilization.")
    @visibility("read")
    storageUtilization?: float32;

    @doc("Predicted total CPU cores used.")
    @visibility("read")
    totalCpuCores?: float32;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("Predicted total RAM used in GB.")
    @visibility("read")
    totalRamInGB?: float32;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("Predicted total Storage used in GB.")
    @visibility("read")
    totalStorageInGB?: float32;

    @doc("Number of machines part of the assessment.")
    @visibility("read")
    numberOfMachines?: int32;

    @doc("Cloud suitability summary for all the machines in the assessment.")
    @visibility("read")
    suitabilitySummary?: Record<int32>;

    @doc("Memory overcommit.")
    @visibility("read")
    memOvercommit?: float32;

    @doc("De-duplication compression.")
    @visibility("read")
    dedupeCompression?: float32;

    @doc("Limiting factor.")
    @visibility("read")
    limitingFactor?: string;

    @doc("Is Stretch Cluster Enabled.")
    @visibility("read")
    isStretchClusterEnabled?: boolean;

    @doc("Gets the group type for the assessment.")
    @visibility("read")
    groupType?: GroupType;

    @doc("Assessment type of the assessment.")
    @visibility("read")
    assessmentType?: AssessmentType;

    @doc("Azure Location or Azure region where to which the machines will be migrated.")
    @visibility("read")
    azureLocation?: AzureLocation;

    @doc("Azure Offer code according to which cost estimation is done.")
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

    @doc("""
Time when the Azure Prices were queried. Date-Time represented in ISO-8601
format.
""")
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
