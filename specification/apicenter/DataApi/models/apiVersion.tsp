import "./api.tsp";

namespace ApiCenter.DataApi.Models;

using TypeSpec.Rest;

@doc("API version")
@resource("versions")
@parentResource(Api)
model ApiVersion {
  @doc("Version identifier.")
  @key("versionName")
  @visibility()
  @maxLength(50)
  name: string;

  @doc("Version title.")
  title: string;

  @doc("Current lifecycle stage of the API version.")
  lifecycleStage: ApiLifecycleStage;
}
