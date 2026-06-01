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
  /** Retrieves the specified evaluation taxonomy. */
  @summary("Get an evaluation taxonomy")
  get is Azure.Core.Foundations.ResourceOperation<
    EvaluationTaxonomy,
    {
      ...EvaluationTaxonomiesPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluationTaxonomy>
  >;

  /** Returns the evaluation taxonomies available in the project, optionally filtered by input name or input type. */
  @summary("List evaluation taxonomies")
  @Rest.listsResource(EvaluationTaxonomy)
  list is Azure.Core.Foundations.ResourceList<
    EvaluationTaxonomy,
    EvaluationTaxonomiesFilterQueryParamsTraits &
      EvaluationTaxonomiesPreviewHeader,
    Azure.Core.Page<EvaluationTaxonomy>
  >;

  /** Removes the specified evaluation taxonomy from the project. */
  @summary("Delete an evaluation taxonomy")
  @Http.delete
  delete is Azure.Core.Foundations.ResourceOperation<
    EvaluationTaxonomy,
    {
      ...EvaluationTaxonomiesPreviewHeader;
    },
    Http.NoContentResponse
  >;

  /** Creates or replaces the specified evaluation taxonomy with the provided definition. */
  @summary("Create an evaluation taxonomy")
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

  /** Modifies the specified evaluation taxonomy with the provided changes. */
  @summary("Update an evaluation taxonomy")
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
