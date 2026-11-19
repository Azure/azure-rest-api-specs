import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Egress credential rules for hosted agents (preview).
// Setting `egress_policy.credential_rules` requires `Foundry-Features: EgressCredentialRules=V1Preview`.
// A version without credential rules keeps today's behavior: a real agent token for any resource and no egress hook.
// ---------------------------------------------------------------------------

@doc("Who a credential rule acts as.")
@removed(Versions.v1)
union CredentialRuleIdentity {
  string,

  @doc("The agent's own Entra identity.")
  agent: "agent",

  @doc("The user bound to the session through Agent Blueprint sign-in (on-behalf-of). Requires a user-bound session.")
  agent_on_behalf_of_user: "agent_on_behalf_of_user",
}

@doc("How a credential is delivered to code in the hosted agent sandbox.")
@removed(Versions.v1)
union CredentialRuleMode {
  string,

  @doc("Sandbox code receives a placeholder; Foundry attaches the real credential only at the rule's destinations.")
  mask: "mask",

  @doc("""
    Sandbox code receives the real token. Foundry does not restrict where it is sent; only network egress rules apply.
    Use only where masking cannot work, such as non-HTTP protocols or tokens carried in a request body.
    """)
  real: "real",
}

@doc("The egress settings of a hosted agent version.")
@removed(Versions.v1)
model EgressPolicy {
  @doc("""
    Unordered rules that say which credential Foundry may attach to which outbound destination. When omitted or
    empty, the version keeps today's behavior. When present, the sandbox token endpoint serves only resources covered
    by a rule or a platform audience.
    """)
  @maxItems(25)
  credential_rules?: CredentialRule[];
}

@doc("The source of the credential that a credential rule delivers.")
@removed(Versions.v1)
union CredentialRuleType {
  string,

  @doc("One Entra resource, such as `https://graph.microsoft.com`.")
  entra: "entra",

  @doc("Every non-platform Entra resource that has no `entra` rule of its own. At most one per version.")
  entra_wildcard: "entra_wildcard",

  @doc("An egress-enabled project connection. The connection's auth type decides who acts.")
  connection: "connection",
}

@doc("A rule that binds one credential source to the destinations where egress may use it.")
@discriminator("type")
@removed(Versions.v1)
model CredentialRule {
  @doc("A unique name for the rule within the agent version.")
  @pattern("^[A-Za-z0-9][A-Za-z0-9_-]{0,63}$")
  name: string;

  @doc("The credential source.")
  type: CredentialRuleType;
}

@doc("A credential rule for one Entra resource.")
@removed(Versions.v1)
model EntraCredentialRule extends CredentialRule {
  type: CredentialRuleType.entra;

  @doc("The Entra resource URI or application id, for example `https://graph.microsoft.com`. `*` is not allowed.")
  resource: string;

  @doc("Who the rule acts as.")
  identity: CredentialRuleIdentity;

  @doc("How the credential is delivered to sandbox code.")
  mode: CredentialRuleMode;

  @doc("Fully qualified delegated scopes, such as `https://graph.microsoft.com/User.Read`. Allowed only with `identity: agent_on_behalf_of_user`. When omitted, the token is for `<resource>/.default`.")
  scopes?: string[];

  @doc("""
    Where egress may use the credential. Required for `mask`. Optional for `real`, where every destination must set
    `inject: true`.
    """)
  @maxItems(25)
  destinations?: CredentialDestination[];
}

@doc("A credential rule for every non-platform Entra resource without an `entra` rule of its own.")
@removed(Versions.v1)
model EntraWildcardCredentialRule extends CredentialRule {
  type: CredentialRuleType.entra_wildcard;

  @doc("""
    Who the rule acts as. With `mode: real`, only `agent` is accepted; a real on-behalf-of-user token needs an
    `entra` rule that names the resource.
    """)
  identity: CredentialRuleIdentity;

  @doc("How the credential is delivered to sandbox code.")
  mode: CredentialRuleMode;

  @doc("""
    Where egress may replace a wildcard placeholder. Required for `mask`, where no destination may set `inject: true`.
    Not allowed for `real`.
    """)
  @maxItems(25)
  destinations?: CredentialDestination[];
}

@doc("A credential rule for an egress-enabled project connection.")
@removed(Versions.v1)
model ConnectionCredentialRule extends CredentialRule {
  type: CredentialRuleType.connection;

  @doc("""
    The connection name, or the full ARM id of a connection in the agent's project. Stored and returned exactly as
    sent.
    """)
  connection_id: string;

  @doc("How the credential is delivered to sandbox code. Only `mask` is supported.")
  mode?: CredentialRuleMode;

  @doc("Where egress sets the connection credential. Every destination must set `inject: true`.")
  @minItems(1)
  @maxItems(25)
  destinations: CredentialDestination[];
}

@doc("Where a credential may be used and how it is written into the request.")
@removed(Versions.v1)
model CredentialDestination {
  @doc("The requests this destination covers.")
  @minItems(1)
  @maxItems(25)
  match: CredentialMatch[];

  @doc("The headers that carry the credential. Defaults to `Authorization: Bearer <credential>`. Required for `CustomKeys` connections.")
  headers?: CredentialHeader[];

  @doc("""
    When `true`, the credential is also set on a matching request that carries no placeholder or handle. When
    `false`, it replaces only this rule's placeholder or handle.
    """)
  inject?: boolean = false;
}

@doc("A request pattern covered by a credential destination.")
@removed(Versions.v1)
model CredentialMatch {
  @doc("An exact host, `*.suffix` (subdomains only), or `*` (`entra_wildcard` rules only).")
  host: string;

  @doc("An exact path, or a prefix ending in `/*`. Compared case-insensitively. Omit to match every path.")
  path?: string;

  @doc("HTTP methods, compared case-insensitively. Omit to match every method.")
  methods?: string[];
}

@doc("How a credential is written into a header.")
@removed(Versions.v1)
union CredentialHeaderType {
  string,

  @doc("`Bearer <credential>`. The default on `Authorization`.")
  bearer: "bearer",

  @doc("HTTP Basic, with `username` and the credential as the password.")
  basic: "basic",

  @doc("The credential inserted into `format`. The default on other header names.")
  raw: "raw",
}

@doc("A header that carries the credential.")
@removed(Versions.v1)
model CredentialHeader {
  @doc("The header name. Defaults to `Authorization`. Hop-by-hop, framing, `Host`, and `Proxy-Authorization` are not allowed.")
  name?: string = "Authorization";

  @doc("How the credential is written into the header. Defaults to `bearer` on `Authorization` and `raw` otherwise.")
  type?: CredentialHeaderType;

  @doc("For `raw`: a template with exactly one `{0}`, for example `token {0}`. Defaults to `{0}`.")
  format?: string;

  @doc("For `basic`: the user name. Cannot contain `:`.")
  username?: string;

  @doc("For `CustomKeys` connections: the name of the stored key that goes in this header.")
  key?: string;
}
