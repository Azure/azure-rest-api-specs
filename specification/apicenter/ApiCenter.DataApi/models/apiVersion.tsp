import "./api.tsp";

namespace ApiCenter.DataApi;

using TypeSpec.Rest;

@doc("API version resource model.")
@resource("versions")
@parentResource(Api)
model ApiVersion {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "FIXME: misused @visibility to get around this warning"
  @doc("Version identifier.")
  @key("versionName")
  @maxLength(50)
  name: string;

  @doc("Version title.")
  title: string;

  @doc("Current lifecycle stage of the API version.")
  lifecycleStage: LifecycleStage;
}
