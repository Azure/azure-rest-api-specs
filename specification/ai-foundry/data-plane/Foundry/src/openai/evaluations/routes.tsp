import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias EvalQueryParameters = {
  /** The identifier of the last item from the previous page. Use this value to retrieve the next page. */
  @query
  after?: string;

  /** The maximum number of items to return. The default is 20. */
  @query
  limit?: integer = 20;

  /** The order in which to return items by timestamp. Use `asc` for ascending order or `desc` for descending order. The default is `asc`. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" ""
  @query
  order?: "asc" | "desc" = "asc";
};

alias RunListQueryParameters = {
  ...EvalQueryParameters;

  /** Filter evaluation runs by status. Accepted values are `queued`, `in_progress`, `completed`, `canceled`, and `failed`. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" ""
  @query
  status?: "queued" | "in_progress" | "completed" | "canceled" | "failed";
};

alias EvalListQueryParameters = {
  ...EvalQueryParameters;

  /**
   * The evaluation timestamp field used for ordering results. Use `created_at`
   * to order by creation time or `updated_at` to order by last modification
   * time. The default is `created_at`.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" ""
  @query(#{ explode: true })
  order_by?: "created_at" | "updated_at" = "created_at";
};

alias EvalRunOutputItemsQueryParameters = {
  ...EvalQueryParameters;

  /**
   * Filter output items by evaluation outcome. Use `fail` for items that did
   * not pass or `pass` for items that passed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" ""
  @query(#{ explode: true })
  status?: "fail" | "pass";
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("openai/v1/evals")
@tag("Evals")
interface Evals {
  /**
   * Returns a page of evaluations configured in the current project.
   * Use `after` and `limit` to page through the results, and use `order_by`
   * and `order` to control how the results are sorted.
   */
  @summary("List evaluations")
  @list
  listEvals is OpenAIOperation<
    {
      ...EvalListQueryParameters;
    },
    AgentsPagedResult<Eval>
  >;

  /**
   * Creates an evaluation configuration that defines the data source schema and
   * testing criteria used to measure model or agent performance.
   *
   * Creating an evaluation does not execute it. To process data with the
   * evaluation, create an evaluation run and provide a compatible data source.
   */
  @summary("Create an evaluation")
  @post
  createEval is OpenAIOperation<
    {
      ...CreateEvalRequest;
    },
    Eval
  >;

  /**
   * Deletes an evaluation and its associated data.
   *
   * This operation cannot be undone.
   */
  @summary("Delete an evaluation")
  @delete
  @route("{eval_id}")
  deleteEval is OpenAIOperation<
    {
      /** The identifier of the evaluation to delete. */
      @path
      eval_id: string;
    },
    DeleteEvalResponse
  >;

  /**
   * Retrieves an evaluation, including its data source configuration and
   * testing criteria.
   */
  @summary("Get an evaluation")
  @get
  @route("{eval_id}")
  getEval is OpenAIOperation<
    {
      /** The identifier of the evaluation to retrieve. */
      @path
      eval_id: string;
    },
    Eval
  >;

  /**
   * Updates the specified evaluation with the supplied properties.
   *
   * Properties omitted from the request remain unchanged.
   */
  @summary("Update an evaluation")
  @post
  @route("{eval_id}")
  updateEval is OpenAIOperation<
    {
      /** The identifier of the evaluation to update. */
      @path
      eval_id: string;

      ...UpdateEvalParametersBody;
    },
    Eval
  >;

  /**
   * Returns a page of runs for the specified evaluation.
   * Results can be filtered by run status and paged by using `after` and
   * `limit`.
   */
  @summary("List evaluation runs")
  @list
  @route("{eval_id}/runs")
  listRuns is OpenAIOperation<
    {
      /** The identifier of the evaluation whose runs to list. */
      @path eval_id: string;

      ...RunListQueryParameters;
    },
    AgentsPagedResult<EvalRun>
  >;

  /**
   * Creates a run of the specified evaluation against the provided data
   * source.
   *
   * Evaluation runs are processed asynchronously. Use the returned run
   * identifier to retrieve the run and monitor its status.
   */
  @summary("Create an evaluation run")
  @post
  @route("{eval_id}/runs")
  createEvalRun is OpenAIOperation<
    {
      /** The identifier of the evaluation to run. */
      @path
      eval_id: string;

      ...CreateEvalRunRequest;
    },
    EvalRun
  >;

  /**
   * Deletes an evaluation run and its associated results.
   *
   * This operation cannot be undone.
   */
  @summary("Delete an evaluation run")
  @delete
  @route("{eval_id}/runs/{run_id}")
  deleteEvalRun is OpenAIOperation<
    {
      /** The identifier of the evaluation that owns the run. */
      @path
      eval_id: string;

      /** The identifier of the run to delete. */
      @path
      run_id: string;
    },
    DeleteEvalRunResponse
  >;

  /**
   * Retrieves an evaluation run, including its current status and available
   * result summary.
   */
  @summary("Get an evaluation run")
  @get
  @route("{eval_id}/runs/{run_id}")
  getEvalRun is OpenAIOperation<
    {
      /** The identifier of the evaluation that owns the run. */
      @path
      eval_id: string;

      /** The identifier of the run to retrieve. */
      @path
      run_id: string;
    },
    EvalRun
  >;

  /**
   * Requests cancellation of an evaluation run that has not completed.
   * The returned run contains the latest status known to the service.
   */
  @summary("Cancel an evaluation run")
  @post
  @route("{eval_id}/runs/{run_id}")
  cancelEvalRun is OpenAIOperation<
    {
      /** The identifier of the evaluation that owns the run. */
      @path
      eval_id: string;

      /** The identifier of the run to cancel. */
      @path
      run_id: string;
    },
    EvalRun
  >;

  /**
   * Returns a page of output items produced by the specified evaluation run.
   * Each output item contains one evaluated input, its generated output when
   * applicable, and the results from each testing criterion.
   */
  @summary("List evaluation run output items")
  @list
  @route("{eval_id}/runs/{run_id}/output_items")
  getEvalRunOutputItems is OpenAIOperation<
    {
      /** The identifier of the evaluation that owns the run. */
      @path
      eval_id: string;

      /** The identifier of the run whose output items to list. */
      @path
      run_id: string;

      ...EvalRunOutputItemsQueryParameters;
    },
    AgentsPagedResult<EvalRunOutputItem>
  >;

  /**
   * Retrieves one output item produced by an evaluation run, including its
   * input, generated output when applicable, and testing-criterion results.
   */
  @summary("Get an output item of an evaluation run")
  @get
  @route("{eval_id}/runs/{run_id}/output_items/{output_item_id}")
  getEvalRunOutputItem is OpenAIOperation<
    {
      /** The identifier of the evaluation that owns the run. */
      @path
      eval_id: string;

      /** The identifier of the run that produced the output item. */
      @path
      run_id: string;

      /** The identifier of the output item to retrieve. */
      @path
      output_item_id: string;
    },
    EvalRunOutputItem
  >;
}
