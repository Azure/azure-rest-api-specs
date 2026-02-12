import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias EvaluationTaxonomiesPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>;

alias EvaluationTaxonomiesFilterQueryParamsTraits = {
  @query("inputName")
  @doc("Filter by the evaluation input name.")
  inputName?: string;

  @query("inputType")
  @doc("Filter by taxonomy input type.")
  inputType?: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Evaluation Taxonomies")
interface EvaluationTaxonomies {
  @doc("Get an evaluation run by name.")
  get is Azure.Core.Foundations.ResourceOperation<
    EvaluationTaxonomy,
    {
      ...EvaluationTaxonomiesPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluationTaxonomy>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List evaluation taxonomies")
  @Rest.listsResource(EvaluationTaxonomy)
  list is Azure.Core.Foundations.ResourceList<
    EvaluationTaxonomy,
    EvaluationTaxonomiesFilterQueryParamsTraits & EvaluationTaxonomiesPreviewHeader,
    Azure.Core.Page<EvaluationTaxonomy>
  >;

  @doc("Delete an evaluation taxonomy by name.")
  @Http.delete
  delete is Azure.Core.Foundations.ResourceOperation<
    EvaluationTaxonomy,
    {
      ...EvaluationTaxonomiesPreviewHeader;
    },
    Http.NoContentResponse
  >;

  @doc("Create an evaluation taxonomy.")
  @put
  @route("/evaluationtaxonomies/{name}")
  create is Azure.Core.Foundations.Operation<
    {
      ...EvaluationTaxonomiesPreviewHeader;

      @doc("The name of the evaluation taxonomy.")
      @path
      name: string;

      @doc("The evaluation taxonomy.")
      @body
      body: EvaluationTaxonomy;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<EvaluationTaxonomy>
  >;

  @doc("Update an evaluation taxonomy.")
  @patch(#{ implicitOptionality: true })
  @route("/evaluationtaxonomies/{name}")
  update is Azure.Core.Foundations.Operation<
    {
      ...EvaluationTaxonomiesPreviewHeader;

      @doc("The name of the evaluation taxonomy.")
      @path
      name: string;

      @doc("The evaluation taxonomy.")
      @body
      body: EvaluationTaxonomy;
    },
    OkResponse<EvaluationTaxonomy>
  >;
}
