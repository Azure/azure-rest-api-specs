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

  @added(Versions.v2026_04_01)
  @doc("The Bring Your Own Root (BYOR) configuration.")
  bringYourOwnRoot?: BringYourOwnRoot;
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
@doc("Configuration for Bring Your Own Root (BYOR). When enabled, customers provide their own CA-signed certificates instead of using the service-managed CA.")
model BringYourOwnRoot {
  @doc("Indicates whether BYOR is enabled for this policy. This can only be set at creation time and cannot be changed afterward.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  enabled: boolean;

  @doc("The certificate is nearing expiration (within renewal window) or has expired. A new CSR has been generated and is waiting for the customer to provide a new signed certificate.")
  @visibility(Lifecycle.Read)
  certificateSigningRequest?: string;

  @added(Versions.v2026_04_01)
  @doc("The status of the BYOR configuration, indicating the current state of the certificate lifecycle.")
  @visibility(Lifecycle.Read)
  status?: BringYourOwnRootStatus;
}

@added(Versions.v2026_04_01)
@doc("Status of the Bring Your Own Root (BYOR) configuration.")
union BringYourOwnRootStatus {
  string,

  @doc("The CSR has been generated and is waiting for the customer to provide the signed certificate.")
  PendingActivation: "PendingActivation",

  @doc("The signed certificate has been successfully uploaded and validated, and the CA is active.")
  Active: "Active",

  @doc("The certificate is nearing expiration (within renewal window) or has expired. A new CSR has been generated and is waiting for the customer to provide a new signed certificate.")
  ActiveButPendingRenewal: "ActiveButPendingRenewal",

  @doc("The certificate activation or rotation has failed. Check error details for more information.")
  Failed: "Failed",
}

@added(Versions.v2026_04_01)
@doc("Request payload for activating a BYOR policy with a customer-provided signed certificate.")
model ActivatePolicyRequest {
  @doc("The customer-provided certificate, signed by their own CA, in PEM format. This certificate will be used to activate the BYOR policy.")
  signedCertificate: string;
}

@added(Versions.v2026_04_01)
@doc("Response from the activate operation, indicating success or failure of the certificate activation.")
model ActivatePolicy {
  @doc("Indicates whether the certificate was successfully activated.")
  success: boolean;

  @doc("Error message if activation failed.")
  errorMessage?: string;
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

  @added(Versions.v2026_04_01)
  @doc("Activates or renews a BYOR policy by accepting a customer-provided signed certificate.")
  @action("activate")
  @armResourceAction(Policy)
  @post
  activate(
    ...ResourceInstanceParameters<Policy>,

    @doc("The activation request containing the customer-provided signed certificate.")
    @body
    request: ActivatePolicyRequest,
  ): ArmResponse<ActivatePolicy> | ErrorResponse;
}
