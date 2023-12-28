import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Workloads;
@doc("SAP monitor info on Azure (ARM properties and SAP monitor properties)")
model Monitor is TrackedResource<MonitorProperties> {
  @doc("Name of the SAP monitor resource.")
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface monitors {
  @doc("Gets properties of a SAP monitor for the specified subscription, resource group, and resource name.")
  get is ArmResourceRead<Monitor>;
  @doc("Creates a SAP monitor for the specified subscription, resource group, and resource name.")
  create is ArmResourceCreateOrUpdateAsync<Monitor>;
  @doc("Patches the Tags field of a SAP monitor for the specified subscription, resource group, and SAP monitor name.")
  update is ArmCustomPatchSync<Monitor, UpdateMonitorRequest>;
  @doc("Deletes a SAP monitor with the specified subscription, resource group, and SAP monitor name.")
  delete is ArmResourceDeleteAsync<Monitor>;
  @doc("Gets a list of SAP monitors in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<Monitor>;
  @doc("Gets a list of SAP monitors in the specified subscription. The operations returns various properties of each SAP monitor.")
  list is ArmListBySubscription<Monitor>;
}
