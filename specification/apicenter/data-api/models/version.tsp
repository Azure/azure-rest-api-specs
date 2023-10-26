import "./api.tsp";

namespace ApiCenter.DataApi.Models;

@doc("API version")
model ApiVersion {
  @doc("The resource name.")
  @maxLength(50)
  name: string;
  
  @doc("Version title.")
  title: string;

  @doc("Current lifecycle stage of the API version.")
  lifeCycleStage: ApiLifecycleStage;
}
