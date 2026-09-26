import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

// ──── Shared enums ────

/** Specifies the sort order for list operations. */
union SortOrder {
  string,

  /** Ascending sort order. */
  asc: "asc",

  /** Descending sort order. */
  desc: "desc",
}

/** The object type for list responses. */
union ListObjectType {
  string,

  /** Indicates a list response. */
  list: "list",
}

// ──── Shared error model ────

/** Represents an error response returned by the service. */
@error
model ErrorResponse {
  /** The error details. */
  error?: ErrorResponseError;
}

/** Details of an error returned by the service. */
model ErrorResponseError {
  /** The error code. */
  code?: string;

  /** A human-readable error message. */
  message?: string;
}

// ──── Shared delete response ────

/** Response returned after a delete operation. */
model DeleteResponse {
  /** The identifier of the deleted resource. */
  id?: string;

  /** The object type of the deleted resource. */
  object?: string;

  /** Whether the resource was successfully deleted. */
  deleted?: boolean;
}
