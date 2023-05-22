import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/confirmation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Resources.Confirmations;

interface Confirmations {
  @route("/confirmations/password")
  @doc("Password reset confirmation.")
  @post
  createPasswordConfirmation(
    ...ApiVersionParameter,

    @doc("The password confirmation request.")
    @body
    confirmationRequest: PasswordConfirmationRequest
  ): OkResponse | Azure.Core.Foundations.ErrorResponse;

  @route("/confirmations/identities/basic")
  @doc("Basic identity (Email) confirmation.")
  @post
  createBasicIdentityConfirmation(
    ...ApiVersionParameter,

    @doc("The identity confirmation request.")
    @body
    identityConfirmationRequest: IdentityConfirmationRequest
  ): OkResponse | Azure.Core.Foundations.ErrorResponse;
}
