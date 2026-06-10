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

@added(Versions.v2026_11_01_preview)
@doc("A Certificate Policy resource.")
@parentResource(Credential)
model CertificatePolicy
  is Azure.ResourceManager.TrackedResource<CertificatePolicyProperties> {
  @doc("The name of the Certificate Policy resource.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @key("certificatePolicyName")
  @segment("certificatePolicies")
  @path
  name: string;
}

@added(Versions.v2026_11_01_preview)
@doc("Details of the Certificate Policy resource.")
model CertificatePolicyProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Globally unique, immutable, non-reusable identifier of the Certificate Policy resource.")
  uuid?: string;

  @doc("The certificate configuration.")
  certificate?: CertificatePolicyConfiguration;
}

@added(Versions.v2026_11_01_preview)
@doc("The Certificate Policy certificate configuration.")
model CertificatePolicyConfiguration {
  @doc("The validity period in days.")
  validityPeriodInDays: int32;
}

@added(Versions.v2026_11_01_preview)
@doc("Update model for Certificate Policy.")
model CertificatePolicyUpdate {
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<CertificatePolicy>;

  @doc("The resource-specific properties for this resource.")
  properties?: CertificatePolicyUpdateProperties;
}

@added(Versions.v2026_11_01_preview)
@doc("Updatable properties for Certificate Policy.")
model CertificatePolicyUpdateProperties {
  @doc("The certificate configuration for update.")
  certificate?: CertificatePolicyCertificateConfigurationUpdate;
}

@added(Versions.v2026_11_01_preview)
@doc("Certificate Policy certificate configuration for update operations.")
model CertificatePolicyCertificateConfigurationUpdate {
  @doc("The leaf certificate configuration.")
  leafCertificateConfiguration?: LeafCertificateConfigurationUpdate;
}

@added(Versions.v2026_11_01_preview)
@armResourceOperations
interface CertificatePolicies {
  get is ArmResourceRead<CertificatePolicy>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CertificatePolicy>;
  delete is ArmResourceDeleteWithoutOkAsync<CertificatePolicy>;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<CertificatePolicy, CertificatePolicyUpdate>;
  listByCredential is ArmResourceListByParent<CertificatePolicy>;
}
