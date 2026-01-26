import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Http;

namespace Genome;

/**
 * Upload endpoint that supports both internal and external uploads based on
 * UploadType.
 *
 * For External uploads:
 * - PUT /v1/documents with form body containing:
 *   - UploadType: External (mandatory)
 *   - CaseId: Case identifier (mandatory)
 *   - SupplierId: Supplier identifier (mandatory)
 *   - DocumentCategory: List of document categories (mandatory)
 *   - Files: Documents to upload (mandatory)
 *
 * For Internal uploads:
 * - PUT /v1/documents with form body containing:
 *   - UploadType: Internal (mandatory)
 *   - CaseId: Case identifier (mandatory)
 *   - SupplierId: Supplier identifier (mandatory)
 *   - DocumentCategory: List of document categories (mandatory)
 *   - Files: Documents to upload (mandatory)
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom document upload operation with multipart form data for internal and external workflows"
@summary("Upload documents")
@route("/v1/documents")
@post
op uploadDocuments is Azure.Core.Foundations.Operation<
  UploadDocumentsRequest,
  UploadResponse
>;
