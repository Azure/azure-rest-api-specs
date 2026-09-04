#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Response identifies a JSON response body; Result is reserved for HTTP response envelopes."
namespace ContainerAppsSandbox {
  /** Represents a validated secret identifier. Must be 3-64 characters, containing only ASCII letters (upper/lower), digits, and hyphens. */
  scalar SecretId extends string;

  /** Secret keys response body. */
  model SecretKeysResponse {
    /** keys value. */
    keys: string[];
  }

  /** Secret list response body. */
  model SecretListResponse {
    /** secrets value. */
    secrets: Secret[];
  }

  /** Secret peek response body. */
  model SecretPeekResponse {
    /** values value. */
    values: Record<string>;
  }

  /** Request body for creating or updating a secret. */
  model CreateSecretContent {
    /** Sensitive secret values. */
    @secret
    values: Record<string>;
  }

  /** Customer-facing secret resource returned by the service. */
  model Secret {
    /** Secret identifier assigned by the service. */
    @visibility(Lifecycle.Read)
    id: SecretId;

    /** Creation timestamp assigned by the service. */
    @visibility(Lifecycle.Read)
    createdAt?: utcDateTime;

    /** Last-update timestamp assigned by the service. */
    @visibility(Lifecycle.Read)
    updatedAt?: utcDateTime;
  }
}
