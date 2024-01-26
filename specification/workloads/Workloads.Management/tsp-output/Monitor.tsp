import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * SAP monitor info on Azure (ARM properties and SAP monitor properties)
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(MonitorProperties)
model Monitor extends TrackedResourceBase {
  /**
   * Name of the SAP monitor resource.
   */
  @path
  @key("monitorName")
  @segment("monitors")
  @visibility("read")
  name: string;

  /**
   * SAP monitor properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: MonitorProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Monitors {
  /**
   * Gets properties of a SAP monitor for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("monitors_Get")
  get is ArmResourceRead<Monitor>;

  /**
   * Creates a SAP monitor for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("monitors_Create")
  create is ArmResourceCreateOrReplaceAsync<
    Monitor,
    BaseParameters<Monitor>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patches the Tags field of a SAP monitor for the specified subscription, resource group, and SAP monitor name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("monitors_Update")
  update is ArmCustomPatchSync<Monitor, UpdateMonitorRequest>;

  /**
   * Deletes a SAP monitor with the specified subscription, resource group, and SAP monitor name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("monitors_Delete")
  delete is ArmResourceDeleteAsync<
    Monitor,
    BaseParameters<Monitor>,
    ArmAsyncOperationHeader
  >;

  /**
   * Gets a list of SAP monitors in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Monitor>;

  /**
   * Gets a list of SAP monitors in the specified subscription. The operations returns various properties of each SAP monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("monitors_List")
  list is ArmListBySubscription<Monitor>;
}

@@projectedName(Monitors.create::parameters.resource,
  "json",
  "MonitorParameter"
);
@@extension(Monitors.create::parameters.resource,
  "x-ms-client-name",
  "MonitorParameter"
);
@@doc(Monitors.create::parameters.resource,
  "Request body representing a SAP monitor"
);
@@projectedName(Monitors.update::parameters.properties, "json", "body");
@@extension(Monitors.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Monitors.update::parameters.properties,
  "The Update SAP workload monitor request body."
);
