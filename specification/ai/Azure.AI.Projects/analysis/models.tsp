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
@resource("error-clusters")
model ErrorClusterReport {
  @doc("The unique identifier for the cluster analysis result.")
  @key("id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Metadata about the cluster analysis.")
  @visibility(Lifecycle.Read)
  metadata: AnalysisMetadata;

  @doc("The current state of the analysis.")
  @visibility(Lifecycle.Read)
  state: OperationState;

  @doc("Scope of the analysis.")
  scope: AnalysisScope;

  @doc("Identifier for the scope. This is either the AgentId or EvaluationId depending on the scope.")
  scopeId: string;

  @doc("Configuration of the model used in the analysis.")
  modelConfiguration?: ModelConfiguration;

  @doc("The result of the cluster analysis.")
  result?: ErrorClusterResult;
}

@doc("The scope of the cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union AnalysisScope {
  @doc("Analysis on an Agent.")
  Agent: "Agent",

  @doc("Analysis on an Evaluation result.")
  Evaluation: "Evaluation",

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
model ErrorClusterResult {
  @doc("Summary of the error cluster analysis.")
  summary: ErrorClusterSummary;

  @doc("List of samples and their associated clusters.")
  samples: AnalysisSample[];

  @doc("List of clusters identified in the analysis.")
  clusters: AnalysisCluster[];
}

@doc("Summary of the error cluster analysis.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model ErrorClusterSummary {
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
  evaluationResult: Record<unknown>;

  @doc("Info about the conversation for the analysis sample.")
  conversationInfo: Record<unknown>;

  @doc("Parameters to help with additional filtering of data in UX.")
  parameters: Record<unknown>;

  @doc("The label of the analysis cluster in which this sample belongs.")
  clusterLabel?: string;

  @doc("Coordinates for the analysis chart.")
  coordinates: AnalysisChartCoordinate;
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
