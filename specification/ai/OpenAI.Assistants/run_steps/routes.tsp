import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

/**
 * Gets a single run step from a thread run.
 *
 * @param threadId The ID of the thread that was run.
 * @param runId The ID of the specific run to retrieve the step from.
 * @param stepId The ID of the step to retrieve information about.
 * @returns Information about the requested run step.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/threads/{threadId}/runs/{runId}/steps/{stepId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op getRunStep(
  @path threadId: string,
  @path runId: string,
  @path stepId: string,
): RunStep;

/**
 * Gets a list of run steps from a thread run.
 *
 * @param threadId The ID of the thread that was run.
 * @param runId The ID of the run to list steps from.
 * @returns The requested list of run steps.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/threads/{threadId}/runs/{runId}/steps")
@added(ServiceApiVersions.v2024_02_15_preview)
op listRunSteps(
  @path threadId: string,
  @path runId: string,
  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<RunStep>;
