import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../service.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;



@doc("Project details.")
@resource("projects")
model Project {
  @key("projectName")
  @doc("Name of the project")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("Description of the project.")
  description?: string;

  @doc("""
When specified, indicates the maximum number of Dev Boxes a single user can
create across all pools in the project.
""")
  @minValue(0)
  maxDevBoxesPerUser?: int32;
}

@doc("Project user")
@resource("users")
@parentResource(Project)
model User {
  @key("userId")
  @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context")
  @minLength(2)
  @maxLength(36)
  @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
  @visibility("read")
  userId: string;
}
