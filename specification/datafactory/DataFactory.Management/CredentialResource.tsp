import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Credential resource type.
 */
@parentResource(Factory)
model CredentialResource
  is Azure.ResourceManager.ProxyResource<Credential, false> {
  ...ResourceNameParameter<
    Resource = CredentialResource,
    KeyName = "credentialName",
    SegmentName = "credentials",
    NamePattern = "^([_A-Za-z0-9]|([_A-Za-z0-9][-_A-Za-z0-9]{0,125}[_A-Za-z0-9]))$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface CredentialResources {
  /**
   * Gets a credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CredentialOperations_Get")
  get is ArmResourceRead<
    CredentialResource,
    Parameters = {
      /**
       * ETag of the credential entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates a credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("CredentialOperations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CredentialResource,
    Parameters = {
      /**
       * ETag of the credential entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<CredentialResource>
  >;

  /**
   * Deletes a credential.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CredentialOperations_Delete")
  delete is ArmResourceDeleteSync<CredentialResource>;

  /**
   * List credentials.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CredentialOperations_ListByFactory")
  listByFactory is ArmResourceListByParent<
    CredentialResource,
    Response = ArmResponse<CredentialListResponse>
  >;
}

@@maxLength(CredentialResource.name, 127);
@@minLength(CredentialResource.name, 1);
@@doc(CredentialResource.name, "Credential name");
@@doc(CredentialResource.properties, "Properties of credentials.");
@@doc(CredentialResources.createOrUpdate::parameters.resource,
  "Credential resource definition."
);
