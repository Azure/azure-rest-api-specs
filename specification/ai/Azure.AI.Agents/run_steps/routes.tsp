import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models.tsp";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

namespace Azure.AI.Agents {

  alias RunStepsTraits = SupportsClientRequestId &
    NoRepeatableRequests &
    NoConditionalRequests;

  alias RunStepsOperations = Azure.Core.ResourceOperations<RunStepsTraits>;

  /**
   * The override for path parameters
   * @param threadId The ID of the thread that was run.
   * @param runId The ID of the run to list steps from.
   */
  model IdPathParameter {
    @doc("Identifier of the thread.")
    @path("threadId")
    @segment("threads")
    threadId: string;

    @doc("Identifier of the run.")
    @segment("threads")
    @path("runId")
    runId: string;
  }

  /**
   * A collection of run‐step operations under
   * `/threads/{threadId}/runs/{runId}/steps`.
   */
  @route("/threads/{threadId}/runs/{runId}")
  interface RunSteps {
    /**
     * Retrieves a single run step from a thread run.
     *
     * @param threadId The ID of the thread that was run.
     * @param runId The ID of the specific run to retrieve the step from.
     * @param stepId The ID of the step to retrieve information about.
     * @param include A list of additional fields to include in the response.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
    @get
    @route("/steps/{stepId}")
    getRunStep is Azure.Core.Foundations.Operation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;

        @doc("Identifier of the run.")
        @path
        runId: string;

        @doc("Identifier of the run step.")
        @path
        stepId: string;

        @doc("""
          A list of additional fields to include in the response.
          Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.
          """)
        @query("include[]")
        include?: RunAdditionalFieldList[];
      },
      RunStep
    >;

    /**
     * Gets a list of run steps from a thread run.
     *
     * @param include A list of additional fields to include in the response.
     * @returns The requested list of run steps.
     */
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    listRunSteps is AgentThreadOperations.ResourceList<
      RunStep,
      ListQueryParametersTrait<{
        @doc("""
          A list of additional fields to include in the response.
          Currently the only supported value is `step_details.tool_calls[*].file_search.results[*].content` to fetch the file search result content.
          """)
        @query("include[]")
        include?: RunAdditionalFieldList[];

        ...OpenAIListRequestOptions;
      }> &
      TraitOverride<VersionParameterTrait<IdPathParameter>>
    >;
  }
}
