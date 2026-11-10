import "@typespec/http";

using TypeSpec.Http;

namespace Azure.AI.Projects;

/**
 * Optional, service-owned response header describing request-outcome attribution.
 * This header can accompany any HTTP status, including a successful HTTP response
 * whose semantic outcome is a failure. It does not change the response status or body.
 */
alias ErrorSourceResponseHeader = {
  /**
   * The request-outcome classification available before response headers are sent.
   * Known values include `customer`, `platform`, and `none`, but any string is valid.
   * A present, empty value means that no classification was available; it is distinct
   * from an absent header, which can occur when service-side emission is disabled.
   * Attribution determined after a streaming response or WebSocket upgrade has
   * committed its headers is not reflected in this value.
   */
  @header("x-ms-error-source")
  errorSource?: string;
};
