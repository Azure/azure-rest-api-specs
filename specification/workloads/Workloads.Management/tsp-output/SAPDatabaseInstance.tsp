import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SAPVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the Database resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SAPVirtualInstance)
@Azure.ResourceManager.Private.armResourceInternal(SAPDatabaseProperties)
@includeInapplicableMetadataInPayload(false)
model SAPDatabaseInstance extends TrackedResourceBase {
  /**
   * Database resource name string modeled as parameter for auto generation to work correctly.
   */
  @path
  @key("databaseInstanceName")
  @segment("databaseInstances")
  name: string;

  /**
   * Defines the Database properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SAPDatabaseProperties;
}

@armResourceOperations
interface SAPDatabaseInstances {
  /**
   * Gets the SAP Database Instance resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPDatabaseInstances_Get")
  get is ArmResourceRead<SAPDatabaseInstance>;

  /**
   * Creates the Database resource corresponding to the Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPDatabaseInstances_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SAPDatabaseInstance,
    BaseParameters<SAPDatabaseInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the Database resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SAPDatabaseInstances_Update")
  update is ArmCustomPatchAsync<
    SAPDatabaseInstance,
    UpdateSAPDatabaseInstanceRequest,
    BaseParameters<SAPDatabaseInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the Database resource corresponding to a Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPDatabaseInstances_Delete")
  delete is ArmResourceDeleteAsync<
    SAPDatabaseInstance,
    BaseParameters<SAPDatabaseInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the Database resources associated with a Virtual Instance for SAP solutions resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPDatabaseInstances_List")
  list is ArmResourceListByParent<SAPDatabaseInstance>;

  /**
   * Starts the database instance of the SAP system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPDatabaseInstances_StartInstance")
  startInstance is ArmResourceActionAsync<
    SAPDatabaseInstance,
    void,
    OperationStatusResult,
    BaseParameters<SAPDatabaseInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Stops the database instance of the SAP system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPDatabaseInstances_StopInstance")
  stopInstance is ArmResourceActionAsync<
    SAPDatabaseInstance,
    StopRequest,
    OperationStatusResult,
    BaseParameters<SAPDatabaseInstance>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(SAPDatabaseInstances.create::parameters.resource,
  "json",
  "body"
);
@@extension(SAPDatabaseInstances.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SAPDatabaseInstances.create::parameters.resource,
  "Request body of Database resource of a SAP system."
);
@@projectedName(SAPDatabaseInstances.update::parameters.properties,
  "json",
  "body"
);
@@extension(SAPDatabaseInstances.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SAPDatabaseInstances.update::parameters.properties,
  "Database resource update request body."
);
@@doc(SAPDatabaseInstances.stopInstance::parameters.body,
  "Stop request for the database instance of the SAP system."
);
