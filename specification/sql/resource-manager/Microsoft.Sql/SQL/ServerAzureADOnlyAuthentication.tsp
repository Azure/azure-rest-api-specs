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
 * Azure Active Directory only authentication.
 */
@parentResource(Server)
model ServerAzureADOnlyAuthentication
  is Azure.ResourceManager.ProxyResource<AzureADOnlyAuthProperties> {
  ...ResourceNameParameter<
    Resource = ServerAzureADOnlyAuthentication,
    KeyName = "authenticationName",
    SegmentName = "azureADOnlyAuthentications",
    NamePattern = "",
    Type = AuthenticationName
  >;
}

@armResourceOperations
interface ServerAzureADOnlyAuthentications {
  /**
   * Gets a specific Azure Active Directory only authentication property.
   */
  get is ArmResourceRead<ServerAzureADOnlyAuthentication>;

  /**
   * Sets Server Active Directory only authentication property or updates an existing server Active Directory only authentication property.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerAzureADOnlyAuthentication,
    Response = ArmResourceUpdatedResponse<ServerAzureADOnlyAuthentication> | ArmResourceCreatedResponse<
      ServerAzureADOnlyAuthentication,
      ArmLroLocationHeader<FinalResult = ServerAzureADOnlyAuthentication> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes an existing server Active Directory only authentication property.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerAzureADOnlyAuthentication,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of server Azure Active Directory only authentications.
   */
  listByServer is ArmResourceListByParent<ServerAzureADOnlyAuthentication>;
}

@@doc(ServerAzureADOnlyAuthentication.name,
  "The name of server azure active directory only authentication."
);
@@doc(ServerAzureADOnlyAuthentication.properties, "Resource properties.");
@@doc(ServerAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating an Active Directory only authentication property."
);
