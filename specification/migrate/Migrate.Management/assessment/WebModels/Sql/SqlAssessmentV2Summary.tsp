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
@parentResource(SqlAssessmentV2)
model SqlAssessmentV2Summary is ProxyResource<SqlAssessmentV2SummaryProperties>{
  @doc("Gets the Name of the SQL Summary.")
  @key("summaryName")
  @segment("summaries")
  @path
  name: string;
}

@doc("SQL Assessment V2 summary properties.")
model SqlAssessmentV2SummaryProperties extends AzureResourceProperties {
  @doc("Gets or sets the Assessment summary.")
  @visibility("read")
  assessmentSummary?: Record<SqlAssessmentV2SummaryData>;

  @doc("Number of machines part of the assessment.")
  @visibility("read")
  numberOfMachines?: int32;

  @doc("Number of sql instances part of the assessment.")
  @visibility("read")
  numberOfSqlInstances?: int32;

  @doc("Number of sql databases part of the assessment.")
  @visibility("read")
  numberOfSqlDatabases?: int32;

  @doc("Number of sql failover cluster instances part of the assessment.")
  @visibility("read")
  numberOfFciInstances?: int32;

  @doc("Number of sql availability groups part of the assessment.")
  @visibility("read")
  numberOfSqlAvailabilityGroups?: int32;
}

@doc("SQL Assessment V2 summary data.")
model SqlAssessmentV2SummaryData {
  @doc("Sql assessment summary data")
  @visibility("read")
  suitabilitySummary?: Record<int32>;

  @doc("Monthly compute cost")
  monthlyComputeCost?: float32;

  @doc("Monthly storage cost")
  monthlyStorageCost?: float32;

  @doc("Monthly license cost")
  monthlyLicenseCost?: float32;

  @doc("Confidence Rating")
  confidenceScore?: float32;
}