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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(Monitor)
@Azure.ResourceManager.Private.armResourceInternal(
  SapLandscapeMonitorProperties
)
@includeInapplicableMetadataInPayload(false)
model SapLandscapeMonitor extends ProxyResourceBase {
  @key("sapLandscapeMonitor")
  @segment("sapLandscapeMonitor")
  name: string;

  /**
   * Sap Landscape Monitor properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SapLandscapeMonitorProperties;
}

@armResourceOperations
interface SapLandscapeMonitors {
  /**
   * Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SapLandscapeMonitor_Get")
  get is ArmResourceRead<SapLandscapeMonitor>;

  /**
   * Creates a SAP Landscape Monitor Dashboard for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SapLandscapeMonitor_Create")
  create is ArmResourceCreateOrReplaceSync<SapLandscapeMonitor>;

  /**
   * Patches the SAP Landscape Monitor Dashboard for the specified subscription, resource group, and SAP monitor name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SapLandscapeMonitor_Update")
  update is ArmCustomPatchSync<SapLandscapeMonitor, SapLandscapeMonitor>;

  /**
   * Deletes a SAP Landscape Monitor Dashboard with the specified subscription, resource group, and SAP monitor name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SapLandscapeMonitor_Delete")
  delete is ArmResourceDeleteSync<SapLandscapeMonitor>;

  /**
   * Gets configuration values for Single Pane Of Glass for SAP monitor for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
