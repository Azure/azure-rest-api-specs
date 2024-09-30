import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Client.Evaluations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("Creates an evaluation.")
@route("raisvc/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/evaluations/create")
@post
op create is Azure.Core.Foundations.Operation<
  {
    @path
    subscriptionId: string;

    @path
    resourceGroupName: string;

    @path
    workspaceName: string;

    @doc("Properties of Evaluation.")
    @evaluation
    body: Evaluation;
  },
  ResourceCreatedResponse<Evaluation>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("List evaluations")
@route("raisvc/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/evaluations")
@get
op list is Azure.Core.Foundations.Operation<
  {
    @path
    subscriptionId: string;

    @path
    resourceGroupName: string;

    @path
    workspaceName: string;

    ...StandardListQueryParameters;
  },
  PagedEvaluation
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("Update an evaluation.")
@route("raisvc/v1.0/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/evaluations/{id}")
@patch
op update is Azure.Core.Foundations.Operation<
  {
    @path
    subscriptionId: string;

    @path
    resourceGroupName: string;

    @path
    workspaceName: string;

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
