namespace Microsoft.SaaS;

// NOTE: SubscriptionTerm removed — GA uses flat termStartDate/termEndDate on SaasResourceProperties.
// NOTE: PaymentChannelMetadata removed — paymentChannelType/Metadata dropped from GA model.
// NOTE: SaasResourceCspProperties, BeneficiaryOrganization, Participant, CspBeneficiary removed —
//       0 non-null usage in 18-month production data. Input-only pass-through to ACS, never stored.

/** Delete options for a SaaS resource. */
model DeleteOptions {
  /** Whether it is unsubscribe only. */
  unsubscribeOnly?: boolean;

  /** The reason code. */
  reasonCode?: int32;

  /** The feedback. */
  feedback?: string;

  /** The deletion source. */
  deletionSource?: DeletionSource = DeletionSource.CustomerCancellation;
}

/** The ISV access token result response. */
model AccessTokenResult {
  /** The Publisher Offer Base Uri. */
  publisherOfferBaseUri?: string;

  /** The generated token. */
  @secret
  token?: string;

  /** The offer URI with the embedded token. */
  @secret
  offerUriWithToken?: string;

  /** The token expiry time. */
  expiryTime?: utcDateTime;
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

/** Preflight validation result. */
model PreflightResult {
  /** The status of the preflight validation. */
  status: string;
}
