import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Azure Active Directory only authentication.
 */
@parentResource(ManagedInstance)
model ManagedInstanceAzureADOnlyAuthentication
  is Azure.ResourceManager.ProxyResource<ManagedInstanceAzureADOnlyAuthProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceAzureADOnlyAuthentication,
    KeyName = "authenticationName",
    SegmentName = "azureADOnlyAuthentications",
    NamePattern = "",
    Type = AuthenticationName
  >;
}

@armResourceOperations
interface ManagedInstanceAzureADOnlyAuthentications {
  /**
   * Gets a specific Azure Active Directory only authentication property.
   */
  get is ArmResourceRead<ManagedInstanceAzureADOnlyAuthentication>;

  /**
   * Sets Server Active Directory only authentication property or updates an existing server Active Directory only authentication property.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedInstanceAzureADOnlyAuthentication,
    Response = ArmResourceUpdatedResponse<ManagedInstanceAzureADOnlyAuthentication> | ArmResourceCreatedResponse<
      ManagedInstanceAzureADOnlyAuthentication,
      ArmLroLocationHeader<FinalResult = ManagedInstanceAzureADOnlyAuthentication> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes an existing server Active Directory only authentication property.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedInstanceAzureADOnlyAuthentication,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of server Azure Active Directory only authentications.
   */
  listByInstance is ArmResourceListByParent<ManagedInstanceAzureADOnlyAuthentication>;
}

@@doc(ManagedInstanceAzureADOnlyAuthentication.name,
  "The name of server azure active directory only authentication."
);
@@doc(ManagedInstanceAzureADOnlyAuthentication.properties,
  "Resource properties."
);
@@doc(ManagedInstanceAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating an Active Directory only authentication property."
);
