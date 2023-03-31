import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/confirmation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Resources.Confirmations;

interface Confirmations {
  @doc("Basic identity (Email) confirmation for a User.")
  createBasicIdentityConfirmation is ResourceCreateWithServiceProvidedName<ConfirmationIdentityResource>;
}

@doc("The confirmations resource.")
@resource("confirmations")
model ConfirmationsResource {
  @doc("The confirmation.")
  @key("confirmationId")
  @visibility("query")
  confirmationId: "";
}

@doc("Apis resource model.")
@resource("users")
@parentResource(ConfirmationsResource)
model UsersResource {
  @doc("User identifier.")
  @key("userId")
  @visibility("query")
  userId: string;
}

@doc("The basic identity confirmation resource.")
@resource("identities/basic")
@parentResource(UsersResource)
model ConfirmationIdentityResource extends IdentityConfirmationRequest {
  @doc("The identity confirmation.")
  @key("default")
  @visibility("query")
  default: "";
}
