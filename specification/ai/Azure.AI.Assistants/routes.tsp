import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

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
@route("/assistants")
op createAssistant is Azure.Core.Foundations.Operation<
  {
    ...CreateAssistantOptions;
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
@route("/assistants")
op listAssistants is Azure.Core.Foundations.Operation<
  {
    ...OpenAIListRequestOptions;
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
@route("/assistants/{assistantId}")
op getAssistant is Azure.Core.Foundations.Operation<
  {
    /**
     * The request details to use when retrieving an assistant.
     */
    ...GetAssistantOptions;
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
@route("/assistants/{assistantId}")
op updateAssistant is Azure.Core.Foundations.Operation<
  {
    /**
     * The request details to use when modifying an existing assistant.
     */
    ...UpdateAssistantOptions;
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
@route("/assistants/{assistantId}")
op deleteAssistant is Azure.Core.Foundations.Operation<
  {
    /**
     * The request details to use when deleting an assistant.
     */
    ...DeleteAssistantOptions;
  },
  AssistantDeletionStatus
>;
