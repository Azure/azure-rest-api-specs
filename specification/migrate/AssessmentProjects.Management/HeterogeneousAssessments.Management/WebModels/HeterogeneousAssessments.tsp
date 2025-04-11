import "../../Common/StandardizedContracts/CommonAssessmentPropertiesEnums.tsp";
import "../../Common/StandardizedContracts/CostComponent.tsp";
import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../../Common/ArmModels/AssessmentProjectV2.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Heterogeneous assessment resource.")
@parentResource(AssessmentProject)
model HeterogeneousAssessment
  is ProxyResource<HeterogeneousAssessmentProperties> {
  @doc("Heterogeneous Assessment ARM name")
  @key("assessmentName")
  @segment("heterogeneousAssessments")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

@doc("Properties of an assessment.")
model HeterogeneousAssessmentProperties is AzureResourceProperties {
  @doc("Arm id of partner assessments.")
  assessmentArmIds?: string[];

  @doc("Whether assessment is in valid state and all machines have been assessed.")
  @visibility(Lifecycle.Read)
  status?: AssessmentStatus;

  @doc("Timestamp for the last successfully calculated summary for the assessment.")
  @visibility(Lifecycle.Read)
  lastCalculatedOn?: utcDateTime;

  @doc("Confidence rating in percentage.")
  @visibility(Lifecycle.Read)
  confidenceRatingInPercentage?: float32;

  @doc("Azure location for assessment.")
  @visibility(Lifecycle.Read)
  azureLocation?: string;

  @doc("Sizing criterion for assessment.")
  @visibility(Lifecycle.Read)
  sizingCriterion?: AssessmentSizingCriterion;

  @doc("Schema version.")
  @visibility(Lifecycle.Read)
  schemaVersion?: string;
}
