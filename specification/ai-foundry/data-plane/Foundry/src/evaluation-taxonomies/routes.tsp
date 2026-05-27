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
  @summary("Get an evaluation taxonomy")
  @doc("Gets an evaluation run by name.")
  get is Azure.Core.Foundations.ResourceOperation<
    EvaluationTaxonomy,
    {
      ...EvaluationTaxonomiesPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluationTaxonomy>
  >;

  @summary("List evaluation taxonomies")
  @doc("Lists evaluation taxonomies")
  @Rest.listsResource(EvaluationTaxonomy)
  list is Azure.Core.Foundations.ResourceList<
    EvaluationTaxonomy,
    EvaluationTaxonomiesFilterQueryParamsTraits &
      EvaluationTaxonomiesPreviewHeader,
    Azure.Core.Page<EvaluationTaxonomy>
  >;

  @summary("Delete an evaluation taxonomy")
  @doc("Deletes an evaluation taxonomy by name.")
  @Http.delete
  delete is Azure.Core.Foundations.ResourceOperation<
    EvaluationTaxonomy,
    {
      ...EvaluationTaxonomiesPreviewHeader;
    },
    Http.NoContentResponse
  >;

  @summary("Create an evaluation taxonomy")
  @doc("Creates an evaluation taxonomy.")
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
      taxonomy: EvaluationTaxonomy;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<EvaluationTaxonomy>
  >;

  @summary("Update an evaluation taxonomy")
  @doc("Updates an evaluation taxonomy.")
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
      taxonomy: EvaluationTaxonomy;
    },
    OkResponse & EvaluationTaxonomy
  >;
}
