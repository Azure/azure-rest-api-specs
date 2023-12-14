import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

@route("/assistants")
interface Assistants {
  /**
   * Creates a new assistant.
   *
   * @returns The new assistant instance.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @post
  @added(ServiceApiVersions.v2023_11_06_beta)
  createAssistant(...AssistantCreationOptions): Assistant;

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
  @added(ServiceApiVersions.v2023_11_06_beta)
  listAssistants(...OpenAIListRequestOptions): OpenAIPageableListOf<Assistant>;

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
  @route("{assistantId}")
  @added(ServiceApiVersions.v2023_11_06_beta)
  retrieveAssistant(@path assistantId: string): Assistant;

  /**
   * Modifies an existing assistant.
   *
   * @param assistantId The ID of the assistant to modify.
   * @param modificationOptions The details of the modification to perform on the specified assistant.
   * @returns The updated assistant instance.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @post
  @route("{assistantId}")
  @added(ServiceApiVersions.v2023_11_06_beta)
  modifyAssistant(
    @path assistantId: string,
    @body modificationOptions: AssistantModificationOptions,
  ): Assistant;

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
  @route("{assistantId}")
  @added(ServiceApiVersions.v2023_11_06_beta)
  deleteAssistant(@path assistantId: string): AssistantDeletionStatus;

  /**
   * Attaches a previously uploaded file to an assistant for use by tools that can read files.
   *
   * @param assistantId The ID of the assistant to attach the file to.
   * @param fileId The ID of the previously uploaded file to attach.
   * @returns Information about the attached file.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @post
  @route("{assistantId}/files")
  @added(ServiceApiVersions.v2023_11_06_beta)
  createAssistantFile(
    @path assistantId: string,
    @projectedName("json", "file_id") fileId: string,
  ): AssistantFile;

  /**
   * Gets a list of files attached to a specific assistant, as used by tools that can read files.
   *
   * @param assistantId The ID of the assistant to retrieve the list of attached files for.
   * @returns The requested list of files attached to the specified assistant.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @get
  @route("{assistantId}/files")
  @added(ServiceApiVersions.v2023_11_06_beta)
  listAssistantFiles(
    @path assistantId: string,
    ...OpenAIListRequestOptions,
  ): OpenAIPageableListOf<AssistantFile>;

  /**
   * Retrieves a file attached to an assistant.
   *
   * @param assistantId The ID of the assistant associated with the attached file.
   * @param fileId The ID of the file to retrieve.
   * @returns A representation of the attached file.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
  @get
  @route("{assistantId}/files/{fileId}")
  @added(ServiceApiVersions.v2023_11_06_beta)
  retrieveAssistantFile(
    @path assistantId: string,
    @path fileId: string,
  ): AssistantFile;

  /**
   * Unlinks a previously attached file from an assistant, rendering it unavailable for use by tools that can read
   * files.
   *
   * @param assistantId The ID of the assistant from which the specified file should be unlinked.
   * @param fileId The ID of the file to unlink from the specified assistant.
   * @returns Status information about the requested file association deletion.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @delete
  @route("{assistantId}/files/{fileId}")
  @added(ServiceApiVersions.v2023_11_06_beta)
  deleteAssistantFile(
    @path assistantId: string,
    @path fileId: string,
  ): AssistantFileDeletionStatus;
}
