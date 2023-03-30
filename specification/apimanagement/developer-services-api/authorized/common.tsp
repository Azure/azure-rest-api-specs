import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace DeveloperServicesAuthorizedApi.Common;

@doc("Apis resource model.")
@resource("users")
model UserResource {
  @doc("User identifier.")
  @key("userId")
  @visibility("query")
  userId: string;
}
