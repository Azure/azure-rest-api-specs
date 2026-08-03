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
@doc("Define the Database resource.")
@parentResource(SAPVirtualInstance)
model SAPDatabaseInstance is TrackedResource<SAPDatabaseProperties> {
  @doc("Database resource name string modeled as parameter for auto generation to work correctly.")
  @pattern("^.*")
  @path
  @key("databaseInstanceName")
  @segment("databaseInstances")
  name: string;
}

@armResourceOperations
interface SAPDatabaseInstances {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the SAP Database Instance resource.")
  @operationId("SAPDatabaseInstances_Get")
  get is ArmResourceRead<SAPDatabaseInstance>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the Database resource corresponding to the Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.")
  @operationId("SAPDatabaseInstances_Create")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  create is ArmResourceCreateOrUpdateAsync<
    SAPDatabaseInstance,
    BaseParameters<SAPDatabaseInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the Database instance resource. This can be used to update tags on the resource.")
  @operationId("SAPDatabaseInstances_Update")
  update is ArmCustomPatchSync<
    SAPDatabaseInstance,
    UpdateSAPDatabaseInstanceRequest
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the Database resource corresponding to a Virtual Instance for SAP solutions resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete by end user will return a Bad Request error.")
  @operationId("SAPDatabaseInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SAPDatabaseInstance,
    BaseParameters<SAPDatabaseInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the Database resources associated with a Virtual Instance for SAP solutions resource.")
  @operationId("SAPDatabaseInstances_List")
  list is ArmResourceListByParent<SAPDatabaseInstance>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Starts the database instance of the SAP system.")
  @operationId("SAPDatabaseInstances_StartInstance")
  @action("start")
  startInstance is ArmResourceActionAsync<
    SAPDatabaseInstance,
    StartRequest,
    OperationStatusResult,
    BaseParameters<SAPDatabaseInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stops the database instance of the SAP system.")
  @operationId("SAPDatabaseInstances_StopInstance")
  @action("stop")
  stopInstance is ArmResourceActionAsync<
    SAPDatabaseInstance,
    StopRequest,
    OperationStatusResult,
    BaseParameters<SAPDatabaseInstance>,
    ArmLroLocationHeader
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
@@doc(SAPDatabaseInstances.startInstance::parameters.body,
  "SAP Database server instance start request body."
);
@@doc(SAPDatabaseInstances.stopInstance::parameters.body,
  "Stop request for the database instance of the SAP system."
);
