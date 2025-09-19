import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias EvaluationTaxonomiesOperations = Azure.Core.ResourceOperations<ServiceTraits>;
alias ListEvaluationTaxonomiesParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v2025_10_15_preview)
interface EvaluationTaxonomies
  extends VersionedOperations<
      EvaluationTaxonomy,
      InputParameters<EvaluationTaxonomy, "evaluationTaxonomy">,
      ListEvaluationTaxonomiesParameters,
      ListEvaluationTaxonomiesParameters
    > {
      }