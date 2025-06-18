import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../common/models.tsp";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Foundations;

namespace Azure.AI.Agents {
  /**
   * A collection of message operations under `/threads/{threadId}/messages`.
   */
  @route("/threads/{threadId}/messages")
  @added(Versions.v2025_05_01)
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
    createMessage is AgentOperation<
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
     * @param threadId The ID of the thread to list messages from.
     * @returns The requested list of messages.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @get
    @list
    listMessages(
      @doc("Identifier of the thread.")
      @path
      threadId: string,

      /** Filter messages by the run ID that generated them. */
      @query("run_id")
      runId?: string,

      ...ApiVersionParameter,
      ...AgentsListOptions,
    ): {
      ...AgentsPagedResult<ThreadMessage>;
    };

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
    @route("/{messageId}")
    getMessage is AgentOperation<
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
    @route("/{messageId}")
    updateMessage is AgentOperation<
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
