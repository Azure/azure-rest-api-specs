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
/**
 * configuration associated with SAP Landscape Monitor Dashboard.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "This is a singleton resource and the name is fixed."
@singleton("default")
@parentResource(Monitor)
model SapLandscapeMonitorResource
  is ProxyResource<SapLandscapeMonitorProperties> {
  /**
   * The name of the resource.
   */
  @key
  @path
  @segment("sapLandscapeMonitor")
  @visibility("read")
  name: string;
}

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
  @parameterVisibility("read")
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
  list is ArmResourceListByParent<SapLandscapeMonitorResource>;
}

@@doc(SapLandscapeMonitor.create::parameters.resource,
  "Request body representing a configuration for Sap Landscape Monitor Dashboard"
);
@@doc(SapLandscapeMonitor.update::parameters.properties,
  "Request body representing a configuration for Sap Landscape Monitor Dashboard"
);
