import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";

using TypeSpec.Http;
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
@tag("EvaluationTaxonomies")
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
  @route("/evaluationtaxonomies/{name}")
  create is Azure.Core.Foundations.Operation<
    {
      ...WithConditionalFoundryPreviewHeader<FoundryPreviewOptInKeys.evaluations_v1>;

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
      ...WithConditionalFoundryPreviewHeader<FoundryPreviewOptInKeys.evaluations_v1>;

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
