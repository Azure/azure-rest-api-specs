import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@added(Versions.v2025_05_15_preview)
@doc("List of human evaluations for a specific agent.")
model AgentHumanEvaluations {
  @doc("Identifier of the agent.")
  agentId: string;

  @doc("List of human evaluation templates used with this agent.")
  humanEvaluationReferences: HumanEvaluationTemplateReference[];
}

@added(Versions.v2025_05_15_preview)
@doc("Request body to create or update the agent's human evaluation template references.")
model HumanEvaluationTemplateReference {
  @doc("Whether the current human evaluation template for this agent is enabled. If omitted the existing value is preserved.")
  active?: boolean;

  @doc("The asset id of the referenced human evaluation template.")
  templateId: AssetId;
}

@added(Versions.v2025_05_15_preview)
@doc("Identifier of a saved asset.")
scalar AssetId extends string;
