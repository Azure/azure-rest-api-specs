import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2025_11_01_preview)
@doc("A Credential Policy")
@parentResource(Credential)
model Policy is TrackedResource<PolicyProperties> {
  @doc("The name of the Policy tracked resource.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @key("policyName")
  @segment("policies")
  @path
  name: string;
}

@added(Versions.v2025_11_01_preview)
@doc("Details of the Credential Policy.")
model PolicyProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The certificate configuration.")
  certificate?: CertificateConfiguration;
}

@added(Versions.v2025_11_01_preview)
@doc("The certificate configuration.")
model CertificateConfiguration {
  @doc("The configuration to set up an ICA.")
  certificateAuthorityConfiguration: CertificateAuthorityConfiguration;

  @doc("The leaf certificate configuration.")
  leafCertificateConfiguration: LeafCertificateConfiguration;
}

@added(Versions.v2025_11_01_preview)
@doc("The configuration to set up an ICA.")
model CertificateAuthorityConfiguration {
  @doc("Crypto type: ECC.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  keyType: SupportedKeyType;

  @doc("Certificate subject.")
  @visibility(Lifecycle.Read)
  subject?: string;

  @doc("Certificate is valid not before this date. Format ISO8601. Generated based on on validity period.")
  @visibility(Lifecycle.Read)
  validityNotBefore?: utcDateTime;

  @doc("Certificate is valid not after this date. Format ISO8601. Generated based on validity period.")
  @visibility(Lifecycle.Read)
  validityNotAfter?: utcDateTime;
}

@added(Versions.v2025_11_01_preview)
@doc("Supported key types.")
union SupportedKeyType {
  string,

  @doc("Indicates the ECC key type.")
  ECC: "ECC",
}

@added(Versions.v2025_11_01_preview)
@doc("The leaf certificate configuration.")
model LeafCertificateConfiguration {
  @doc("The validity period in days.")
  @minValue(7)
  @maxValue(90)
  validityPeriodInDays: int32;
}

@added(Versions.v2025_11_01_preview)
@armResourceOperations
interface Policies {
  get is ArmResourceRead<Policy>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Policy>;
  delete is ArmResourceDeleteWithoutOkAsync<Policy>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    Policy,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Policy,
      PolicyProperties
    >
  >;
  listByResourceGroup is ArmResourceListByParent<Policy>;
}
