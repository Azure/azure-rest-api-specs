import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../openai-evaluations/models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Evaluation Taxonomy Definition")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@resource("evaluationtaxonomies")
model EvaluationTaxonomy {
  ...AssetBase;

  @doc("Input configuration for the evaluation taxonomy.")
  taxonomyInput: EvaluationTaxonomyInput;

  @doc("List of taxonomy categories.")
  taxonomyCategories?: TaxonomyCategory[];

  @doc("Risk name from the Evaluator Catalog (for policy-based taxonomies).")
  riskName?: string;

  @doc("Natural language definition of the risk (for policy-based taxonomies).")
  riskDefinition?: string;

  @doc("Whether the taxonomy has been expanded in the P2M pipeline.")
  isExpanded?: boolean;

  @doc("Metadata about taxonomy expansion in the P2M pipeline.")
  expansionMetadata?: TaxonomyExpansionMetadata;

  @doc("Additional properties for the evaluation taxonomy.")
  properties?: Record<string>;
}

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@doc("Type of the evaluation taxonomy input.")
union EvaluationTaxonomyInputType {
  string,

  @doc("Agent")
  agent: "agent",

  @doc("Policy")
  policy: "policy",
}

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@discriminator("type")
@doc("Input configuration for the evaluation taxonomy.")
model EvaluationTaxonomyInput {
  @doc("Input type of the evaluation taxonomy.")
  type: EvaluationTaxonomyInputType;
}

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
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
@removed(Versions.v1)
@doc("Input configuration for the evaluation taxonomy when the input type is policy.")
model PolicyTaxonomyInput extends EvaluationTaxonomyInput {
  @doc("Input type of the evaluation taxonomy.")
  type: EvaluationTaxonomyInputType.policy;

  @doc("Risk name from the Evaluator Catalog.")
  riskName: string;

  @doc("Natural language definition of the risk.")
  riskDefinition?: string;

  @doc("Clarifications to guide taxonomy generation.")
  clarifications?: string[];

  @doc("Scope of the risk policy.")
  scope?: string;

  @doc("Example prompts labeled as in_scope or out_of_scope.")
  examples?: RiskExample[];
}

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@doc("Example prompt with label for taxonomy generation.")
model RiskExample {
  @doc("Example prompt text.")
  text: string;

  @doc("Label indicating if the example is in scope or out of scope.")
  label: "in_scope" | "out_of_scope";
}

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@doc("Metadata about taxonomy expansion in the P2M pipeline.")
model TaxonomyExpansionMetadata {
  @doc("Model used to generate the taxonomy.")
  generatorModel: string;

  @doc("Timestamp when the taxonomy was expanded.")
  expandedAt: utcDateTime;

  @doc("Total number of subtopics in the taxonomy.")
  totalSubtopics: int32;
}

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@doc("Taxonomy category definition.")
model TaxonomyCategory {
  @doc("Unique identifier of the taxonomy category.")
  id: string;

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
@removed(Versions.v1)
@doc("Taxonomy sub-category definition.")
model TaxonomySubCategory {
  @doc("Unique identifier of the taxonomy sub-category.")
  id: string;

  @doc("Name of the taxonomy sub-category.")
  name: string;

  @doc("Description of the taxonomy sub-category.")
  description?: string;

  @doc("List of taxonomy items under this sub-category.")
  enabled: boolean;

  @doc("List of subtopics in this sub-category (for P2M pipeline).")
  subtopics?: string[];

  @doc("Additional properties for the taxonomy sub-category.")
  properties?: Record<string>;
}
