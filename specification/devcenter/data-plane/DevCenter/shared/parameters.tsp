import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenterService;

@doc("The project name path parameter.")
model ProjectNameParameter {
  @doc("The DevCenter Project upon which to execute operations.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @path
  projectName: string;
}

@doc("The user id path parameter.")
model UserIdParameter {
  @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
  @maxLength(36)
  @minLength(2)
  @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
  @path
  userId: string;
}
