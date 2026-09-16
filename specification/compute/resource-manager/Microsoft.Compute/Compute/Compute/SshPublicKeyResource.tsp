import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Common;

namespace Compute;
/**
 * Specifies information about the SSH public key.
 */
model SshPublicKeyResource
  is Azure.ResourceManager.TrackedResource<SshPublicKeyResourceProperties> {
  ...ResourceNameParameter<
    Resource = SshPublicKeyResource,
    KeyName = "sshPublicKeyName",
    SegmentName = "sshPublicKeys",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
@tag("SshPublicKeys")
interface SshPublicKeyResources {
  /**
   * Retrieves information about an SSH public key.
   */
  get is ComputeResourceRead<SshPublicKeyResource>;

  /**
   * Creates a new SSH public key resource.
   */
  create is ComputeResourceCreateOrReplaceSync<SshPublicKeyResource>;

  /**
   * Updates a new SSH public key resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchSync<
    SshPublicKeyResource,
    SshPublicKeyUpdateResource
  >;

  /**
   * Delete an SSH public key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  delete is ComputeResourceDeleteSync<SshPublicKeyResource>;

  /**
   * Lists all of the SSH public keys in the specified resource group. Use the nextLink property in the response to get the next page of SSH public keys.
   */
  listByResourceGroup is ComputeResourceListByParent<
    SshPublicKeyResource,
    Response = SshPublicKeysGroupListResult
  >;

  /**
   * Lists all of the SSH public keys in the subscription. Use the nextLink property in the response to get the next page of SSH public keys.
   */
  listBySubscription is ComputeListBySubscription<
    SshPublicKeyResource,
    Response = SshPublicKeysGroupListResult
  >;

  /**
   * Generates and returns a public/private key pair and populates the SSH public key resource with the public key. The length of the key will be 3072 bits. This operation can only be performed once per SSH public key resource.
   */
  generateKeyPair is ComputeResourceActionSync<
    SshPublicKeyResource,
    Request = SshGenerateKeyPairInputParameters,
    Response = SshPublicKeyGenerateKeyPairResult,
    OptionalRequestBody = true
  >;
}

@@doc(SshPublicKeyResource.name, "The name of the SSH public key.");
@@doc(SshPublicKeyResource.properties, "Properties of the SSH public key.");
@@doc(
  SshPublicKeyResources.create::parameters.resource,
  "Parameters supplied to create the SSH public key."
);
@@doc(
  SshPublicKeyResources.update::parameters.properties,
  "Parameters supplied to update the SSH public key."
);
@@doc(
  SshPublicKeyResources.generateKeyPair::parameters.body,
  "Parameters supplied to generate the SSH public key."
);
