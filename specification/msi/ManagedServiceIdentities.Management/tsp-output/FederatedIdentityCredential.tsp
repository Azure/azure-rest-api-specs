import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Identity.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedServiceIdentities;
@doc("Describes a federated identity credential.")
@parentResource(Identity)
model FederatedIdentityCredential
  is ProxyResource<FederatedIdentityCredentialProperties> {
  @doc("The name of the federated identity credential resource.")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{2,119}$")
  @path
  @key("federatedIdentityCredentialResourceName")
  @segment("federatedIdentityCredentials")
  name: string;
}

@armResourceOperations
interface FederatedIdentityCredentials {
  @doc("Gets the federated identity credential.")
  get is ArmResourceRead<FederatedIdentityCredential>;
  @doc("Create or update a federated identity credential under the specified user assigned identity.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<FederatedIdentityCredential>;
  @doc("Deletes the federated identity credential.")
  delete is ArmResourceDeleteSync<FederatedIdentityCredential>;
  @doc("Lists all the federated identity credentials under the specified user assigned identity.")
  list is ArmResourceListByParent<
    FederatedIdentityCredential,
    {
      ...BaseParameters<FederatedIdentityCredential>;

      @doc("Number of records to return.")
      @minValue(1)
      @query("$top")
      $top?: int32;

      @doc("A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}
