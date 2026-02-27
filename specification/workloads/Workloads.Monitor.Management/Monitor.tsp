using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * SAP monitor info on Azure (ARM properties and SAP monitor properties)
 */
model Monitor is Azure.ResourceManager.TrackedResource<MonitorProperties> {
  ...ResourceNameParameter<
    Resource = Monitor,
    KeyName = "monitorName",
    SegmentName = "monitors",
    NamePattern = "^[a-zA-Z0-9-_]+$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Monitors {
  /**
   * Gets properties of a SAP monitor for the specified subscription, resource group, and resource name.
   */
  get is ArmResourceRead<Monitor>;

  /**
   * Creates a SAP monitor for the specified subscription, resource group, and resource name.
   */
  create is ArmResourceCreateOrReplaceAsync<Monitor>;

  /**
   * Patches the Tags field of a SAP monitor for the specified subscription, resource group, and SAP monitor name.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Monitor, UpdateMonitorRequest>;

  /**
   * Deletes a SAP monitor with the specified subscription, resource group, and SAP monitor name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Monitor>;

  /**
   * Gets a list of SAP monitors in the specified resource group.
   */
  @list
  listByResourceGroup is ArmResourceListByParent<Monitor>;

  /**
   * Gets a list of SAP monitors in the specified subscription. The operations returns various properties of each SAP monitor.
   */
  @list
  list is ArmListBySubscription<Monitor>;
}

@@doc(Monitor.name, "Name of the SAP monitor resource.");
@@doc(Monitor.properties, "SAP monitor properties");
@@doc(Monitors.create::parameters.resource,
  "Request body representing a SAP monitor"
);
@@doc(Monitors.update::parameters.properties,
  "The Update SAP workload monitor request body."
);
