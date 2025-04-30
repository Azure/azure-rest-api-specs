import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

namespace Azure.AI.Agents {

  alias MessagesTraits = SupportsClientRequestId &
    NoRepeatableRequests &
    NoConditionalRequests;

  alias MessagesOperations = Azure.Core.ResourceOperations<MessagesTraits>;
  
  /**
   * The override for path parameters
   * @param threadId The ID of the thread that was run.
   */
  model MsgIdPathParameter {
    @doc("Identifier of the thread.")
    @segment("threads")
    @path("threadId")
    threadId: string;
  }

  /**
   * A collection of message operations under `/threads/{threadId}/messages`.
   */
  @route("/threads/{threadId}/messages")
  interface Messages {
    /**
     * Creates a new message on a specified thread.
     *
     * @param threadId The ID of the thread to create the new message on.
     * @returns A representation of the new message.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @route("/messages")
    createMessage is Azure.Core.Foundations.Operation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;

        /** A single message within an agent thread, as provided during that thread's creation for its initial state. */
        ...ThreadMessageOptions;
      },
      ThreadMessage
    >;

    /**
     * Gets a list of messages that exist on a thread.
     *
     * @returns The requested list of messages.
     */
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    listMessages is MessagesOperations.ResourceList<
      ThreadMessage,
      ListQueryParametersTrait<{
        /** Filter messages by the run ID that generated them. */
        @query("run_id")
        runId?: string;

        ...OpenAIListRequestOptions;
      }> &
      TraitOverride<VersionParameterTrait<MsgIdPathParameter>>
    >;

    /**
     * Retrieves an existing message.
     *
     * @param threadId The ID of the thread to retrieve the specified message from.
     * @param messageId The ID of the message to retrieve.
     * @returns A representation of the requested message.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "not standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
    @get
    @route("/messages/{messageId}")
    getMessage is Azure.Core.Foundations.Operation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;

        @doc("Identifier of the message.")
        @path
        messageId: string;
      },
      ThreadMessage
    >;

    /**
     * Modifies an existing message on an existing thread.
     *
     * @param threadId The ID of the thread containing the message to modify.
     * @param messageId The ID of the message to modify.
     * @returns A representation of the modified message.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "not standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @route("/messages/{messageId}")
    updateMessage is Azure.Core.Foundations.Operation<
      {
        @doc("Identifier of the thread.")
        @path
        threadId: string;

        @doc("Identifier of the message.")
        @path
        messageId: string;

        ...OptionalNullableMetadata;
      },
      ThreadMessage
    >;
  }
}
