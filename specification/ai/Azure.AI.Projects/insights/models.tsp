import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

@doc("The response body for cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
@resource("insights")
model Insight {
  @doc("The unique identifier for the insights report.")
  @key("id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Metadata about the insights report.")
  @visibility(Lifecycle.Read)
  metadata: AnalysisMetadata;

  @doc("The current state of the analysis.")
  @visibility(Lifecycle.Read)
  state: OperationState;

  @doc("User friendly display name for the insight.")
  displayName: string;

  @doc("Request for the insights analysis.")
  request: AnalysisRequest;

  @doc("Configuration of the model used in the analysis.")
  modelConfiguration?: ModelConfiguration;

  @doc("The result of the insights report.")
  @visibility(Lifecycle.Read)
  result?: InsightResult;
}

@doc("The request of the insights report.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
@discriminator("type")
model AnalysisRequest {
  @doc("The type of analysis request.")
  type: AnalysisType;
}

@doc("Analysis on set of Evaluation Results")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model EvaluationRunClusterAnalysis extends AnalysisRequest {
  @doc("The type of analysis request.")
  type: AnalysisType.EvaluationRunClusterAnalysis;

  @doc("List of evaluation IDs for the analysis.")
  evalIds: string[];
}

@doc("Analysis on set of Agent Evaluation Results")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model AgentClusterAnalysis extends AnalysisRequest {
  @doc("The type of analysis request.")
  type: AnalysisType.AgentClusterAnalysis;

  @doc("Identifier for the agent.")
  agentName: string;
}

@doc("The request of the cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union AnalysisType {
  @doc("Analysis on an Evaluation run result.")
  EvaluationRunClusterAnalysis: "EvaluationRunClusterAnalysis",

  @doc("Analysis on an Agent.")
  AgentClusterAnalysis: "AgentClusterAnalysis",

  string,
}

@doc("Metadata about the analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model AnalysisMetadata {
  @doc("The timestamp when the analysis was created.")
  createdAt: utcDateTime;

  @doc("The timestamp when the analysis was completed.")
  completedAt?: utcDateTime;
}

@doc("Configuration of the model used in the analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model ModelConfiguration {
  @doc("The model deployment to be evaluated. Accepts either the deployment name alone or with the connection name as '{connectionName}/<modelDeploymentName>'.")
  modelDeploymentName: string;

  @doc("Optional parameters passed to the model for analysis and insight generation.")
  modelParams: Record<unknown>;
}

@doc("The result of the analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
@discriminator("type")
model InsightResult {
  @doc("The type of insights result.")
  type: AnalysisType;
}

@doc("Insights from the cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model ClusterAnalysisInsights {
  @doc("Summary of the insights report.")
  summary: InsightSummary;

  @doc("List of samples and their associated clusters.")
  samples: AnalysisSample[];

  @doc("List of clusters identified in the analysis.")
  clusters: AnalysisCluster[];
}

@doc("Insights from the evaluation run cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model EvaluationRunClusterInsightResult extends InsightResult {
  @doc("The type of insights result.")
  type: AnalysisType.EvaluationRunClusterAnalysis;

  ...ClusterAnalysisInsights;
}

@doc("Insights from the agent cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model AgentClusterInsightResult extends InsightResult {
  @doc("The type of insights result.")
  type: AnalysisType.AgentClusterAnalysis;

  ...ClusterAnalysisInsights;
}

@doc("The type of insights result.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union InsightResultType {
  @doc("Insights from the cluster analysis.")
  ClusterAnalysisInsights: "ClusterAnalysisInsights",

  string,
}

@doc("Summary of the error cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model InsightSummary {
  @doc("Total number of samples analyzed.")
  sampleCount: int32;

  @doc("Total number of unique subcluster labels.")
  uniqueSubclusterCount: int32;

  @doc("Total number of unique clusters.")
  uniqueClusterCount: int32;

  @doc("Method used for clustering.")
  method: string;
}

@doc("Coordinates for the analysis chart.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model AnalysisChartCoordinate {
  @doc("X-axis coordinate.")
  x: int32;

  @doc("Y-axis coordinate.")
  y: int32;
}

@doc("A sample from the analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model AnalysisSample {
  @doc("The unique identifier for the analysis sample.")
  id: string;

  @doc("Evaluation result for the analysis sample.")
  evaluationResult: EvalResult;

  @doc("Info about the correlation for the analysis sample.")
  correlationInfo: Record<unknown>;

  @doc("Parameters to help with additional filtering of data in UX.")
  parameters: Record<unknown>;

  @doc("The label of the analysis cluster in which this sample belongs.")
  clusterLabel?: string;

  @doc("Coordinates for the analysis chart.")
  coordinates: AnalysisChartCoordinate;
}

@doc("Result of the evaluation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model EvalResult {
  @doc("name of the check")
  name: string;

  @doc("type of the check")
  type: string;

  @doc("score")
  score: float32;

  @doc("indicates if the check passed or failed")
  passed: boolean;
}

@doc("A cluster of analysis samples.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model AnalysisCluster {
  @doc("The label of the analysis cluster.")
  label: string;

  @doc("Description of the analysis cluster.")
  description: string;

  @doc("The weight of the analysis cluster. This indicate number of samples in the cluster.")
  weight: int32;

  @doc("The parent cluster label of the analysis cluster in case of a hierarchical structure. This is null if the cluster is at the top level.")
  parentClusterLabel?: string;

  @doc("Coordinates for the analysis chart.")
  coordinates: AnalysisChartCoordinate;
}
