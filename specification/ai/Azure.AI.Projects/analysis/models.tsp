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
}
