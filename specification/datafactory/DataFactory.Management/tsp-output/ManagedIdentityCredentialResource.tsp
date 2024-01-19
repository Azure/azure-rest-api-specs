import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
@doc("Credential resource type.")
@parentResource(Factory)
model ManagedIdentityCredentialResource
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
interface ManagedIdentityCredentialResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a credential.")
  @operationId("CredentialOperations_Get")
  get is ArmResourceRead<
    ManagedIdentityCredentialResource,
    {
      ...BaseParameters<ManagedIdentityCredentialResource>;

      @doc("ETag of the credential entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a credential.")
  @operationId("CredentialOperations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ManagedIdentityCredentialResource,
    {
      ...BaseParameters<ManagedIdentityCredentialResource>;

      @doc("ETag of the credential entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a credential.")
  @operationId("CredentialOperations_Delete")
  delete is ArmResourceDeleteSync<ManagedIdentityCredentialResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List credentials.")
  @operationId("CredentialOperations_ListByFactory")
  listByFactory is ArmResourceListByParent<ManagedIdentityCredentialResource>;
}

@@projectedName(ManagedIdentityCredentialResources.createOrUpdate::parameters.resource,
  "json",
  "credential"
);
@@extension(ManagedIdentityCredentialResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "credential"
);
@@doc(ManagedIdentityCredentialResources.createOrUpdate::parameters.resource,
  "Credential resource definition."
);
