import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

/**
 * Creates a new thread. Threads contain messages and can be run by assistants.
 *
 * @returns Information about the newly created thread.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@added(ServiceApiVersions.v2024_02_15_preview)
@route("/threads")
op createThread(
  /**
   * The details used to create a new assistant thread.
   */
  @bodyRoot
  body: AssistantThreadCreationOptions,
): AssistantThread;

// list threads?

/**
 * Gets information about an existing thread.
 *
 * @param threadId The ID of the thread to retrieve information about.
 * @returns Information about the requested thread.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/threads/{threadId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op getThread(@path threadId: string): AssistantThread;

/**
 * Modifies an existing thread.
 *
 * @param threadId The ID of the thread to modify.
 * @param updateAssistantThreadOptions The details of the modification to perform on a specified thread.
 * @returns Information about the modified thread.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/threads/{threadId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op updateThread(
  /**
   * The details used to update an existing assistant thread.
   */
  @bodyRoot
  body: UpdateAssistantThreadOptions,
): AssistantThread;

/**
 * Deletes an existing thread.
 *
 * @param threadId The ID of the thread to delete.
 * @returns Status information about the requested thread deletion operation.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@route("/threads/{threadId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op deleteThread(@path threadId: string): ThreadDeletionStatus;
