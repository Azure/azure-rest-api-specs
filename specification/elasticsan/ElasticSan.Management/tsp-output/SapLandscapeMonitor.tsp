import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Monitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
@doc("configuration associated with SAP Landscape Monitor Dashboard.")
@singleton("default")
@parentResource(Monitor)
model SapLandscapeMonitor is ProxyResource<SapLandscapeMonitorProperties> {
  @key("sapLandscapeMonitor")
  @segment("sapLandscapeMonitor")
  name: string;
}

@armResourceOperations
interface SapLandscapeMonitors {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.")
  @operationId("SapLandscapeMonitor_Get")
  get is ArmResourceRead<SapLandscapeMonitor>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a SAP Landscape Monitor Dashboard for the specified subscription, resource group, and resource name.")
  @operationId("SapLandscapeMonitor_Create")
  create is ArmResourceCreateOrReplaceSync<SapLandscapeMonitor>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patches the SAP Landscape Monitor Dashboard for the specified subscription, resource group, and SAP monitor name.")
  @operationId("SapLandscapeMonitor_Update")
  update is ArmCustomPatchSync<SapLandscapeMonitor, SapLandscapeMonitor>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a SAP Landscape Monitor Dashboard with the specified subscription, resource group, and SAP monitor name.")
  @operationId("SapLandscapeMonitor_Delete")
  delete is ArmResourceDeleteSync<SapLandscapeMonitor>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.")
  @operationId("SapLandscapeMonitor_List")
  list is ArmResourceListByParent<SapLandscapeMonitor>;
}

@@projectedName(SapLandscapeMonitors.create::parameters.resource,
  "json",
  "sapLandscapeMonitorParameter"
);
@@extension(SapLandscapeMonitors.create::parameters.resource,
  "x-ms-client-name",
  "sapLandscapeMonitorParameter"
);
@@doc(SapLandscapeMonitors.create::parameters.resource,
  "Request body representing a configuration for Sap Landscape Monitor Dashboard"
);
@@projectedName(SapLandscapeMonitors.update::parameters.properties,
  "json",
  "sapLandscapeMonitorParameter"
);
@@extension(SapLandscapeMonitors.update::parameters.properties,
  "x-ms-client-name",
  "sapLandscapeMonitorParameter"
);
@@doc(SapLandscapeMonitors.update::parameters.properties,
  "Request body representing a configuration for Sap Landscape Monitor Dashboard"
);
