import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataFactory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Credential resource type.")
@parentResource(DataFactory)
model DataFactoryManagedIdentityCredential
  is ProxyResource<ManagedIdentityCredential> {
  @doc("Credential name")
  @maxLength(127)
  @minLength(1)
  @pattern("^([_A-Za-z0-9]|([_A-Za-z0-9][-_A-Za-z0-9]{0,125}[_A-Za-z0-9]))$")
  @path
  @key("credentialName")
  @segment("credentials")
  name: string;
}

@armResourceOperations
interface DataFactoryManagedIdentityCredentials {
  @doc("Gets a credential.")
  get is ArmResourceRead<
    DataFactoryManagedIdentityCredential,
    {
      ...BaseParameters<DataFactoryManagedIdentityCredential>;

      @doc("ETag of the credential entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a credential.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFactoryManagedIdentityCredential,
    {
      ...BaseParameters<DataFactoryManagedIdentityCredential>;

      @doc("ETag of the credential entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a credential.")
  delete is ArmResourceDeleteSync<DataFactoryManagedIdentityCredential>;
  @doc("List credentials.")
  listByFactory is ArmResourceListByParent<DataFactoryManagedIdentityCredential>;
}
