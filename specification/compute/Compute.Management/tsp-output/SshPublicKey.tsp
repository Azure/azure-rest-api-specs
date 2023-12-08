import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Compute;
@doc("Specifies information about the SSH public key.")
model SshPublicKey is TrackedResource<SshPublicKeyResourceProperties> {
  @doc("The name of the SSH public key.")
  @path
  @key("sshPublicKeyName")
  @segment("sshPublicKeys")
  name: string;
}

@armResourceOperations
interface SshPublicKeys {
  @doc("Retrieves information about an SSH public key.")
  get is ArmResourceRead<SshPublicKey>;
  @doc("Creates a new SSH public key resource.")
  create is ArmResourceCreateOrReplaceSync<SshPublicKey>;
  @doc("Updates a new SSH public key resource.")
  update is ArmResourcePatchSync<SshPublicKey, SshPublicKeyResourceProperties>;
  @doc("Delete an SSH public key.")
  delete is ArmResourceDeleteSync<SshPublicKey>;
  @doc("Lists all of the SSH public keys in the specified resource group. Use the nextLink property in the response to get the next page of SSH public keys.")
  listByResourceGroup is ArmResourceListByParent<SshPublicKey>;
  @doc("Lists all of the SSH public keys in the subscription. Use the nextLink property in the response to get the next page of SSH public keys.")
  listBySubscription is ArmListBySubscription<SshPublicKey>;
  @doc("Generates and returns a public/private key pair and populates the SSH public key resource with the public key. The length of the key will be 3072 bits. This operation can only be performed once per SSH public key resource.")
  generateKeyPair is ArmResourceActionSync<
    SshPublicKey,
    {},
    SshPublicKeyGenerateKeyPairResult
  >;
}
