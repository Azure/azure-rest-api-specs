import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SAPVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Workloads;
@doc("Define the Database resource.")
@parentResource(SAPVirtualInstance)
model SAPDatabaseInstance is TrackedResource<SAPDatabaseProperties> {
  @doc("Database resource name string modeled as parameter for auto generation to work correctly.")
  @key("databaseInstanceName")
  @segment("databaseInstances")
  name: string;
}

@armResourceOperations
interface SAPDatabaseInstances {
  @doc("Gets the SAP Database Instance resource.")
  get is ArmResourceRead<SAPDatabaseInstance>;
  @doc("Creates the Database resource corresponding to the Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.")
  create is ArmResourceCreateOrUpdateAsync<SAPDatabaseInstance>;
  @doc("Updates the Database resource.")
  update is ArmCustomPatchAsync<
    SAPDatabaseInstance,
    UpdateSAPDatabaseInstanceRequest
  >;
  @doc("Deletes the Database resource corresponding to a Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete by end user will return a Bad Request error.")
  delete is ArmResourceDeleteAsync<SAPDatabaseInstance>;
  @doc("Lists the Database resources associated with a Virtual Instance for SAP solutions resource.")
  list is ArmResourceListByParent<SAPDatabaseInstance>;
  @doc("Starts the database instance of the SAP system.")
  startInstance is ArmResourceActionAsync<
    SAPDatabaseInstance,
    void,
    OperationStatusResult
  >;
  @doc("Stops the database instance of the SAP system.")
  stopInstance is ArmResourceActionAsync<
    SAPDatabaseInstance,
    StopRequest,
    OperationStatusResult
  >;
}
