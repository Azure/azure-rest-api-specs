import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "../common/models.tsp";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

/**
 * Creates a new assistant.
 *
 * @returns The new assistant instance.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/assistants")
op createAssistant(
  @doc("The request details to use when creating a new assistant.")
  @bodyRoot
  body: AssistantCreationOptions,
): Assistant;

/**
 * Gets a list of assistants that were previously created.
 *
 * @returns The requested list of assistants.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/assistants")
op listAssistants(...OpenAIListRequestOptions): OpenAIPageableListOf<Assistant>;

/**
 * Retrieves an existing assistant.
 *
 * @param assistantId The ID of the assistant to retrieve.
 * @returns The requested assistant instance.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/assistants/{assistantId}")
op getAssistant(@path assistantId: string): Assistant;

/**
 * Modifies an existing assistant.
 *
 * @param updateAssistantOptions The details of the modification to perform on a specified assistant.
 * @returns The updated assistant instance.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/assistants/{assistantId}")
op updateAssistant(
  @doc("The request details to use when modifying an existing assistant.")
  @bodyRoot
  body: UpdateAssistantOptions,
): Assistant;

/**
 * Deletes an assistant.
 *
 * @param assistantId The ID of the assistant to delete.
 * @returns Status information about the requested deletion operation.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@route("/assistants/{assistantId}")
op deleteAssistant(@path assistantId: string): AssistantDeletionStatus;
