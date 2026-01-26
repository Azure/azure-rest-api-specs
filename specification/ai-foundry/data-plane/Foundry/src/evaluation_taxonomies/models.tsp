import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

import "../common/models.tsp";
import "../openai-evaluations/models.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

@doc("Evaluation Taxonomy Definition")
@resource("evaluationtaxonomies")
model EvaluationTaxonomy {
  ...AssetBase;

  @doc("Input configuration for the evaluation taxonomy.")
  taxonomyInput: EvaluationTaxonomyInput;

  @doc("List of taxonomy categories.")
  taxonomyCategories?: TaxonomyCategory[];

  @doc("Additional properties for the evaluation taxonomy.")
  properties?: Record<string>;
}

@doc("Type of the evaluation taxonomy input.")
union EvaluationTaxonomyInputType {
  string,

  @doc("Agent")
  agent: "agent",

  @doc("Policy")
  policy: "policy",
}

@discriminator("type")
@doc("Input configuration for the evaluation taxonomy.")
model EvaluationTaxonomyInput {
  @doc("Input type of the evaluation taxonomy.")
  type: EvaluationTaxonomyInputType;
}

@doc("Input configuration for the evaluation taxonomy when the input type is agent.")
model AgentTaxonomyInput extends EvaluationTaxonomyInput {
  @doc("Input type of the evaluation taxonomy.")
  type: EvaluationTaxonomyInputType.agent;

  @doc("Target configuration for the agent.")
  target: Target;

  @doc("List of risk categories to evaluate against.")
  riskCategories: RiskCategory[];
}

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

  @doc("Additional properties for the taxonomy sub-category.")
  properties?: Record<string>;
}
