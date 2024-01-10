import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./TriggeredWebJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Triggered Web Job History. List of Triggered Web Job Run Information elements.")
@parentResource(TriggeredWebJob)
model TriggeredJobHistory is ProxyResource<TriggeredJobHistoryProperties> {
  @doc("History ID.")
  @key("id")
  @segment("history")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface TriggeredJobHistories_WebApps {
  @doc("Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.")
  getTriggeredWebJobHistorySlot is ArmResourceRead<TriggeredJobHistory>;

  @doc("Description for List a triggered web job's history for an app, or a deployment slot.")
  listTriggeredWebJobHistorySlot is ArmResourceListByParent<TriggeredJobHistory>;
}
