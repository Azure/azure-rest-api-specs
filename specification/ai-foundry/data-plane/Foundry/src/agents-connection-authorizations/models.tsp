import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

const ConnectionAuthorizationsRequiredPreviews = #{
  required_previews: #[
    FoundryFeaturesOptInKeys.connection_authorizations_v1_preview
  ],
};

alias ConnectionAuthorizationPathParams = {
  /** The name of the agent. */
  @path agent_name: string;

  /** The name of a project connection the agent uses. */
  @path connection: string;
};

/** Authorization state is per user and short-lived, so no response is cached. */
alias ConnectionAuthorizationNoStore = {
  /** Always `no-store`. */
  @header("Cache-Control")
  cache_control: "no-store";
};

/** The `:grant` response: the authorization, never cached. */
alias ConnectionAuthorizationGrantResponse = ConnectionAuthorization &
  ConnectionAuthorizationNoStore;

/** The `GET` response: the authorization, never cached, with a polling hint while authorization is pending. */
alias ConnectionAuthorizationGetResponse = ConnectionAuthorization &
  ConnectionAuthorizationNoStore & {
    /** Seconds to wait before polling again. Present when `status` is `authorization_required`; poll no faster. */
    @header("Retry-After")
    retry_after?: int32;
  };

/** The `:revoke` response: no content, never cached. */
alias ConnectionAuthorizationRevokeResponse = NoContentResponse &
  ConnectionAuthorizationNoStore;

@doc("Whether the calling user has authorized a connection for an agent.")
@removed(Versions.v1)
union ConnectionAuthorizationStatus {
  string,

  @doc("The user has authorized the connection for this agent.")
  authorized: "authorized",

  @doc("The user must authorize the connection, for example because they never did, didn't finish, or the grant expired or was revoked.")
  authorization_required: "authorization_required",
}

@doc("The calling user's authorization of one project connection for one agent.")
@removed(Versions.v1)
model ConnectionAuthorization {
  @doc("The project connection name. Equals the path key.")
  connection: string;

  @doc("The authorization status.")
  status: ConnectionAuthorizationStatus;

  @doc("An opaque, short-lived sign-in link. Present only on `:grant` when `status` is `authorization_required`. Treat it as a secret: show it only to the user and never log it.")
  url?: url;

  @doc("When `url` expires. Present only with `url`.")
  expires_at?: FoundryTimestamp;
}
