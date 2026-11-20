import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ProfessionalService;

/**
 * Optional query parameter that opts the caller into customer data (PII) in the response.
 *
 * When `true`, the response includes customer-data fields such as `purchaserEmail`.
 * When `false` or omitted (the default), those fields are stripped from the response so that
 * downstream Azure Resource Manager components (such as Azure Resource Graph) do not store PII.
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

/**
 * Campaign attribution metadata supplied when creating a new subscription-level resource.
 * Accepted only on create and purchase validation; never returned in responses or accepted on update.
 */
model CampaignMetadata {
  /** The referral source that brought the customer (for example, azure-marketplace or contoso-newsletter). */
  source?: string;

  /** The marketing medium (for example, cpc, banner, or email). */
  medium?: string;

  /** The marketing campaign name or identifier. */
  campaign?: string;

  /** The paid search term associated with the campaign. */
  term?: string;

  /** The campaign content identifier used to differentiate links or placements. */
  content?: string;

  /** The Microsoft campaign tracking identifier. */
  ocid?: string;

  /** The legacy Microsoft 365 marketing campaign identifier. */
  mktcmpid?: string;

  /** The legacy Microsoft 365 referral source identifier. */
  src?: string;
}

/** A machine-readable error code and human-readable message describing a validation failure. */
model ResourceValidationError {
  /** Machine-readable validation error code. */
  code: string;

  /** Human-readable description of the validation failure. */
  message: string;
}

/** The result of validating a proposed purchase or resource update without modifying state. */
model ResourceValidationResult {
  /** Indicates whether the proposed purchase or update passed validation. */
  isValid: boolean;

  /** The list of validation failures. Empty when `isValid` is `true`. */
  @identifiers(#[])
  details: ResourceValidationError[];
}
