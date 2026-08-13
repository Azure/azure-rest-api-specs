import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * Virtual Connections configuration for a web app. Declares which app settings
 * and connection strings are virtualized so secrets never enter the application
 * sandbox at runtime.
 *
 * This is a proxy-only configuration singleton following the established pattern
 * of other config sub-resources (authsettingsV2, azurestorageaccounts).
 */
@added(Versions.v2026_09_01)
@singleton("virtualConnections")
@parentResource(Site)
model VirtualConnections
  is Azure.ResourceManager.ProxyResource<VirtualConnectionsProperties> {
  ...ResourceNameParameter<
    Resource = VirtualConnections,
    KeyName = "config",
    SegmentName = "config",
    NamePattern = ""
  >;
}

/** Properties of the Virtual Connections configuration. */
@added(Versions.v2026_09_01)
model VirtualConnectionsProperties {
  /** Whether virtual connections are enabled for this site. */
  enabled?: VirtualConnectionsEnabledState = VirtualConnectionsEnabledState.Disabled;

  /**
   * All virtualized connections. Key is a customer-chosen connection name
   * (e.g., "sql", "cache", "storage"). Maximum 50 connections per site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Connection names are arbitrary customer-chosen keys and cannot be represented as a fixed set of model properties."
  connections?: Record<VirtualConnection>;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: VirtualConnectionsProvisioningState;
}

/** Enabled state for virtual connections. */
@added(Versions.v2026_09_01)
union VirtualConnectionsEnabledState {
  /** Virtual connections are enabled — proxy intercepts configured settings. */
  Enabled: "Enabled",

  /** Virtual connections are disabled — all settings pass through unchanged. */
  Disabled: "Disabled",

  string,
}

/** The resource provisioning state. */
@added(Versions.v2026_09_01)
union VirtualConnectionsProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is updating. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource create request has been accepted. */
  Accepted: "Accepted",

  string,
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
   * Maximum 10 settings per connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Setting names are arbitrary customer-chosen keys and cannot be represented as a fixed set of model properties."
  settings: Record<SettingRole>;

  /**
   * Where to look up the settings. Default: "appSettings". Each connection pulls
   * from exactly one source — create separate connections if you need settings
   * from both sources.
   */
  source?: SettingSource = SettingSource.appSettings;

  /** Protocol for the backend service. */
  protocol: VirtualConnectionProtocol;

  /**
   * Authentication strategy for the backend connection.
   * "credential" — proxy injects the original secret (from setting value).
    * "managedIdentity" — proxy acquires a managed identity token for upstream auth.
   */
  auth: VirtualConnectionAuthType;

  /**
    * Managed Identity scope for token acquisition. Only relevant when auth=managedIdentity.
   * Optional — the platform infers a default scope from protocol + host.
   * Specify explicitly for custom hosts or non-standard resource URIs.
   */
  identityScope?: string;

  /**
   * Per-connection override for the user-assigned managed identity resource ID.
   * Used when multiple connections target different backends that require
   * different identities.
   */
  identityResourceId?: string;

  /**
   * How to inject a standalone credential into upstream HTTP requests.
   * Required when protocol=http + auth=credential and the credential is a
    * separate setting. Not needed for role="value" or auth=managedIdentity.
   */
  credentialInjection?: HttpCredentialInjection;
}

/**
 * Describes how the proxy injects a standalone credential setting into upstream
 * HTTP requests. Only applies when protocol=http and the credential is a
 * separate setting (not embedded in a value/URL).
 */
@added(Versions.v2026_09_01)
model HttpCredentialInjection {
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
model SettingRole {
  /**
   * The role this setting plays in the connection. The platform uses this to
   * determine runtime behavior:
   * - "credential" settings are masked (app never sees the real value).
   * - "host"/"value" settings identify the intercept target.
   * - "username" settings feed protocol auth construction.
   */
  role: SettingRoleType;
}

/** Where to resolve settings from. */
@added(Versions.v2026_09_01)
union SettingSource {
  /** App Settings (config/appsettings). */
  appSettings: "appSettings",

  /** Connection Strings (config/connectionstrings). */
  connectionStrings: "connectionStrings",

  string,
}

/** Protocol for the backend service. */
@added(Versions.v2026_09_01)
union VirtualConnectionProtocol {
  /** HTTP/HTTPS (Azure Storage, Cosmos DB REST, Key Vault, custom APIs). */
  http: "http",

  /** TDS (Azure SQL, SQL Server). */
  tds: "tds",

  /** RESP (Azure Cache for Redis). */
  redis: "redis",

  /** PostgreSQL wire protocol (Azure Database for PostgreSQL). */
  postgres: "postgres",

  string,
}

/** Authentication strategy for upstream connections. */
@added(Versions.v2026_09_01)
union VirtualConnectionAuthType {
  /** Proxy injects the original credential from the setting value. */
  credential: "credential",

  /** Proxy acquires a Managed Identity token for upstream auth. */
  managedIdentity: "managedIdentity",

  string,
}

/** The role a setting plays in a connection. */
@added(Versions.v2026_09_01)
union SettingRoleType {
  /** Plain hostname or IP — identifies the intercept target. */
  host: "host",

  /** Standalone secret (password, key, SAS token) — masked from app, used or replaced by proxy. */
  credential: "credential",

  /** Standalone username — used for protocol auth construction (e.g., Redis ACL OID). */
  username: "username",

  /** Composite value (connection string, SAS URL, DSN, Redis URI) — proxy parses based on protocol. */
  value: "value",

  string,
}

/** Result of validating a Virtual Connections configuration. */
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
@added(Versions.v2026_09_01)
union ValidationErrorCode {
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

  string,
}

// ─────────────────────────────────────────────────────────────────────────────
// Operations — production slot: .../sites/{name}/config/virtualConnections
// ─────────────────────────────────────────────────────────────────────────────

@added(Versions.v2026_09_01)
@armResourceOperations
interface VirtualConnectionsOps
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
        virtualConnections: "virtualConnections",
      },
      ResourceName = "VirtualConnections"
    > {}

@added(Versions.v2026_09_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface VirtualConnectionsConfigs {
  /** Gets the Virtual Connections configuration for an app. */
  @summary("Gets the Virtual Connections configuration for an app.")
  getVirtualConnections is VirtualConnectionsOps.Read<
    VirtualConnections,
    OverrideErrorType = DefaultErrorResponse
  >;

  /** Creates or replaces the Virtual Connections configuration for an app. */
  @summary("Creates or replaces the Virtual Connections configuration for an app.")
  createOrUpdateVirtualConnections is VirtualConnectionsOps.CreateOrUpdateSync<
    VirtualConnections,
    Response = ArmResourceUpdatedResponse<VirtualConnections>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Validates a Virtual Connections configuration without applying it. Returns
   * validation errors for missing settings, unsupported protocols, or invalid
   * role/protocol/auth combinations.
   */
  @summary("Validates a Virtual Connections configuration without applying it.")
  @action("validate")
  validateVirtualConnections is VirtualConnectionsOps.ActionSync<
    VirtualConnections,
    VirtualConnectionsProperties,
    ArmResponse<ValidationResult>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

// ─────────────────────────────────────────────────────────────────────────────
// Operations — deployment slot: .../sites/{name}/slots/{slot}/config/virtualConnections
// ─────────────────────────────────────────────────────────────────────────────

@added(Versions.v2026_09_01)
@armResourceOperations
interface VirtualConnectionsSlotOps
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
        virtualConnections: "virtualConnections",
      },
      ResourceName = "VirtualConnectionsSlot"
    > {}

@added(Versions.v2026_09_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface VirtualConnectionsSlotConfigs {
  /** Gets the Virtual Connections configuration for a deployment slot. */
  @summary("Gets the Virtual Connections configuration for a deployment slot.")
  getVirtualConnectionsSlot is VirtualConnectionsSlotOps.Read<
    VirtualConnections,
    OverrideErrorType = DefaultErrorResponse
  >;

  /** Creates or replaces the Virtual Connections configuration for a deployment slot. */
  @summary("Creates or replaces the Virtual Connections configuration for a deployment slot.")
  createOrUpdateVirtualConnectionsSlot is VirtualConnectionsSlotOps.CreateOrUpdateSync<
    VirtualConnections,
    Response = ArmResourceUpdatedResponse<VirtualConnections>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Validates a Virtual Connections configuration for a deployment slot without
   * applying it.
   */
  @summary("Validates a Virtual Connections configuration for a deployment slot.")
  @action("validate")
  validateVirtualConnectionsSlot is VirtualConnectionsSlotOps.ActionSync<
    VirtualConnections,
    VirtualConnectionsProperties,
    ArmResponse<ValidationResult>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
