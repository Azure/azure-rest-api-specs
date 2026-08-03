import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Azure Active Directory only authentication.
 */
@parentResource(ManagedInstance)
model ManagedInstanceAzureADOnlyAuthentication
  is ProxyResource<ManagedInstanceAzureADOnlyAuthProperties> {
  /**
   * The name of server azure active directory only authentication.
   */
  @path
  @key("authenticationName")
  @segment("azureADOnlyAuthentications")
  name: AuthenticationName;
}

@armResourceOperations
interface ManagedInstanceAzureADOnlyAuthentications {
  /**
   * Gets a specific Azure Active Directory only authentication property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceAzureADOnlyAuthentications_Get")
  get is ArmResourceRead<ManagedInstanceAzureADOnlyAuthentication>;

  /**
   * Sets Server Active Directory only authentication property or updates an existing server Active Directory only authentication property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceAzureADOnlyAuthentications_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedInstanceAzureADOnlyAuthentication>;

  /**
   * Deletes an existing server Active Directory only authentication property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceAzureADOnlyAuthentications_Delete")
  delete is ArmResourceDeleteAsync<ManagedInstanceAzureADOnlyAuthentication>;

  /**
   * Gets a list of server Azure Active Directory only authentications.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceAzureADOnlyAuthentications_ListByInstance")
  listByInstance is ArmResourceListByParent<ManagedInstanceAzureADOnlyAuthentication>;
}

@@projectedName(ManagedInstanceAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating an Active Directory only authentication property."
);
