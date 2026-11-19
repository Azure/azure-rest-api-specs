import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/**
 * Get, grant, and revoke the calling user's authorization of a project connection for an agent. An authorization is
 * scoped to agent, user, and connection, not to a session, so a client can authorize before it creates a session.
 *
 * Callers authenticate with the user's Agent Blueprint token for the agent in the path; Foundry user tokens,
 * application tokens, and `x-ms-user-identity` are rejected. Every operation requires the
 * `Foundry-Features: ConnectionAuthorizations=V1Preview` header.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Get, grant, and revoke are custom operations on a per-user grant owned by the agent endpoint."
@tag("Connection Authorizations")
@removed(Versions.v1)
interface ConnectionAuthorizations {
  /**
   * Returns the calling user's authorization of a connection for the agent. Read-only; never creates a link or a
   * grant.
   */
  @summary("Get a connection authorization")
  @get
  @route("/agents/{agent_name}/endpoint/authorizations/{connection}")
  @extension("x-ms-foundry-meta", ConnectionAuthorizationsRequiredPreviews)
  getAuthorization is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.connection_authorizations_v1_preview,
    ConnectionAuthorizationPathParams,
    ConnectionAuthorization
  >;

  /**
   * Starts authorization of a connection for the agent. Returns a sign-in `url` when the user must authorize. Each
   * call can return a new link; use the latest.
   */
  @summary("Grant a connection authorization")
  @post
  @route("/agents/{agent_name}/endpoint/authorizations/{connection}:grant")
  @extension("x-ms-foundry-meta", ConnectionAuthorizationsRequiredPreviews)
  grantAuthorization is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.connection_authorizations_v1_preview,
    ConnectionAuthorizationPathParams,
    ConnectionAuthorization
  >;

  /**
   * Revokes the calling user's authorization of a connection for the agent, so Foundry stops using the credential.
   * Succeeds when no authorization exists. The connection and the agent remain.
   */
  @summary("Revoke a connection authorization")
  @post
  @route("/agents/{agent_name}/endpoint/authorizations/{connection}:revoke")
  @extension("x-ms-foundry-meta", ConnectionAuthorizationsRequiredPreviews)
  revokeAuthorization is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.connection_authorizations_v1_preview,
    ConnectionAuthorizationPathParams,
    NoContentResponse
  >;
}
