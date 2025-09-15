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
@doc("List of human evaluation template associations for a specific agent.")
model HumanEvaluation {
  @doc("Identifier of the agent.")
  agentId: string;

  @doc("List of human evaluation template associations for this agent.")
  associations: HumanEvaluationAssociation[];
}

@added(Versions.v2025_05_15_preview)
@doc("Request body to update an existing human evaluation template association.")
model HumanEvaluationAssociation {
  @doc("Whether the current human evaluation template for this agent is enabled. If omitted the existing value is preserved.")
  active?: boolean;

  @doc("Identifier of the human evaluation template associated with this agent.")
  templateId: AssetId;
}

@added(Versions.v2025_05_15_preview)
@doc("Identifier of a saved asset.")
scalar AssetId extends string;
