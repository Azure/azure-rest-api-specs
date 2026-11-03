import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Agents {
  /**
   * A collection of file‐related operations under `/files`.
   */
  @route("/files")
  @added(Versions.v2025_05_01)
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
    listFiles is AgentOperation<
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
     * @param contentType The 'content-type' header value, always 'multipart/form-data' for this operation.
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
    uploadFile is AgentOperation<
      {
        @doc("The name of the file to upload.")
        @header
        contentType: "multipart/form-data";

        /** Multipart body */
        @multipartBody body: {
          @doc("The file data, in bytes.")
          @clientName("Data", "csharp")
          file: HttpPart<bytes>;

          @doc("The intended purpose of the uploaded file. Use `assistants` for Agents and Message files, `vision` for Agents image file inputs, `batch` for Batch API, and `fine-tune` for Fine-tuning.")
          purpose: HttpPart<FilePurpose>;

          /*
           * Spec note: filename is not documented as a distinct option but functionally should be one. The value is encoded
           *            in the multipart Content-Disposition header for the data section and can be provided independently of
           *            any specific data source like a file. It can be inferred in some circumstances (as when using direct
           *            file input, like curl does) but should remain configurable when using a stream or other data source
           *            lacking an a priori name.
           */
          @doc("The name of the file.")
          filename?: HttpPart<string>;
        };
      },
      FileInfo
    >;

    /**
     * Deletes a previously uploaded file.
     *
     * @param fileId The ID of the file to delete.
     * @returns Status of the deletion operation.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @delete
    @doc("Delete a previously uploaded file.")
    @route("/{fileId}")
    deleteFile is AgentOperation<
      {
        @doc("The ID of the file to delete.")
        @encodedName("application/json", "file_id")
        @path
        fileId: string;
      },
      FileDeletionStatus
    >;

    /**
     * Returns information about a specific file.
     * Does not retrieve the file content.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
    @get
    @route("/{fileId}")
    @doc("Returns information about a specific file. Does not retrieve file content.")
    getFile is AgentOperation<
      {
        @doc("The ID of the file to retrieve.")
        @path
        @encodedName("application/json", "file_id")
        fileId: string;
      },
      FileInfo
    >;

    /**
     * Retrieves the raw content of a specific file.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @get
    @route("/{fileId}/content")
    @doc("Retrieves the raw content of a specific file.")
    getFileContent is AgentOperation<
      {
        @doc("The ID of the file to retrieve.")
        @path
        @encodedName("application/json", "file_id")
        fileId: string;
      },
      bytes
    >;
  }
}
