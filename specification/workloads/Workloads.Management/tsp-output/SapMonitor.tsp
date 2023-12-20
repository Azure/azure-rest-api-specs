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
model SapMonitor is TrackedResource<MonitorProperties> {
  @doc("Name of the SAP monitor resource.")
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface SapMonitors {
  @doc("Gets properties of a SAP monitor for the specified subscription, resource group, and resource name.")
  get is ArmResourceRead<SapMonitor>;
  @doc("Creates a SAP monitor for the specified subscription, resource group, and resource name.")
  create is ArmResourceCreateOrUpdateAsync<SapMonitor>;
  @doc("Patches the Tags field of a SAP monitor for the specified subscription, resource group, and SAP monitor name.")
  update is ArmTagsPatchSync<SapMonitor>;
  @doc("Deletes a SAP monitor with the specified subscription, resource group, and SAP monitor name.")
  delete is ArmResourceDeleteAsync<SapMonitor>;
  @doc("Gets a list of SAP monitors in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<SapMonitor>;
  @doc("Gets a list of SAP monitors in the specified subscription. The operations returns various properties of each SAP monitor.")
  list is ArmListBySubscription<SapMonitor>;
}
