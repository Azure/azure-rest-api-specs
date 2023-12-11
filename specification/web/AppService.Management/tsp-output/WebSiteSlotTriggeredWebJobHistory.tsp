import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSiteSlotTriggeredWebJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Triggered Web Job History. List of Triggered Web Job Run Information elements.")
@parentResource(WebSiteSlotTriggeredWebJob)
model WebSiteSlotTriggeredWebJobHistory
  is ProxyResource<TriggeredJobHistoryProperties> {
  @doc("History ID.")
  @path
  @key("id")
  @segment("history")
  name: string;
}

@armResourceOperations
interface WebSiteSlotTriggeredWebJobHistories {
  @doc("Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.")
  getTriggeredWebJobHistorySlot is ArmResourceRead<WebSiteSlotTriggeredWebJobHistory>;
  @doc("Description for List a triggered web job's history for an app, or a deployment slot.")
  listTriggeredWebJobHistorySlot is ArmResourceListByParent<WebSiteSlotTriggeredWebJobHistory>;
}
