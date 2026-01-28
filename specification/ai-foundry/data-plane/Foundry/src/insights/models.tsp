import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

import "../common/models.tsp";

using TypeSpec.Rest;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

@doc("The response body for cluster insights.")
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

  @doc("The result of the insights report.")
  @visibility(Lifecycle.Read)
  result?: InsightResult;
}

@doc("Configuration of the model used in the insight generation.")
model InsightModelConfiguration {
  @doc("The model deployment to be evaluated. Accepts either the deployment name alone or with the connection name as '{connectionName}/<modelDeploymentName>'.")
  modelDeploymentName: string;
}

@doc("The request of the insights report.")
@discriminator("type")
model InsightRequest {
  @doc("The type of request.")
  type: InsightType;
}

@doc("Insights on set of Evaluation Results")
model EvaluationRunClusterInsightRequest extends InsightRequest {
  @doc("The type of insights request.")
  type: InsightType.EvaluationRunClusterInsight;

  @doc("Evaluation Id for the insights.")
  evalId: string;

  @doc("List of evaluation run IDs for the insights.")
  runIds: string[];

  @doc("Configuration of the model used in the insight generation.")
  modelConfiguration?: InsightModelConfiguration;
}

@doc("Insights on set of Agent Evaluation Results")
model AgentClusterInsightRequest extends InsightRequest {
  @doc("The type of request.")
  type: InsightType.AgentClusterInsight;

  @doc("Identifier for the agent.")
  agentName: string;

  @doc("Configuration of the model used in the insight generation.")
  modelConfiguration?: InsightModelConfiguration;
}

@doc("Evaluation Comparison Request")
model EvaluationComparisonInsightRequest extends InsightRequest {
  @doc("The type of request.")
  type: InsightType.EvaluationComparison;

  @doc("Identifier for the evaluation.")
  evalId: string;

  @doc("The baseline run ID for comparison.")
  baselineRunId: string;

  @doc("List of treatment run IDs for comparison.")
  treatmentRunIds: string[];
}

@doc("The request of the insights.")
union InsightType {
  string,

  @doc("Insights on an Evaluation run result.")
  EvaluationRunClusterInsight: "EvaluationRunClusterInsight",

  @doc("Cluster Insight on an Agent.")
  AgentClusterInsight: "AgentClusterInsight",

  @doc("Evaluation Comparison.")
  EvaluationComparison: "EvaluationComparison",
}

@doc("Metadata about the insights.")
model InsightsMetadata {
  @doc("The timestamp when the insights were created.")
  createdAt: utcDateTime;

  @doc("The timestamp when the insights were completed.")
  completedAt?: utcDateTime;
}

@doc("The result of the insights.")
@discriminator("type")
model InsightResult {
  @doc("The type of insights result.")
  type: InsightType;
}

@doc("Insights from the evaluation comparison.")
model EvaluationComparisonInsightResult extends InsightResult {
  @doc("The type of insights result.")
  type: InsightType.EvaluationComparison;

  @doc("Comparison results for each treatment run against the baseline.")
  comparisons: EvalRunResultComparison[];

  @doc("The statistical method used for comparison.")
  method: string;
}

@doc("Comparison results for treatment runs against the baseline.")
model EvalRunResultComparison {
  @doc("Name of the testing criteria.")
  testingCriteria: string;

  @doc("Metric being evaluated.")
  metric: string;

  @doc("Name of the evaluator for this testing criteria.")
  evaluator: string;

  @doc("Summary statistics of the baseline run.")
  baselineRunSummary: EvalRunResultSummary;

  @doc("List of comparison results for each treatment run.")
  compareItems: EvalRunResultCompareItem[];
}

@doc("Summary statistics of a metric in an evaluation run.")
model EvalRunResultSummary {
  @doc("The evaluation run ID.")
  runId: string;

  @doc("Number of samples in the evaluation run.")
  sampleCount: int32;

  @doc("Average value of the metric in the evaluation run.")
  average: float32;

  @doc("Standard deviation of the metric in the evaluation run.")
  standardDeviation: float32;
}

@doc("Metric comparison for a treatment against the baseline.")
model EvalRunResultCompareItem {
  @doc("The treatment run ID.")
  treatmentRunId: string;

  @doc("Summary statistics of the treatment run.")
  treatmentRunSummary: EvalRunResultSummary;

  @doc("Estimated difference between treatment and baseline.")
  deltaEstimate: float32;

  @doc("P-value for the treatment effect.")
  pValue: float32;

  @doc("Type of treatment effect.")
  treatmentEffect: TreatmentEffectType;
}

@doc("Treatment Effect Type.")
union TreatmentEffectType {
  @doc("Not enough samples to determine treatment effect.")
  TooFewSamples: "TooFewSamples",

  @doc("No significant difference between treatment and baseline.")
  Inconclusive: "Inconclusive",

  @doc("Indicates the metric changed with statistical significance, but the direction is neutral.")
  Changed: "Changed",

  @doc("Indicates the treatment significantly improved the metric compared to baseline.")
  Improved: "Improved",

  @doc("Indicates the treatment significantly degraded the metric compared to baseline.")
  Degraded: "Degraded",

  string,
}

@doc("Insights from the cluster analysis.")
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
      ```
      {
        "cluster-1": { "x": 12, "y": 34, "size": 8 },
        "sample-123": { "x": 18, "y": 22, "size": 4 }
      }
      ```
    
      Coordinates are intended only for client-side visualization and do not
      modify the canonical insights results.
    """)
  coordinates?: Record<ChartCoordinate>;
}

@doc("Insights from the evaluation run cluster analysis.")
model EvaluationRunClusterInsightResult extends InsightResult {
  @doc("The type of insights result.")
  type: InsightType.EvaluationRunClusterInsight;

  clusterInsight: ClusterInsightResult;
}

@doc("Insights from the agent cluster analysis.")
model AgentClusterInsightResult extends InsightResult {
  @doc("The type of insights result.")
  type: InsightType.AgentClusterInsight;

  clusterInsight: ClusterInsightResult;
}

@doc("Summary of the error cluster analysis.")
model InsightSummary {
  @doc("Total number of samples analyzed.")
  sampleCount: int32;

  @doc("Total number of unique subcluster labels.")
  uniqueSubclusterCount: int32;

  @doc("Total number of unique clusters.")
  uniqueClusterCount: int32;

  @doc("Method used for clustering.")
  method: string;

  @doc("Token usage while performing clustering analysis")
  usage: ClusterTokenUsage;
}

@doc("Token usage for cluster analysis")
model ClusterTokenUsage {
  @doc("input token usage")
  inputTokenUsage: int32;

  @doc("output token usage")
  outputTokenUsage: int32;

  @doc("total token usage")
  totalTokenUsage: int32;
}

@doc("Coordinates for the analysis chart.")
model ChartCoordinate {
  @doc("X-axis coordinate.")
  x: int32;

  @doc("Y-axis coordinate.")
  y: int32;

  @doc("Size of the chart element.")
  size: int32;
}

@doc("The type of sample used in the analysis.")
union SampleType {
  @doc("A sample from the evaluation result.")
  EvaluationResultSample: "EvaluationResultSample",

  string,
}

@doc("A sample from the analysis.")
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
model EvaluationResultSample extends InsightSample {
  @doc("Evaluation Result Sample Type")
  type: SampleType.EvaluationResultSample;

  @doc("Evaluation result for the analysis sample.")
  evaluationResult: EvalResult;
}

@doc("Result of the evaluation.")
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
model InsightCluster {
  @doc("The id of the analysis cluster.")
  id: string;

  @doc("Label for the cluster")
  label: string;

  @doc("Suggestion for the cluster")
  suggestion: string;

  @doc("The title of the suggestion for the cluster")
  suggestionTitle: string;

  @doc("Description of the analysis cluster.")
  description: string;

  @doc("The weight of the analysis cluster. This indicate number of samples in the cluster.")
  weight: int32;

  @doc("List of subclusters within this cluster. Empty if no subclusters exist.")
  subClusters?: InsightCluster[];

  @doc("List of samples that belong to this cluster. Empty if samples are part of subclusters.")
  samples?: InsightSample[];
}
