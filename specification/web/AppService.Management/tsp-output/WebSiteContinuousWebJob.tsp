import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Continuous Web Job Information.")
@parentResource(WebSite)
model WebSiteContinuousWebJob is ProxyResource<ContinuousWebJobProperties> {
  @doc("Name of Web Job.")
  @path
  @key("webJobName")
  @segment("continuouswebjobs")
  name: string;
}

@armResourceOperations
interface WebSiteContinuousWebJobs {
  @doc("Description for Gets a continuous web job by its ID for an app, or a deployment slot.")
  getContinuousWebJob is ArmResourceRead<WebSiteContinuousWebJob>;
  @doc("Description for Delete a continuous web job by its ID for an app, or a deployment slot.")
  deleteContinuousWebJob is ArmResourceDeleteSync<WebSiteContinuousWebJob>;
  @doc("Description for List continuous web jobs for an app, or a deployment slot.")
  listContinuousWebJobs is ArmResourceListByParent<WebSiteContinuousWebJob>;
  @doc("Description for Start a continuous web job for an app, or a deployment slot.")
  startContinuousWebJob is ArmResourceActionSync<
    WebSiteContinuousWebJob,
    {},
    {}
  >;
  @doc("Description for Stop a continuous web job for an app, or a deployment slot.")
  stopContinuousWebJob is ArmResourceActionSync<
    WebSiteContinuousWebJob,
    {},
    {}
  >;
}
