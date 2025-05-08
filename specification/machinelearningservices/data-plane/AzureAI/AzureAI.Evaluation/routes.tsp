import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices;

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
  @route("/evaluations/create")
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Update an evaluation.")
  @route("/evaluations/{id}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the evaluation.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      id: string;

      @doc("Update evaluation request.")
      @body
      body: UpdateEvaluationRequest;
    },
    OkResponse<Evaluation>
  >;
}