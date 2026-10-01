import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** An MCP authorization policy resource. */
@added(Versions.`2026-11-01-preview`)
@parentResource(InstanceResource)
model McpAuthorizationPolicyResource
  is ProxyResource<McpAuthorizationPolicyProperties> {
  /** The name of the MCP authorization policy resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("mcpAuthorizationPolicyName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("mcpAuthorizationPolicies")
  name: string;

  /** The edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** The rules and runtime state of an MCP authorization policy. */
@added(Versions.`2026-11-01-preview`)
model McpAuthorizationPolicyProperties {
  ...DefaultProvisioningStateProperty;

  /** The allow rules evaluated for MCP tool calls. */
  @minItems(1)
  @identifiers(#[])
  policies: McpAuthorizationPolicyRule[];
}

/** An allow rule for MCP tool calls. */
@added(Versions.`2026-11-01-preview`)
model McpAuthorizationPolicyRule {
  /** The action authorized by the rule. */
  action: McpAuthorizationAction;

  /** The principal selector that must match the caller. */
  principal: McpAuthorizationPrincipal;

  /** The MCP tool names authorized by the rule. */
  @minItems(1)
  resources: NonEmptyString[];

  /** Additional values that must match the tool call context. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This model describes MCP tools which can take arbitrary parameters which have underfined shape. They may be customer-defined, so we need to model this field as a free-form JSON object"
  context?: Record<unknown>;
}

/** The supported MCP authorization actions. */
@added(Versions.`2026-11-01-preview`)
union McpAuthorizationAction {
  string,

  /** Invoke an MCP tool. */
  ToolCall: "ToolCall",
}

/** The principal selector for an MCP authorization rule. */
@added(Versions.`2026-11-01-preview`)
@discriminator("principalType")
model McpAuthorizationPrincipal {
  /** The type of principal selector. */
  principalType: McpAuthorizationPrincipalType;
}

/** The supported principal selector types. */
@added(Versions.`2026-11-01-preview`)
union McpAuthorizationPrincipalType {
  string,

  /** Match one or more named identities. */
  Identities: "Identities",

  /** Match an assigned authorization role. */
  Role: "Role",
}

/** A principal selector that matches one of the named identities. */
@added(Versions.`2026-11-01-preview`)
model McpAuthorizationIdentitiesPrincipal extends McpAuthorizationPrincipal {
  /** The type of principal selector. */
  principalType: "Identities";

  /** The identities that can match the rule. */
  @minItems(1)
  identities: NonEmptyString[];
}

/** A principal selector that matches an assigned authorization role. */
@added(Versions.`2026-11-01-preview`)
model McpAuthorizationRolePrincipal extends McpAuthorizationPrincipal {
  /** The type of principal selector. */
  principalType: "Role";

  /** The authorization role that can match the rule. */
  @minLength(1)
  role: string;
}
