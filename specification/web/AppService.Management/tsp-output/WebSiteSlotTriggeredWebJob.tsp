import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Triggered Web Job Information.")
@parentResource(WebSiteSlot)
model WebSiteSlotTriggeredWebJob is ProxyResource<TriggeredWebJobProperties> {
  @doc("Name of Web Job.")
  @path
  @key("webJobName")
  @segment("triggeredwebjobs")
  name: string;
}

@armResourceOperations
interface WebSiteSlotTriggeredWebJobs {
  @doc("Description for Gets a triggered web job by its ID for an app, or a deployment slot.")
  getTriggeredWebJobSlot is ArmResourceRead<WebSiteSlotTriggeredWebJob>;
  @doc("Description for Delete a triggered web job by its ID for an app, or a deployment slot.")
  deleteTriggeredWebJobSlot is ArmResourceDeleteSync<WebSiteSlotTriggeredWebJob>;
  @doc("Description for List triggered web jobs for an app, or a deployment slot.")
  listTriggeredWebJobsSlot is ArmResourceListByParent<WebSiteSlotTriggeredWebJob>;
  @doc("Description for Run a triggered web job for an app, or a deployment slot.")
  runTriggeredWebJobSlot is ArmResourceActionSync<
    WebSiteSlotTriggeredWebJob,
    {},
    {}
  >;
}
