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
@added(Versions.v2025_10_15_preview)
@resource("evaluation_taxonomies")
model EvaluationTaxonomy {
    ...AssetBase;

    @doc("Input configuration for the evaluation taxonomy.")
    input: EvaluationTaxonomyInput;

    @doc("List of taxonomy categories.")
    taxonomyCategories: TaxonomyCategory[];
}

@added(Versions.v2025_10_15_preview)
@doc("Type of the evaluation taxonomy input.")
union EvaluationTaxonomyInputType {
  string,

  @doc("Agent tool.")
  agentTool: "agentTool",

  @doc("Policy.")
  policy: "policy",
}

@added(Versions.v2025_10_15_preview)
@discriminator("type")
@doc("Input configuration for the evaluation taxonomy.")
model EvaluationTaxonomyInput {
  @doc("Input type of the evaluation taxonomy.")
  type: EvaluationTaxonomyInputType;

  @doc("ID of the evaluation taxonomy input.")
  id?: string;

  @doc("Name of the evaluation taxonomy input.")
  name?: string;

  @doc("Version of the evaluation taxonomy input.")
  version?: string;

  @doc("Description of the evaluation taxonomy input.")
  description?: string;
}

@added(Versions.v2025_10_15_preview)
@doc("Input configuration for the evaluation taxonomy when the input type is agent tool.")
model AgentToolInput extends EvaluationTaxonomyInput {
  @doc("Input type of the evaluation taxonomy.")
  type: EvaluationTaxonomyInputType.agentTool;

  @doc("Tool description.")
  tool: ToolDescription[];
}

@added(Versions.v2025_10_15_preview)
@doc("Tool description.")
model ToolDescription {
    @doc("Name of the tool.")
    name: string;
    
    @doc("Description of the tool.")
    description: string;
}

@added(Versions.v2025_10_15_preview)
@doc("Taxonomy category definition.")
model TaxonomyCategory {
    @doc("Name of the taxonomy category.")
    name: string;

    @doc("Description of the taxonomy category.")
    description?: string;

    @doc("List of taxonomy sub categories.")
    subCategories: TaxonomySubCategory[];
}

@added(Versions.v2025_10_15_preview)
@doc("Taxonomy sub-category definition.")
model TaxonomySubCategory {
    @doc("Name of the taxonomy sub-category.")
    name: string;

    @doc("Description of the taxonomy sub-category.")
    description?: string;

    @doc("List of taxonomy items under this sub-category.")
    enabled: boolean;
}