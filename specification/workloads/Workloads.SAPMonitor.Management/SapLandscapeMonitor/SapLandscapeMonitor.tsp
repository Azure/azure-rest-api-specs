import "./models.tsp";

using Azure.ResourceManager;

namespace Microsoft.Workloads.SapLandscapeMonitor;

@armResourceOperations
interface SapLandscapeMonitor {
  /**
   * Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.
   */
  get is ArmResourceRead<SapLandscapeMonitorResource>;

  /**
   * Creates a SAP Landscape Monitor Dashboard for the specified subscription, resource group, and resource name.
   */
  create is ArmResourceCreateOrReplaceSync<SapLandscapeMonitorResource>;

  /**
   * Patches the SAP Landscape Monitor Dashboard for the specified subscription, resource group, and SAP monitor name.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    SapLandscapeMonitorResource,
    SapLandscapeMonitorResource
  >;

  /**
   * Deletes a SAP Landscape Monitor Dashboard with the specified subscription, resource group, and SAP monitor name.
   */
  delete is ArmResourceDeleteSync<SapLandscapeMonitorResource>;

  /**
   * Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.
   */
  listByMonitor is ArmResourceListByParent<SapLandscapeMonitorResource>;
}

@@doc(SapLandscapeMonitor.create::parameters.resource,
  "Request body representing a configuration for Sap Landscape Monitor Dashboard"
);
@@doc(SapLandscapeMonitor.update::parameters.properties,
  "Request body representing a configuration for Sap Landscape Monitor Dashboard"
);
