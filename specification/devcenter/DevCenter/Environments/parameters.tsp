import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenterService;

@doc("The force delete environment query parameter.")
model ForceDeleteEnvironmentQueryParameter {
  @doc("The query option to force environment deletion even if the environment definition does not exist. This is a best-effort delete, and anything custom that forces resource creation beyond the associated resource group may not be deleted.")
  @query("force")
  @added(APIVersions.v2024_09_01_preview)
  force?: boolean;
}

@doc("The environment name path parameter.")
model EnvironmentNameParameter {
  @doc("The name of the environment.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @path
  environmentName: string;
}
