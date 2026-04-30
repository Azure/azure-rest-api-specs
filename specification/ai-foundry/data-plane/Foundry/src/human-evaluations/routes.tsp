import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;
using Http;
using OpenAPI;
using Rest;
using TypeSpec.Versioning;

alias HumanEvaluationsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>;

// Full CRUD operations to be added in a later milestone.
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Human Evaluations")
interface HumanEvaluationTemplates {
  // GET /human_evaluation_templates
  @removed(Versions.v1)
  @doc("List the latest version of each human-evaluation template available to the project.")
  @Rest.listsResource(HumanEvaluationTemplate)
  listLatestVersions is Azure.Core.Foundations.ResourceList<
    HumanEvaluationTemplate,
    HumanEvaluationsPreviewHeader,
    Azure.Core.Page<HumanEvaluationTemplate>
  >;
}
