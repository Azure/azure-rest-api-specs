import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/identity.tsp";

using TypeSpec.Http;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Routes.Confirmations;

@route("/users/{userId}/identities")
@doc("List a collection of user identities.")
@get
op ListUserIdentities(
  ...UserParams,
  ...ListParams
): ApiResponse<Page<IdentityResult>>;

@route("/users/{userId}/identities/{provider}/{identity}")
@doc("Creates or updates the given user identity.")
@put
op CreateOrUpdateUserIdentityProvider(
  ...UserParams,
  ...ListParams,

  @doc("The provider of the identity.")
  @path
  provider: string,

  @doc("The identity.")
  @path
  identity: string
): NoContentResponse | ErrorResponse;
