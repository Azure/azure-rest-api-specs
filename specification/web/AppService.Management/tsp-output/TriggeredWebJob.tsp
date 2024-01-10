import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Triggered Web Job Information.")
model TriggeredWebJob is ProxyResource<TriggeredWebJobProperties> {
  @doc("Name of Web Job.")
  @key("webJobName")
  @segment("triggeredwebjobs")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface TriggeredWebJobs_WebApps {
  @doc("Description for Gets a triggered web job by its ID for an app, or a deployment slot.")
  getTriggeredWebJobSlot is ArmResourceRead<TriggeredWebJob>;

  @doc("Description for Delete a triggered web job by its ID for an app, or a deployment slot.")
  deleteTriggeredWebJobSlot is ArmResourceDeleteSync<TriggeredWebJob>;

  @doc("Description for List triggered web jobs for an app, or a deployment slot.")
  listTriggeredWebJobsSlot is ArmResourceListByParent<TriggeredWebJob>;

  @doc("Description for Run a triggered web job for an app, or a deployment slot.")
  runTriggeredWebJobSlot is ArmResourceActionSync<TriggeredWebJob, void, void>;
}
