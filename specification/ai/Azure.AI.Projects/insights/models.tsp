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
model ProjectInsight {
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

  @doc("Request for the insights analysis.")
  request: AnalysisRequest;

  @doc("Configuration of the model used in the analysis.")
  modelConfiguration?: ModelConfiguration;

  @doc("The result of the insights report.")
  @visibility(Lifecycle.Read)
  result?: InsightResult;
}

@doc("The scope of the insights report.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
@discriminator("kind")
model AnalysisRequest {
  @doc("The kind of analysis scope.")
  kind: AnalysisRequestType;
}

@doc("Analysis on set of Evaluation Results")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model EvaluationRunClusterAnalysis extends AnalysisRequest {
  @doc("The kind of analysis scope.")
  kind: AnalysisRequestType.EvaluationRunClusterAnalysis;

  @doc("List of evaluation names for the analysis.")
  evaluationNames: string[];
}

@doc("Analysis on set of Agent Evaluation Results")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model AgentClusterAnalysis extends AnalysisRequest {
  @doc("The kind of analysis scope.")
  kind: AnalysisRequestType.AgentClusterAnalysis;

  @doc("Identifier for the agent.")
  agentId: string;
}

@doc("The scope of the cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union AnalysisRequestType {
  @doc("Analysis on an Evaluation result.")
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

  @doc("Optional parameters passed to the model for evaluation.")
  modelParams: Record<unknown>;
}

@doc("The result of the cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
@discriminator("kind")
model InsightResult {
  @doc("The type of insights result.")
  kind: InsightResultType;
}

@doc("Insights from the cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model ClusterAnalysisInsights extends InsightResult {
  @doc("Insights from the cluster analysis.")
  kind: InsightResultType.ClusterAnalysisInsights;

  @doc("Summary of the insights report.")
  summary: InsightSummary;

  @doc("List of samples and their associated clusters.")
  samples: AnalysisSample[];

  @doc("List of clusters identified in the analysis.")
  clusters: AnalysisCluster[];
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
  totalSample: int32;

  @doc("Total number of unique subcluster labels.")
  uniqueSubclusterLabel: int32;

  @doc("Total number of unique clusters.")
  uniqueClusters: int32;

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
