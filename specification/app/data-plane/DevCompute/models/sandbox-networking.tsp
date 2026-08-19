using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

model AddPortRequest {
  name?: null | string;
  port: Int32OrString;
  @oneOf auth?: null | PortAuthConfigView;
  @oneOf activationMode?: null | PortActivationMode;
  protocol?: PortProtocol;
  @oneOf ipAccessControl?: null | IpAccessControlView;
  @oneOf cors?: null | PortCorsConfigView;
}

model PatchPortRequest {
  port?: NullableInt32OrString;
  name?: null | string;
  @oneOf auth?: null | PortAuthConfigView;
  @oneOf activationMode?: null | PortActivationMode;
  @oneOf protocol?: null | PortProtocol;
  @oneOf ipAccessControl?: null | IpAccessControlView;
  @oneOf cors?: null | PortCorsConfigView;
}

union PortActivationMode {
  "Manual",
  "OnDemand",
  null,
}

/** Entra ID-specific auth configuration for a port. */
model PortAuthConfigEntraId {
  /** Whether Entra ID authentication is enabled. */
  enabled?: boolean;

  /**
   * List of allowed email addresses (exact match).
   * Empty means any authenticated Entra ID user can access.
   * Combined with emailSuffixes, objectIds, and tenantIds, maximum 100 entries allowed.
   */
  emails?: unknown[];

  /**
   * List of allowed email domain suffixes (e.g., "\@microsoft.com").
   * Matches any email ending with the suffix.
   * Combined with emails, objectIds, and tenantIds, maximum 100 entries allowed.
   */
  emailSuffixes?: string[];

  /**
   * List of allowed Entra ID object IDs (user or group GUIDs).
   * Combined with emails, emailSuffixes, and tenantIds, maximum 100 entries allowed.
   */
  objectIds?: string[];

  /**
   * List of allowed Entra ID tenant IDs (directory GUIDs).
   * Matches any user from the specified tenant.
   * Combined with emails, emailSuffixes, and objectIds, maximum 100 entries allowed.
   */
  tenantIds?: string[];
}

/**
 * GitHub-specific auth configuration for a port.
 * Permits users whose verified email ends with \@microsoft.com or \@github.com.
 */
model PortAuthConfigGithub {
  /** Whether GitHub authentication is enabled. */
  enabled?: boolean;

  /**
   * List of allowed email addresses (exact match).
   * Empty means any \@microsoft.com or \@github.com user can access.
   * Combined with emailSuffixes, usernames, and usernameSuffixes, maximum 100 entries allowed.
   */
  emails?: unknown[];

  /**
   * List of allowed email domain suffixes (e.g., "\@microsoft.com").
   * Matches any email ending with the suffix.
   * Combined with emails, usernames, and usernameSuffixes, maximum 100 entries allowed.
   */
  emailSuffixes?: string[];

  /**
   * List of allowed GitHub usernames (exact match).
   * Empty means any authenticated GitHub user can access.
   * Combined with emails, emailSuffixes, and usernameSuffixes, maximum 100 entries allowed.
   */
  usernames?: string[];

  /**
   * List of allowed username suffixes (e.g., "_microsoft" for EMU accounts).
   * Matches any username ending with the suffix.
   * Combined with emails, emailSuffixes, and usernames, maximum 100 entries allowed.
   */
  usernameSuffixes?: string[];
}

/**
 * Auth configuration for a port.
 * Each provider can be independently enabled/disabled without removing configuration.
 */
model PortAuthConfigView {
  anonymous?: boolean;
  @oneOf github?: null | PortAuthConfigGithub;
  @oneOf entraId?: null | PortAuthConfigEntraId;
}

/** CORS configuration for a sandbox port. */
model PortCorsConfigView {
  allowOrigins?: string[];
  allowMethods?: string[];
  allowHeaders?: string[];
  allowCredentials?: boolean;
  maxAge?: NullableInt32OrString;
}

/** Specifies the HTTP protocol version to use when forwarding requests to a port. */
union PortProtocol {
  "Http",
  "Http2",
}

model PortsListResponse {
  ports: SandboxPortView[];
}

model RemovePortRequest {
  name?: null | string;
  port?: NullableInt32OrString;
}

/** Represents a port on an instance (inside the VM). */
scalar SandboxPort;

model SandboxPortView {
  name?: null | string;
  port: UInt16OrString;
  url: url;
  @oneOf auth?: null | PortAuthConfigView;
  @oneOf activationMode?: null | PortActivationMode;
  protocol?: PortProtocol;
  @oneOf ipAccessControl?: null | IpAccessControlView;
  @oneOf cors?: null | PortCorsConfigView;
}

model UpdatePortsRequest {
  ports: SandboxPortView[];
}
