import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * Egress configuration for a web app. Declares which app settings
 * and connection strings are virtualized so secrets never enter the application
 * sandbox at runtime.
 *
 * This is a proxy-only configuration singleton following the established pattern
 * of other config sub-resources (authsettingsV2, azurestorageaccounts).
 */
@added(Versions.v2026_09_01)
@singleton("egress")
@parentResource(Site)
model EgressConfig
  is Azure.ResourceManager.ProxyResource<EgressConfigProperties> {
  ...ResourceNameParameter<
    Resource = EgressConfig,
    KeyName = "config",
    SegmentName = "config",
    NamePattern = ""
  >;
}

/** Properties of the egress configuration. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "egress is a proxy-only sites/config singleton that is written synchronously and does not track a provisioning state, consistent with the other Microsoft.Web config singletons such as authsettingsV2."
@added(Versions.v2026_09_01)
model EgressConfigProperties {
  /** Whether virtual connections are enabled for this site. */
  enabled?: EgressEnabledState;

  /**
   * All virtualized connections. Key is a customer-chosen connection name
   * (e.g., "sql", "cache", "storage") of at most 256 characters, which must not
   * end in whitespace and must be unique within the site regardless of casing.
   *
   * This collection is authoritative: a write replaces the stored connections in
   * full, and omitting it (or supplying an empty object) deletes the egress
   * configuration for the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Connection names are arbitrary customer-chosen keys and cannot be represented as a fixed set of model properties."
  connections?: Record<VirtualConnection>;
}

/** Enabled state for virtual connections. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The 2026-09-01 service rejects unknown egress enabled states, so this union intentionally models a closed set."
@added(Versions.v2026_09_01)
union EgressEnabledState {
  /** Virtual connections are enabled — proxy intercepts configured settings. */
  Enabled: "Enabled",

  /** Virtual connections are disabled — all settings pass through unchanged. */
  Disabled: "Disabled",
}

/**
 * Declares one backend connection to virtualize. Maps one or more app settings
 * (or connection strings) to a proxy configuration with a specific protocol
 * and authentication strategy.
 */
@added(Versions.v2026_09_01)
model VirtualConnection {
  /**
   * Settings that compose this connection. Key is the app setting
   * (or connection string) name; value describes its role in the connection.
   * Setting keys must be nonempty, must not end in whitespace, and must be
   * unique within the connection regardless of casing.
   *
   * All referenced setting names must already exist in the selected source
   * when the egress configuration is written. Missing app settings, missing
   * connection strings, or ambiguous connection-string references cause
   * create/update validation to fail.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Setting names are arbitrary customer-chosen keys and cannot be represented as a fixed set of model properties."
  settings: Record<VirtualConnectionSetting>;

  /**
   * Where to look up the settings. Default: "AppSettings". Each connection pulls
   * from exactly one source — create separate connections if you need settings
   * from both sources.
   */
  source?: VirtualConnectionSettingSource = VirtualConnectionSettingSource.AppSettings;

  /** Protocol for the backend service. */
  protocol: VirtualConnectionProtocol;

  /**
   * Authentication strategy for the backend connection.
   * "Credential" — proxy injects the original secret (from setting value).
   * "ManagedIdentity" — proxy acquires a managed identity token for upstream auth.
   */
  auth: VirtualConnectionAuthType;

  /**
   * Managed Identity scope for token acquisition. Only relevant when auth=ManagedIdentity.
   * Optional — the platform infers a default scope from protocol + host.
   * Specify explicitly for custom hosts or non-standard resource URIs.
   */
  identityScope?: string;

  /**
   * Per-connection override for the user-assigned managed identity resource ID.
   * Used when multiple connections target different backends that require
   * different identities.
   *
   * Only relevant when auth=ManagedIdentity. If omitted, create/update uses
   * the app's system-assigned identity and rejects the request if that identity
   * does not exist. If supplied, the referenced identity must already be
   * assigned to the app; otherwise create/update validation fails.
   */
  identityResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /**
   * How to inject a standalone credential into upstream HTTP requests.
   * Required when protocol=Http + auth=Credential and the credential is a
   * separate setting. Not needed for role="Value" or auth=ManagedIdentity.
   */
  credentialInjection?: VirtualConnectionCredentialInjection;
}

/**
 * Describes how the proxy injects a standalone credential setting into upstream
 * HTTP requests. Only applies when protocol=Http and the credential is a
 * separate setting (not embedded in a value/URL).
 */
@added(Versions.v2026_09_01)
model VirtualConnectionCredentialInjection {
  /** HTTP header name to inject the credential into (e.g., "Authorization", "X-API-Key"). */
  header: string;

  /**
   * Format string for the header value. Use {value} as placeholder for the
   * credential. Default: raw credential value (no formatting).
   * Examples: "Bearer {value}", "Basic {value}", "ApiKey {value}".
   */
  format?: string;
}

/**
 * Describes the role of a single app setting or connection string within a
 * virtual connection.
 */
@added(Versions.v2026_09_01)
model VirtualConnectionSetting {
  /**
   * The role this setting plays in the connection. The platform uses this to
   * determine runtime behavior:
   * - "Credential" settings are masked (app never sees the real value).
   * - "Host"/"Value" settings identify the intercept target.
   * - "Username" settings feed protocol auth construction.
   */
  role: VirtualConnectionSettingRole;
}

/** Where to resolve settings from. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The 2026-09-01 service rejects unknown virtual connection setting sources, so this union intentionally models a closed set."
@added(Versions.v2026_09_01)
union VirtualConnectionSettingSource {
  /** App Settings (config/appsettings). */
  AppSettings: "AppSettings",

  /** Connection Strings (config/connectionstrings). */
  ConnectionStrings: "ConnectionStrings",
}

/** Protocol for the backend service. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The 2026-09-01 service rejects unsupported virtual connection protocols, so this union intentionally models a closed set."
@added(Versions.v2026_09_01)
union VirtualConnectionProtocol {
  /** HTTP/HTTPS (Azure Storage, Cosmos DB REST, Key Vault, custom APIs). */
  Http: "Http",

  /** TDS (Azure SQL, SQL Server). */
  Tds: "Tds",

  /** RESP (Azure Cache for Redis). */
  Redis: "Redis",

  /** PostgreSQL wire protocol (Azure Database for PostgreSQL). */
  Postgres: "Postgres",
}

/** Authentication strategy for upstream connections. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The 2026-09-01 service rejects unsupported virtual connection authentication types, so this union intentionally models a closed set."
@added(Versions.v2026_09_01)
union VirtualConnectionAuthType {
  /** Proxy injects the original credential from the setting value. */
  Credential: "Credential",

  /** Proxy acquires a Managed Identity token for upstream auth. */
  ManagedIdentity: "ManagedIdentity",
}

/** The role a setting plays in a connection. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The 2026-09-01 service rejects unsupported virtual connection setting roles, so this union intentionally models a closed set."
@added(Versions.v2026_09_01)
union VirtualConnectionSettingRole {
  /** Plain hostname or IP — identifies the intercept target. */
  Host: "Host",

  /** Standalone secret (password, key, SAS token) — masked from app, used or replaced by proxy. */
  Credential: "Credential",

  /** Standalone username — used for protocol auth construction (e.g., Redis ACL OID). */
  Username: "Username",

  /** Composite value (connection string, SAS URL, DSN, Redis URI) — proxy parses based on protocol. */
  Value: "Value",
}

/** Result of validating an egress configuration. */
@added(Versions.v2026_09_01)
model ValidationResult {
  /** Whether the configuration is valid. */
  valid: boolean;

  /** Validation errors, if any. Empty when valid=true. */
  @Azure.ResourceManager.identifiers(#[])
  errors?: ValidationError[];
}

/** A single validation error. */
@added(Versions.v2026_09_01)
model ValidationError {
  /** The connection name that failed validation (or null for top-level errors). */
  connectionName?: string;

  /** The setting name within the connection (if applicable). */
  setting?: string;

  /** Machine-readable error code. */
  code: ValidationErrorCode;

  /** Human-readable error message. */
  message: string;
}

/** Machine-readable error codes returned by the validate action. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Validation error codes are a stable machine-readable contract and unknown codes are not returned by the 2026-09-01 service."
@added(Versions.v2026_09_01)
union ValidationErrorCode {
  /** The configuration contains invalid structure, names, values, or unsupported individual options. */
  InvalidConfiguration: "InvalidConfiguration",

  /** A referenced setting does not exist in the configured source. */
  MissingSetting: "MissingSetting",

  /** An unsupported role+protocol+auth combination. */
  InvalidRoleCombination: "InvalidRoleCombination",

  /** credentialInjection is specified on a non-http connection. */
  InvalidCredentialInjection: "InvalidCredentialInjection",

  /** A connection with auth=credential + protocol=http has a separate credential setting but no credentialInjection. */
  MissingCredentialInjection: "MissingCredentialInjection",

  /** auth=credential but no credential-role or value-role setting provides the secret to inject. */
  MissingCredentialSource: "MissingCredentialSource",

  /** A connection has a username role but no host or value setting to bind it to. */
  OrphanedUsername: "OrphanedUsername",

  /** Two connections resolve to the same host:port with conflicting policies. */
  HostConflict: "HostConflict",

  /** The connection exceeds the maximum number of settings (10). */
  TooManySettings: "TooManySettings",

  /** The configuration exceeds the maximum number of connections (50). */
  TooManyConnections: "TooManyConnections",
}

// ─────────────────────────────────────────────────────────────────────────────
// Operations — production slot: .../sites/{name}/config/egress
// ─────────────────────────────────────────────────────────────────────────────

@added(Versions.v2026_09_01)
@armResourceOperations
interface EgressConfigOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Name of the configuration singleton. */
        @path
        @segment("config")
        @key
        egress: "egress",
      },
      ResourceName = "EgressConfig"
    > {}

@added(Versions.v2026_09_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface EgressConfigs {
  /**
   * Creates or replaces the egress configuration for an app. The supplied
   * connections replace the stored ones in full, so connections omitted from
   * the request are deleted; omitting connections entirely, or supplying an
   * empty object, deletes the configuration for the app. Returns 201 when no
   * configuration was stored for the app beforehand and 200 otherwise, with the
   * stored configuration in the response body.
   *
   * The request is normalized and then structurally and semantically validated
   * before persistence. Invalid configurations are rejected by create/update.
   * Clients can call the validate action first to obtain preflight diagnostics
   * without writing the configuration.
   */
  @summary("Creates or replaces the egress configuration for an app.")
  createOrUpdateEgressConfig is EgressConfigOps.CreateOrUpdateSync<
    EgressConfig,
    Response =
      | ArmResourceUpdatedResponse<EgressConfig>
      | (CreatedResponse & {
          @bodyRoot body: EgressConfig;
        }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Gets the egress configuration stored for an app, including its connections.
   * Returns an empty configuration when none is stored.
   */
  @summary("Gets the stored egress configuration for an app.")
  @action("list")
  listEgressConfig is EgressConfigOps.ActionSync<
    EgressConfig,
    void,
    ArmResponse<EgressConfig>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Validates an egress configuration without applying it.
   *
   * This checks the same structural and semantic constraints enforced by
   * create/update, including referenced setting existence and managed identity
   * assignment requirements, and returns diagnostics for preflight use.
   */
  @summary("Validates an egress configuration without applying it.")
  @action("validate")
  @actionSeparator(":")
  validateEgressConfig is EgressConfigOps.ActionSync<
    EgressConfig,
    EgressConfigProperties,
    ArmResponse<ValidationResult>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

// ─────────────────────────────────────────────────────────────────────────────
// Operations — deployment slot: .../sites/{name}/slots/{slot}/config/egress
// ─────────────────────────────────────────────────────────────────────────────

@added(Versions.v2026_09_01)
@armResourceOperations
interface EgressConfigSlotOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Name of the configuration singleton. */
        @path
        @segment("config")
        @key
        egress: "egress",
      },
      ResourceName = "EgressConfigSlot"
    > {}

@added(Versions.v2026_09_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface EgressConfigSlotConfigs {
  /**
   * Creates or replaces the egress configuration for a deployment slot. The
   * supplied connections replace the stored ones in full, so connections
   * omitted from the request are deleted; omitting connections entirely, or
   * supplying an empty object, deletes the configuration for the slot. Returns
   * 201 when no configuration was stored for the slot beforehand and 200
   * otherwise, with the stored configuration in the response body.
   *
   * The request is normalized and then structurally and semantically validated
   * before persistence. Invalid configurations are rejected by create/update.
   * Clients can call the validate action first to obtain preflight diagnostics
   * without writing the configuration.
   */
  @summary("Creates or replaces the egress configuration for a deployment slot.")
  createOrUpdateEgressConfigSlot is EgressConfigSlotOps.CreateOrUpdateSync<
    EgressConfig,
    Response =
      | ArmResourceUpdatedResponse<EgressConfig>
      | (CreatedResponse & {
          @bodyRoot body: EgressConfig;
        }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Gets the egress configuration stored for a deployment slot, including its
   * connections. Returns an empty configuration when none is stored.
   */
  @summary("Gets the stored egress configuration for a deployment slot.")
  @action("list")
  listEgressConfigSlot is EgressConfigSlotOps.ActionSync<
    EgressConfig,
    void,
    ArmResponse<EgressConfig>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Validates an egress configuration for a deployment slot without applying
   * it.
   *
   * This checks the same structural and semantic constraints enforced by
   * create/update, including referenced setting existence and managed identity
   * assignment requirements, and returns diagnostics for preflight use.
   */
  @summary("Validates an egress configuration for a deployment slot.")
  @action("validate")
  @actionSeparator(":")
  validateEgressConfigSlot is EgressConfigSlotOps.ActionSync<
    EgressConfig,
    EgressConfigProperties,
    ArmResponse<ValidationResult>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
