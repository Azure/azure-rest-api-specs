import "@typespec/openapi";
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is used for representing the company product."
@parentResource(SAPVirtualInstance)
model SAPDatabaseInstance is TrackedResource<SAPDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = SAPDatabaseInstance,
    KeyName = "databaseInstanceName",
    SegmentName = "databaseInstances",
    NamePattern = "^.*"
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is used for representing the company product."
@armResourceOperations
interface SAPDatabaseInstances {
  /**
   * Gets the SAP Database Instance resource.
   */
  get is ArmResourceRead<SAPDatabaseInstance>;

  /**
   * Creates the Database resource corresponding to the Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<SAPDatabaseInstance>;

  /**
   * Updates the Database resource.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    SAPDatabaseInstance,
    UpdateSAPDatabaseInstanceRequest
  >;

  /**
   * Deletes the Database resource corresponding to a Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete by end user will return a Bad Request error.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SAPDatabaseInstance>;

  /**
   * Lists the Database resources associated with a Virtual Instance for SAP solutions resource.
   */
  list is ArmResourceListByParent<SAPDatabaseInstance>;

  /**
   * Starts the database instance of the SAP system.
   */
  start is ArmResourceActionAsync<
    SAPDatabaseInstance,
    {
      @doc("SAP Database server instance start request body.")
      @body
      body?: StartRequest;
    },
    Foundations.OperationStatusResult
  >;

  /**
   * Stops the database instance of the SAP system.
   */
  stop is ArmResourceActionAsync<
    SAPDatabaseInstance,
    {
      @doc("Stop request for the database instance of the SAP system.")
      @body
      body?: StopRequest;
    },
    Foundations.OperationStatusResult
  >;
}

@@doc(SAPDatabaseInstance.name,
  "Database resource name string modeled as parameter for auto generation to work correctly."
);
@@doc(SAPDatabaseInstances.create::parameters.resource,
  "Request body of Database resource of a SAP system."
);
@@doc(SAPDatabaseInstances.update::parameters.properties,
  "Database resource update request body."
);
@@doc(SAPDatabaseInstances.start::parameters.body,
  "SAP Database server instance start request body."
);
@@doc(SAPDatabaseInstances.stop::parameters.body,
  "Stop request for the database instance of the SAP system."
);
