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
 * Define the SAP Application Server Instance resource.
 */
@parentResource(SAPVirtualInstance)
model SAPApplicationServerInstance
  is Azure.ResourceManager.TrackedResource<SAPApplicationServerProperties> {
  ...ResourceNameParameter<
    Resource = SAPApplicationServerInstance,
    KeyName = "applicationInstanceName",
    SegmentName = "applicationInstances",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SAPApplicationServerInstances {
  /**
   * Gets the SAP Application Server Instance corresponding to the Virtual Instance for SAP solutions resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPApplicationServerInstances_Get")
  get is ArmResourceRead<SAPApplicationServerInstance>;

  /**
   * Puts the SAP Application Server Instance resource. <br><br>This will be used by service only. PUT by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPApplicationServerInstances_Create")
  create is ArmResourceCreateOrReplaceAsync<SAPApplicationServerInstance>;

  /**
   * Puts the SAP Application Server Instance resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("SAPApplicationServerInstances_Update")
  update is ArmCustomPatchAsync<
    SAPApplicationServerInstance,
    PatchModel = UpdateSAPApplicationInstanceRequest,
    Response = ArmResponse<SAPApplicationServerInstance> | ArmResourceCreatedResponse<SAPApplicationServerInstance>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the SAP Application Server Instance resource. <br><br>This operation will be used by service only. Delete by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("SAPApplicationServerInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SAPApplicationServerInstance,
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the SAP Application Server Instance resources for a given Virtual Instance for SAP solutions resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPApplicationServerInstances_List")
  list is ArmResourceListByParent<
    SAPApplicationServerInstance,
    Response = ArmResponse<SAPApplicationServerInstanceList>
  >;

  /**
   * Starts the SAP Application Server Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("start")
  @operationId("SAPApplicationServerInstances_StartInstance")
  startInstance is ArmResourceActionAsync<
    SAPApplicationServerInstance,
    void,
    ArmResponse<OperationStatusResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Stops the SAP Application Server Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("stop")
  @operationId("SAPApplicationServerInstances_StopInstance")
  stopInstance is ArmResourceActionAsync<
    SAPApplicationServerInstance,
    {
      /**
       * SAP Application server instance stop request body.
       */
      @bodyRoot
      body?: StopRequest;
    },
    ArmResponse<OperationStatusResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(SAPApplicationServerInstance.name,
  "The name of SAP Application Server instance resource."
);
@@doc(SAPApplicationServerInstance.properties,
  "Defines the SAP Application Server instance properties."
);
@@doc(SAPApplicationServerInstances.create::parameters.resource,
  "The SAP Application Server Instance resource request body."
);
@@doc(SAPApplicationServerInstances.update::parameters.properties,
  "The SAP Application Server Instance resource request body."
);
