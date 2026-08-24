namespace AzureDevCompute {
  /** Represents a validated secret identifier. Must be 3-64 characters, containing only ASCII letters (upper/lower), digits, and hyphens. */
  scalar SecretId extends string;

  /** SecretKeysResponse wire model. */
  model SecretKeysResponse {
    /** keys value. */
    keys: string[];
  }

  /** SecretListResponse wire model. */
  model SecretListResponse {
    /** secrets value. */
    secrets: SecretResponse[];
  }

  /** SecretPeekResponse wire model. */
  model SecretPeekResponse {
    /** values value. */
    values: Record<string>;
  }

  /** SecretResponse wire model. */
  model SecretResponse {
    /** id value. */
    id: SecretId;

    /** createdAt value. */
    createdAt?: utcDateTime;

    /** updatedAt value. */
    updatedAt?: utcDateTime;
  }

  /** SecretUpsertRequest wire model. */
  model SecretUpsertRequest {
    /** values value. */
    values: Record<string>;
  }
}
