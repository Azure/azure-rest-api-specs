import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace AzureOpenAI;

@error
model AzureErrorResponse {
  /** A request ID used for troubleshooting purposes. */
  @header `apim-request-id`?: string;

  /** The error details. */
  error?: {
    /** The distinct, machine-generated identifier for the error. */
    code?: string;

    /** A human-readable message associated with the error. */
    message?: string;

    /** If applicable, the request input parameter associated with the error */
    param?: string;

    /** The object type, always 'error.' */
    type?: "error";

    inner_error?: unknown;
  };
}
