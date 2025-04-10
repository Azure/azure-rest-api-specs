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
 * Define the Virtual Instance for SAP solutions resource.
 */
model SAPVirtualInstance
  is Azure.ResourceManager.TrackedResource<
    SAPVirtualInstanceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SAPVirtualInstance,
    KeyName = "sapVirtualInstanceName",
    SegmentName = "sapVirtualInstances",
    NamePattern = ""
  >;

  /**
   * A pre-created user assigned identity with appropriate roles assigned. To learn more on identity and roles required, visit the ACSS how-to-guide.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: UserAssignedServiceIdentity;
}

@armResourceOperations
interface SAPVirtualInstances {
  /**
   * Gets a Virtual Instance for SAP solutions resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPVirtualInstances_Get")
  get is ArmResourceRead<SAPVirtualInstance>;

  /**
   * Creates a Virtual Instance for SAP solutions (VIS) resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPVirtualInstances_Create")
  create is ArmResourceCreateOrReplaceAsync<SAPVirtualInstance>;

  /**
   * Updates a Virtual Instance for SAP solutions resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("SAPVirtualInstances_Update")
  update is ArmCustomPatchSync<
    SAPVirtualInstance,
    PatchModel = UpdateSAPVirtualInstanceRequest
  >;

  /**
   * Deletes a Virtual Instance for SAP solutions resource and its child resources, that is the associated Central Services Instance, Application Server Instances and Database Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("SAPVirtualInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SAPVirtualInstance,
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all Virtual Instances for SAP solutions resources in a Resource Group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPVirtualInstances_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    SAPVirtualInstance,
    Response = ArmResponse<SAPVirtualInstanceList>
  >;

  /**
   * Gets all Virtual Instances for SAP solutions resources in a Subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPVirtualInstances_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    SAPVirtualInstance,
    Response = ArmResponse<SAPVirtualInstanceList>
  >;

  /**
   * Starts the SAP application, that is the Central Services instance and Application server instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPVirtualInstances_Start")
  start is ArmResourceActionAsync<
    SAPVirtualInstance,
    void,
    ArmResponse<OperationStatusResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Stops the SAP Application, that is the Application server instances and Central Services instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPVirtualInstances_Stop")
  stop is ArmResourceActionAsync<
    SAPVirtualInstance,
    {
      /**
       * The Virtual Instance for SAP solutions resource stop request body.
       */
      @bodyRoot
      body?: StopRequest;
    },
    ArmResponse<OperationStatusResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(SAPVirtualInstance.name,
  "The name of the Virtual Instances for SAP solutions resource"
);
@@doc(SAPVirtualInstance.properties,
  "Defines the Virtual Instance for SAP solutions resource properties."
);
@@doc(SAPVirtualInstances.create::parameters.resource,
  "Virtual Instance for SAP solutions resource request body."
);
@@doc(SAPVirtualInstances.update::parameters.properties,
  "Request body to update a Virtual Instance for SAP solutions resource."
);
