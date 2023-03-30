import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/confirmation.tsp";

using TypeSpec.Http;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Resources.Confirmations;

interface Confirmations {
  //TODO: find a workaround
  @route("/confirmations/users/{userId}/identities/basic")
  @doc("Basic identity (Email) confirmation for a User.")
  @post
  CreateUserBasicIdentityConfirmation(
    ...ApiVersionParameter,

    @doc("User identifier.")
    @path
    userId: string,

    @doc("The identity confirmation request.")
    @body
    identityConfirmationRequest: IdentityConfirmationRequest
  ): NoContentResponse | Azure.Core.Foundations.ErrorResponse;
}
