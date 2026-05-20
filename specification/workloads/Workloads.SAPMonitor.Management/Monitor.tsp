using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * SAP monitor info on Azure (ARM properties and SAP monitor properties)
 */
model Monitor is TrackedResource<MonitorProperties> {
  /**
   * Name of the SAP monitor resource.
   */
  @pattern("^[a-zA-Z0-9-_]+$")
  @path
  @key("monitorName")
  @segment("monitors")
  @visibility(Lifecycle.Read)
  name: string;

  ...ManagedServiceIdentityProperty;
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
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    Monitor,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

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
  listByResourceGroup is ArmResourceListByParent<Monitor>;

  /**
   * Gets a list of SAP monitors in the specified subscription. The operations returns various properties of each SAP monitor.
   */
  list is ArmListBySubscription<Monitor>;
}

@@doc(Monitors.create::parameters.resource,
  "Request body representing a SAP monitor"
);
@@doc(Monitors.update::parameters.properties,
  "The Update SAP workload monitor request body."
);
