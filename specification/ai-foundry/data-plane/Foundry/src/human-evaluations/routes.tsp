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
  // GET /humanevaluations/templates/{name}/versions/{version}
  @removed(Versions.v1)
  @doc("Get a specific version of a human-evaluation template. Returns 404 if either the template name or the version does not exist.")
  getVersion is Azure.Core.Foundations.ResourceOperation<
    HumanEvaluationTemplate,
    {
      ...HumanEvaluationsPreviewHeader;

      @doc("The specific version of the template to retrieve.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Azure.Core.Foundations.ResourceOkResponse<HumanEvaluationTemplate>
  >;

  // GET /humanevaluations/templates
  @removed(Versions.v1)
  @doc("List the latest version of each human-evaluation template available to the project. Built-in templates (for example, 'builtin.thumbs') are always included.")
  @Rest.listsResource(HumanEvaluationTemplate)
  listLatestVersions is Azure.Core.Foundations.ResourceList<
    HumanEvaluationTemplate,
    HumanEvaluationsPreviewHeader,
    Azure.Core.Page<HumanEvaluationTemplate>
  >;
}
