import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects.Agents;

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
@route("/files")
op listFiles is Azure.Core.Foundations.Operation<
  {
    @doc("The purpose of the file.")
    @query
    purpose?: FilePurpose;
  },
  FileListResponse
>;

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
@route("/files")
op uploadFile is Azure.Core.Foundations.Operation<
  {
    @doc("The name of the file to upload.")
    @header
    contentType: "multipart/form-data";

    @doc("The file data, in bytes.")
    @clientName("Data", "csharp")
    file: bytes;

    @doc("The intended purpose of the uploaded file. Use `assistants` for Agents and Message files, `vision` for Agents image file inputs, `batch` for Batch API, and `fine-tune` for Fine-tuning.")
    purpose: FilePurpose;

    /*
     * Spec note: filename is not documented as a distinct option but functionally should be one. The value is encoded
     *            in the multipart Content-Disposition header for the data section and can be provided independently of
     *            any specific data source like a file. It can be inferred in some circumstances (as when using direct
     *            file input, like curl does) but should remain configurable when using a stream or other data source
     *            lacking an a priori name.
     */
    @doc("The name of the file.")
    filename?: string;
  },
  OpenAIFile
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@doc("Delete a previously uploaded file.")
@route("/files/{fileId}")
op deleteFile is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the file to delete.")
    @encodedName("application/json", "file_id")
    @path
    fileId: string;
  },
  FileDeletionStatus
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/files/{fileId}")
@doc("Returns information about a specific file. Does not retrieve file content.")
op getFile is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the file to retrieve.")
    @path
    @encodedName("application/json", "file_id")
    fileId: string;
  },
  OpenAIFile
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/files/{fileId}/content")
@doc("Retrieves the raw content of a specific file.")
op getFileContent is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the file to retrieve.")
    @path
    @encodedName("application/json", "file_id")
    fileId: string;
  },
  bytes
>;
