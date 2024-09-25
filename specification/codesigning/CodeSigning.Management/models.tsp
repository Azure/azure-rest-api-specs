import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CodeSigning;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
union ProvisioningState {
  string,

  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("Updating in progress.")
  Updating: "Updating",

  @doc("Deletion in progress.")
  Deleting: "Deleting",

  @doc("Resource creation started.")
  Accepted: "Accepted",
}

@doc("Type of the certificate")
union ProfileType {
  string,

  @doc("Used for signing files which are distributed publicly.")
  PublicTrust: "PublicTrust",

  @doc("Used for signing files which are distributed internally within organization or group boundary.")
  PrivateTrust: "PrivateTrust",

  @doc("Used for signing CI policy files.")
  PrivateTrustCIPolicy: "PrivateTrustCIPolicy",

  @doc("Used for signing files which are run in secure vbs enclave.")
  VBSEnclave: "VBSEnclave",

  @doc("Used for signing files for testing purpose.")
  PublicTrustTest: "PublicTrustTest",
}

@doc("Status of the certificate profiles.")
union CertificateProfileStatus {
  string,

  @doc("The certificate profile is active.")
  Active: "Active",

  @doc("The certificate profile is disabled.")
  Disabled: "Disabled",

  @doc("The certificate profile is suspended.")
  Suspended: "Suspended",
}

@doc("Status of the certificate")
union CertificateStatus {
  string,

  @doc("The certificate is active.")
  Active: "Active",

  @doc("The certificate is expired.")
  Expired: "Expired",

  @doc("The certificate is revoked.")
  Revoked: "Revoked",
}

@doc("Revocation status of the certificate.")
union RevocationStatus {
  string,

  @doc("Certificate revocation succeeded.")
  Succeeded: "Succeeded",

  @doc("Certificate revocation is in progress.")
  InProgress: "InProgress",

  @doc("Certificate revocation failed.")
  Failed: "Failed",
}

@doc("Name of the sku.")
union SkuName {
  string,

  @doc("Basic sku.")
  Basic: "Basic",

  @doc("Premium sku.")
  Premium: "Premium",
}

@doc("The reason that a trusted signing account name could not be used. The Reason element is only returned if nameAvailable is false.")
union NameUnavailabilityReason {
  string,

  @doc("Account name is invalid")
  AccountNameInvalid: "AccountNameInvalid",

  @doc("Account name already exists")
  AlreadyExists: "AlreadyExists",
}

@doc("Properties of the trusted signing account.")
model CodeSigningAccountProperties {
  @doc("The URI of the trusted signing account which is used during signing files.")
  @visibility("read")
  accountUri?: string;

  @doc("SKU of the trusted signing account.")
  sku?: AccountSku;

  @doc("Status of the current operation on trusted signing account.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("SKU of the trusted signing account.")
model AccountSku {
  @doc("Name of the SKU.")
  name: SkuName;
}

@doc("Parameters for creating or updating a trusted signing account.")
model CodeSigningAccountPatch {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Resource tags.")
  tags?: Record<string>;

  #suppress "deprecated" "Legacy flatten"
  @doc("Properties of the trusted signing account.")
  @Azure.ClientGenerator.Core.flattenProperty
  properties?: CodeSigningAccountPatchProperties;
}

@doc("Properties of the trusted signing account.")
model CodeSigningAccountPatchProperties {
  @doc("SKU of the trusted signing account.")
  sku?: AccountSku;
}

@doc("Properties of the certificate profile.")
model CertificateProfileProperties {
  @doc("Profile type of the certificate.")
  profileType: ProfileType;

  @doc("Used as CN in the certificate subject name.")
  @visibility("read")
  commonName?: string;

  @doc("Used as O in the certificate subject name.")
  @visibility("read")
  organization?: string;

  @doc("Used as OU in the private trust certificate subject name.")
  @visibility("read")
  organizationUnit?: string;

  @doc("Used as STREET in the certificate subject name.")
  @visibility("read")
  streetAddress?: string;

  @doc("Whether to include STREET in the certificate subject name.")
  includeStreetAddress?: boolean = false;

  @doc("Used as L in the certificate subject name.")
  @visibility("read")
  city?: string;

  @doc("Whether to include L in the certificate subject name. Applicable only for private trust, private trust ci profile types")
  includeCity?: boolean = false;

  @doc("Used as S in the certificate subject name.")
  @visibility("read")
  state?: string;

  @doc("Whether to include S in the certificate subject name. Applicable only for private trust, private trust ci profile types")
  includeState?: boolean = false;

  @doc("Used as C in the certificate subject name.")
  @visibility("read")
  country?: string;

  @doc("Whether to include C in the certificate subject name. Applicable only for private trust, private trust ci profile types")
  includeCountry?: boolean = false;

  @doc("Used as PC in the certificate subject name.")
  @visibility("read")
  postalCode?: string;

  @doc("Whether to include PC in the certificate subject name.")
  includePostalCode?: boolean = false;

  @doc("Enhanced key usage of the certificate.")
  @visibility("read")
  enhancedKeyUsage?: string;

  @doc("Identity validation id used for the certificate subject name.")
  identityValidationId?: string;

  @doc("Status of the current operation on certificate profile.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Status of the certificate profile.")
  @visibility("read")
  status?: CertificateProfileStatus;

  #suppress "deprecated" "Legacy flatten"
  @doc("List of renewed certificates.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  @Azure.ClientGenerator.Core.flattenProperty
  certificates?: Certificate[];
}

@doc("Properties of the certificate.")
model Certificate {
  @doc("Serial number of the certificate.")
  serialNumber?: string;

  @doc("Subject name of the certificate.")
  subjectName?: string;

  @doc("Thumbprint of the certificate.")
  thumbprint?: string;

  @doc("Certificate created date.")
  createdDate?: string;

  @doc("Certificate expiry date.")
  expiryDate?: string;

  @doc("Status of the certificate.")
  status?: CertificateStatus;

  #suppress "deprecated" "Legacy flatten"
  @doc("Revocations history of a certificate.")
  @Azure.ClientGenerator.Core.flattenProperty
  revocation?: Revocation;
}

@doc("Revocation details of the certificate.")
model Revocation {
  @doc("The timestamp when the revocation is requested.")
  requestedAt?: utcDateTime;

  @doc("The timestamp when the revocation is effective.")
  effectiveAt?: utcDateTime;

  @doc("Reason for revocation.")
  reason?: string;

  @doc("Remarks for the revocation.")
  remarks?: string;

  @doc("Status of the revocation.")
  status?: RevocationStatus;

  @doc("Reason for the revocation failure.")
  failureReason?: string;
}

@doc("Defines the certificate revocation properties.")
model RevokeCertificate {
  @doc("Serial number of the certificate.")
  serialNumber: string;

  @doc("Thumbprint of the certificate.")
  thumbprint: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @doc("The timestamp when the revocation is effective.")
  effectiveAt: utcDateTime;

  @doc("Reason for the revocation.")
  reason: string;

  @doc("Remarks for the revocation.")
  remarks?: string;
}

@doc("The parameters used to check the availability of the trusted signing account name.")
model CheckNameAvailability {
  @doc("Trusted signing account name.")
  name: string;
}

@doc("The CheckNameAvailability operation response.")
model CheckNameAvailabilityResult {
  @doc("A boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or is invalid and cannot be used.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason that a trusted signing account name could not be used. The Reason element is only returned if nameAvailable is false.")
  @visibility("read")
  reason?: NameUnavailabilityReason;

  @doc("An error message explaining the Reason value in more detail.")
  @visibility("read")
  message?: string;
}
