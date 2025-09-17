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

@doc("The response body for cluster insights.")
@added(Versions.v2025_10_15_preview)
@resource("insights")
model Insight {
  @doc("The unique identifier for the insights report.")
  @key("id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Metadata about the insights report.")
  @visibility(Lifecycle.Read)
  metadata: InsightsMetadata;

  @doc("The current state of the insights.")
  @visibility(Lifecycle.Read)
  state: OperationState;

  @doc("User friendly display name for the insight.")
  displayName: string;

  @doc("Request for the insights analysis.")
  request: InsightRequest;

  @doc("Configuration of the model used in the analysis.")
  modelConfiguration?: InsightModelConfiguration;

  @doc("The result of the insights report.")
  @visibility(Lifecycle.Read)
  result?: InsightResult;
}

@doc("Configuration of the model used in the insight generation.")
@added(Versions.v2025_10_15_preview)
model InsightModelConfiguration {
  @doc("The model deployment to be evaluated. Accepts either the deployment name alone or with the connection name as '{connectionName}/<modelDeploymentName>'.")
  modelDeploymentName: string;
}

@doc("The request of the insights report.")
@added(Versions.v2025_10_15_preview)
@discriminator("type")
model InsightRequest {
  @doc("The type of request.")
  type: InsightType;
}

@doc("Insights on set of Evaluation Results")
@added(Versions.v2025_10_15_preview)
model EvaluationRunClusterInsightsRequest extends InsightRequest {
  @doc("The type of insights request.")
  type: InsightType.EvaluationRunClusterInsight;

  @doc("Evaluation Id for the insights.")
  evalId: string;

  @doc("List of evaluation run IDs for the insights.")
  runIds: string[];
}

@doc("Insights on set of Agent Evaluation Results")
@added(Versions.v2025_10_15_preview)
model AgentClusterInsightsRequest extends InsightRequest {
  @doc("The type of request.")
  type: InsightType.AgentClusterInsight;

  @doc("Identifier for the agent.")
  agentName: string;
}

@doc("The request of the insights.")
@added(Versions.v2025_10_15_preview)
union InsightType {
  @doc("Insights on an Evaluation run result.")
  EvaluationRunClusterInsight: "EvaluationRunClusterInsight",

  @doc("Cluster Insight on an Agent.")
  AgentClusterInsight: "AgentClusterInsight",

  string,
}

@doc("Metadata about the insights.")
@added(Versions.v2025_10_15_preview)
model InsightsMetadata {
  @doc("The timestamp when the insights were created.")
  createdAt: utcDateTime;

  @doc("The timestamp when the insights were completed.")
  completedAt?: utcDateTime;
}

@doc("The result of the insights.")
@added(Versions.v2025_10_15_preview)
@discriminator("type")
model InsightResult {
  @doc("The type of insights result.")
  type: InsightType;
}

@doc("Insights from the cluster analysis.")
@added(Versions.v2025_10_15_preview)
model ClusterInsightResult {
  @doc("Summary of the insights report.")
  summary: InsightSummary;

  @doc("List of clusters identified in the insights.")
  clusters: InsightCluster[];

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
      modify the canonical insights results.
    """)
  coordinates?: Record<ChartCoordinate>;
}

@doc("Insights from the evaluation run cluster analysis.")
@added(Versions.v2025_10_15_preview)
model EvaluationRunClusterInsightResult extends InsightResult {
  @doc("The type of insights result.")
  type: InsightType.EvaluationRunClusterInsight;

  clusterInsight: ClusterInsightResult;
}

@doc("Insights from the agent cluster analysis.")
@added(Versions.v2025_10_15_preview)
model AgentClusterInsightResult extends InsightResult {
  @doc("The type of insights result.")
  type: InsightType.AgentClusterInsight;

  clusterInsight: ClusterInsightResult;
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
model ChartCoordinate {
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

  string,
}

@doc("A sample from the analysis.")
@added(Versions.v2025_10_15_preview)
@discriminator("type")
model InsightSample {
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
model EvaluationResultSample extends InsightSample {
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
model InsightCluster {
  @doc("The id of the analysis cluster.")
  id: string;

  @doc("Description of the analysis cluster.")
  description: string;

  @doc("The weight of the analysis cluster. This indicate number of samples in the cluster.")
  weight: int32;

  @doc("List of subclusters within this cluster. Empty if no subclusters exist.")
  subClusters?: InsightCluster[];

  @doc("List of samples that belong to this cluster. Empty if samples are part of subclusters.")
  samples?: InsightSample[];
}
