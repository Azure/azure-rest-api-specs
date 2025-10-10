import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Evaluation Taxonomy Definition")
@added(Versions.v2025_11_15_preview)
@resource("evaluation_taxonomies")
model EvaluationTaxonomy {
  ...AssetBase;

  @doc("Input configuration for the evaluation taxonomy.")
  taxonomyInput: EvaluationTaxonomyInput;

  @doc("List of taxonomy categories.")
  taxonomyCategories: TaxonomyCategory[];

  @doc("Additional properties for the evaluation taxonomy.")
  properties?: Record<string>;
}

@added(Versions.v2025_11_15_preview)
@doc("Type of the evaluation taxonomy input.")
union EvaluationTaxonomyInputType {
  string,

  @doc("Agent")
  agent: "agent",

  @doc("Policy.")
  policy: "policy",
}

@added(Versions.v2025_11_15_preview)
@discriminator("type")
@doc("Input configuration for the evaluation taxonomy.")
model EvaluationTaxonomyInput {
  @doc("Input type of the evaluation taxonomy.")
  type: EvaluationTaxonomyInputType;
}

@added(Versions.v2025_11_15_preview)
@doc("Input configuration for the evaluation taxonomy when the input type is agent.")
model AgentTaxonomyInput extends EvaluationTaxonomyInput {
  @doc("Input type of the evaluation taxonomy.")
  type: EvaluationTaxonomyInputType.agent;

  @doc("Target configuration for the agent.")
  target: AzureAIAgentTarget;

  @doc("List of risk categories to evaluate against.")
  riskCategories: RiskCategory[];
}

@added(Versions.v2025_11_15_preview)
@doc("Target type.")
union TargetType {
  string,

  @doc("Azure AI Agent Target")
  azureAIAgent: "AzureAIAgent",
}

@added(Versions.v2025_11_15_preview)
@doc("Azure AI Agent target configuration.")
model AzureAIAgentTarget {
  @doc("Type of the target.")
  type: TargetType.azureAIAgent;

  @doc("Name of the Azure AI Agent.")
  name: string;

  @doc("Version of the Azure AI Agent.")
  version: string;

  @doc("Tool description.")
  tools: ToolDescription[];
}

@added(Versions.v2025_11_15_preview)
@doc("Tool description.")
model ToolDescription {
  @doc("Name of the tool.")
  name: string;

  @doc("Description of the tool.")
  description: string;
}

@added(Versions.v2025_11_15_preview)
@doc("Taxonomy category definition.")
model TaxonomyCategory {
  @doc("Name of the taxonomy category.")
  name: string;

  @doc("Description of the taxonomy category.")
  description?: string;

  @doc("Risk category associated with this taxonomy category.")
  riskCategory: RiskCategory;

  @doc("List of taxonomy sub categories.")
  subCategories: TaxonomySubCategory[];

  @doc("Additional properties for the taxonomy category.")
  properties?: Record<string>;
}

@added(Versions.v2025_11_15_preview)
@doc("Taxonomy sub-category definition.")
model TaxonomySubCategory {
  @doc("Name of the taxonomy sub-category.")
  name: string;

  @doc("Description of the taxonomy sub-category.")
  description?: string;

  @doc("List of taxonomy items under this sub-category.")
  enabled: boolean;

  @doc("Additional properties for the taxonomy sub-category.")
  properties?: Record<string>;
}
