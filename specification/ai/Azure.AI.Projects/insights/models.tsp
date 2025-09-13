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
@added(Versions.v2025_10_15_preview)
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
@added(Versions.v2025_10_15_preview)
@discriminator("type")
model AnalysisRequest {
  @doc("The type of analysis request.")
  type: AnalysisType;
}

@doc("Analysis on set of Evaluation Results")
@added(Versions.v2025_10_15_preview)
model EvaluationRunClusterAnalysis extends AnalysisRequest {
  @doc("The type of analysis request.")
  type: AnalysisType.EvaluationRunClusterAnalysis;

  @doc("Evaluation Id for the analysis.")
  evalId: string;

  @doc("List of evaluation run IDs for the analysis.")
  runIds: string[];
}

@doc("Analysis on set of Agent Evaluation Results")
@added(Versions.v2025_10_15_preview)
model AgentClusterAnalysis extends AnalysisRequest {
  @doc("The type of analysis request.")
  type: AnalysisType.AgentClusterAnalysis;

  @doc("Identifier for the agent.")
  agentName: string;
}

@doc("The request of the cluster analysis.")
@added(Versions.v2025_10_15_preview)
union AnalysisType {
  @doc("Analysis on an Evaluation run result.")
  EvaluationRunClusterAnalysis: "EvaluationRunClusterAnalysis",

  @doc("Analysis on an Agent.")
  AgentClusterAnalysis: "AgentClusterAnalysis",

  string,
}

@doc("Metadata about the analysis.")
@added(Versions.v2025_10_15_preview)
model AnalysisMetadata {
  @doc("The timestamp when the analysis was created.")
  createdAt: utcDateTime;

  @doc("The timestamp when the analysis was completed.")
  completedAt?: utcDateTime;
}

@doc("Configuration of the model used in the analysis.")
@added(Versions.v2025_10_15_preview)
model ModelConfiguration {
  @doc("The model deployment to be evaluated. Accepts either the deployment name alone or with the connection name as '{connectionName}/<modelDeploymentName>'.")
  modelDeploymentName: string;
}

@doc("The result of the analysis.")
@added(Versions.v2025_10_15_preview)
@discriminator("type")
model InsightResult {
  @doc("The type of insights result.")
  type: AnalysisType;
}

@doc("Insights from the cluster analysis.")
@added(Versions.v2025_10_15_preview)
model ClusterAnalysisInsights {
  @doc("Summary of the insights report.")
  summary: InsightSummary;

  @doc("List of clusters identified in the analysis.")
  clusters: AnalysisCluster[];

  @doc("""
      Optional mapping of IDs to 2D coordinates used by the UX for visualization.

      The map keys are string identifiers (for example, a cluster id or a sample id)
      and the values are the coordinates and visual size for rendering on a 2D chart.

      This property is omitted unless the client requests coordinates (for example,
      by passing `includeCoordinates=true` as a query parameter).

      Example:
      {
        "cluster-1": { "x": 12, "y": 34, "size": 8 },
        "sample-123": { "x": 18, "y": 22, "size": 4 }
      }

      Coordinates are intended only for client-side visualization and do not
      modify the canonical analysis results.
    """)
  coordinates?: Record<AnalysisChartCoordinate>;
}

@doc("Insights from the evaluation run cluster analysis.")
@added(Versions.v2025_10_15_preview)
model EvaluationRunClusterInsightResult extends InsightResult {
  @doc("The type of insights result.")
  type: AnalysisType.EvaluationRunClusterAnalysis;

  ...ClusterAnalysisInsights;
}

@doc("Insights from the agent cluster analysis.")
@added(Versions.v2025_10_15_preview)
model AgentClusterInsightResult extends InsightResult {
  @doc("The type of insights result.")
  type: AnalysisType.AgentClusterAnalysis;

  ...ClusterAnalysisInsights;
}

@doc("The type of insights result.")
@added(Versions.v2025_10_15_preview)
union InsightResultType {
  @doc("Insights from the cluster analysis.")
  ClusterAnalysisInsights: "ClusterAnalysisInsights",

  string,
}

@doc("Summary of the error cluster analysis.")
@added(Versions.v2025_10_15_preview)
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
@added(Versions.v2025_10_15_preview)
model AnalysisChartCoordinate {
  @doc("X-axis coordinate.")
  x: int32;

  @doc("Y-axis coordinate.")
  y: int32;

  @doc("Size of the chart element.")
  size: int32;
}

@doc("The type of sample used in the analysis.")
@added(Versions.v2025_10_15_preview)
union SampleType {
    @doc("A sample from the evaluation result.")
    EvaluationResultSample: "EvaluationResultSample",

    string
}

@doc("A sample from the analysis.")
@added(Versions.v2025_10_15_preview)
@discriminator("type")
model AnalysisSample {
  @doc("The unique identifier for the analysis sample.")
  id: string;

  @doc("Sample type")
  type: SampleType;
  
  @doc("Features to help with additional filtering of data in UX.")
  features: Record<unknown>;
  
  @doc("Info about the correlation for the analysis sample.")
  correlationInfo: Record<unknown>;
}

@doc("A sample from the evaluation result.")
@added(Versions.v2025_10_15_preview)
model EvaluationResultAnalysisSample extends AnalysisSample {
  @doc("Evaluation Result Sample Type")
  type: SampleType.EvaluationResultSample;

  @doc("Evaluation result for the analysis sample.")
  evaluationResult: EvalResult;
}

@doc("Result of the evaluation.")
@added(Versions.v2025_10_15_preview)
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
@added(Versions.v2025_10_15_preview)
model AnalysisCluster {
  @doc("The id of the analysis cluster.")
  id: string;

  @doc("Description of the analysis cluster.")
  description: string;

  @doc("The weight of the analysis cluster. This indicate number of samples in the cluster.")
  weight: int32;

  @doc("List of subclusters within this cluster. Empty if no subclusters exist.")
  subClusters?: AnalysisCluster[];

  @doc("List of samples that belong to this cluster. Empty if samples are part of subclusters.")
  samples?: AnalysisSample[];
}
