import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "singleton"
@added(Versions.v2025_02_01)
@doc("A Credential Resource")
@parentResource(Namespace)
model Credential is TrackedResource<CredentialProperties> {
  @doc("The name of the Credential tracked resource.")
  @key("credentialName")
  @segment("credentials")
  @path
  name: "default";
}

@added(Versions.v2025_02_01)
@doc("Details of the Credential Resource.")
model CredentialProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Configuration for using a self-signed certificate for device authentication. Only one of 'selfSignedCertificate' or 'byocaCertificate' should be specified.")
  selfSignedCertificate?: SelfSignedCertificateConfiguration;

  @doc("Configuration for using a Bring Your Own Certificate Authority (BYOCA) certificate for device authentication. Only one of 'selfSignedCertificate' or 'byocaCertificate' should be specified.")
  byocaCertificate?: ByocaCertificateConfiguration;

  @visibility(Lifecycle.Read)
  @doc("The root certificate thumbprint for the credential. This is automatically populated when a policy with BYOCA is configured.")
  rootCertificateThumbprint?: string;

  @visibility(Lifecycle.Read)
  @doc("The issuer certificate thumbprint for the credential. This is automatically populated when a policy with BYOCA is configured.")
  issuerCertificateThumbprint?: string;
}

@added(Versions.v2025_02_01)
@doc("Configuration for using a self-signed certificate for device authentication.")
model SelfSignedCertificateConfiguration {
  @doc("Indicates whether self-signed certificate authentication is enabled.")
  enabled: boolean;
}

@added(Versions.v2025_02_01)
@doc("Configuration for using a Bring Your Own Certificate Authority (BYOCA) certificate for device authentication.")
model ByocaCertificateConfiguration {
  @doc("The URI of the Azure Key Vault where the BYOCA certificate chain is stored.")
  @secret
  keyVaultUri: string;
}

@added(Versions.v2025_02_01)
@armResourceOperations
interface Credentials {
  get is ArmResourceRead<Credential>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Credential>;
  delete is ArmResourceDeleteWithoutOkAsync<Credential>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    Credential,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Credential,
      CredentialProperties
    >
  >;
  listByResourceGroup is ArmResourceListByParent<Credential>;
  synchronize is ArmResourceActionNoResponseContentAsync<Credential, void>;
}
