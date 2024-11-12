import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.AI.OpenAI.Assistants;

/**
 * Gets a list of previously uploaded files.
 *
 * @param purpose A value that, when provided, limits list results to files matching the corresponding purpose.
 * @returns The requested list of files.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@added(ServiceApiVersions.v2024_02_15_preview)
@route("/files")
op listFiles(@query purpose?: FilePurpose): FileListResponse;

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
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/byos" "mirrored API"
@post
@added(ServiceApiVersions.v2024_02_15_preview)
@route("/files")
op uploadFile(
  @header contentType: "multipart/form-data",
  @clientName("Data", "csharp") file: bytes,
  purpose: FilePurpose,

  /*
   * Spec note: filename is not documented as a distinct option but functionally should be one. The value is encoded
   *            in the multipart Content-Disposition header for the data section and can be provided independently of
   *            any specific data source like a file. It can be inferred in some circumstances (as when using direct
   *            file input, like curl does) but should remain configurable when using a stream or other data source
   *            lacking an a priori name.
   */
  filename?: string,
): OpenAIFile;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@doc("Delete a previously uploaded file.")
@route("/files/{fileId}")
op deleteFile(
  @doc("The ID of the file to delete.")
  @encodedName("application/json", "file_id")
  @path
  fileId: string,
): FileDeletionStatus;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/files/{fileId}")
@doc("Returns information about a specific file. Does not retrieve file content.")
op getFile(
  @doc("The ID of the file to retrieve.")
  @path
  @encodedName("application/json", "file_id")
  fileId: string,
): OpenAIFile;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/files/{fileId}/content")
@doc("Returns information about a specific file. Does not retrieve file content.")
op getFileContent(
  @doc("The ID of the file to retrieve.")
  @path
  @encodedName("application/json", "file_id")
  fileId: string,
): bytes;
