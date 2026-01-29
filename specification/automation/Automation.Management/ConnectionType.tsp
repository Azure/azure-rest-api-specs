import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the connection type.
 */
@parentResource(AutomationAccount)
model ConnectionType
  is Azure.ResourceManager.ProxyResource<ConnectionTypeProperties> {
  ...ResourceNameParameter<
    Resource = ConnectionType,
    KeyName = "connectionTypeName",
    SegmentName = "connectionTypes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ConnectionTypes {
  /**
   * Retrieve the connection type identified by connection type name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionType_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/connectiontypeoperations")
  get is ArmResourceRead<ConnectionType>;

  /**
   * Create a connection type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ConnectionType_CreateOrUpdate")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/connectiontypeoperations")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    ConnectionType,
    Request = ConnectionTypeCreateOrUpdateParameters,
    Response = ArmResourceCreatedSyncResponse<ConnectionType>
  >;

  /**
   * Delete the connection type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionType_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/connectiontypeoperations")
  delete is ArmResourceDeleteSync<ConnectionType>;

  /**
   * Retrieve a list of connection types.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectionType_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/connectiontypeoperations")
  listByAutomationAccount is ArmResourceListByParent<ConnectionType>;
}

@@doc(ConnectionType.name, "The name of connection type.");
@@doc(ConnectionType.properties,
  "Gets or sets the properties of the connection type."
);
@@doc(ConnectionTypes.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update connection type operation."
);
