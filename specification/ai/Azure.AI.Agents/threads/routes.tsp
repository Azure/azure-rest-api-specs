import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core.Traits;

namespace Azure.AI.Agents {

  alias AgentThreadTraits = SupportsClientRequestId &
    NoRepeatableRequests &
    NoConditionalRequests;

  alias AgentThreadOperations = Azure.Core.ResourceOperations<AgentThreadTraits>;

  /**
   * A collection of thread operations under `/threads`.
   */
  interface Threads {
    /**
     * Creates a new thread. Threads contain messages and can be run by agents.
     *
     * @returns Information about the newly created thread.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @route("/threads")
    createThread is Azure.Core.Foundations.Operation<
      {
        /**
         * The details used to create a new agent thread.
         */
        ...AgentThreadCreationOptions;
      },
      AgentThread
    >;

    /**
     * Gets a list of threads that were previously created.
     *
     * @returns The requested list of threads.
     */
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    listThreads is AgentThreadOperations.ResourceList<
      AgentThread,
      ListQueryParametersTrait<{
        ...OpenAIListRequestOptions;
      }>
    >;

    /**
     * Gets information about an existing thread.
     *
     * @param threadId The ID of the thread to retrieve information about.
     * @returns Information about the requested thread.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
    @get
    @route("/threads/{threadId}")
    getThread is Azure.Core.Foundations.Operation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;
      },
      AgentThread
    >;

    /**
     * Modifies an existing thread.
     *
     * @param threadId The ID of the thread to modify.
     * @returns Information about the modified thread.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @route("/threads/{threadId}")
    updateThread is Azure.Core.Foundations.Operation<
      {
        /**
         * The details used to update an existing agent thread.
         */
        ...UpdateAgentThreadOptions;
      },
      AgentThread
    >;

    /**
     * Deletes an existing thread.
     *
     * @param threadId The ID of the thread to delete.
     * @returns Status information about the requested thread deletion operation.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @delete
    @route("/threads/{threadId}")
    deleteThread is Azure.Core.Foundations.Operation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;
      },
      ThreadDeletionStatus
    >;
  }
}
