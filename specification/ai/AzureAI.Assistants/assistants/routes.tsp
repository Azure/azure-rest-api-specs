import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Assistants;

/**
 * Creates a new assistant.
 *
 * @returns The new assistant instance.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@added(ServiceApiVersions.v2024_02_15_preview)
@route("/openai/assistants")
op createAssistant is Azure.Core.RpcOperation<
  {
    ...CreateAssistantOptions
  },
  Assistant
>;

/**
 * Gets a list of assistants that were previously created.
 *
 * @returns The requested list of assistants.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@added(ServiceApiVersions.v2024_02_15_preview)
@route("/openai/assistants")
op listAssistants is Azure.Core.RpcOperation<
  {
    ...OpenAIListRequestOptions
  },
  OpenAIPageableListOf<Assistant>
>;

/**
 * Retrieves an existing assistant.
 *
 * @param assistantId The ID of the assistant to retrieve.
 * @returns The requested assistant instance.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/openai/assistants/{assistantId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op getAssistant is Azure.Core.RpcOperation<
  {
    @path assistantId: string
  },
  Assistant
>;

/**
 * Modifies an existing assistant.
 *
 * @param updateAssistantOptions The details of the modification to perform on a specified assistant.
 * @returns The updated assistant instance.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/openai/assistants/{assistantId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op updateAssistant is Azure.Core.RpcOperation<
  {
    /**
     * The request details to use when modifying an existing assistant.
     */
    ...UpdateAssistantOptions
  },
  Assistant
>;

/**
 * Deletes an assistant.
 *
 * @param assistantId The ID of the assistant to delete.
 * @returns Status information about the requested deletion operation.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@route("/openai/assistants/{assistantId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op deleteAssistant is Azure.Core.RpcOperation<
  {
    @path assistantId: string
  },
  AssistantDeletionStatus
>;