import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/identity.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using DeveloperServicesApi.Models;
using DeveloperServicesAuthorizedApi.Common;

namespace DeveloperServicesAuthorizedApi.Resources.Confirmations;

interface Identities {
  @doc("Identity of current user.")
  getIdentity is ResourceRead<IdentityResource>;

  @doc("List a collection of user identities.")
  listIdentities is ResourceList<UserIdentityResource>;

  @route("/users/{userId}/identities/{provider}/{identity}")
  @doc("Creates or updates the given user identity.")
  @put
  createOrUpdateUserIdentityProvider(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("User identifier.")
    @path
    userId: string,

    @doc("The provider of the identity.")
    @path
    provider: string,

    @doc("The identity.")
    @path
    identity: string
  ): OkResponse | Azure.Core.Foundations.ErrorResponse;
}
@doc("Identity resource model.")
@resource("identities")
@parentResource(UserResource)
model UserIdentityResource extends IdentityResult {
  @doc("Identity identifier.")
  @key("default")
  @visibility("query")
  default: "";
}

@doc("Identity resource model.")
@resource("identity")
model IdentityResource extends IdentityResult {
  @doc("Identity identifier.")
  @key("default")
  @visibility("query")
  default: "";
}
