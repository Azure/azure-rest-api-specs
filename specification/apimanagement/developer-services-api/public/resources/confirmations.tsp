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
  @doc("Password reset confirmation.")
  createPasswordConfirmation is ResourceCreateWithServiceProvidedName<ConfirmationPasswordResource>;

  @doc("Basic identity (Email) confirmation.")
  createBasicIdentityConfirmation is ResourceCreateWithServiceProvidedName<ConfirmationIdentityResource>;
}

@doc("The confirmations resource.")
@resource("confirmations/password")
model ConfirmationPasswordResource extends PasswordConfirmationRequest {
  @doc("Password reset confirmation.")
  @key("default")
  @visibility("query")
  default: "";
}

@doc("The confirmations resource.")
@resource("confirmations/identities/basic")
model ConfirmationIdentityResource extends IdentityConfirmationRequest {
  @doc("The identity confirmation.")
  @key("default")
  @visibility("query")
  default: "";
}
