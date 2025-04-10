import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Monitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * configuration associated with SAP Landscape Monitor Dashboard.
 */
@singleton("default")
@parentResource(Monitor)
model SapLandscapeMonitor
  is Azure.ResourceManager.ProxyResource<SapLandscapeMonitorProperties> {
  ...ResourceNameParameter<
    Resource = SapLandscapeMonitor,
    KeyName = "sapLandscapeMonitor",
    SegmentName = "sapLandscapeMonitor",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SapLandscapeMonitors {
  /**
   * Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SapLandscapeMonitor_Get")
  get is ArmResourceRead<SapLandscapeMonitor>;

  /**
   * Creates a SAP Landscape Monitor Dashboard for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SapLandscapeMonitor_Create")
  create is ArmResourceCreateOrReplaceSync<SapLandscapeMonitor>;

  /**
   * Patches the SAP Landscape Monitor Dashboard for the specified subscription, resource group, and SAP monitor name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("SapLandscapeMonitor_Update")
  update is ArmCustomPatchSync<
    SapLandscapeMonitor,
    PatchModel = SapLandscapeMonitor
  >;

  /**
   * Deletes a SAP Landscape Monitor Dashboard with the specified subscription, resource group, and SAP monitor name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SapLandscapeMonitor_Delete")
  delete is ArmResourceDeleteSync<SapLandscapeMonitor>;

  /**
   * Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SapLandscapeMonitor_List")
  list is ArmResourceListByParent<SapLandscapeMonitor>;
}

@@doc(SapLandscapeMonitor.name, "");
@@doc(SapLandscapeMonitor.properties, "Sap Landscape Monitor properties");
@@doc(SapLandscapeMonitors.create::parameters.resource,
  "Request body representing a configuration for Sap Landscape Monitor Dashboard"
);
@@doc(SapLandscapeMonitors.update::parameters.properties,
  "Request body representing a configuration for Sap Landscape Monitor Dashboard"
);
