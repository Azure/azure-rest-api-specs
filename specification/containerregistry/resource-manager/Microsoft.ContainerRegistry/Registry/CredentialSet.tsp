import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./CredentialSet.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a credential set resource for a container registry.
 */
@parentResource(Registry)
model CredentialSet
  is Azure.ResourceManager.ProxyResource<CredentialSetProperties> {
  ...ResourceNameParameter<
    Resource = CredentialSet,
    KeyName = "credentialSetName",
    SegmentName = "credentialSets",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * Identities associated with the resource. This is used to access the KeyVault secrets.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;
}

@armResourceOperations
interface CredentialSets {
  /**
   * Gets the properties of the specified credential set resource.
   */
  get is ArmResourceRead<CredentialSet>;

  /**
   * Creates a credential set for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<CredentialSet>;

  /**
   * Updates a credential set for a container registry with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    CredentialSet,
    PatchModel = CredentialSetUpdateParameters,
    Response = ArmResponse<CredentialSet> | ArmResourceCreatedResponse<
      CredentialSet,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = CredentialSet> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a credential set from a container registry.
   */
  delete is ArmResourceDeleteWithoutOkAsync<CredentialSet>;

  /**
   * Lists all credential set resources for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    CredentialSet,
    Response = ArmResponse<CredentialSetListResult>
  >;
}

@@maxLength(CredentialSet.name, 50);
@@minLength(CredentialSet.name, 5);
@@doc(CredentialSet.name, "The name of the credential set.");
@@doc(CredentialSet.properties, "The properties of the credential set.");
@@doc(CredentialSets.create::parameters.resource,
  "The parameters for creating a credential set."
);
@@doc(CredentialSets.update::parameters.properties,
  "The parameters for updating a credential set."
);
