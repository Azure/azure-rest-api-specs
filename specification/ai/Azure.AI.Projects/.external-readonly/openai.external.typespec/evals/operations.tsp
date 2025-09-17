import "@typespec/http";
import "@typespec/openapi";

import "../common";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace OpenAI;

@route("/evals")
interface Evals {
  @get
  @operationId("listEvals")
  @tag("Evals")
  @summary("List evaluations for a project.")
  listEvals(
    /**
     * Identifier for the last eval from the previous pagination request.
     */
    @query after?: string,

    /**
     * A limit on the number of evals to be returned in a single pagination response.
     */
    @query limit?: int32 = 20,

    /**
     * Sort order for evals by timestamp. Use `asc` for ascending order or
     * `desc` for descending order.
     */
    @query order?: "asc" | "desc" = "asc",

    /**
     * Evals can be ordered by creation time or last updated time. Use
     * `created_at` for creation time or `updated_at` for last updated
     * time.
     */
    @query order_by?: "created_at" | "updated_at" = "created_at",
  ): EvalList;

  /**
   * Create the structure of an evaluation that can be used to test a model's
   * performance.
   *
   * An evaluation is a set of testing criteria and a datasource. After
   * creating an evaluation, you can run it on different models and model
   * parameters. We support several types of graders and datasources.
   *
   * For more information, see the [Evals guide](/docs/guides/evals).
   */
  @post
  @operationId("createEval")
  @tag("Evals")
  createEval(@body body: CreateEvalRequest): {
    @statusCode statusCode: 201;
    ...Eval;
  } | EvalsErrorResponse;

  @get
  @route("{eval_id}")
  @operationId("getEval")
  @tag("Evals")
  @summary("Retrieve an evaluation by its ID.")
  getEval(@path eval_id: string): Eval | EvalsErrorResponse;

  /**
   * Update select, mutable properties of a specified evaluation.
   *
   * @param eval_id The ID of the evaluation to update.
   */
  @post
  @route("{eval_id}")
  @operationId("updateEval")
  @tag("Evals")
  updateEval(
    @path eval_id: string,
    @body body: {
      name?: string;
      metadata?: MetadataPropertyForRequest;
    },
  ): Eval | EvalsErrorResponse;

  /**
   * Delete a specified evaluation.
   *
   * @param eval_id The ID of the evaluation to delete.
   */
  @delete
  @route("{eval_id}")
  @operationId("deleteEval")
  @tag("Evals")
  deleteEval(@path eval_id: string): {
    object: "eval.deleted";
    deleted: boolean;
    eval_id: string;
  } | EvalsErrorResponse;

  /**
   * Retrieve a list of runs for a specified evaluation.
   *
   * @param eval_id The ID of the evaluation to retrieve runs for.
   * @param after Identifier for the last run from the previous pagination request.
   * @param limit A limit on the number of runs to be returned in a single pagination response.
   * @param order Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for descending order.
   * @param status Filter runs by their status. Possible values are `queued`, `in_progress`, `completed`, `canceled`, and `failed`.
   */
  @get
  @route("{eval_id}/runs")
  @operationId("getEvalRuns")
  @tag("Evals")
  @summary("")
  getEvalRuns(
    @path eval_id: string,
    @query after?: string,
    @query limit?: int32 = 20,
    @query order?: "asc" | "desc" = "asc",
    @query status?:
      | "queued"
      | "in_progress"
      | "completed"
      | "canceled"
      | "failed",
  ): EvalRunList | EvalsErrorResponse;

  /**
   * Create a new evaluation run, beginning the grading process.
   *
   * @param eval_id The ID of the evaluation to run.
   */
  @post
  @route("{eval_id}/runs")
  @operationId("createEvalRun")
  @tag("Evals")
  createEvalRun(@path eval_id: string, @body body: CreateEvalRunRequest): {
    @statusCode statusCode: 201;
    ...EvalRun;
  } | EvalsErrorResponse;

  /**
   * Retrieve a specific evaluation run by its ID.
   *
   * @param eval_id The ID of the evaluation the run belongs to.
   * @param run_id The ID of the evaluation run to retrieve.
   */
  @get
  @route("{eval_id}/runs/{run_id}")
  @operationId("getEvalRun")
  @tag("Evals")
  getEvalRun(
    @path eval_id: string,
    @path run_id: string,
  ): EvalRun | EvalsErrorResponse;

  /**
   * Cancel a specific evaluation run by its ID.
   *
   * @param eval_id The ID of the evaluation the run belongs to.
   * @param run_id The ID of the evaluation run to cancel.
   */
  @post
  @route("{eval_id}/runs/{run_id}")
  @operationId("cancelEvalRun")
  @tag("Evals")
  cancelEvalRun(
    @path eval_id: string,
    @path run_id: string,
  ): EvalRun | EvalsErrorResponse;

  /**
   * Delete a specific evaluation run by its ID.
   *
   * @param eval_id The ID of the evaluation the run belongs to.
   * @param run_id The ID of the evaluation run to delete.
   */
  @delete
  @route("{eval_id}/runs/{run_id}")
  @operationId("deleteEvalRun")
  @tag("Evals")
  deleteEvalRun(@path eval_id: string, @path run_id: string): {
    object: "eval_run.deleted";
    deleted: boolean;
    eval_run_id: string;
  } | EvalsErrorNotFoundResponse;

  /**
   * Get a list of output items for a specified evaluation run.
   *
   * @param eval_id The ID of the evaluation the run belongs to.
   * @param run_id The ID of the evaluation run to retrieve output items for.
   * @param after Identifier for the last output item from the previous pagination request.
   * @param limit A limit on the number of output items to be returned in a single pagination response.
   * @param status Filter output items by their status. Possible values are `fail` and `pass`.
   * @param order Sort order for output items by timestamp. Use `asc` for ascending order or `desc` for descending order.
   */
  @get
  @route("{eval_id}/runs/{run_id}/output_items")
  @operationId("getEvalRunOutputItems")
  @tag("Evals")
  getEvalRunOutputItems(
    @path eval_id: string,
    @path run_id: string,
    @query after?: string,
    @query limit?: int32 = 20,
    @query status?: "fail" | "pass",
    @query order?: "asc" | "desc" = "asc",
  ): EvalRunOutputItemList | EvalsErrorResponse;

  /**
   * Retrieve a specific output item from an evaluation run by its ID.
   *
   * @param eval_id The ID of the evaluation the run belongs to.
   * @param run_id The ID of the evaluation run the output item belongs to.
   * @param output_item_id The ID of the output item to retrieve.
   */
  @get
  @route("{eval_id}/runs/{run_id}/output_items/{output_item_id}")
  @operationId("getEvalRunOutputItem")
  @tag("Evals")
  getEvalRunOutputItem(
    @path eval_id: string,
    @path run_id: string,
    @path output_item_id: string,
  ): EvalRunOutputItem;
}

@error
model EvalsErrorResponse {
  @statusCode statusCode: 400;
  ...Error;
}

@error
model EvalsErrorNotFoundResponse {
  @statusCode statusCode: 404;
  ...Error;
}
