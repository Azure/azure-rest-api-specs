import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DurableTask;

@doc("A transparent data encryption resource belonging to the scheduler")
@added(Versions.v2026_05_01_Preview)
@parentResource(Scheduler)
@singleton
model TransparentDataEncryption
  is Azure.ResourceManager.ProxyResource<TransparentDataEncryptionProperties> {
  ...ResourceNameParameter<
    TransparentDataEncryption,
    "transparentDataEncryptionName",
    "transparentDataEncryptions"
  >;
}

@doc("The transparent data encryption settings for the resource")
@added(Versions.v2026_05_01_Preview)
model TransparentDataEncryptionProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("The key source for the transparent data encryption")
  keySource: TransparentDataEncryptionKeySource;

  @doc("The URI of the key in Key Vault to be used for transparent data encryption")
  keyVaultKeyUri?: url;
}

@added(Versions.v2026_05_01_Preview)
@doc("The key source for the transparent data encryption")
union TransparentDataEncryptionKeySource {
  string,

  @doc("The key source is Microsoft-managed")
  MicrosoftManaged: "MicrosoftManaged",

  @doc("The key source is customer-managed")
  CustomerManaged: "CustomerManaged",
}

@added(Versions.v2026_05_01_Preview)
@armResourceOperations(TransparentDataEncryption)
interface TransparentDataEncryptions {
  @doc("Get a Transparent Data Encryption")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<TransparentDataEncryption>;
  @doc("Create or Update a Transparent Data Encryption")
  @errorsDoc("Validation error: required parameters are missing")
  createOrReplace is ArmResourceCreateOrReplaceAsync<TransparentDataEncryption>;
  @doc("Delete a Transparent Data Encryption")
  delete is ArmResourceDeleteWithoutOkAsync<TransparentDataEncryption>;
  @doc("List Transparent Data Encryptions")
  listByScheduler is ArmResourceListByParent<TransparentDataEncryption>;
}
