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

namespace Microsoft.Sql;
/**
 * Azure Active Directory administrator.
 */
@parentResource(Server)
model ServerAzureADAdministrator
  is Azure.ResourceManager.ProxyResource<AdministratorProperties> {
  ...ResourceNameParameter<
    Resource = ServerAzureADAdministrator,
    KeyName = "administratorName",
    SegmentName = "administrators",
    NamePattern = "",
    Type = AdministratorName
  >;
}

@armResourceOperations
interface ServerAzureADAdministrators {
  /**
   * Gets a Azure Active Directory administrator.
   */
  get is ArmResourceRead<ServerAzureADAdministrator>;

  /**
   * Creates or updates an existing Azure Active Directory administrator.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerAzureADAdministrator,
    Response = ArmResourceUpdatedResponse<ServerAzureADAdministrator> | ArmResourceCreatedResponse<
      ServerAzureADAdministrator,
      ArmLroLocationHeader<FinalResult = ServerAzureADAdministrator> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes the Azure Active Directory administrator with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerAzureADAdministrator,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of Azure Active Directory administrators in a server.
   */
  listByServer is ArmResourceListByParent<ServerAzureADAdministrator>;
}

@@doc(ServerAzureADAdministrator.name,
  "The name of server active directory administrator."
);
@@doc(ServerAzureADAdministrator.properties, "Resource properties.");
@@doc(ServerAzureADAdministrators.createOrUpdate::parameters.resource,
  "The requested Azure Active Directory administrator Resource state."
);
