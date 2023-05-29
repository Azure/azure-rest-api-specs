import "../Common/SqlEnums.tsp";
import "../Common/CommonModels.tsp";
import "../Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("SQL Assessment REST resource.")
@parentResource(Group)
model SqlAssessmentV2  is ProxyResource<SqlAssessmentV2Properties>{
    @doc("SQL Assessment arm name.")
    @key("assessmentName")
    @segment("sqlAssessments")
    @path
    name: string;
}

@doc("SQL assessment properties class.")
model SqlAssessmentV2Properties extends AzureResourceProperties {
  @doc("Gets or sets user configurable setting to display the azure hybrid use benefit.")
  @visibility("read")
  osLicense?: OsLicense;

  @doc("Gets or sets user configurable setting to display the environment type.")
  @visibility("read")
  environmentType?: EnvironmentType;

  @doc("""
Gets or sets the duration for which the entity (SQL, VMs) are up in the
on-premises environment.
""")
  @visibility("read")
  entityUptime?: EntityUptime;

  @doc("Gets or sets SQL optimization logic.")
  @visibility("read")
  optimizationLogic?: OptimizationLogic;

  @doc("Gets or sets azure reserved instance for VM.")
  @visibility("read")
  reservedInstanceForVm?: AzureReservedInstance;

  @doc("Gets or sets Azure Offer Code for VM.")
  @visibility("read")
  azureOfferCodeForVm?: AzureOfferCode;

  @doc("Gets or sets the Enterprise agreement subscription id.")
  @visibility("read")
  eaSubscriptionId?: string;

  @doc("Gets or sets user configurable SQL managed instance settings.")
  @visibility("read")
  azureSqlManagedInstanceSettings?: SqlMiSettings;

  @doc("Gets or sets user configurable SQL database settings.")
  @visibility("read")
  azureSqlDatabaseSettings?: SqlDbSettings;

  @doc("Gets or sets user configurable SQL VM settings.")
  @visibility("read")
  azureSqlVmSettings?: SqlVmSettings;

  @doc("Gets or sets user preference indicating intent of multi-subnet configuration.")
  @visibility("read")
  multiSubnetIntent?: MultiSubnetIntent;

  @doc("Gets or sets user preference indicating intent of async commit mode.")
  @visibility("read")
  asyncCommitModeIntent?: AsyncCommitModeIntent;

  @doc("Gets or sets a value indicating whether internet access is available.")
  @visibility("read")
  isInternetAccessAvailable?: boolean;

  @doc("""
Gets or sets the Azure Location or Azure region where to which the machines
will be migrated.
""")
  @visibility("read")
  disasterRecoveryLocation?: AzureLocation;

  @doc("Gets or sets a value indicating whether HADR assessments needs to be created.")
  @visibility("read")
  enableHadrAssessment?: boolean;

  @doc("Reserved instance.")
  @visibility("read")
  reservedInstance?: AzureReservedInstance;

  @doc("SQL server license.")
  @visibility("read")
  sqlServerLicense?: SqlServerLicense;

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