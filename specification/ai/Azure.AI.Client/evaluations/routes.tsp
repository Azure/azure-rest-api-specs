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
@route("/evaluations/create")
@post
op create is Azure.Core.Foundations.Operation<
  {
    @doc("Properties of Evaluation.")
    @body
    evaluation: Evaluation;
  },
  ResourceCreatedResponse<Evaluation>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("List evaluations")
@route("/evaluations")
@get
op list is Azure.Core.Foundations.Operation<
  {
    ...StandardListQueryParameters;
  },
  PagedEvaluation
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("Update an evaluation.")
@route("/evaluations/{id}")
@patch
op update is Azure.Core.Foundations.Operation<
  {
    @doc("Identifier of the evaluation.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    id: string;

    @doc("Update evaluation request.")
    @body
    updateRequest: UpdateEvaluationRequest;
  },
  OkResponse<Evaluation>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("Get an evaluation.")
@route("/evaluations/{id}")
@get
op get is Azure.Core.Foundations.Operation<
  {
    @doc("Identifier of the evaluation.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    id: string;
  },
  OkResponse<Evaluation>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("Creates an evaluation schedule.")
@route("/evaluations/schedules/create")
@post
op createSchedule is Azure.Core.Foundations.Operation<
  {
    @doc("Properties of Evaluation Schedule.")
    @body
    body: EvaluationSchedule;
  },
  ResourceCreatedResponse<EvaluationSchedule>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("Get an evaluation schedule along with runs.")
@route("/evaluations/schedules/{id}")
@get
op getSchedule is Azure.Core.Foundations.Operation<
  {
    @doc("Identifier of the evaluation schedule.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    id: string;
  },
  EvaluationSchedule
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("List evaluation schedules")
@route("/evaluations/schedules")
@get
op listSchedules is Azure.Core.Foundations.Operation<
  {
    ...StandardListQueryParameters;
  },
  PagedEvaluationSchedule
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("List evaluations under a schedule")
@route("/evaluations/schedules/{id}/runs")
@get
op listScheduleEvaluations is Azure.Core.Foundations.Operation<
  {
    @doc("Identifier of the evaluation schedule.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    id: string;

    ...StandardListQueryParameters;
  },
  PagedEvaluation
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
@doc("Delete an evaluation schedule.")
@route("/evaluations/schedules/{id}")
@delete
op deleteSchedule is Azure.Core.Foundations.Operation<
  {
    @doc("Identifier of the evaluation schedule.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    id: string;
  },
  void
>;
