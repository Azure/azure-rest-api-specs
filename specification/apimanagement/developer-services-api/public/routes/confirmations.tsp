import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/confirmation.tsp";

using TypeSpec.Http;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Confirmations;

@route("/confirmations/password")
@doc("Password reset confirmation.")
@post
op CreatePasswordConfirmation(
  @doc("The password confirmation request.")
  @body
  confirmationRequest: ConfirmationRequest
): NoContentResponse | ErrorResponse;

@route("/confirmations/identities/basic")
@doc("Basic identity (Email) confirmation.")
@post
op CreateBasicIdentityConfirmation(
  @doc("The identity confirmation request.")
  @body
  identityConfirmationRequest: IdentityConfirmationRequest
): NoContentResponse | ErrorResponse;
