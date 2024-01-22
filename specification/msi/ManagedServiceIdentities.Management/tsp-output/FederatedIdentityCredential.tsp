import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Identity.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedIdentity;
/**
 * Describes a federated identity credential.
 */
@parentResource(Identity)
model FederatedIdentityCredential
  is ProxyResource<FederatedIdentityCredentialProperties> {
  /**
   * The name of the federated identity credential resource.
   */
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{2,119}$")
  @path
  @key("federatedIdentityCredentialResourceName")
  @segment("federatedIdentityCredentials")
  name: string;
}

@armResourceOperations
interface FederatedIdentityCredentials {
  /**
   * Gets the federated identity credential.
   */
  get is ArmResourceRead<FederatedIdentityCredential>;

  /**
   * Create or update a federated identity credential under the specified user assigned identity.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<FederatedIdentityCredential>;

  /**
   * Deletes the federated identity credential.
   */
  delete is ArmResourceDeleteSync<FederatedIdentityCredential>;

  /**
   * Lists all the federated identity credentials under the specified user assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FederatedIdentityCredentials_List")
  list is ArmResourceListByParent<
    FederatedIdentityCredential,
    {
      ...BaseParameters<FederatedIdentityCredential>;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@projectedName(FederatedIdentityCredentials.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(FederatedIdentityCredentials.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(FederatedIdentityCredentials.createOrUpdate::parameters.resource,
  "Parameters to create or update the federated identity credential."
);
