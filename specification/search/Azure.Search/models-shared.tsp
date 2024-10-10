import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace SearchClient;

alias matchingHeader = {
  @doc("Defines the If-Match condition. The operation will be performed only if the ETag on the server matches this value.")
  @header("If-Match")
  ifMatch?: string;

  @doc("Defines the If-None-Match condition. The operation will be performed only if the ETag on the server does not match this value.")
  @header("If-None-Match")
  ifNoneMatch?: string;
};

alias clientRequestIdHeader = {
  @doc("The tracking ID sent with the request to help with debugging.")
  @header("x-ms-client-request-id")
  xMsClientRequestId?: string;
};

alias preferHeader = {
  @doc("For HTTP PUT requests, instructs the service to return the created/updated resource on success.")
  @header("Prefer")
  prefer: "return=representation";
};

alias indexNameParameter = {
  @doc("The name of the index.")
  @path
  indexName: string;
};

alias indexerNameParameter = {
  @doc("The name of the indexer.")
  @path
  indexerName: string;
};

/**
 * Common error response for all Azure Resource Manager APIs to return error
 * details for failed operations. (This also follows the OData error response
 * format.).
 */
@error
model ErrorResponse {
  /**
   * The error object.
   */
  error?: ErrorDetail;
}

/**
 * The error detail.
 */
model ErrorDetail {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error target.
   */
  @visibility("read")
  target?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: ErrorDetail[];

  /**
   * The error additional info.
   */
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility("read")
  type?: string;

  /**
   * The additional info.
   */
  @visibility("read")
  info?: Record<string>;
}
