namespace Microsoft.ProfessionalService;

/** Delete options for a Professional Service resource. */
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

/** Check name availability request. */
model CheckNameAvailabilityRequest {
  /** Name to check availability for. */
  name?: string;

  /** Resource type. */
  type?: string;
}

/** Check name availability response. */
model CheckNameAvailabilityResponse {
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
  status: PreflightStatus;
}
