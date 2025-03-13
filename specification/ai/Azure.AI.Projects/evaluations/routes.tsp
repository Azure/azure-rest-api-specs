import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

interface Evaluations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get an evaluation.")
  @route("/evaluations/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the evaluation.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      id: string;
    },
    Evaluation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Creates an evaluation.")
  @route("/evaluations:create")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("Properties of Evaluation.")
      @body
      body: Evaluation;
    },
    ResourceCreatedResponse<Evaluation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("List evaluations")
  @route("/evaluations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      ...StandardListQueryParameters;
    },
    PagedEvaluation
  >;
}
