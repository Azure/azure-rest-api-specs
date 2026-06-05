import "../common/models.tsp";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/common";
import "@azure-tools/openai-typespec/models/evals";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/evals")
@tag("Evals")
interface Evals {
  @list
  @get
  @summary("""
    List evaluations for a project.
    
    """)
  listEvals is OpenAIOperation<
    {
      /** Identifier for the last eval from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of evals to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for descending order. */
      @query(#{ explode: true })
      order?: OrderEnum = OrderEnum.asc;

      /**Evals can be ordered by creation time or last updated time. Use
  `created_at` for creation time or `updated_at` for last updated time.*/
      @query(#{ explode: true })
      order_by?: "created_at" | "updated_at" = "created_at";
    },
    EvalList
  >;

  @post
  @summary("""
    Create the structure of an evaluation that can be used to test a model's performance.
    An evaluation is a set of testing criteria and the config for a data source, which dictates the schema of the data used in the evaluation. After creating an evaluation, you can run it on different models and model parameters. We support several types of graders and datasources.
    For more information, see the [Evals guide](/docs/guides/evals).
    
    """)
  createEval is OpenAIOperation<
    {
      @body
      body: CreateEvalRequest;
    },
    {
      @statusCode
      statusCode: 201;

      @extension("x-stainless-const", true)
      object: "eval";

      id: string;
      name: string;

      @oneOf
      @changePropertyType(

          | CreateEvalCustomDataSourceConfig
          | CreateEvalLogsDataSourceConfig
          | CreateEvalStoredCompletionsDataSourceConfig
          | AzureAIDataSourceConfig
          | AzureAIBenchmarkDataSourceConfig
      )
      data_source_config:
        | CreateEvalCustomDataSourceConfig
        | CreateEvalLogsDataSourceConfig
        | CreateEvalStoredCompletionsDataSourceConfig
        | AzureAIDataSourceConfig
        | AzureAIBenchmarkDataSourceConfig;

      @changePropertyType(
        (
          | EvalGraderLabelModel
          | EvalGraderStringCheck
          | EvalGraderTextSimilarity
          | EvalGraderPython
          | EvalGraderScoreModel
          | TestingCriterionAzureAIEvaluator)[]
      )
      testing_criteria: (
        | EvalGraderLabelModel
        | EvalGraderStringCheck
        | EvalGraderTextSimilarity
        | EvalGraderPython
        | EvalGraderScoreModel
        | TestingCriterionAzureAIEvaluator)[];

      @encode(DateTimeKnownEncoding.unixTimestamp, integer)
      created_at: utcDateTime;

      metadata: Metadata | null;
    }
  >;

  @route("{eval_id}")
  @delete
  @summary("""
    Delete an evaluation.
    
    """)
  deleteEval is OpenAIOperation<
    {
      /** The ID of the evaluation to delete. */
      @path
      eval_id: string;
    },
    Body<{
      object: string;
      deleted: boolean;
      eval_id: string;
    }>
  >;

  @route("{eval_id}")
  @get
  @summary("""
    Get an evaluation by ID.
    
    """)
  getEval is OpenAIOperation<
    {
      /** The ID of the evaluation to retrieve. */
      @path
      eval_id: string;
    },
    Eval
  >;

  @route("{eval_id}")
  @post
  @summary("""
    Update certain properties of an evaluation.
    
    """)
  updateEval is OpenAIOperation<
    {
      /** The ID of the evaluation to update. */
      @path
      eval_id: string;

      /** Request to update an evaluation */
      @body
      body: UpdateEvalParametersBody;
    },
    Eval
  >;

  @list
  @route("{eval_id}/runs")
  @get
  @summary("""
    Get a list of runs for an evaluation.
    
    """)
  getEvalRuns is OpenAIOperation<
    {
      /** The ID of the evaluation to retrieve runs for. */
      @path
      eval_id: string;

      /** Identifier for the last run from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of runs to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
      @query(#{ explode: true })
      order?: OrderEnum = OrderEnum.asc;

      /** Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed` | `canceled`. */
      @query(#{ explode: true })
      status?: "queued" | "in_progress" | "completed" | "canceled" | "failed";
    },
    EvalRunList
  >;

  @route("{eval_id}/runs")
  @post
  @summary("""
    Kicks off a new run for a given evaluation, specifying the data source, and what model configuration to use to test. The datasource will be validated against the schema specified in the config of the evaluation.
    
    """)
  createEvalRun is OpenAIOperation<
    {
      /** The ID of the evaluation to create a run for. */
      @path
      eval_id: string;

      @body
      body: CreateEvalRunRequest;
    },
    {
      @statusCode
      statusCode: 201;

      @extension("x-stainless-const", true)
      object: "eval.run";

      id: string;
      eval_id: string;
      status: string;
      `model`: string;
      name: string;

      @encode(DateTimeKnownEncoding.unixTimestamp, integer)
      created_at: utcDateTime;

      report_url: url;
      result_counts: EvalRunResultCounts;
      per_model_usage: EvalRunPerModelUsage[];
      per_testing_criteria_results: EvalRunPerTestingCriteriaResults[];

      @oneOf
      @changePropertyType(

          | CreateEvalJsonlRunDataSource
          | CreateEvalCompletionsRunDataSource
          | CreateEvalResponsesRunDataSource
          | EvalRunDataSource
      )
      data_source:
        | CreateEvalJsonlRunDataSource
        | CreateEvalCompletionsRunDataSource
        | CreateEvalResponsesRunDataSource
        | EvalRunDataSource;

      metadata: Metadata | null;
      error: EvalApiError;
    }
  >;

  @route("{eval_id}/runs/{run_id}")
  @delete
  @summary("""
    Delete an eval run.
    
    """)
  deleteEvalRun is OpenAIOperation<
    {
      /** The ID of the evaluation to delete the run from. */
      @path
      eval_id: string;

      /** The ID of the run to delete. */
      @path
      run_id: string;
    },
    Body<{
      object?: string;
      deleted?: boolean;
      run_id?: string;
    }>
  >;

  @route("{eval_id}/runs/{run_id}")
  @get
  @summary("""
    Get an evaluation run by ID.
    
    """)
  getEvalRun is OpenAIOperation<
    {
      /** The ID of the evaluation to retrieve runs for. */
      @path
      eval_id: string;

      /** The ID of the run to retrieve. */
      @path
      run_id: string;
    },
    EvalRun
  >;

  @route("{eval_id}/runs/{run_id}")
  @post
  @summary("""
    Cancel an ongoing evaluation run.
    
    """)
  cancelEvalRun is OpenAIOperation<
    {
      /** The ID of the evaluation whose run you want to cancel. */
      @path
      eval_id: string;

      /** The ID of the run to cancel. */
      @path
      run_id: string;
    },
    EvalRun
  >;

  @list
  @route("{eval_id}/runs/{run_id}/output_items")
  @get
  @summary("""
    Get a list of output items for an evaluation run.
    
    """)
  getEvalRunOutputItems is OpenAIOperation<
    {
      /** The ID of the evaluation to retrieve runs for. */
      @path
      eval_id: string;

      /** The ID of the run to retrieve output items for. */
      @path
      run_id: string;

      /** Identifier for the last output item from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of output items to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /**Filter output items by status. Use `failed` to filter by failed output
  items or `pass` to filter by passed output items.*/
      @query(#{ explode: true })
      status?: "fail" | "pass";

      /** Sort order for output items by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
      @query(#{ explode: true })
      order?: OrderEnum = OrderEnum.asc;
    },
    EvalRunOutputItemList
  >;

  @route("{eval_id}/runs/{run_id}/output_items/{output_item_id}")
  @get
  @summary("""
    Get an evaluation run output item by ID.
    
    """)
  getEvalRunOutputItem is OpenAIOperation<
    {
      /** The ID of the evaluation to retrieve runs for. */
      @path
      eval_id: string;

      /** The ID of the run to retrieve. */
      @path
      run_id: string;

      /** The ID of the output item to retrieve. */
      @path
      output_item_id: string;
    },
    EvalRunOutputItem
  >;
}
