import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/confirmation.tsp";

using TypeSpec.Http;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Confirmations;

//TODO: find a workaround

@route("/confirmations/password")
@doc("Password reset confirmation.")
@post
op CreatePasswordConfirmation(
  ...ApiVersionParameter,

  @doc("The password confirmation request.")
  @body
  confirmationRequest: ConfirmationRequest
): NoContentResponse | Azure.Core.Foundations.ErrorResponse;

@route("/confirmations/identities/basic")
@doc("Basic identity (Email) confirmation.")
@post
op CreateBasicIdentityConfirmation(
  ...ApiVersionParameter,

  @doc("The identity confirmation request.")
  @body
  identityConfirmationRequest: IdentityConfirmationRequest
): NoContentResponse | Azure.Core.Foundations.ErrorResponse;
