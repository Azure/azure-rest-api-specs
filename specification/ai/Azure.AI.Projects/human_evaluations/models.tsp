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

@added(Versions.v2025_10_15_preview)
@doc("List of human evaluations for a specific agent.")
model AgentHumanEvaluations {
  @doc("Agent identifier.")
  agentId: string;

  @doc("Templates currently associated with the agent (embedded set).")
  templates: HumanEvaluationTemplateReference[];

  @doc("Primary active template Id.")
  activeTemplateId?: string;
}

@added(Versions.v2025_10_15_preview)
@doc("Request body to create or update the agent's human evaluation template references.")
model HumanEvaluationTemplateReference {
  @doc("Identifier of the evaluation template (server-assigned or user-provided).")
  templateId: AssetId;

  @doc("Display-friendly name or short label for the template.")
  displayName?: string;

  @doc("UTC ISO 8601 timestamp when this template was first linked to the agent.")
  addedAt: string;
}

@added(Versions.v2025_10_15_preview)
@doc("Identifier of a saved asset.")
scalar AssetId extends string;
