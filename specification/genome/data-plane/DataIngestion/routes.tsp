import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace Genome;

/**
 * Uploads customer data file.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom file upload operation with multipart form data"
#suppress "@azure-tools/typespec-azure-core/byos" "Direct file upload is required for this API"
@summary("Uploads customer data file.")
@route("/v1/dataingestions")
@post
op uploadCustomerData is Azure.Core.Foundations.Operation<
  {
    /**
     * Type of the upload. Value can be Delta or Full.
     */
    @query("uploadType")
    uploadType: UploadType;

    /**
     * The type of data in the file.
     */
    @query("dataType")
    dataType: UploadDataType;

    /** The file content to upload */
    @bodyRoot
    formFile?: bytes;
  },
  UploadResponse
>;

/**
 * Gets the status of an upload request.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom status retrieval operation"
@summary("Gets the status of an upload request.")
@route("/v1/dataingestions/{ingestionId}")
@get
op getUploadStatus is Azure.Core.Foundations.Operation<
  {
    /**
     * The ID of the ingestion request.
     */
    @path
    ingestionId: string;
  },
  UploadStatus
>;
