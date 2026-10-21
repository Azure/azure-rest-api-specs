using Rest;
using Versioning;

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
    @typeChangedFrom(ApiVersions.v2026_10_01_preview, Record<string>)
    values: Record<SecretValue>;
  }

  /** Request body for creating or updating a secret. */
  model CreateSecretContent {
    /** Sensitive secret values. */
    @secret
    @typeChangedFrom(ApiVersions.v2026_10_01_preview, Record<string>)
    values: Record<SecretValueInput>;

    /** Shared Key Vault source. Required when any value references a Key Vault secret and must be absent for inline-only values. At most 80 references are allowed, with distinct secret names ignoring case. */
    @added(ApiVersions.v2026_10_01_preview)
    valueReferenceSource?: SecretValueReferenceSource;
  }

  /** A secret value containing exactly one of value or secretName. A plain string is also accepted as shorthand for an inline value. The values dictionary must contain at least one entry. */
  @added(ApiVersions.v2026_10_01_preview)
  model SecretValueInput {
    /** An inline secret value. Must be absent when secretName is provided. */
    @secret
    value?: string;

    /** The Key Vault secret name. Must be absent when value is provided. */
    @minLength(1)
    @maxLength(127)
    @pattern("^[a-zA-Z0-9-]+$")
    secretName?: string;

    /** The requested Key Vault secret version. Allowed only with secretName; omit to use the latest version. */
    @minLength(1)
    @maxLength(127)
    @pattern("^[a-zA-Z0-9-]+$")
    secretVersion?: string;
  }

  /** A stored secret definition returned by peek. Inline values contain value; Key Vault references contain reference metadata instead of the resolved secret value. */
  @added(ApiVersions.v2026_10_01_preview)
  model SecretValue {
    /** The sensitive inline value, omitted for a Key Vault reference. */
    @secret
    value?: string;

    /** The referenced Key Vault secret name. */
    secretName?: string;

    /** The requested Key Vault secret version, if pinned. */
    secretVersion?: string;

    /** The actual Key Vault secret version used during resolution. */
    secretActualVersion?: string;
  }

  /** Shared Key Vault configuration for referenced secret values. */
  @added(ApiVersions.v2026_10_01_preview)
  model SecretValueReferenceSource {
    /** An HTTPS Azure Key Vault base URL without credentials, path, query, or fragment. Supported host suffixes are .vault.azure.net, .vault.azure.cn, .vault.usgovcloudapi.net, and .vault.microsoftazure.de. */
    keyVaultUrl: url;

    /** The VNet connection used to access the vault. Must not be empty or whitespace when provided. */
    vnetConnectionName?: string;

    /** Authentication used to access the vault. */
    authentication: SecretValueReferenceAuthentication;
  }

  /** Authentication for a Key Vault reference source. */
  @added(ApiVersions.v2026_10_01_preview)
  model SecretValueReferenceAuthentication {
    /** The sandbox group's managed identity used to access the vault. */
    identity: SecretValueReferenceIdentity;
  }

  /** The managed identity used to resolve Key Vault references. */
  @added(ApiVersions.v2026_10_01_preview)
  model SecretValueReferenceIdentity {
    /** The managed identity type. */
    type: SecretManagedIdentityType;

    /** The resource ID of an attached user-assigned managed identity. Required for UserAssigned and must be absent for SystemAssigned. */
    identityResourceId?: string;
  }

  /** Supported managed identity types for Key Vault authentication. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The controller rejects identity types other than SystemAssigned and UserAssigned."
  @added(ApiVersions.v2026_10_01_preview)
  union SecretManagedIdentityType {
    /** Uses the sandbox group's system-assigned managed identity. */
    SystemAssigned: "SystemAssigned",

    /** Uses an attached user-assigned managed identity. */
    UserAssigned: "UserAssigned",
  }

  /** The result of resolving a secret's Key Vault references. */
  @added(ApiVersions.v2026_10_01_preview)
  union SecretResolutionStatus {
    /** An unrecognized resolution status returned by the service. */
    StringValue: string,

    /** The references were resolved successfully. */
    Succeeded: "Succeeded",

    /** Reference resolution failed. */
    Failed: "Failed",
  }

  /** The latest Key Vault reference resolution result. */
  @added(ApiVersions.v2026_10_01_preview)
  model SecretResolution {
    /** The resolution status. */
    status: SecretResolutionStatus;

    /** The timestamp of the most recent resolution attempt. */
    lastAttemptedAt?: utcDateTime;

    /** Details of the resolution failure, if any. */
    error?: SecretResolutionError;
  }

  /** Details of a Key Vault reference resolution failure. */
  @added(ApiVersions.v2026_10_01_preview)
  model SecretResolutionError {
    /** The service error code. */
    code: string;

    /** The error message. */
    message: string;
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

    /** The latest Key Vault reference resolution result, omitted for inline-only secrets. */
    @added(ApiVersions.v2026_10_01_preview)
    @visibility(Lifecycle.Read)
    resolution?: SecretResolution;
  }
}
