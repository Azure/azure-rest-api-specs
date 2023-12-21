import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Web Job Information.")
model WebJob is ProxyResource<WebJobProperties> {
  @doc("Name of the web job.")
  @path
  @key("webJobName")
  @segment("webjobs")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Get webjob information for an app, or a deployment slot.")
  getWebJobSlot is ArmResourceRead<WebJob>;
  @doc("Description for List webjobs for an app, or a deployment slot.")
  listWebJobsSlot is ArmResourceListByParent<WebJob>;
}
