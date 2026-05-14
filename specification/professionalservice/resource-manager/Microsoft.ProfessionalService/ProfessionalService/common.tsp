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

/** Preflight validation result. */
model PreflightResult {
  /** The status of the preflight validation. */
  status: PreflightStatus;
}
