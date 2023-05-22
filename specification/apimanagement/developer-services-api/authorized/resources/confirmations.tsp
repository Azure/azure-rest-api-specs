import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/confirmation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Resources.Confirmations;

interface Confirmations {
  @route("/confirmations/users/{userId}/identities/basic")
  @doc("Basic identity (Email) confirmation for a User.")
  @post
  createUserBasicIdentityConfirmation(
    ...ApiVersionParameter,

    @doc("User identifier.")
    @path
    userId: string,

    @doc("The identity confirmation request.")
    @body
    identityConfirmationRequest: IdentityConfirmationRequest
  ): OkResponse | Azure.Core.Foundations.ErrorResponse;
}
