import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Monitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Workloads;
@doc("configuration associated with SAP Landscape Monitor Dashboard.")
@singleton("default")
@parentResource(Monitor)
model SapLandscapeMonitor is ProxyResource<SapLandscapeMonitorProperties> {
  @key("default")
  @segment("sapLandscapeMonitor")
  name: string;
}

@armResourceOperations
interface SapLandscapeMonitor {
  @doc("Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.")
  get is ArmResourceRead<SapLandscapeMonitor>;
  @doc("Creates a SAP Landscape Monitor Dashboard for the specified subscription, resource group, and resource name.")
  create is ArmResourceCreateOrReplaceSync<SapLandscapeMonitor>;
  @doc("Patches the SAP Landscape Monitor Dashboard for the specified subscription, resource group, and SAP monitor name.")
  update is ArmResourcePatchSync<
    SapLandscapeMonitor,
    SapLandscapeMonitorProperties
  >;
  @doc("Deletes a SAP Landscape Monitor Dashboard with the specified subscription, resource group, and SAP monitor name.")
  delete is ArmResourceDeleteSync<SapLandscapeMonitor>;
  @doc("Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.")
  list is ArmResourceListByParent<SapLandscapeMonitor>;
}
