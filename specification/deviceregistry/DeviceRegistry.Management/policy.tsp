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

@added(Versions.v2025_08_01_preview)
@doc("A Credential Policy")
@parentResource(Credential)
model Policy is Azure.ResourceManager.TrackedResource<PolicyProperties> {
  @doc("The name of the Policy tracked resource.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @key("policyName")
  @segment("policies")
  @path
  name: string;
}

@added(Versions.v2025_08_01_preview)
@doc("Details of the Credential Policy.")
model PolicyProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The certificate configuration.")
  certificate?: CertificateConfiguration;

  @added(Versions.v2026_11_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Globally unique, immutable, non-reusable identifier of the Policy resource.")
  uuid?: string;
}

@added(Versions.v2025_08_01_preview)
@doc("The certificate configuration.")
model CertificateConfiguration {
  @doc("The configuration to set up an ICA.")
  certificateAuthorityConfiguration: CertificateAuthorityConfiguration;

  @doc("The leaf certificate configuration.")
  leafCertificateConfiguration: LeafCertificateConfiguration;
}

@added(Versions.v2025_08_01_preview)
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

@added(Versions.v2025_08_01_preview)
@doc("Supported key types.")
union SupportedKeyType {
  string,

  @doc("Indicate the ECC key type.")
  ECC: "ECC",
}

@added(Versions.v2025_08_01_preview)
@doc("The leaf certificate configuration.")
model LeafCertificateConfiguration {
  @doc("The validity period in days.")
  validityPeriodInDays: int32;
}

// ============================================================
// Explicit update models for PATCH operations
// ============================================================

@added(Versions.v2025_08_01_preview)
@doc("Update model for Policy.")
model PolicyUpdate {
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<Policy>;

  @doc("The resource-specific properties for this resource.")
  properties?: PolicyUpdateProperties;
}

@added(Versions.v2025_08_01_preview)
@doc("Updatable properties for Policy.")
model PolicyUpdateProperties {
  @doc("The certificate configuration for update.")
  certificate?: CertificateConfigurationUpdate;
}

@added(Versions.v2025_08_01_preview)
@doc("Certificate configuration for update operations. Only includes updatable fields.")
model CertificateConfigurationUpdate {
  // NOTE: certificateAuthorityConfiguration is intentionally excluded.
  // keyType is immutable after creation.

  @doc("The leaf certificate configuration.")
  leafCertificateConfiguration?: LeafCertificateConfigurationUpdate;
}

@added(Versions.v2025_08_01_preview)
@doc("Leaf certificate configuration for update operations.")
model LeafCertificateConfigurationUpdate {
  @doc("The validity period in days.")
  validityPeriodInDays?: int32;
}

@added(Versions.v2025_08_01_preview)
@armResourceOperations
interface Policies {
  get is ArmResourceRead<Policy>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Policy>;
  delete is ArmResourceDeleteWithoutOkAsync<Policy>;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Policy, PolicyUpdate>;
  listByCredential is ArmResourceListByParent<Policy>;
}
