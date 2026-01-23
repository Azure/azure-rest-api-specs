import "@typespec/rest";
import "@azure-tools/openai-typespec/models/evals";

import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias EvalQueryParameters = {
  @query
  @doc("Identifier for the last run from the previous pagination request.")
  after?: string;

  @query
  @doc("Number of runs to retrieve.")
  limit?: integer = 20;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @query
  @doc("Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`.")
  order?: "asc" | "desc" = "asc";
};

alias RunListQueryParameters = {
  ...EvalQueryParameters;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @query
  @doc("Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed` | `canceled`.")
  status?: "queued" | "in_progress" | "completed" | "canceled" | "failed";
};

alias EvalListQueryParameters = {
  ...EvalQueryParameters;

  /**Evals can be ordered by creation time or last updated time. Use
`created_at` for creation time or `updated_at` for last updated time.*/
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  order_by?: "created_at" | "updated_at" = "created_at";
};

alias EvalRunOutputItemsQueryParameters = {
  ...EvalQueryParameters;

  /**Filter output items by status. Use `failed` to filter by failed output
items or `pass` to filter by passed output items.*/
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  status?: "fail" | "pass";
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("openai/v1/evals")
@tag("Evals")
interface OpenAIEvals {
  /** List evaluations for a project. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Auto-suppressed warnings non-applicable rules during import."
  @summary("List all evaluations")
  @list
  listEvals is OpenAIOperation<
    {
      ...EvalListQueryParameters;
    },
    AgentsPagedResult<Eval>
  >;

  /**Create the structure of an evaluation that can be used to test a model's performance.
An evaluation is a set of testing criteria and the config for a data source, which dictates the schema of the data used in the evaluation. After creating an evaluation, you can run it on different models and model parameters. We support several types of graders and datasources.
For more information, see the [Evals guide](https://platform.openai.com/docs/guides/evals).*/
  @summary("Create evaluation")
  @post
  createEval is OpenAIOperation<
    {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
      ...CreateEvalRequest;
    },
    Eval
  >;

  /** Delete an evaluation. */
  @summary("Delete an evaluation")
  @delete
  @route("{eval_id}")
  deleteEval is OpenAIOperation<
    {
      /** The ID of the evaluation to delete. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      eval_id: string;
    },
    DeleteEvalResponse
  >;

  /** Get an evaluation by ID. */
  @summary("Get an evaluation")
  @get
  @route("{eval_id}")
  getEval is OpenAIOperation<
    {
      /** The ID of the evaluation to retrieve. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      eval_id: string;
    },
    Eval
  >;

  /** Update certain properties of an evaluation. */
  @summary("Update an evaluation")
  @post
  @route("{eval_id}")
  updateEval is OpenAIOperation<
    {
      /** The ID of the evaluation to update. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      eval_id: string;

      ...UpdateEvalParametersBody;
    },
    Eval
  >;

  /** Get a list of runs for an evaluation. */
  @summary("Get a list of runs for an evaluation")
  @list
  @route("{eval_id}/runs")
  listRuns is OpenAIOperation<
    {
      /** The ID of the evaluation to retrieve runs for. */
      @path eval_id: string;

      ...RunListQueryParameters;
    },
    AgentsPagedResult<EvalRun>
  >;

  @summary("Create evaluation run")
  @post
  @route("{eval_id}/runs")
  createEvalRun is OpenAIOperation<
    {
      /** The ID of the evaluation to create a run for. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      eval_id: string;

      ...CreateEvalRunRequest;
    },
    EvalRun
  >;

  /** Delete an eval run. */
  @summary("Delete evaluation run")
  @delete
  @route("{eval_id}/runs/{run_id}")
  deleteEvalRun is OpenAIOperation<
    {
      /** The ID of the evaluation to delete the run from. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      eval_id: string;

      /** The ID of the run to delete. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      run_id: string;
    },
    DeleteEvalRunResponse
  >;

  /** Get an evaluation run by ID. */
  @summary("Get an evaluation run")
  @get
  @route("{eval_id}/runs/{run_id}")
  getEvalRun is OpenAIOperation<
    {
      /** The ID of the evaluation to retrieve runs for. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      eval_id: string;

      /** The ID of the run to retrieve. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      run_id: string;
    },
    EvalRun
  >;

  /** Cancel an ongoing evaluation run. */
  @summary("Cancel evaluation run")
  @post
  @route("{eval_id}/runs/{run_id}")
  cancelEvalRun is OpenAIOperation<
    {
      /** The ID of the evaluation whose run you want to cancel. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      eval_id: string;

      /** The ID of the run to cancel. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      run_id: string;
    },
    EvalRun
  >;

  /** Get a list of output items for an evaluation run. */
  @summary("Get evaluation run output items")
  @list
  @route("{eval_id}/runs/{run_id}/output_items")
  getEvalRunOutputItems is OpenAIOperation<
    {
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      eval_id: string;

      /** The ID of the run to retrieve output items for. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      run_id: string;

      ...EvalRunOutputItemsQueryParameters;
    },
    AgentsPagedResult<EvalRunOutputItem>
  >;

  /** Get an evaluation run output item by ID. */
  @summary("Get an output item of an evaluation run")
  @get
  @route("{eval_id}/runs/{run_id}/output_items/{output_item_id}")
  getEvalRunOutputItem is OpenAIOperation<
    {
      /** The ID of the evaluation to retrieve runs for. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      eval_id: string;

      /** The ID of the run to retrieve. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      run_id: string;

      /** The ID of the output item to retrieve. */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
      @path
      output_item_id: string;
    },
    EvalRunOutputItem
  >;
}
