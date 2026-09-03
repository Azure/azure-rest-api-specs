namespace ContainerAppsSandbox {
  /** Represents a validated secret identifier. Must be 3-64 characters, containing only ASCII letters (upper/lower), digits, and hyphens. */
  scalar SecretId extends string;

  /** SecretKeysResult wire model. */
  model SecretKeysResult {
    /** keys value. */
    keys: string[];
  }

  /** SecretListResult wire model. */
  model SecretListResult {
    /** secrets value. */
    secrets: Secret[];
  }

  /** SecretPeekResult wire model. */
  model SecretPeekResult {
    /** values value. */
    values: Record<string>;
  }

  /** Secret wire model. */
  model Secret {
    /** id value. */
    id: SecretId;

    /** createdAt value. */
    createdAt?: utcDateTime;

    /** updatedAt value. */
    updatedAt?: utcDateTime;
  }

  /** SecretUpsertContent wire model. */
  model SecretUpsertContent {
    /** values value. */
    values: Record<string>;
  }
}
