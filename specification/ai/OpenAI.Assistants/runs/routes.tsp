import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";
import "../threads/models.tsp";
import "../runs/models.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

/**
 * Creates and starts a new run of the specified thread using the specified assistant.
 *
 * @param threadId The ID of the thread to run.
 * @param createRunOptions The details for the run to create.
 *
 * @returns Information about the new thread run.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/threads/{threadId}/runs")
@doc("Creates a new run for an assistant thread.")
@added(ServiceApiVersions.v2024_02_15_preview)
op createRun(
  @path threadId: string,

  /**
   * The details used when creating a new run of an assistant thread.
   */
  @bodyRoot body: CreateRunOptions,
): ThreadRun;

/**
 * Gets a list of runs for a specified thread.
 *
 * @param threadId The ID of the thread to list runs from.
 * @returns The requested list of thread runs.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/threads/{threadId}/runs")
@added(ServiceApiVersions.v2024_02_15_preview)
op listRuns(
  @path threadId: string,
  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<ThreadRun>;

/**
 * Gets an existing run from an existing thread.
 *
 * @param threadId The ID of the thread to retrieve run information from.
 * @param runId The ID of the thread to retrieve information about.
 * @returns The requested information about the specified thread run.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/threads/{threadId}/runs/{runId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op getRun(@path threadId: string, @path runId: string): ThreadRun;

/**
 * Modifies an existing thread run.
 *
 * @param threadId The ID of the thread associated with the specified run.
 * @param runId The ID of the run to modify.
 * @returns Information about the modified run.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/threads/{threadId}/runs/{runId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op updateRun(
  @path threadId: string,
  @path runId: string,
  ...OptionalNullableMetadata,
): ThreadRun;

/**
 * Submits outputs from tools as requested by tool calls in a run. Runs that need submitted tool outputs will have a status of 'requires_action' with a required_action.type of 'submit_tool_outputs'.
 *
 * @param threadId The ID of the thread that was run.
 * @param runId The ID of the run that requires tool outputs.
 * @param toolOutputs A list of tools for which the outputs are being submitted.
 * @param stream If `true`, returns a stream of events that happen during the Run as server-sent events, terminating when the Run enters a terminal state with a `data: [DONE]` message.
 * @returns Updated information about the run.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/threads/{threadId}/runs/{runId}/submit_tool_outputs")
@added(ServiceApiVersions.v2024_02_15_preview)
op submitToolOutputsToRun(
  @path threadId: string,
  @path runId: string,

  @encodedName("application/json", "tool_outputs")
  toolOutputs: ToolOutput[],

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  stream?: boolean | null,
): ThreadRun;

/**
 * Cancels a run of an in progress thread.
 *
 * @param threadId The ID of the thread being run.
 * @param runId The ID of the run to cancel.
 * @returns Updated information about the cancelled run.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/threads/{threadId}/runs/{runId}/cancel")
@added(ServiceApiVersions.v2024_02_15_preview)
op cancelRun(@path threadId: string, @path runId: string): ThreadRun;

/**
 * Creates a new thread and immediately starts a run of that thread.
 *
 * @returns Information about the newly created thread.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/threads/runs")
@doc("Creates a new assistant thread and immediately starts a run using that new thread.")
@added(ServiceApiVersions.v2024_02_15_preview)
op createThreadAndRun(
  /**
   * The details used when creating and immediately running a new assistant thread.
   */
  @bodyRoot
  body: CreateAndRunThreadOptions,
): ThreadRun;
