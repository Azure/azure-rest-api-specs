import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../threads/models.tsp";
import "../runs/models.tsp";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Foundations;

namespace Azure.AI.Agents {
  /**
   * Creates a new thread and immediately starts a run of that thread.
   *
   * @returns Information about the newly created thread run.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @post
  @route("/threads/runs")
  @doc("Creates a new agent thread and immediately starts a run using that new thread.")
  @added(Versions.v2025_05_01)
  op createThreadAndRun is AgentOperation<
    {
      /**
       * The details used when creating and immediately running a new agent thread.
       */
      ...CreateAndRunThreadOptions;
    },
    ThreadRun
  >;

  /**
   * A collection of run operations under `/threads/{threadId}/runs`.
   */
  @route("/threads/{threadId}/runs")
  @added(Versions.v2025_05_01)
  interface Runs {
    /**
     * Creates and starts a new run of the specified thread using the specified agent.
     *
     * @param threadId The ID of the thread to run.
     * @param include   A list of additional fields to include in the response.
     * @param createRunOptions The details for the run to create.
     * @returns Information about the new thread run.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @doc("Creates a new run for an agent thread.")
    createRun is AgentOperation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;

        @doc("""
          A list of additional fields to include in the response.
          Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content`
          to fetch the file search result content.
          """)
        @query("include[]")
        include?: RunAdditionalFieldList[];

        /**
         * The details used when creating a new run of an agent thread.
         */
        ...CreateRunOptions;
      },
      ThreadRun
    >;

    /**
     * Gets a list of runs for a specified thread.
     *
     * @param threadId The ID of the thread to list runs from.
     * @returns The requested list of thread runs.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @get
    @list
    listRuns(
      @doc("Identifier of the thread.")
      @path
      threadId: string,

      ...ApiVersionParameter,
      ...AgentsListOptions,
    ): {
      ...AgentsPagedResult<ThreadRun>;
    } | AgentV1Error;

    /**
     * Gets an existing run from an existing thread.
     *
     * @param threadId The ID of the thread to retrieve run information from.
     * @param runId    The ID of the run to retrieve information about.
     * @returns The requested information about the specified thread run.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
    @get
    @route("/{runId}")
    getRun is AgentOperation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;

        @doc("Identifier of the run.")
        @path
        runId: string;
      },
      ThreadRun
    >;

    /**
     * Modifies an existing thread run.
     *
     * @param threadId The ID of the thread associated with the specified run.
     * @param runId    The ID of the run to modify.
     * @returns Information about the modified run.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @route("/{runId}")
    updateRun is AgentOperation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;

        @doc("Identifier of the run.")
        @path
        runId: string;

        ...OptionalNullableMetadata;
      },
      ThreadRun
    >;

    /**
     * Submits outputs from tools as requested by tool calls in a run.
     *
     * @param threadId   The ID of the thread that was run.
     * @param runId      The ID of the run that requires tool outputs.
     * @param toolOutputs A list of tools for which the outputs are being submitted.
     * @param stream     If `true`, returns a stream of SSE events until the run terminates.
     * @returns Updated information about the run.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @route("/{runId}/submit_tool_outputs")
    submitToolOutputsToRun is AgentOperation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;

        @doc("Identifier of the run.")
        @path
        runId: string;

        @doc("A list of tools for which the outputs are being submitted")
        @encodedName("application/json", "tool_outputs")
        @madeOptional(Versions.v2025_05_15_preview)
        toolOutputs?: ToolOutput[];

        @doc("A list of tool approvals allowing data to be sent to tools.")
        @encodedName("application/json", "tool_approvals")
        @added(Versions.v2025_05_15_preview)
        toolApprovals?: ToolApproval[];

        #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability"
        @doc("If true, returns a stream of events that happen during the Run as SSE, terminating at `[DONE]`.")
        stream?: boolean | null;
      },
      ThreadRun
    >;

    /**
     * Cancels a run of an in‐progress thread.
     *
     * @param threadId The ID of the thread being run.
     * @param runId    The ID of the run to cancel.
     * @returns Updated information about the cancelled run.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @route("/{runId}/cancel")
    cancelRun is AgentOperation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;

        @doc("Identifier of the run.")
        @path
        runId: string;
      },
      ThreadRun
    >;
  }
}
