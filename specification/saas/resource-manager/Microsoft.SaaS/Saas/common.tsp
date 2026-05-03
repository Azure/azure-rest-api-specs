using TypeSpec.Rest;
using TypeSpec.Http;
namespace Microsoft.SaaS;

// NOTE: SubscriptionTerm removed — GA decapsulates to termStartDate/termEndDate on SaasResourceProperties.
// NOTE: PaymentChannelMetadata removed — paymentChannelType/Metadata dropped from GA model.
// NOTE: SaasResourceCspProperties, BeneficiaryOrganization, Participant, CspBeneficiary removed —
//       0 non-null usage in 18-month production data. Input-only pass-through to ACS, never stored.

/** Delete options for a SaaS resource. */
model DeleteOptions {
  /** Whether it is unsubscribe only. */
  unsubscribeOnly?: boolean;
  /** The reason code. */
  reasonCode?: float64;
  /** The feedback. */
  feedback?: string;
}

/** The ISV access token result response. */
model AccessTokenResult {
  /** The Publisher Offer Base Uri. */
  publisherOfferBaseUri?: string;
  /** The generated token. */
  @secret
  token?: string;
}

/** Resource Move Options. */
model MoveResource {
  /** The target resource group uri for the move. */
  targetResourceGroup?: string;
  /** The resource uris to move. */
  resources?: string[];
}

/** Check name availability request. */
model SaasNameAvailabilityRequest {
  /** Name to check availability for. */
  name?: string;
  /** Resource type. */
  type?: string;
}

/** Check name availability response. */
model SaasNameAvailabilityResponse {
  /** Whether the name is available. */
  nameAvailable?: boolean;
  /** Reason the name is not available. */
  reason?: string;
  /** Detailed message. */
  message?: string;
}

/** Eligibility check result with structured errors. */
model EligibilityCheckResult {
  /** Whether the subscription is eligible. */
  isEligible?: boolean;
  /** Structured list of eligibility errors. */
  errors?: EligibilityErrorDetail[];
}

/** A single eligibility error. */
model EligibilityErrorDetail {
  /** Machine-readable error code. */
  code?: string;
  /** Human-readable error description. */
  message?: string;
}

