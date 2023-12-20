import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SapVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Workloads;
@doc("Define the Database resource.")
@parentResource(SapVirtualInstance)
model SapDatabaseInstance is TrackedResource<SAPDatabaseProperties> {
  @doc("Database resource name string modeled as parameter for auto generation to work correctly.")
  @path
  @key("databaseInstanceName")
  @segment("databaseInstances")
  name: string;
}

@armResourceOperations
interface SapDatabaseInstances {
  @doc("Gets the SAP Database Instance resource.")
  get is ArmResourceRead<SapDatabaseInstance>;
  @doc("Creates the Database resource corresponding to the Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.")
  create is ArmResourceCreateOrUpdateAsync<SapDatabaseInstance>;
  @doc("Updates the Database resource.")
  update is ArmTagsPatchAsync<SapDatabaseInstance>;
  @doc("Deletes the Database resource corresponding to a Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete by end user will return a Bad Request error.")
  delete is ArmResourceDeleteAsync<SapDatabaseInstance>;
  @doc("Lists the Database resources associated with a Virtual Instance for SAP solutions resource.")
  list is ArmResourceListByParent<SapDatabaseInstance>;
  @doc("Starts the database instance of the SAP system.")
  startInstance is ArmResourceActionAsync<
    SapDatabaseInstance,
    void,
    OperationStatusResult
  >;
  @doc("Stops the database instance of the SAP system.")
  stopInstance is ArmResourceActionAsync<
    SapDatabaseInstance,
    StopRequest,
    OperationStatusResult
  >;
}
