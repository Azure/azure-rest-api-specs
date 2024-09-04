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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix:}
  @doc("Get an Evalution.")
  @route("/evalations/{id}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the evaluation.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$") # TODO: Check if this is the correct pattern
      @maxLength(254)
      @path
      id: string;

    },
    Evaluation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Creates or updates a Prompt")
  @route("/evaluations/create")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("Properties of Evaluation.")
      @body
      body: Evaluation;
    },
    ResourceCreated<Evaluation>
  >;