import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

@route("/files")
interface Files {
  /**
   * Gets a list of previously uploaded files.
   *
   * @param purpose A value that, when provided, limits list results to files matching the corresponding purpose.
   * @returns The requested list of files.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @get
  @added(ServiceApiVersions.v2023_11_06_beta)
  listFiles(@query purpose?: FilePurpose): FileListResponse;

  /**
   * Uploads a file for use by other operations.
   *
   * @param contentType The 'content-type' header value, always 'multipart/format-data' for this operation.
   * @param file The file data (not filename) to upload.
   * @param purpose The intended purpose of the file.
   * @param filename A filename to associate with the uploaded data.
   * @returns A representation of the uploaded file.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  #suppress "@azure-tools/typespec-azure-core/byos" "mirrored API"
  @post
  @added(ServiceApiVersions.v2023_11_06_beta)
  uploadFile(
    @header contentType: "multipart/form-data",
    @projectedName("csharp", "Data") file: bytes,
    purpose: FilePurpose,

    /*
     * Spec note: filename is not documented as a distinct option but functionally should be one. The value is encoded
     *            in the multipart Content-Disposition header for the data section and can be provided independently of
     *            any specific data source like a file. It can be inferred in some circumstances (as when using direct
     *            file input, like curl does) but should remain configurable when using a stream or other data source
     *            lacking an a priori name.
     */
    filename?: string,
  ): File;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @delete
  @doc("Delete a previously uploaded file.")
  @route("/{fileId}")
  deleteFile(
    @doc("The ID of the file to delete.")
    @projectedName("json", "file_id")
    @path
    fileId: string,
  ): FileDeletionStatus;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
  @get
  @route("/{fileId}")
  @doc("Returns information about a specific file. Does not retrieve file content.")
  retrieveFile(
    @doc("The ID of the file to retrieve.")
    @path
    @projectedName("json", "file_id")
    fileId: string,
  ): File;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
  @get
  @route("/{fileId}/content")
  @doc("Returns the contents of a specified file.")
  retrieveFileContent(
    @doc("The ID of the file to retrieve the contents of.")
    @path
    @projectedName("json", "file_id")
    fileId: string,
  ): bytes;
}
