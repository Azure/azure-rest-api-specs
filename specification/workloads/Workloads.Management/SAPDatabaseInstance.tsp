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
 * Define the Database resource.
 */
@parentResource(SAPVirtualInstance)
model SAPDatabaseInstance
  is Azure.ResourceManager.TrackedResource<SAPDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = SAPDatabaseInstance,
    KeyName = "databaseInstanceName",
    SegmentName = "databaseInstances",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SAPDatabaseInstances {
  /**
   * Gets the SAP Database Instance resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPDatabaseInstances_Get")
  get is ArmResourceRead<SAPDatabaseInstance>;

  /**
   * Creates the Database resource corresponding to the Virtual Instance for SAP solutions resource. <br><br>This will be used by service only. PUT by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPDatabaseInstances_Create")
  create is ArmResourceCreateOrReplaceAsync<SAPDatabaseInstance>;

  /**
   * Updates the Database resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("SAPDatabaseInstances_Update")
  update is ArmCustomPatchAsync<
    SAPDatabaseInstance,
    PatchModel = UpdateSAPDatabaseInstanceRequest,
    Response = ArmResponse<SAPDatabaseInstance> | ArmResourceCreatedResponse<SAPDatabaseInstance>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the Database resource corresponding to a Virtual Instance for SAP solutions resource. <br><br>This will be used by service only. Delete by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("SAPDatabaseInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SAPDatabaseInstance,
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the Database resources associated with a Virtual Instance for SAP solutions resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SAPDatabaseInstances_List")
  list is ArmResourceListByParent<
    SAPDatabaseInstance,
    Response = ArmResponse<SAPDatabaseInstanceList>
  >;

  /**
   * Starts the database instance of the SAP system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("start")
  @operationId("SAPDatabaseInstances_StartInstance")
  startInstance is ArmResourceActionAsync<
    SAPDatabaseInstance,
    void,
    ArmResponse<OperationStatusResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Stops the database instance of the SAP system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("stop")
  @operationId("SAPDatabaseInstances_StopInstance")
  stopInstance is ArmResourceActionAsync<
    SAPDatabaseInstance,
    {
      /**
       * Stop request for the database instance of the SAP system.
       */
      @bodyRoot
      body?: StopRequest;
    },
    ArmResponse<OperationStatusResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(SAPDatabaseInstance.name,
  "Database resource name string modeled as parameter for auto generation to work correctly."
);
@@doc(SAPDatabaseInstance.properties, "Defines the Database properties.");
@@doc(SAPDatabaseInstances.create::parameters.resource,
  "Request body of Database resource of a SAP system."
);
@@doc(SAPDatabaseInstances.update::parameters.properties,
  "Database resource update request body."
);
