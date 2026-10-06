using Rest;

namespace ContainerAppsSandbox {
  /** Represents a validated secret identifier. Must be 3-64 characters, containing only ASCII letters (upper/lower), digits, and hyphens. */
  scalar SecretId extends string;

  /** Keys stored in a secret. */
  model SecretKeysResponse {
    /** The key names stored in the secret. */
    keys: string[];
  }

  /** Selected values from a secret. */
  model SecretPeekResponse {
    /** The sensitive key-value pairs stored in the secret. */
    @secret
    values: Record<string>;
  }

  /** Request body for creating or updating a secret. */
  model CreateSecretContent {
    /** Sensitive secret values. */
    @secret
    values: Record<string>;
  }

  /** Customer-facing secret resource returned by the service. */
  @resource("secrets")
  @parentResource(SandboxGroupScope)
  model Secret {
    /** Secret identifier assigned by the service. */
    @key("secretId")
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
