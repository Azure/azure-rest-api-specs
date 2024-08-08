import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;

namespace Azure.AI.OpenAI.Assistants;

/**
 * Creates a new message on a specified thread.
 *
 * @param threadId The ID of the thread to create the new message on.
 * @param role The role to associate with the new message.
 * @param content The textual content for the new message.
 * @param fileIds A list of up to 10 file IDs to associate with the message, as used by tools like 'code_interpreter' or 'retrieval' that can read files.
 * @returns A representation of the new message.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/threads/{threadId}/messages")
@added(ServiceApiVersions.v2024_02_15_preview)
op createMessage(
  @path threadId: string,
  role: MessageRole,
  content: string,
  @encodedName("application/json", "file_ids") fileIds?: string[],
  ...OptionalNullableMetadata,
): ThreadMessage;

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
@route("/threads/{threadId}/messages")
@added(ServiceApiVersions.v2024_02_15_preview)
op listMessages(
  @path threadId: string,
  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<ThreadMessage>;

/**
 * Gets an existing message from an existing thread.
 *
 * @param threadId The ID of the thread to retrieve the specified message from.
 * @param messageId The ID of the message to retrieve from the specified thread.
 * @returns A representation of the requested message.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/threads/{threadId}/messages/{messageId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op getMessage(@path threadId: string, @path messageId: string): ThreadMessage;

/**
 * Modifies an existing message on an existing thread.
 *
 * @param threadId The ID of the thread containing the specified message to modify.
 * @param messageId The ID of the message to modify on the specified thread.
 * @returns A representation of the modified message.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/threads/{threadId}/messages/{messageId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op updateMessage(
  @path threadId: string,
  @path messageId: string,
  ...OptionalNullableMetadata,
): ThreadMessage;

/**
 * Gets a list of previously uploaded files associated with a message from a thread.
 *
 * @param threadId The ID of the thread containing the message to list files from.
 * @param messageId The ID of the message to list files from.
 * @returns The requested list of files associated with the specified message.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/threads/{threadId}/messages/{messageId}/files")
@added(ServiceApiVersions.v2024_02_15_preview)
op listMessageFiles(
  @path threadId: string,
  @path messageId: string,
  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<MessageFile>;

/**
 * Gets information about a file attachment to a message within a thread.
 *
 * @param threadId The ID of the thread containing the message to get information from.
 * @param messageId The ID of the message to get information from.
 * @param fileId The ID of the file to get information about.
 * @returns The requested file information.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/threads/{threadId}/messages/{messageId}/files/{fileId}")
@added(ServiceApiVersions.v2024_02_15_preview)
op getMessageFile(
  @path threadId: string,
  @path messageId: string,
  @path fileId: string,
): MessageFile;
