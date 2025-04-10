import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents an Active Directory administrator.
 */
@parentResource(Server)
model ActiveDirectoryAdministrator
  is Azure.ResourceManager.ProxyResource<AdministratorProperties, false> {
  ...ResourceNameParameter<
    Resource = ActiveDirectoryAdministrator,
    KeyName = "objectId",
    SegmentName = "administrators",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ActiveDirectoryAdministrators {
  /**
   * Gets information about a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Administrators_Get")
  get is ArmResourceRead<ActiveDirectoryAdministrator>;

  /**
   * Creates a new server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Administrators_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ActiveDirectoryAdministrator,
    Response = ArmResourceUpdatedResponse<ActiveDirectoryAdministrator> | ArmResourceCreatedResponse<ActiveDirectoryAdministrator> | ArmAcceptedLroResponse
  >;

  /**
   * Deletes an Active Directory Administrator associated with the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Administrators_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ActiveDirectoryAdministrator,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the AAD administrators for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Administrators_ListByServer")
  listByServer is ArmResourceListByParent<ActiveDirectoryAdministrator>;
}

@@doc(ActiveDirectoryAdministrator.name,
  "Guid of the objectId for the administrator."
);
@@doc(ActiveDirectoryAdministrator.properties,
  "Properties of the active directory administrator."
);
@@doc(ActiveDirectoryAdministrators.create::parameters.resource,
  "The required parameters for adding an active directory administrator for a server."
);
