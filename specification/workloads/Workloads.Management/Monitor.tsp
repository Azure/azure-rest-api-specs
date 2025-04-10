import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

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
    NamePattern = ""
  >;

  /**
   * [currently not in use] Managed service identity(user assigned identities)
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: UserAssignedServiceIdentity;
}

@armResourceOperations
interface Monitors {
  /**
   * Gets properties of a SAP monitor for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("monitors_Get")
  get is ArmResourceRead<Monitor>;

  /**
   * Creates a SAP monitor for the specified subscription, resource group, and resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("monitors_Create")
  create is ArmResourceCreateOrReplaceAsync<Monitor>;

  /**
   * Patches the Tags field of a SAP monitor for the specified subscription, resource group, and SAP monitor name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("monitors_Update")
  update is ArmCustomPatchSync<Monitor, PatchModel = UpdateMonitorRequest>;

  /**
   * Deletes a SAP monitor with the specified subscription, resource group, and SAP monitor name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("monitors_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    Monitor,
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of SAP monitors in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Monitor>;

  /**
   * Gets a list of SAP monitors in the specified subscription. The operations returns various properties of each SAP monitor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("monitors_List")
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
