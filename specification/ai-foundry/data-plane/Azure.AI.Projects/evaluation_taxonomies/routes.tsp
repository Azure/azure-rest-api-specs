import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias EvaluationTaxonomiesServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias EvaluationTaxonomiesOperations = Azure.Core.ResourceOperations<EvaluationTaxonomiesServiceTraits>;

alias EvaluationTaxonomiesFilterQueryParamsTraits = {
  @query("inputName")
  @doc("Filter by the evaluation input name.")
  inputName?: string;

  @query("inputType")
  @doc("Filter by taxonomy input type.")
  inputType?: string;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
interface EvaluationTaxonomies {
  @doc("Get an evaluation run by name.")
  get is EvaluationTaxonomiesOperations.ResourceRead<EvaluationTaxonomy>;

  @doc("List evaluation taxonomies")
  list is EvaluationTaxonomiesOperations.ResourceList<
    EvaluationTaxonomy,
    ListQueryParametersTrait<EvaluationTaxonomiesFilterQueryParamsTraits>
  >;

  @doc("Delete an evaluation taxonomy by name.")
  delete is EvaluationTaxonomiesOperations.ResourceDelete<EvaluationTaxonomy>;

  @doc("Create an evaluation taxonomy.")
  @put
  @route("/evaluation_taxonomies/{name}")
  create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the evaluation taxonomy.")
      @path
      name: string;

      @doc("The evaluation taxonomy.")
      @body
      body: EvaluationTaxonomy;
    },
    ResourceCreatedResponse<EvaluationTaxonomy>
  >;

  @doc("Update an evaluation taxonomy.")
  @patch(#{ implicitOptionality: true })
  @route("/evaluation_taxonomies/{name}")
  update is Azure.Core.Foundations.Operation<
    {
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
