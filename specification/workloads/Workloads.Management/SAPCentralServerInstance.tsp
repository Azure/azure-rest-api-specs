import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SAPVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the SAP Central Services Instance resource.
 */
@parentResource(SAPVirtualInstance)
model SAPCentralServerInstance
  is Azure.ResourceManager.TrackedResource<SAPCentralServerProperties> {
  ...ResourceNameParameter<
    Resource = SAPCentralServerInstance,
    KeyName = "centralInstanceName",
    SegmentName = "centralInstances",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SAPCentralServerInstances {
  /**
   * Gets the SAP Central Services Instance resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPCentralInstances_Get")
  get is ArmResourceRead<SAPCentralServerInstance>;

  /**
   * Creates the SAP Central Services Instance resource. <br><br>This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPCentralInstances_Create")
  create is ArmResourceCreateOrReplaceAsync<SAPCentralServerInstance>;

  /**
   * Updates the SAP Central Services Instance resource. <br><br>This can be used to update tags on the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("SAPCentralInstances_Update")
  update is ArmCustomPatchAsync<
    SAPCentralServerInstance,
    PatchModel = UpdateSAPCentralInstanceRequest,
    Response = ArmResponse<SAPCentralServerInstance> | ArmResourceCreatedResponse<SAPCentralServerInstance>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the SAP Central Services Instance resource. <br><br>This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the Virtual Instance for SAP solutions resource, using the delete operation on it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("SAPCentralInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SAPCentralServerInstance,
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the SAP Central Services Instance resource for the given Virtual Instance for SAP solutions resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPCentralInstances_List")
  list is ArmResourceListByParent<
    SAPCentralServerInstance,
    Response = ArmResponse<SAPCentralInstanceList>
  >;

  /**
   * Starts the SAP Central Services Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("start")
  @operationId("SAPCentralInstances_StartInstance")
  startInstance is ArmResourceActionAsync<
    SAPCentralServerInstance,
    void,
    ArmResponse<OperationStatusResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Stops the SAP Central Services Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("stop")
  @operationId("SAPCentralInstances_StopInstance")
  stopInstance is ArmResourceActionAsync<
    SAPCentralServerInstance,
    {
      /**
       * SAP Central Services instance stop request body.
       */
      @bodyRoot
      body?: StopRequest;
    },
    ArmResponse<OperationStatusResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(SAPCentralServerInstance.name,
  "Central Services Instance resource name string modeled as parameter for auto generation to work correctly."
);
@@doc(SAPCentralServerInstance.properties,
  "Defines the SAP Central Services Instance properties."
);
@@doc(SAPCentralServerInstances.create::parameters.resource,
  "The SAP Central Services Instance request body."
);
@@doc(SAPCentralServerInstances.update::parameters.properties,
  "The SAP Central Services Instance resource request body."
);
