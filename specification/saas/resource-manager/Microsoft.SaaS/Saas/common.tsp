namespace Microsoft.SaaS;

// NOTE: SubscriptionTerm removed — GA uses flat termStartDate/termEndDate on SaasResourceProperties.
// NOTE: PaymentChannelMetadata removed — paymentChannelType/Metadata dropped from GA model.
// NOTE: SaasResourceCspProperties, BeneficiaryOrganization, Participant, CspBeneficiary removed —
//       0 non-null usage in 18-month production data. Input-only pass-through to ACS, never stored.

/** Unsubscribe options for a SaaS resource. */
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
