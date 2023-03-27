import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/confirmation.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesPublicAPI.Routes.Confirmations;

@route("/confirmations/password")
@doc("Password reset confirmation.")
@post
op CreatePasswordConfirmation(
  @body confirmationRequest: ConfirmationRequest
): NoContentResponse | ErrorResponse;

@route("/confirmations/identities/basic")
@doc("Basic identity (Email) confirmation.")
@post
op CreateBasicIdentityConfirmation(
  @body identityConfirmationRequest: IdentityConfirmationRequest
): NoContentResponse | ErrorResponse;
