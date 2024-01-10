import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataFactory;
@doc("Credential resource type.")
@parentResource(Factory)
model ManagedIdentityCredentialResource
  is ProxyResource<ManagedIdentityCredential> {
  @doc("Credential name")
  @maxLength(127)
  @minLength(1)
  @pattern("^([_A-Za-z0-9]|([_A-Za-z0-9][-_A-Za-z0-9]{0,125}[_A-Za-z0-9]))$")
  @key("credentialName")
  @segment("credentials")
  name: string;
}

@armResourceOperations
@projectedName("client", "CredentialOperations")
interface ManagedIdentityCredentialResources_CredentialOperations {
  @doc("Gets a credential.")
  get is ArmResourceRead<
    ManagedIdentityCredentialResource,
    {
      ...BaseParameters<ManagedIdentityCredentialResource>;

      @doc("ETag of the credential entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;

  @doc("Creates or updates a credential.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ManagedIdentityCredentialResource,
    {
      ...BaseParameters<ManagedIdentityCredentialResource>;

      @doc("ETag of the credential entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;

  @doc("Deletes a credential.")
  delete is ArmResourceDeleteSync<ManagedIdentityCredentialResource>;

  @doc("List credentials.")
  listByFactory is ArmResourceListByParent<ManagedIdentityCredentialResource>;
}
