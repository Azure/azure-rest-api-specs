import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Client.Agents;

/**
 * Creates a new thread. Threads contain messages and can be run by agents.
 *
 * @returns Information about the newly created thread.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@added(ServiceApiVersions.v2024_02_15_preview)
@route("/openai/threads")
op createThread is Azure.Core.RpcOperation<
  {
    /**
     * The details used to create a new agent thread.
     */
    ...AgentThreadCreationOptions
  },
  AgentThread
>;

// list threads?

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
@route("/openai/threads/{threadId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op getThread is Azure.Core.RpcOperation<
  {
    @path threadId: string
  },
  AgentThread
>;

/**
 * Modifies an existing thread.
 *
 * @param threadId The ID of the thread to modify.
 * @param updateAgentThreadOptions The details of the modification to perform on a specified thread.
 * @returns Information about the modified thread.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/openai/threads/{threadId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op updateThread is Azure.Core.RpcOperation<
  {
    /**
     * The details used to update an existing agent thread.
     */
    ...UpdateAgentThreadOptions
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
@added(ServiceApiVersions.v2024_02_15_preview)
op deleteThread is Azure.Core.RpcOperation<
  {
    @path threadId: string
  },
  ThreadDeletionStatus
>;
