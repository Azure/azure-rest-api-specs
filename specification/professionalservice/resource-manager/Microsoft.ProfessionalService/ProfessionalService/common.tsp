import "@typespec/http";

using TypeSpec.Http;

namespace Microsoft.ProfessionalService;

/**
 * Optional query parameter that opts the caller into customer data (PII) in the response.
 *
 * When `true`, the response includes customer-data fields such as `purchaserEmail`.
 * When `false` or omitted (the default), those fields are stripped from the response so that
 * downstream ARM components (e.g. ARG cache) do not store PII.
 */
model ExpandCustomerDataQueryParameter {
  /** When `true`, the response includes customer-data (PII) fields such as `purchaserEmail`. Defaults to `false`. */
  @query("$expandCustomerData")
  expandCustomerData?: boolean = false;
}

/** Unsubscribe options for a Professional Service resource. */
model UnsubscribeOptions {
  /** Whether it is unsubscribe only. */
  unsubscribeOnly?: boolean;

  /** The reason code. */
  reasonCode?: int32;

  /** The feedback. */
  feedback?: string;

  /** The deletion source. Defaults to CustomerCancellation if not specified. */
  deletionSource?: DeletionSource;
}
