import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/confirmation.tsp";

using TypeSpec.Http;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Routes.Confirmations;

@route("/confirmations/users/{userId}/identities/basic")
@doc("Basic identity (Email) confirmation for a User.")
@post
op CreateUserBasicIdentityConfirmation(
  ...UserParams,
  @body identityConfirmationRequest: IdentityConfirmationRequest
): NoContentResponse | ErrorResponse;
